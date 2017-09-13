# Hackday-Character-Controls-Lua Notes
This repo is created for a hackday project I am working on to learn some lua scripting inside of Stingray. The goal is to create 3rd person game controls and camera follows all in Lua.

## Friday August 11th 2017
 
This was the initial start date of this project. I learned quite a few things:

* In a table it is you can use the table name with a dot to create variables that are related to it. For example:
    * The following is the name of my table:
    ```lua
    actionRoobControls = actionRoobControls or {}
    ```


    * I can then use that name with a dot to create a related variable:
    ```lua
    actionRoobControls.ar_character = stingray.World.spawn_unit(ar_world, "content/models/character/actionRoob/actionRoobStingrayScale", stingray.Vector3(0,0,0))
    ```

    * Now that variable is tied to this table which helps avoid the confusion and possible naming conflicts that can be caused by using global variables.

* I also learned about `Vector3Box()` which is used for values that you would lke to use at a later time. `Vector3()` can become stale and then you are unable to use them at a later time.
    * The following produced a stale error:
    ```lua
        --get ar_character unit local position.
    actionRoobControls.ar_char_unit_postion = stingray.Unit.local_position(actionRoobControls.ar_character,1)
    print(actionRoobControls.ar_char_unit_postion)
    --create offset for position of camera
    actionRoobControls.ar_cam_offset = stingray.Vector3(0,-7,6)
    actionRoobControls.ar_char_pos_cam_offset = stingray.Vector3(actionRoobControls.ar_char_unit_postion + actionRoobControls.ar_cam_offset)
    ```
    * The following did not produce a stale error:
    ```lua
      --get ar_character unit local position.
    actionRoobControls.ar_char_unit_postion = stingray.Unit.local_position(actionRoobControls.ar_character,1)
    print(actionRoobControls.ar_char_unit_postion)
     --create offset for position of camera
    actionRoobControls.ar_cam_offset = stingray.Vector3(0,-7,6)
    actionRoobControls.ar_char_pos_cam_offset = stingray.Vector3Box(actionRoobControls.ar_char_unit_postion + actionRoobControls.ar_cam_offset)
    ```
    * When the vector3() needs to be used you unbox it:
    ```lua
        --set the camera unit local position
    stingray.Unit.set_local_position(actionRoobControls.ar_camera,1,actionRoobControls.ar_char_pos_cam_offset:unbox())
    ```
* Next step is to work on character movement and camera follow. There currently is no update on character movement because variables are not being reassigned so the same value is being kept.

## Friday August 25th 2017

* This week I started on the camera follow. At this point the camera translates with the character but it is always facing the same direction. Eventually I would like for the camera to be able to rotate around the character using the mouse.

* I also added character translation. This was done by creating position variables for `x,y,z` then I used those in the `Vector3()` and updated them based off of there current location and the key that is being pressed:
```lua
    actionRoobControls.pos_x = 0
    actionRoobControls.pos_y = 0
    actionRoobControls.pos_z = 0
```
* For instance on the camera I used the following to update it's position.

```lua
actionRoobControls.ar_cam_offset = stingray.Vector3(actionRoobControls.pos_x,actionRoobControls.pos_y -7,actionRoobControls.pos_z +6)
```
The following is a gif showing the controls at work:

![running controls gif][logo]

[logo]: https://github.com/santosd/Hackday-Character-Controls-Lua/blob/master/images/gifs/LUA_animControllerHackday01.gif "Logo Title Text 2"

Right now I am able to get the character to walk, walk left, walk right, walk backwards. Using shift plus the w,a,s,d keys he can run in those directions as well.

Initially I did not intend on having the character collide with anything, but have decided "why not!?" so that is the next thing I will look into doing. At some point I would also like to bring in the textures for the character. I would also like to add a funny animation such as a dance or something that is triggered when the character has been idle for a certain amount of time.

## Friday September 8th 2017

* This week I worked on getting collisions to work on the character and also figured out how to get the character to walk at an angle.

* I ran into a few issues regarding the collssions.
    * First I wasn't certain if I needed to have an actor or not. I came to find that having a mover was all I needed. I created a mover `stingray.Mover` and then I was able to move it using `stingray.Mover.move()`. Initially I tried using `stingray.Mover.set_position()` However, this simply spawns the mover to the specified location, therefore collisions do not work.
    * At this point I am able to tell that the Mover is colliding because I am printing it's position with the `W` key and at a certain point it doesn't move past.
    * The mover is currently not moving the character. I thought that this would automatically happen with the mover being attached to the character, but I haven't figured that out. There is a function for setting a mover to a unit `stingray.Unit.set_mover` but I may need to assign on update (I haven't tried this so I am not sure). My other guess is that I need to use the `stingray.Unit.set_moving`. I will be playing with that a little bit more to see if I can get it to work.

* I was able to get the rotation on the character by using the `stingray.Unit.set_axis` this was a way to avoid using quaternion as it automatically converts to a quaternion for you.

I feel that I am about half way through when it comes to getting the collisions to work. At this point I know that the collisions are working with the mover, I just need the mover to move my unit. Until next hackday...

## In Between Hackday

* I have been doing some extra work on this at home.
    * I have figured out the movement of the character unit. Basically I captured the value of the position of the mover in a variable and I am assigning those values to the camera with an offset and to the character unit:

```lua
    actionRoobControls.ar_mover_position = stingray.Mover.position(actionRoobControls.ar_mover)
    actionRoobControls.pos_x = actionRoobControls.ar_mover_position[1]
    actionRoobControls.pos_y = actionRoobControls.ar_mover_position[2]
    actionRoobControls.pos_z = actionRoobControls.ar_mover_position[3]
```
Then later I am using the value:

```lua
    stingray.Unit.set_local_position(actionRoobControls.ar_character,1,stingray.Vector3(actionRoobControls.pos_x,actionRoobControls.pos_y,actionRoobControls.pos_z))
```
* I got the backwards running to work. After setting up all of this motion that is mainly animation based meaning that the left run is simply a left run animation with the mover\unit translating in that direction not actually rotating to face that direction. I have seen other examples in wich the mover\unit are rotated to actually face that direction and the animation is actually only a foward walk\run. I am considering doing that to meet the needs of a different gaming experience.
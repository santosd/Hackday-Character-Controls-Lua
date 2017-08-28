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
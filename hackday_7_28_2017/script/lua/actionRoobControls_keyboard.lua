actionRoobControls_keyboard = actionRoobControls_keyboard or {}

-- this file is used to for the controls of the Action Roob character.

-- This function is called at level load only.
function actionRoobControls_keyboard.ar_spawn()
    print("this is a test")
    local ar_world = SimpleProject.world

    -- Rotation Variables    
    actionRoobControls_keyboard.rot_x = 0

    -- The Spawned Action Roob Character in a variable
    actionRoobControls_keyboard.ar_character = stingray.World.spawn_unit(ar_world, "content/models/character/actionRoob/actionRoobStingrayScale", stingray.Vector3(0,0,0))
    actionRoobControls_keyboard.ar_mover = stingray.Unit.set_mover(actionRoobControls_keyboard.ar_character, "default")
    actionRoobControls_keyboard.ar_actor = stingray.Unit.actor(actionRoobControls_keyboard.ar_character, 1)

    -- get ar_mover postion
     actionRoobControls_keyboard.ar_mover_position = stingray.Mover.position(actionRoobControls_keyboard.ar_mover)
     print("mover pos " .. tostring(actionRoobControls_keyboard.ar_mover_position[1]))

    -- Translate Variables
    actionRoobControls_keyboard.pos_x = 0
    actionRoobControls_keyboard.pos_y = 0
    actionRoobControls_keyboard.pos_z = 0

    -- get the camera unit
    actionRoobControls_keyboard.ar_camera = stingray.World.unit_by_name(ar_world, "arCamera")
end
-- The following function is called on update.
function actionRoobControls_keyboard.ar_controls()
    -- check to see if keyboard button is being pressed
    local w_key_id = stingray.Keyboard.button_id("w")
    local wIsPressed = stingray.Keyboard.button(w_key_id)
    local a_key_id = stingray.Keyboard.button_id("a")
    local aIsPressed = stingray.Keyboard.button(a_key_id)
    local s_key_id = stingray.Keyboard.button_id("s")
    local sIsPressed = stingray.Keyboard.button(s_key_id)
    local d_key_id = stingray.Keyboard.button_id("d")
    local dIsPressed = stingray.Keyboard.button(d_key_id)
    local shift_key_id = stingray.Keyboard.button_id("left shift")
    local shiftIsPressed = stingray.Keyboard.button(shift_key_id)
    local space_key_id = stingray.Keyboard.button_id("space")
    local spaceIsPressed = stingray.Keyboard.button(space_key_id)
-- if button is pressed play specific animation event and update the position of the character
    if spaceIsPressed == 1 then
        stingray.Unit.animation_event(actionRoobControls_keyboard.ar_character, "jump")
    
    -- walk
    elseif wIsPressed == 1 and shiftIsPressed == 0 and dIsPressed == 0  then
        stingray.Unit.animation_event(actionRoobControls_keyboard.ar_character, "walk")
        stingray.Mover.move(actionRoobControls_keyboard.ar_mover,stingray.Vector3(0,0.09,0),0.01)
        actionRoobControls_keyboard.rot_x = 0
    
    -- right forward walk
    elseif wIsPressed == 1 and shiftIsPressed == 0 and dIsPressed == 1 then
        stingray.Unit.animation_event(actionRoobControls_keyboard.ar_character, "walk")
        stingray.Mover.move(actionRoobControls_keyboard.ar_mover,stingray.Vector3(0.09,0.09,0),0.01)
        actionRoobControls_keyboard.rot_x = -0.785

    -- run
    elseif wIsPressed == 1 and shiftIsPressed == 1 and dIsPressed == 0  then
        stingray.Unit.animation_event(actionRoobControls_keyboard.ar_character, "run")
        stingray.Mover.move(actionRoobControls_keyboard.ar_mover,stingray.Vector3(0,0.25,0),0.01)

    -- left strafe walk
    elseif aIsPressed == 1 and shiftIsPressed == 0 then
        stingray.Unit.animation_event(actionRoobControls_keyboard.ar_character, "leftStrafeWalk")
        stingray.Mover.move(actionRoobControls_keyboard.ar_mover,stingray.Vector3(-0.09,0.0,0),0.01)
        actionRoobControls_keyboard.rot_x = 0

    -- left strafe run
    elseif aIsPressed == 1 and shiftIsPressed == 1 then
        stingray.Unit.animation_event(actionRoobControls_keyboard.ar_character, "leftStrafeRun")
        stingray.Mover.move(actionRoobControls_keyboard.ar_mover,stingray.Vector3(-0.25,0,0),0.01)
        actionRoobControls_keyboard.rot_x = 0

    -- right strafe walk
    elseif dIsPressed == 1 and shiftIsPressed == 0 then
        stingray.Unit.animation_event(actionRoobControls_keyboard.ar_character, "rightStrafeWalk")
        stingray.Mover.move(actionRoobControls_keyboard.ar_mover,stingray.Vector3(0.09,0,0),0.01)
        actionRoobControls_keyboard.rot_x = 0
        
    -- right strafe run
    elseif dIsPressed == 1 and shiftIsPressed == 1 then
        stingray.Unit.animation_event(actionRoobControls_keyboard.ar_character, "rightStrafeRun")
        stingray.Mover.move(actionRoobControls_keyboard.ar_mover,stingray.Vector3(0.25,0,0),0.01)
        actionRoobControls_keyboard.rot_x = 0

    -- backwards walk
    elseif sIsPressed == 1 and shiftIsPressed == 0 then
        stingray.Unit.animation_event(actionRoobControls_keyboard.ar_character, "backwardsWalk")
        stingray.Mover.move(actionRoobControls_keyboard.ar_mover,stingray.Vector3(0,-0.09,0),0.01)
        actionRoobControls_keyboard.rot_x = 0
    
    -- backwards run
    elseif sIsPressed == 1 and shiftIsPressed == 1 then
        stingray.Unit.animation_event(actionRoobControls_keyboard.ar_character, "backwardsRun")
        stingray.Mover.move(actionRoobControls_keyboard.ar_mover,stingray.Vector3(0,-0.25,0),0.01)
        actionRoobControls_keyboard.rot_x = 0

    else 
        stingray.Unit.animation_event(actionRoobControls_keyboard.ar_character, "idle")
        actionRoobControls_keyboard.rot_x = 0
        stingray.Unit.animation_get_state(actionRoobControls_keyboard.ar_character)
        -- stingray.Unit.animation_event(actionRoobControls_keyboard.ar_character, "dance")
    end
    --update the variables for the position of the mover
    actionRoobControls_keyboard.ar_mover_position = stingray.Mover.position(actionRoobControls_keyboard.ar_mover)
    actionRoobControls_keyboard.pos_x = actionRoobControls_keyboard.ar_mover_position[1]
    actionRoobControls_keyboard.pos_y = actionRoobControls_keyboard.ar_mover_position[2]
    actionRoobControls_keyboard.pos_z = actionRoobControls_keyboard.ar_mover_position[3]
    --update the position of the camera based on the location of the character.
    stingray.Unit.set_local_position(actionRoobControls_keyboard.ar_character,1,stingray.Vector3(actionRoobControls_keyboard.pos_x,actionRoobControls_keyboard.pos_y,actionRoobControls_keyboard.pos_z))
    stingray.Unit.set_local_position(actionRoobControls_keyboard.ar_camera,1,stingray.Vector3(actionRoobControls_keyboard.pos_x,actionRoobControls_keyboard.pos_y -7,actionRoobControls_keyboard.pos_z +6))

    local x_rot_quat = stingray.Quaternion.axis_angle( stingray.Vector3(0, 0, 1), actionRoobControls_keyboard.rot_x )
    stingray.Unit.set_local_rotation(actionRoobControls_keyboard.ar_character,1,x_rot_quat)
end
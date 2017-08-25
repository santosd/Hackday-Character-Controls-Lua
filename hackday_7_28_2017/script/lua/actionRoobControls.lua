actionRoobControls = actionRoobControls or {}

-- this file is used to for the controls of the Action Roob character.

-- This function is called at level load only.
function actionRoobControls.ar_spawn()
    print("this is a test")
    local ar_world = SimpleProject.world
    actionRoobControls.pos_x = 0
    actionRoobControls.pos_y = 0
    actionRoobControls.pos_z = 0
    actionRoobControls.ar_character = stingray.World.spawn_unit(ar_world, "content/models/character/actionRoob/actionRoobStingrayScale", stingray.Vector3(actionRoobControls.pos_x,actionRoobControls.pos_y,actionRoobControls.pos_z))
    --get ar_character unit local position.
    actionRoobControls.ar_char_unit_postion = stingray.Unit.local_position(actionRoobControls.ar_character,1)
    print(actionRoobControls.ar_char_unit_postion)
    --create mover variables in +X -X and +Y -Y
    -- actionRoobControls.positive_y_offset = stingray.Vector3(0,0.5,0)
    -- actionRoobControls.move_y = stingray.Vector3Box(actionRoobControls.ar_char_unit_postion + actionRoobControls.positive_y_offset)
    --create offset for position of camera
    actionRoobControls.ar_cam_offset = stingray.Vector3(actionRoobControls.pos_x,actionRoobControls.pos_y -7,actionRoobControls.pos_z +6)
    print(actionRoobControls.ar_char_pos_cam_offset)
    --get the camera unit
    actionRoobControls.ar_camera = stingray.World.unit_by_name(ar_world, "arCamera")
end
-- The following function is called on update.
function actionRoobControls.ar_controls()
-- check to see if button is being pressed
    local w_key_id = stingray.Keyboard.button_id("w")
    local wIsPressed = stingray.Keyboard.button(w_key_id)
    local a_key_id = stingray.Keyboard.button_id("a")
    local aIsPressed = stingray.Keyboard.button(a_key_id)
    local s_key_id = stingray.Keyboard.button_id("s")
    local sIsPressed = stingray.Keyboard.button(s_key_id)
    local d_key_id = stingray.Keyboard.button_id("d")
    local dIsPressed = stingray.Keyboard.button(d_key_id)
-- if button is pressed play specific animation event and update the position of the character
    if wIsPressed == 1 then
        stingray.Unit.animation_event(actionRoobControls.ar_character, "walk")
        actionRoobControls.pos_y = actionRoobControls.pos_y + 0.05
        stingray.Unit.set_local_position(actionRoobControls.ar_character,1,stingray.Vector3(actionRoobControls.pos_x,actionRoobControls.pos_y,actionRoobControls.pos_z))
    elseif aIsPressed == 1 then
        stingray.Unit.animation_event(actionRoobControls.ar_character, "leftStrafeWalk")
        actionRoobControls.pos_x = actionRoobControls.pos_x - 0.05
        stingray.Unit.set_local_position(actionRoobControls.ar_character,1,stingray.Vector3(actionRoobControls.pos_x,actionRoobControls.pos_y,actionRoobControls.pos_z))
    elseif dIsPressed == 1 then
        stingray.Unit.animation_event(actionRoobControls.ar_character, "rightStrafeWalk")
        actionRoobControls.pos_x = actionRoobControls.pos_x + 0.05
        stingray.Unit.set_local_position(actionRoobControls.ar_character,1,stingray.Vector3(actionRoobControls.pos_x,actionRoobControls.pos_y,actionRoobControls.pos_z))
    elseif sIsPressed == 1 then
        stingray.Unit.animation_event(actionRoobControls.ar_character, "backwardsWalk")
        actionRoobControls.pos_y = actionRoobControls.pos_y - 0.05
        stingray.Unit.set_local_position(actionRoobControls.ar_character,1,stingray.Vector3(actionRoobControls.pos_x,actionRoobControls.pos_y,actionRoobControls.pos_z))
    else stingray.Unit.animation_event(actionRoobControls.ar_character, "idle")
    end
    --update the position of the camera based on the location of the character.
    stingray.Unit.set_local_position(actionRoobControls.ar_camera,1,stingray.Vector3(actionRoobControls.pos_x,actionRoobControls.pos_y -7,actionRoobControls.pos_z +6))
end
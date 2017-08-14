actionRoobControls = actionRoobControls or {}

-- this file is used to for the controls of the Action Roob character.

function actionRoobControls.ar_spawn()
    print("this is a test")
    local ar_world = SimpleProject.world
    actionRoobControls.ar_character = stingray.World.spawn_unit(ar_world, "content/models/character/actionRoob/actionRoobStingrayScale", stingray.Vector3(0,0,0))
    --get ar_character unit local position.
    actionRoobControls.ar_char_unit_postion = stingray.Unit.local_position(actionRoobControls.ar_character,1)
    print(actionRoobControls.ar_char_unit_postion)
    --create mover variables in +X -X and +Y -Y
    actionRoobControls.positive_y_offset = stingray.Vector3(0,0.5,0)
    actionRoobControls.move_y = stingray.Vector3Box(actionRoobControls.ar_char_unit_postion + actionRoobControls.positive_y_offset)
    --create offset for position of camera
    actionRoobControls.ar_cam_offset = stingray.Vector3(0,-7,6)
    actionRoobControls.ar_char_pos_cam_offset = stingray.Vector3Box(actionRoobControls.ar_char_unit_postion + actionRoobControls.ar_cam_offset)
    print(actionRoobControls.ar_char_pos_cam_offset)
    --get the camera unit
    actionRoobControls.ar_camera = stingray.World.unit_by_name(ar_world, "arCamera")
end
-- check to see if button is being pressed
function actionRoobControls.ar_controls()
    local w_key_id = stingray.Keyboard.button_id("w")
    local wIsPressed = stingray.Keyboard.button(w_key_id)
    local a_key_id = stingray.Keyboard.button_id("a")
    local aIsPressed = stingray.Keyboard.button(a_key_id)
    local s_key_id = stingray.Keyboard.button_id("s")
    local sIsPressed = stingray.Keyboard.button(s_key_id)
    local d_key_id = stingray.Keyboard.button_id("d")
    local dIsPressed = stingray.Keyboard.button(d_key_id)
-- if button is pressed play specific animation event
    if wIsPressed == 1 then
        stingray.Unit.animation_event(actionRoobControls.ar_character, "walk")
        stingray.Unit.set_local_position(actionRoobControls.ar_character,1,actionRoobControls.move_y:unbox())
    elseif aIsPressed == 1 then
        stingray.Unit.animation_event(actionRoobControls.ar_character, "leftStrafeWalk")
    elseif dIsPressed == 1 then
        stingray.Unit.animation_event(actionRoobControls.ar_character, "rightStrafeWalk")
    else stingray.Unit.animation_event(actionRoobControls.ar_character, "idle")
    end
    --set the camera unit local position
    stingray.Unit.set_local_position(actionRoobControls.ar_camera,1,actionRoobControls.ar_char_pos_cam_offset:unbox())
end
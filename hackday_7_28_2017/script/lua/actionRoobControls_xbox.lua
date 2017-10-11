actionRoobControls_xbox = actionRoobControls_xbox or {}

pad1 = stingray.pad1

function actionRoobControls_xbox.ar_spawn()
    local ar_world = SimpleProject.world
    actionRoobControls_xbox.ar_character = stingray.World.spawn_unit(ar_world, "content/models/character/actionRoob/actionRoobStingrayScale", stingray.Vector3(0,0,0))
    actionRoobControls_xbox.ar_mover = stingray.Unit.set_mover(actionRoobControls_xbox.ar_character, "default")
end


function actionRoobControls_xbox.ar_controls()
    local right_axis_id = stingray.Pad1.axis_id("right")
    local value = stingray.Pad1.axis(right_axis_id)
    
end
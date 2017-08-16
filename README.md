<center> <h1>Hackday-Character-Controls-Lua Notes</h1></center>
<p>This repo is created for a hackday project I am working on to learn some lua scripting inside of Stingray. The goal is to create 3rd person game controls and camera follows all in Lua.</p>

## Friday August 11th 2017
 
<p>This was the initial start date of this project. I learned quite a few things<p/>

* In a table it is you can use the table name with a dot to create variables that are related to it. For example:
    * The following is the name of my table:
    <p><code>actionRoobControls = actionRoobControls or {}</code><p/>

    * I can then use that name with a dot to create a related variable:
    <p><code>actionRoobControls.ar_character = stingray.World.spawn_unit(ar_world, "content/models/character/actionRoob/actionRoobStingrayScale", stingray.Vector3(0,0,0))</code></p>

    * Now that variable is tied to this table which helps avoid the confusion and possible naming conflicts that can be caused by using global variables.

* I also learned about <code>Vector3Box()</code> which is used for values that you would lke to use at a later time. <code>Vector3()</code> can become stale and then you are unable to use them at a later time.
    * The following produced a stale error:
    <pre><code>
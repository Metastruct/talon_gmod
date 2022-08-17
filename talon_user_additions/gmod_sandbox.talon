tag: user.sandbox
and tag: user.gmodmode
-

# Cleanup / undo
^sand box clean up everything$: 
    user.gmod_runcmd("play buttons/button16.wav;_talon_message Confirmation required")
    user.gmod_preparecmd("gmod_cleanup")
^sand box clean up$: 
    user.gmod_runcmd("play buttons/button16.wav;_talon_message Confirmation required")
    user.gmod_preparecmd("gmod_cleanup")

^sand box undo$: user.gmod_runcmd("gmod_undo")
^sand box undo (two|twice)$: user.gmod_runcmd("gmod_undo;gmod_undo")
^sand box undo (three|thrice)$: user.gmod_runcmd("gmod_undo;gmod_undo;gmod_undo")

# Properties
^sand box ignite this$: user.gmod_runcmd("_talon_cmd properties ignite")
^sand box extinguish this$: user.gmod_runcmd("_talon_cmd properties extinguish")
^wingardium (leviosa|leviosaa|leviosaaa)$: user.gmod_runcmd("_talon_cmd properties gravity")
^sand box delete this$: 
    user.gmod_runcmd("play buttons/button16.wav;_talon_message Confirmation required")
    user.gmod_preparecmd("_talon_cmd properties remove")
^(sectumsempra|sand box break this)$:
    user.gmod_runcmd("play buttons/button16.wav;_talon_message Confirmation required")
    user.gmod_preparecmd("_talon_cmd properties breakable_break")

# Creation
^(give|create) weapon {user.sandbox_weapon}$: user.gmod_runcmd("gm_giveswep "+user.sandbox_weapon)
^spawn weapon {user.sandbox_weapon}$: user.gmod_runcmd("gm_spawnswep "+user.sandbox_weapon)
^(spawn|create prop) {user.sandbox_prop}$: user.gmod_runcmd("gm_spawn "+user.sandbox_prop)
^(spawn|create) vehicle {user.sandbox_vehicle}$: user.gmod_runcmd("gm_spawnvehicle "+user.sandbox_vehicle)
^(spawn|create) (npc|character) {user.sandbox_npc}$: user.gmod_runcmd("gmod_spawnnpc "+user.sandbox_npc)
^(spawn|create) entity {user.sandbox_entity}$: user.gmod_runcmd("gm_spawnsent "+user.sandbox_entity)
^(tool mode|toolgun|tool gun|toolmode) {user.sandbox_tools}$: user.gmod_runcmd("use gmod_tool;gmod_toolmode "+user.sandbox_tools)

# Other
^drop (current weapon|weapon)$: user.gmod_runcmd("drop")

# Disabled: triggers too often
^sand box revert$: user.gmod_runcmd("talon_failed")
^spawn weapon cleanup$: user.gmod_runcmd("talon_failed")
^sand box weapon cleanup$: user.gmod_runcmd("talon_failed")

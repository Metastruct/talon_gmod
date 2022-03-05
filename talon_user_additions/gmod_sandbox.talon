tag: user.sandbox
-


^sandbox cleanup everything$: user.gmod_runcmd("gmod_cleanup")
^sandbox cleanup$: user.gmod_runcmd("talon_failed")
^sandbox revert$: user.gmod_runcmd("gmod_undo")
^revert spawn$: user.gmod_runcmd("gmod_undo")
^sandbox undo$: user.gmod_runcmd("gmod_undo")
^sandbox undo two$:
    user.gmod_runcmd("gmod_undo")
    user.gmod_runcmd("gmod_undo")
^sandbox undo three$:
    user.gmod_runcmd("gmod_undo")
    user.gmod_runcmd("gmod_undo")
    user.gmod_runcmd("gmod_undo")

^spawn weapon cleanup$:
    user.gmod_runcmd("talon_failed")

^drop weapon$:
    user.gmod_runcmd("drop")

^sandbox weapon cleanup$: user.gmod_runcmd("talon_failed")
^(give|create) weapon {user.sandbox_weapon}$: 
    user.gmod_runcmd("gm_giveswep "+user.sandbox_weapon)
^spawn weapon {user.sandbox_weapon}$: 
    user.gmod_runcmd("gm_spawnswep "+user.sandbox_weapon)

^(spawn|create prop) {user.sandbox_prop}$: 
    user.gmod_runcmd("gm_spawn "+user.sandbox_prop)
    
^(spawn|create) vehicle {user.sandbox_vehicle}$: 
    user.gmod_runcmd("gm_spawnvehicle "+user.sandbox_vehicle)

^(spawn|create) npc {user.sandbox_npc}$: 
    user.gmod_runcmd("gmod_spawnnpc "+user.sandbox_npc)

^(spawn|create) entity {user.sandbox_entity}$: 
    user.gmod_runcmd("gm_spawnsent "+user.sandbox_entity)

^(tool mode|toolgun|tool gun|toolmode) {user.sandbox_tools}$: 
    user.gmod_runcmd("use gmod_tool")
    user.gmod_runcmd("gmod_toolmode "+user.sandbox_tools)

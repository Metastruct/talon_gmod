tag: user.aowl
and tag: user.gmodmode
-

^admin mod revive me$: user.gmod_runcmd("aowl revive")
^admin mod resurrect me$: user.gmod_runcmd("aowl revive")
^resurrect me$: user.gmod_runcmd("aowl revive")
^admin mod teleport there$: user.gmod_runcmd("aowl tp")
^teleport there$: user.gmod_runcmd("aowl tp")

^go to spawn$: user.gmod_preparecmd("aowl spawn")
^admin mod respawn me$: user.gmod_runcmd("aowl spawn")

^kaboom kaboom$: user.gmod_runcmd("aowl splode")
^kaaboom kaaboom$: user.gmod_runcmd("aowl splode")


^teleport back$: user.gmod_runcmd("aowl back")
^admin mod back$: user.gmod_runcmd("aowl back")

^teleport to {user.teleportnames}$: user.gmod_runcmd("aowl goto \"{user.teleportnames}\"")
^(teleport|send) this (person|player|user) to {user.teleportnames}$: user.gmod_runcmd("aowl send #this \"{user.teleportnames}\"")
^computer (transport to|go to|teleport to) {user.teleportnames}$: user.gmod_runcmd("aowl goto \"{user.teleportnames}\"")
^computer please bring us {user.teleportnames}$: user.gmod_runcmd("aowl bring \"{user.teleportnames}\"")
^computer please send back {user.teleportnames}$: user.gmod_runcmd("aowl back \"{user.teleportnames}\"")


^avada kedavra$: user.gmod_runcmd("aowl kill #this")
(prepare civil judgement|laputan machine|admin mod kill this user|admin mod terminate this user): 
    user.gmod_runcmd("play buttons/button16.wav;_talon_message Confirmation required")
    user.gmod_preparecmd("aowl kill #this")
computer [please] terminate this user: 
    user.gmod_runcmd("play buttons/button16.wav;_talon_message Confirmation required")
    user.gmod_preparecmd("aowl kill #this")

^admin mod (resurrect|revive) this (player|person|user)$: user.gmod_runcmd("aowl revive #us")
^admin mod resurrect (everyone|all)$: user.gmod_runcmd("aowl revive #all")
^admin mod heal (everyone|all)$: user.gmod_runcmd("aowl l all:SetHealth(100)")
^admin mod heal this (player|person|user) to <number>$: user.gmod_runcmd("aowl l this:SetHealth({number})")


^arresto momentum$: user.gmod_runcmd("aowl sleep")
^expelliarmus$: user.gmod_runcmd("aowl strip #this")
^(petrificus totalus|freeze all motor functions)$: user.gmod_runcmd("aowl l this:PreventMoving(30)")
^(resume motor functions)$: user.gmod_runcmd("aowl l this:PreventMoving(false)")
^(stupor)$: user.gmod_runcmd("aowl l this:SetDrunkFactor(100) timer.Simple(15,function() this:SetDrunkFactor(0) end)")

#TODO
^finite incantatem$: user.gmod_runcmd("aowl l this:SetDrunkFactor(0) this:PreventMoving(false)")

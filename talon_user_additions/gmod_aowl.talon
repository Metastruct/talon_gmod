tag: user.aowl
and tag: user.gmodmode
-

^admin mod revive me$: user.gmod_runcmd("aowl revive")
^admin mod resurrect me$: user.gmod_runcmd("aowl revive")
^resurrect me$: user.gmod_runcmd("aowl revive")
^admin mod teleport there$: user.gmod_runcmd("aowl tp")
^teleport there$: user.gmod_runcmd("aowl tp")

^go to spawn$: user.gmod_runcmd("aowl spawn")
^admin mod respawn me$: user.gmod_runcmd("aowl spawn")

^kaboom kaboom$: user.gmod_runcmd("aowl splode")
^kaaboom kaaboom$: user.gmod_runcmd("aowl splode")


^teleport back$: user.gmod_runcmd("aowl back")
^admin mod back$: user.gmod_runcmd("aowl back")

^teleport to {user.teleportnames}$: user.gmod_runcmd("aowl goto _"+user.teleportnames)
^admin mod go to {user.teleportnames}$: user.gmod_runcmd("aowl goto _"+user.teleportnames)
^computer please bring us {user.teleportnames}$: user.gmod_runcmd("aowl bring _"+user.teleportnames)
^computer please send back {user.teleportnames}$: user.gmod_runcmd("aowl back _"+user.teleportnames)


^avada kedavra$: user.gmod_runcmd("aowl kill #this")
(prepare civil judgement|laputan machine): user.gmod_preparecmd("aowl kill #this")
computer [please] terminate this user: user.gmod_preparecmd("aowl kill #this")
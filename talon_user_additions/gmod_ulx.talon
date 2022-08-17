#TODO: HELP WANTED!!!

tag: user.ulx
and tag: user.gmodmode
-

^teleport back$: user.gmod_runcmd("ulx return")
^admin mod back$: user.gmod_runcmd("ulx return")

^teleport to {user.teleportnames}$: user.gmod_runcmd("ulx goto \"${user.teleportnames}\"")
^admin mod go to {user.teleportnames}$: user.gmod_runcmd("ulx goto \"${user.teleportnames}\"")
^computer please bring us {user.teleportnames}$: user.gmod_runcmd("ulx bring \"${user.teleportnames}\"")
^computer please send back {user.teleportnames}$: user.gmod_runcmd("ulx back \"${user.teleportnames}\"")

^avada kedavra$: user.gmod_runcmd("ulx slay @")
^(prepare civil judgement|laputan machine)$: user.gmod_preparecmd("ulx slay @")
^computer [please] terminate this user$: user.gmod_preparecmd("ulx slay @")

^admin mod resurrect (everyone|all)$: user.gmod_runcmd("ulx revive *")

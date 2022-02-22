^computer what time is it$: user.timefi()
^computer what is the time$: user.timefi()
^computer time please$: user.timefi()
^computer current time please$: user.timefi()


^computer terminate user$: user.runcmd("kill")
^operator terminate user$: user.runcmd("kill")
^i cant take this anymore$: user.runcmd("kill")


^operator I need a shotgun$: user.runcmd("gm_giveswep weapon_shotgun")
^operator give this person a shotgun$: user.runcmd("gm_giveswep weapon_shotgun")
^operator give us shotguns$:
	user.runcmd("gm_giveswep weapon_shotgun")
	user.runcmd("gm_spawnswep weapon_shotgun")

^operator I need a vehicle$: user.runcmd("gm_spawnvehicle Jeep")
^operator I need a jeep$: user.runcmd("gm_spawnvehicle Jeep")
^operator we need a jeep$: user.runcmd("gm_spawnvehicle Jeep")
^operator I need a means of transportation$: user.runcmd("gm_spawnvehicle Jeep")

app: gmod
-
^computer what time is it$: user.gmod_timefi()
^computer what is the time$: user.gmod_timefi()
^computer time please$: user.gmod_timefi()
^computer current time please$: user.gmod_timefi()


toggle flashlight: user.gmod_runcmd("impulse 100")
toggle noclip: user.gmod_runcmd("noclip")

flashlight: user.gmod_runcmd("impulse 100")
flash light: user.gmod_runcmd("impulse 100")

^computer terminate user$: user.gmod_runcmd("kill")
^operator terminate user$: user.gmod_runcmd("kill")
^i cant take this anymore$: user.gmod_runcmd("tail_failed")


^operator I need a shotgun$: user.gmod_runcmd("gm_giveswep weapon_shotgun")
^operator give this person a shotgun$: user.gmod_runcmd("gm_giveswep weapon_shotgun")
^operator give us shotguns$:
	user.gmod_runcmd("gm_giveswep weapon_shotgun")
	user.gmod_runcmd("gm_spawnswep weapon_shotgun")

^operator I need a vehicle$: user.gmod_runcmd("gm_spawnvehicle Jeep")
^operator I need a jeep$: user.gmod_runcmd("gm_spawnvehicle Jeep")
^operator we need a jeep$: user.gmod_runcmd("gm_spawnvehicle Jeep")
^operator I need a means of transportation$: user.gmod_runcmd("gm_spawnvehicle Jeep")

^(select|use) weapon {user.gmod_baseweapons}$: 
    user.gmod_runcmd("use "+user.gmod_baseweapons)

^microphone enable$: user.gmod_runcmd("+voicerecord")
^microphone disable$: user.gmod_runcmd("-voicerecord")
^enable microphone$: user.gmod_runcmd("+voicerecord")
^enable micro phone$: user.gmod_runcmd("+voicerecord")
^disable microphone$: user.gmod_runcmd("-voicerecord")

^exit vr mod confirm$: user.gmod_runcmd("vrmod_exit")

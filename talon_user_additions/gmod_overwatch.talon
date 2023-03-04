app: gmod
-


^(disable|deactive) all [voice] (command|control) functions$: 
    user.gmod_runcmd("_talon_cmd gmodmode 0;play hl1/fvox/deactivated.wav")
    user.gmodmode(0)
	user.gmod_preparecmd("")
^(disable|deactive) all [voice] (command|control) functions permanently$: 
    user.gmod_runcmd("_talon_cmd gmodmode 0;play hl1/fvox/voice_off.wav")
    user.gmodmode(0)
	user.gmod_preparecmd("")
    speech.disable()

^(enable|activate) [all] voice command functions$:
	user.gmod_runcmd("play garrysmod/ui_click.wav")
	user.gmod_preparecmd("enable_talon_cmds")

(flashlight|flash light|toggle flashlight|lumos|lumos maxima|revelio): user.gmod_runcmd("impulse 100")


^computer (disable|deactive|bypass) confirmation$:
    user.gmod_runcmd("play hl1/fvox/deactivated.wav")
    user.gmod_setconfirm(0)
^computer (enable|active|require) confirmation$: 
    user.gmod_setconfirm(1)


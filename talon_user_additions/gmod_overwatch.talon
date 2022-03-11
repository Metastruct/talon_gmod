app: gmod
-


^(disable|deactive) all [voice] (command|control) functions$: 
    user.gmod_runcmd("_talon_cmd gmodmode 0;play hl1/fvox/voice_off.wav")
    user.gmodmode(0)
^(disable|deactive) all [voice] (command|control) functions permanently$: 
    user.gmod_runcmd("_talon_cmd gmodmode 0;play hl1/fvox/deactivated.wav")
    actions.speech.disable()

^(enable|activate) [all] voice command functions$: 
    user.gmod_runcmd("_talon_cmd gmodmode 1;play hl1/fvox/voice_on.wav")
    user.gmodmode(1)

toggle flashlight: user.gmod_runcmd("impulse 100")
flashlight: user.gmod_runcmd("impulse 100")
flash light: user.gmod_runcmd("impulse 100")

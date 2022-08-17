tag: user.gmodmode
-

^exit (vrmod|vr mod|vr mode|virtual reality mode)$: user.gmod_runcmd("play garrysmod/ui_return.wav;vrmod_exit")
^(computer start vr|computer start vr mode|vrmod start)$: 
	user.gmod_runcmd("play garrysmod/ui_return.wav;_talon_message Say confirm to enabled vrmod.")
    user.gmod_preparecmd("vrmod_start")

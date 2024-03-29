## Voice Control Garry's Mod ingame (Mostly for VR). 

Work in Progress voice control for Garry's Mod. 

Does not modify Garry's Mod so it should also be VAC safe! **(WINDOWS ONLY)**

**Warning:** If you already use talon voice this may conflict with repositories like [knausj_talon](https://github.com/knausj85/knausj_talon/)!

Although talonvoice supports Mac and Linux, **talon_gmod does not yet support them, only Windows (due to valvecmd.exe)!**

### For Users: How to install (server hosters look [below](#for-servers--singleplayer--listen-server-users))

 1. Install [Talon Voice](https://talonvoice.com/)
 2. Install voice recognition: (Gen2 seems to work for foreign accents. Conformer is more recent and should be more accurate.)
 
      ![image](https://user-images.githubusercontent.com/207340/156883300-794009b3-5a72-46dc-a4bc-720188f3cc9c.png)
      
      **NOTE:** You may need to wait for talon to initialize for over a minute before the button appears. Check [logs](#troubleshooting) to see progress.
      You can also try restarting talon once and waiting for a minute. You can also continue to next step in the meanwhile. Please write in issues what worked.
      
 3. Open the talon configuration folder from tray
  
     ![image](https://user-images.githubusercontent.com/207340/156883338-8097ddf1-31c1-4cec-9a4c-cb62f7359ae1.png)
 
 4. Download [talon_gmod](https://github.com/Metastruct/talon_gmod/archive/refs/heads/dev.zip) zip
 5. Extract `talon_user_additions`from the downloaded `talon_gmod` zip file such that the folder structure looks like this (important!): 
     
     ![image](https://user-images.githubusercontent.com/207340/156883351-13e8b385-7e78-448f-b5f0-ee0e6aa3fac0.png)
     
     If talon is running it will autoreload and install dependencies.
     
 6. Restart talon voice. It should automatically find GMod. (possibly optional).
 7. Subscribe to the [workshop addon](https://steamcommunity.com/sharedfiles/filedetails/?id=2850447765) for improved command support (Optional). See [below](#for-servers--singleplayer--listen-server-users).
 8. Make sure `garrysmod/cfg/talon.cfg` exists. This is used by ingame lua code to see if you have talon. The file can be empty.
 9. Begin using voice commands! See examples below. For example, say `toggle flashlight`

### Troubleshooting
  View logs for any errors:
  
  ![image](https://user-images.githubusercontent.com/207340/156885913-a3783c2f-8085-4a5d-91b2-729ab851bf67.png)

  It might help restarting talon once more.
  
Check from [issues](https://github.com/Metastruct/talon_gmod/issues?q=is%3Aissue) for any solutions if you cannot get talon to work:
 -  Make sure `garrysmod/cfg/talon.cfg` exists. You can create the file manually yourself. After this, restart GMod and restart talon **after** finishing joining ingame.

### For servers / singleplayer / listen server users

The addon requires clientside/serverside Lua files for support for most commands!

Subscribe to the [workshop addon](https://steamcommunity.com/sharedfiles/filedetails/?id=2850447765) for improved command support.

**Alternatively**

Please clone [the repo](https://github.com/Metastruct/talon_gmod.git) to your server's addons folder. You can also [download it](https://github.com/Metastruct/talon_gmod/archive/refs/heads/dev.zip).

### Voice commands
**Generic:** ([`gmod.talon`](https://github.com/Metastruct/talon_gmod/blob/dev/talon_user_additions/gmod.talon))
 - toggle flashlight | flashlight
 - select weapon crowbar
 - enable/disable microphone
 - c̵̳̀o̵͖̚m̷̥̀p̶̼̈ụ̵͗t̷̛̹e̵͔̅r̸̛̪ ̵͕̿t̸̲͆e̵͎̅r̴͘ͅm̵̨͑i̸̼͐n̸͍̆â̴͔ṭ̷̀ẻ̶͖ ̷̜̽u̶̢̓s̶̺͛e̶͊ͅr̶̦͝
 
**Sandbox:** (More on [`gmod_sandbox.talon`](https://github.com/Metastruct/talon_gmod/blob/dev/talon_user_additions/gmod_sandbox.talon))

 - spawn crate | spawn tree | spawn oil drum
 - spawn vehicle jeep
 - spawn weapon crowbar
 - **sandbox** undo | sandbox revert
 - **sandbox** cleanup everything
 - **toolgun** weld | toolgun rope | toolgun remover

**Admin mod:** (only `aowl` on [metastruct](https://metastruct.eu) servers are presently supported. For ULX See [`gmod_ulx.talon`](https://github.com/Metastruct/talon_gmod/blob/dev/talon_user_additions/gmod_ulx.talon))
 - teleport to `short username`
 - computer please bring us `short username`
 - admin mod go to `short username`
 - admin mod revive me | admin mod resurrect me
 - teleport back
 - kaboom kaboom
 - go to spawn
 - admin mod teleport there

Also see: [`gmod_overwatch.talon`](https://github.com/Metastruct/talon_gmod/blob/dev/talon_user_additions/gmod_overwatch.talon)

### TODO / help wanted

 - ULX and other admin mod integration
 - Generic weapon spawning / selection
 - User defined easy listing of props and names for spawning
 - DarkRP / Terrortown
 - Volume control etc.
 - Better goto
 - More toolgun commands
 - Toolgun settings selection?
 - Entity context menu settings (remove this prop)
 - Undo confirmation (sandbox undo. "Confirmation required". Confirm)
 - Print ingame what was printed on screen

### Credits
 - [ValveCMD](https://github.com/python1320/valvecmd)
 - https://github.com/knausj85/knausj_talon/ for numbers.py et al.

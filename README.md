## Voice Control Garry's Mod ingame (Mostly for VR). 

Work in Progress voice control for Garry's Mod. Does not modify Garry's Mod so it should also be VAC safe!

### For Users: How to install

 1. Install [Talon Voice](https://talonvoice.com/)
 2. Install voice recognition:
 
      ![image](https://user-images.githubusercontent.com/207340/156883300-794009b3-5a72-46dc-a4bc-720188f3cc9c.png)
 3. Open the talon folder from tray
  
     ![image](https://user-images.githubusercontent.com/207340/156883338-8097ddf1-31c1-4cec-9a4c-cb62f7359ae1.png)
 
 4. Download [talon_gmod](https://github.com/Metastruct/talon_gmod/archive/refs/heads/dev.zip)
 5. Extract `talon_user_additions`from the downloaded `talon_gmod` zip file such that the folder structure looks like this (important!): 
     
     ![image](https://user-images.githubusercontent.com/207340/156883351-13e8b385-7e78-448f-b5f0-ee0e6aa3fac0.png)
     If talon is running it will autoreload and install dependencies.
     
 6. Restart talon voice. It should automatically find GMod. (possibly optional)
 7. Subscribe to the [workshop addon](https://steamcommunity.com/sharedfiles/filedetails/?id=TODO) for command support. (TODO/Optional)
 8. Make sure `garrysmod/cfg/talon.cfg` exists. Begin using voice commands! See examples below.


### For servers / singleplayer / listen server users

The addon requires clientside/serverside Lua files for better commands support! 
Please clone [the repo](https://github.com/Metastruct/talon_gmod.git) to your server's addons folder. You can also [download it](https://github.com/Metastruct/talon_gmod/archive/refs/heads/dev.zip).

### Voice commands
**Generic:** (Open `gmod.talon` with a text file)
 - toggle flashlight | flashlight
 - select weapon crowbar
 - enable/disable microphone
 - c̵̳̀o̵͖̚m̷̥̀p̶̼̈ụ̵͗t̷̛̹e̵͔̅r̸̛̪ ̵͕̿t̸̲͆e̵͎̅r̴͘ͅm̵̨͑i̸̼͐n̸͍̆â̴͔ṭ̷̀ẻ̶͖ ̷̜̽u̶̢̓s̶̺͛e̶͊ͅr̶̦͝
 
**Sandbox:** (gmod_sandbox.talon)

 - spawn crate | spawn tree | spawn oil drump
 - spawn vehicle jeep
 - spawn weapon crowbar
 - **sandbox** undo | sandbox revert
 - **sandbox** cleanup everything
 - **toolgun** weld | toolgun rope | toolgun remover

**Admin mod:** (only `aowl` on [metastruct](https://metastruct.eu) servers are presently supported)
 - teleport to `short username`
 - computer please bring us `short username`
 - admin mod go to `short username`
 - admin mod revive me | admin mod resurrect me
 - teleport back
 - kaboom kaboom
 - go to spawn
 - admin mod teleport there

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
 - [ValveCMD](github.com/python1320/valvecmd)
 - https://github.com/knausj85/knausj_talon/ for numbers.py et al.

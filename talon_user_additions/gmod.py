
from . import gmodutils # TODO: This will NOT autoreload!!
from .gmodutils import sandbox  # TODO: Same!!!!!

gmodutils.getCreateTalonCfg()
gmodutils.RunConsoleCommand("_talon_initializer")


from talon import cron, actions, Module, Context, screen, ui, actions, clip, app, fs, settings, noise

from datetime import datetime
import os, subprocess
import time,re
from datetime import datetime
mod = Module()
#mod.mode("gmodmode", desc="GMod command functions mode")
#actions.mode.enable("user.gmodmode")

apps = mod.apps
apps.gmod = "app.name: Garry's Mod (x64)"
apps.gmod = "app.name: Garry's Mod"
apps.gmod = "app.name: gmod"
apps.gmod = """
os: windows
and app.name: Garry's Mod
os: windows
and app.exe: gmod.exe
"""
apps.gmod = """
os: windows
and app.name: Garry's Mod
os: windows
and app.exe: hl2.exe
"""
apps.gmod = """
os: mac
and app.bundle: org.facepunch.gmod
"""

# Register some common tags, like admin mods
mod.tag("gmodmode", desc="gmod command mode")
mod.tag("aowl", desc="Aowl commands")
mod.tag("ulx", desc="ulx commands")
mod.tag("arcvr", desc="arcvr")
mod.tag("sandbox", desc="sandbox commands")
mod.tag("sandbox_modded", desc="sandbox modded") #TODO
mod.tag("darkrp", desc="darkrp commands")
mod.tag("terrortown", desc="terrortown commands")
mod.tag("gmodconfirm", desc="gmodconfirm for confirming commands")

# We use this context to enable tags
ctx = Context()
ctx.matches = "app: gmod"

# "use weapon crowbar"
mod.list("gmod_baseweapons", desc="base weapons")
def genMapping(str):
	lines=str.splitlines()
	ret = {}
	for l in lines:
		if not l.strip():
			continue
		id,callers = l.split(",",1)
		for alias in callers.split(","):
			ret[alias]=id
	return ret
ctx.lists["user.gmod_baseweapons"] = genMapping(sandbox.weapons_raw)

# Tags are used to enable .talon-files if they have "tag: x" in the header
settings_tags=[]
runtime_tags=["user.gmodmode"]
def updateTags():
	tags = list(set(settings_tags + runtime_tags))
	print("tags=",tags)
	ctx.tags = tags
updateTags()


preparedcmd=["",time.time(),True]
# User actions, like running console commands
@mod.action_class
class Actions:
	def gmod_setconfirm(c: int):
		"""Should confirmation be required"""
		preparedcmd[2]=c==1

	def gmod_preparecmd(c: str):
		"""Prepares running console command ingame"""
		preparedcmd[0]=c
		preparedcmd[1]=time.time()
		if preparedcmd[2]==False:
			Actions.gmod_preparecmd_execute()
		else:
			if "user.gmodconfirm" not in runtime_tags:
				runtime_tags.append("user.gmodconfirm")
				updateTags()

	def gmod_runcmd(c: str):
		"""Runs console command ingame"""
		gmodutils.RunConsoleCommand(c)

	def gmodmode(e: int):
		"""Set whether any of the gmod commands should run"""
		if e:
			runtime_tags.append("user.gmodmode")
		else:
			try:
				runtime_tags.remove("user.gmodmode")
			except ValueError:
				pass
		updateTags()
		
	def gmod_preparecmd_execute():
		"""Runs console command ingame"""
		cmd=preparedcmd[0]
		if cmd:
			if cmd=="enable_talon_cmds":
				gmodutils.RunConsoleCommand("_talon_cmd gmodmode 1;play hl1/fvox/activated.wav")
				runtime_tags.append("user.gmodmode")
				updateTags()
			else:
				gmodutils.RunConsoleCommand(preparedcmd[0])
			preparedcmd[0]=""
		if "user.gmodconfirm" in runtime_tags:
			runtime_tags.remove("user.gmodconfirm")
			updateTags()

	def gmod_timefi():
		"""current time cmd"""
		now = datetime.now()
		current_time = now.strftime("%H:%M")
		gmodutils.RunConsoleCommand("say !tts The time is now "+current_time+"")



# ==== settings.json ==========
inited=False
settings_path = gmodutils.getTalonSettingsPath()
if settings_path:
	settings_path=str(settings_path)
	def update_settings(name, flags):
		if name != settings_path:
			return # ?
		conf = gmodutils.readTalonAutogenSettings()
		if conf:
			settings_tags.clear()
			settings_tags.extend(["user."+key for key,val in conf["features"].items()]+["user."+conf["ActiveGamemode"]])
			updateTags()

	update_settings(settings_path, None)
	fs.watch(settings_path, update_settings)
	inited=True

if not inited:
	print("could not initialize settings relay")

# ===== players.json (TODO: json) ======
inited=False
datafolder = gmodutils.GetTalonDataFolder()
if datafolder:
	players_file = datafolder / 'players.json'
	if players_file.exists():
		players_file=str(players_file)
		mod.list("teleportnames", desc="list of teleport names and entity ids")

		def update_teleport_list(name, flags):
			if name != players_file:
				return

			t = {}
			with open(players_file, "r") as f:
				for line in f:
					data = line.rstrip().split(" ",1)
					if len(data)>1:
						username=data[1]
						username=re.sub(r'[^a-zA-Z ]',r' ', username) # TODO: convert numbers?
						username=re.sub(r'  ',r' ', username)
						username=re.sub(r'  ',r' ', username).rstrip().lstrip()
						t[username]=data[0]
						#print(username)

			ctx.lists["user.teleportnames"]=t
			print("updated teleport listing",len(t))
		update_teleport_list(players_file, None)
		fs.watch(players_file, update_teleport_list)
		inited=True
if not inited:
	print("could not initialize teleport listing")

sandbox.init()
gmodutils.RunConsoleCommand("_talon_initializer")


### ==== pop/hiss ###

def on_pop(active):
	print("pop",active)
	gmodutils.RunConsoleCommand("_talon_cmd pop")

def on_hiss(active):
	print("hiss", active)
	gmodutils.RunConsoleCommand("_talon_cmd hiss %d" % (active and 1 or 0))

noise.register("hiss", on_hiss)
noise.register("pop", on_pop)
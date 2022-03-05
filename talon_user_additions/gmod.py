from talon import cron, imgui, Module, Context, screen, ui, actions, clip, app, fs, settings #, noise

from datetime import datetime
import os, subprocess
import time
from datetime import datetime
from . import gmodutils # TODO: This will NOT autoreload!!
from .gmodutils import sandbox  # TODO: Same!!!!!


toggled=False
mod = Module()

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
os: mac
and app.bundle: org.facepunch.gmod
"""

# Register some common tags, like admin mods
mod.tag("aowl", desc="Aowl commands")
mod.tag("ulx", desc="ulx commands")
mod.tag("arcvr", desc="arcvr")
mod.tag("sandbox", desc="sandbox commands")
mod.tag("sandbox_modded", desc="sandbox modded") #TODO
mod.tag("darkrp", desc="darkrp commands")
mod.tag("terrortown", desc="terrortown commands")


mod.list("gmod_baseweapons", desc="base weapons")


# We use this context to enable tags
ctx = Context()
ctx.matches = "app: gmod"


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

settings_tags=[]
runtime_tags=[]
def updateTags():
	tags = list(set(settings_tags + runtime_tags))
	print("tags are now",tags)
	ctx.tags = tags


# User actions
right=True
@mod.action_class
class Actions:
	def gmod_runcmd(c: str):
		"""Runs console command ingame"""
		gmodutils.RunConsoleCommand(c)

	def gmod_timefi():
		"""current time cmd"""
		now = datetime.now()
		current_time = now.strftime("%H:%M")
		gmodutils.RunConsoleCommand("say !tts The time is now "+current_time+"")

# ==== settings.json ==========
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
			print("settings tags",settings_tags)
			updateTags()

	update_settings(settings_path, None)
	fs.watch(settings_path, update_settings)

# ===== players.json (TODO: json) ======
players_file = gmodutils.GetTalonDataFolder() / 'players.json'
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
				if len(data)>0:
					t[data[1]]=data[0]
					#print(data[1])
		ctx.lists["user.teleportnames"]=t

	update_teleport_list(players_file, None)
	fs.watch(players_file, update_teleport_list)


sandbox.init()
gmodutils.getCreateTalonCfg()
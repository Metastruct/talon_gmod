
import os,sys,subprocess
from pathlib import Path

#TODO: This will break at some point (is there a better way)
def pipInstall(pkg):
	pip = Path(os.path.dirname(os.path.realpath(__file__))) / '../../.venv/Scripts/pip.bat'
	pip = pip.resolve()
	subprocess.call([str(pip),"install",pkg])

try:
	import vdf
except ImportError:
	pipInstall("vdf")
import vdf


import os,json
import winreg
import vdf
from functools import cache
from pprint import pprint as PrintTable

# Find GMod (Windows only for now)
def Is64Windows():
	return 'PROGRAMFILES(X86)' in os.environ

def GetProgramFiles32():
	if Is64Windows():
		return os.environ['PROGRAMFILES(X86)']
	else:
		return os.environ['PROGRAMFILES']

def GetProgramFiles64():
	if Is64Windows():
		return os.environ['PROGRAMW6432']
	else:
		return None

if Is64Windows() is True:
	key = winreg.OpenKey(winreg.HKEY_LOCAL_MACHINE, "SOFTWARE\\Wow6432Node\\Valve\\Steam")
else:
	key = winreg.OpenKey(winreg.HKEY_LOCAL_MACHINE, "SOFTWARE\\Valve\\Steam")
	
steampath =  winreg.QueryValueEx(key, "InstallPath")[0]
@cache
def GetSteamPath():
	return steampath

@cache
def getValveCMD():
	file_path = os.path.dirname(os.path.realpath(__file__))
	VALVECMD=file_path+'/valvecmd.exe'
	return VALVECMD

@cache
def GetSteamLibraryPaths():
	vdflocations=[steampath]
	
	with open(GetSteamPath() + "/SteamApps/LibraryFolders.vdf") as f:
		vdffile = vdf.parse(f)
		libfolders = vdffile.get('LibraryFolders')
		if libfolders:
			print("Found legaacy library folders")
			vdflocations = [val for key,val in libfolders.items() if key.isdigit()]+vdflocations
			for path in vdflocations:
				print("\tFound Library path: ",path)
		else:
			libfolders = vdffile.get('libraryfolders')
			if libfolders:
				vdflocations = [val["path"] for key,val in libfolders.items() if key.isdigit()]+vdflocations
				for path in vdflocations:
					print("\tFound Library path: ",path)
			else:
				print("[notice] No library folders?")
				
	return vdflocations
		
@cache
def GetGamePath(appid):
	for acfpath in GetSteamLibraryPaths():
		appmanifestpath = acfpath + "/SteamApps/appmanifest_%d.acf"%(appid)
		if os.path.isfile(appmanifestpath):
			with open(appmanifestpath) as f:
				appmanifest = vdf.parse(f)
				return Path(acfpath+"\\SteamApps\\common\\"+appmanifest['AppState']['installdir']+"\\")

@cache
def GetGModPath():
	return GetGamePath(4000)

@cache
def GetTalonDataFolder():
	fld = GetGModPath() / 'garrysmod/data/talonvoice/'
	return fld

def getTalonSettingsPath():
	fld=GetTalonDataFolder()

	file = fld / 'settings.json'

	return file

import time,re
def getCreateTalonCfg():
	fld=GetGModPath()
	file = fld / 'garrysmod/cfg/talon.cfg'
	if not file.exists():
		with file.open("w") as f:
			f.write("echo talon config enable\ntalon_ts "+str(int(time.time()))+"\n")
		print("Created talon.cfg")
		
	else:
		with file.open("r") as f:
			data=f.read()

		data=re.sub(r"^(talon_ts )\d+$",lambda x:x.group(1)+str(int(time.time())),data,flags=re.MULTILINE)

		with file.open("w") as f:
			f.write(data)
	
	file.touch(0o777,True) # Make sure file is updated

	return file

def readTalonAutogenSettings():
	file = getTalonSettingsPath()
	if not file or not file.exists():
		return None

	with file.open("r") as f:
		conf = json.load(f)
		return conf

def RunConsoleCommand(c: str):
	#print("HELLO")
	#print(getValveCMD())
	si = subprocess.STARTUPINFO()
	si.dwFlags |= subprocess.STARTF_USESHOWWINDOW
	#si.wShowWindow = subprocess.SW_HIDE # default
	CREATE_NO_WINDOW = 0x08000000
	DETACHED_PROCESS = 0x00000008
	subprocess.call([getValveCMD(), c],creationflags=DETACHED_PROCESS)#,startupinfo=si)

def PrintMessageIngame(msg):
	RunConsoleCommand("_talon_message "+msg)


if __name__ == "__main__":
	import pprint
	pprint.pprint(readTalonAutogenSettings())
	pprint.pprint("gmod=",GetGModPath())
	RunConsoleCommand("say Testing test test!")
	
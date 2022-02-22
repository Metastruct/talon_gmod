
import time
from talon import Module, screen, ui, actions, clip, app, settings
from datetime import datetime
import os, subprocess

from talon import Module
import time

import os

file_path = os.path.dirname(os.path.realpath(__file__))
VALVECMD=file_path+'/valvecmd.exe'
print(VALVECMD)

from talon import noise
from datetime import datetime
toggled=False
def on_pop(active):
	print("lip pop sound done...")

noise.register("pop", on_pop)

mod = Module()
right=True
@mod.action_class
class Actions:
	def runcmd(c: str):
		"""cmdrun"""
		subprocess.call([VALVECMD, c])

	def timefi():
		"""current time cmd"""
		now = datetime.now()
		current_time = now.strftime("%H:%M")
		subprocess.call([VALVECMD, "say !tts The time is now "+current_time+""])

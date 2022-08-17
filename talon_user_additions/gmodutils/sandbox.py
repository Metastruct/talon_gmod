def genMapping(str):
	lines=str.splitlines()
	ret = {}
	for l in lines:
		if not l.strip():
			continue
		id,callers = l.split(",",1)
		ret[id]=callers.split(",")
	return ret

weapons_raw = """weapon_ar2,ar2,ar two
weapon_bugbait,bug bait,bugbait
weapon_crossbow,crossbow,cross bow
weapon_crowbar,crow bar,crowbar
weapon_357,revolver,revolver magnum,three five seven magnum,three five seven
none,none,nan
weapon_slam,tripmine,trip mine,slam,selectable lightweight attack munition
weapon_frag,frag grenade,grenade,half life two grenade
weapon_physcannon,physcannon,physics cannon,physics weapon,gravity gun
weapon_physgun,physics gun,physgun,physics manipulator
weapon_pistol,pistol,half life two pistol
weapon_rpg,rpg,rocket launcher,rocket propeller gun
weapon_shotgun,shot gun,shotgun
weapon_smg1,smg one,s m g,s m g one,smg one,uzi
weapon_stunstick,stun stick,stunstick
gmod_tool,toolgun,tool gun"""

# todo move
weapons_raw+="""
arcticvr_m9,vr beretta am nine,vr beretta m9,vr beretta
arcticvr_deagle,vr desert eagle,vr deagle
arcticvr_glock,vr glock
arcticvr_mac10,vr mac,vr mac ten
arcticvr_tmp,vr tmp,vr steyr tmp,vr silenced gun
arcticvr_usptactical,vr pistol"""

weapons=genMapping(weapons_raw)

props=genMapping("""models/props_junk/wood_crate001a.mdl,crate
models/Items/item_item_crate.mdl,small crate
models/props_borealis/bluebarrel001.mdl,blue barrel
models/props_c17/oildrum001.mdl,oildrum,oil drum,oil barrel
models/props_c17/oildrum001_explosive.mdl,explosive oildrum,explosive oil drum,explosive oil barrel
models/props_c17/furnitureStove001a.mdl,stove,a stove
models/props_interiors/pot02a.mdl,pot,a pot
models/props_interiors/pot01a.mdl,kettle,a kettle
models/props_junk/PopCan01a.mdl,pop can,soda can
models/props_interiors/Radiator01a.mdl,radiator
models/props_junk/TrafficCone001a.mdl,traffic cone,cone
models/props_junk/propane_tank001a.mdl,propane tank
models/props_trainstation/trashcan_indoor001b.mdl,trashcan,trash can
models/props_interiors/VendingMachineSoda01a.mdl,vending machine
models/props_c17/FurnitureDrawer001a.mdl,furniture drawer
models/props_lab/clipboard.mdl,clipboard,clip board
models/props_lab/frame002a.mdl,family frame
models/props_interiors/Furniture_Lamp01a.mdl,furniture lamp
models/props_lab/huladoll.mdl,hula doll
models/props_lab/citizenradio.mdl,citizen radio
models/props_junk/harpoon002a.mdl,harpoon
models/props_lab/binderblue.mdl,book
models/props_junk/GlassBottle01a.mdl,glass bottle
models/props_junk/sawblade001a.mdl,saw blade,sawblade
models/props_junk/wood_crate002a.mdl,wide crate
models/props_wasteland/barricade001a.mdl,barricade
models/props_c17/FurnitureTable001a.mdl,desk
models/props_interiors/Furniture_chair01a.mdl,chair
models/props_junk/gascan001a.mdl,gas can,gascan
models/props_junk/metal_paintcan001a.mdl,paint can
models/props_c17/fence01a.mdl,fence
models/props_trainstation/bench_indoor001a.mdl,bench
models/props_foliage/tree_poplar_01.mdl,tree
models/props_combine/breenchair.mdl,breen chair
models/props_junk/CinderBlock01a.mdl,brick,a brick
models/props_wasteland/gaspump001a.mdl,gas pump
models/props_combine/breendesk.mdl,breen desk
models/props_c17/FurnitureCouch001a.mdl,couch,furniture couch
models/props_junk/TrashDumpster02.mdl,dumpster,trash dumpster
models/props_vehicles/tire001c_car.mdl,tire,a tire
models/props_junk/garbage_coffeemug001a.mdl,coffee mug,mug,cup,coffee cup
models/props_junk/watermelon01.mdl,watermelon""")

vehicles=genMapping("""Jeep,Jeep
Airboat,Air boat,airboat
Chair_Wood,wooden chair
Chair_Office2,breen chair,office chair
Chair_Plastic,chair,normal chair""")
tools=genMapping("""weld,weld
rope,rope
light,light
button,button
dynamite,dynamite
paint,paint
inflator,inflator
material,material
balloon,balloons,balloon
remover,remover,remove""")

npcs=genMapping("""npc_zombie,a zombie,zombie
npc_dog,dog
Rebel,rebel
npc_citizen,citizen
npc_vortigaunt,vortigaunt
npc_breen,breen
npc_headcrab,head crab,headcrab
npc_antlion,antlion,ant lion
npc_antlion_grub,ant lion grub,antlion grub
npc_turret_floor,combine turret,enemy turret
npc_combine_s,combine solider,combine solder
npc_rollermine,roller mine,rollermine
npc_cscanner,city scanner,scanner
npc_manhack,man hack,manhack
npc_barney,barney
npc_eli,eli vance
Medic,medic""")


sents=genMapping("""sent_ball,ball
item_healthkit,health kit,medkit,med kit
item_healthvial,health vial,healthvial,tiny medkit,small medkit
item_battery,suit battery,battery
combine_mine,combine mine
item_ammo_pistol_large,pistol ammo,ammo pistol
item_ammo_smg1_grenade,s m g grenade,smg grenade""")

spawners={
	"npc": npcs,
	"weapon": weapons,
	"vehicle": vehicles,
	"prop": props,
	"entity": sents,
	"tools": tools,
}

def init():
	from talon import Module, Context, actions

	mod = Module()

	ctx = Context()
	ctx.matches = r"""
	tag: user.sandbox
	"""
	for spawn_type,objects in spawners.items():
		mapping={}
		for name,aliases in objects.items():
			for alias in aliases:
				mapping[alias]=name
		listname="sandbox_"+spawn_type
		mod.list(listname, desc="Sandbox "+spawn_type)
		ctx.lists["user."+listname] = mapping
	return (ctx,mod)

if __name__ == "__main__":
	import pprint
	pprint.pprint(spawners)

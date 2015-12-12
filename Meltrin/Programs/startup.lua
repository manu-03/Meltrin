term.clear()
term.setCursorPos(1,1)
function log(str,_level)
	if not fs.exists("/Meltrin/main.log") then fs.open("/Meltrin/main.log","w").close() end
	f = fs.open("/Meltrin/main.log","a") f.write("["..(_level or "Normal").."] "..str.."\n") f.close()
	print(str)
end
log("Started!")
log("Loading boot config...")
f = fs.open("/Meltrin/Config/boot.cfg","r")
h = f.readAll()
f.close()
boot = textutils.unserialize(h)
log("Loaded!")
for k,v in ipairs(fs.list("/Meltrin/APIs")) do
	os.loadAPI("/Meltrin/APIs/"..v)
	log("Loaded API "..v)
end
log("All APIs loaded")
log("Starting update detection")
shell.run("/Meltrin/Programs/update.lua","check")
log("Ended update detection")
log("Press F8 to enter BIOS setup/Recovery mode")
log("In "..boot.seconds.." seconds, OS will be booted")
t = os.startTimer(boot.seconds)
while true do
	e,v1 = os.pullEventRaw()
	if e == "key" and v1 == keys.f8 then
		setup = true
		break
	elseif e == "timer" and v1 == t then
		break
	end
end
if setup then
	shell.run("/Meltrin/Programs/setup.lua")
end
for k,v in ipairs(boot.run) do
	shell.run(v)
end

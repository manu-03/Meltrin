url = ""
v = os.version()
nv = http.get(url).readAll()
if nv > v then
log("Update found!")
log("Actual version: "..v)
log("New version: "..nv)
log("Update? Press LShift to accept, other to cancel")
_,k = os.pullEventRaw("key")
if k == keys.lshift then
	log("Updating")
	--Update
else
	log("Cancelled")
end
end
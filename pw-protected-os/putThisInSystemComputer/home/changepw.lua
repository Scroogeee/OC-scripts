local filesystem = require("filesystem")
local component = require("component")
local cmpfilepath = "/disk/keyhash.txt"

print("new password:")
local pw = require("uuid").next()
print("The new pw is:")
print(pw)
pw = component.data.sha256(pw)

local cmpfile = io.open(cmpfilepath,"w")
io.output(cmpfile)
io.write(pw)
io.close(file)
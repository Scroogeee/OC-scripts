--get the filesystem
local filesystem = require("filesystem")
--get the component api for the data card (crypto)
local component = require("component")

--set keyfilepath and cmpfilepath
local keyfilepath = "/key/keyfile.txt"
local cmpfilepath = "/disk/keyhash.txt"

--generate the new password
local pw = require("uuid").next()

--define functions

local function run()
  print("The new pw is:")
  print(pw)
  --if there is a valid drive mounted under /key
  if (filesystem.exists("/key")) then
    --if there is an old keyfile, delete it
    if (filesystem.exists(keyfilepath)) then
      filesystem.remove(keyfilepath)
    end
    --write the new pw to the keyfile
    local keyfile = io.open(keyfilepath, "w")
    io.output(keyfile)
    io.write(pw)
    io.close(keyfile)
  end
  --compute the hash of the password
  pw = component.data.sha256(pw)
  --if there is an old cmpfile, delete it
  if (filesystem.exists(cmpfilepath)) then
    filesystem.remove(cmpfilepath)
  end
  --write the new hash to the cmpfile
  local cmpfile = io.open(cmpfilepath, "w")
  io.output(cmpfile)
  io.write(pw)
  io.close(cmpfile)
end

--execution
run()

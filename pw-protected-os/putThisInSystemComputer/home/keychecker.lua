--get the filesystem
local filesystem = require("filesystem")
--get the data card
local component = require("component")
--get the computer reference
local computer = require("computer")

local keyfilepath = "/key/keyfile.txt"
local cmpfilepath = "/disk/keyhash.txt"

local keyCorrect = false

while(not(keyCorrect)) do

print("waiting for key")
local foundKey = false

while (not(foundKey)) do
os.sleep(5)
--check for a keyfile
foundKey = filesystem.exists(keyfilepath)
end

print("found keyfile")
local keyfile=io.lines(keyfilepath)

local proposedkey = ""
for c in keyfile do
--append the file contents to make the proposed key
proposedkey=proposedkey..c
end

--hash the key
proposedkey = component.data.sha256(proposedkey)

local actualkeyhash=""
local cmpfile = io.lines(cmpfilepath)

for c in cmpfile do
actualkeyhash = actualkeyhash..c
end

if (proposedkey==actualkeyhash) then
keyCorrect = true
else
print("Incorrect!")
computer.beep(391.995,0.5)
computer.beep(311.127,0.5)
computer.beep(261.626,0.5)
os.sleep(5)
end

end

print("Correct Key!")
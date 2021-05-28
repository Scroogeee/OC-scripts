--get the filesystem
local filesystem = require("filesystem")
--get the component api for the data card (crypto)
local component = require("component")
--get event
local event = require("event")
--get note for beeps
local note = require("note")
--get shell for clearing the screen
local shell = require ("shell")

--define other necessary variables

local keyfilepath = "/key/keyfile.txt"
local cmpfilepath = "/disk/keyhash.txt"

local keyCorrect = false;

--define functions

local function checkKey()
  local keyfile = io.lines(keyfilepath)

  local proposedkey = ""
  for c in keyfile do
    --append the file contents to make the proposed key
    proposedkey = proposedkey..c
  end

  --hash the key
  proposedkey = component.data.sha256(proposedkey)

  local actualkeyhash = ""
  local cmpfile = io.lines(cmpfilepath)

  for c in cmpfile do
    actualkeyhash = actualkeyhash..c
  end

  if (proposedkey == actualkeyhash) then
    return true
  else
    shell.execute("cls")
    print("Key incorrect!")
    print("waiting for key...")
    note.play("G4", 0.2)
    note.play("Eb4", 0.2)
    note.play("C4", 0.2)
    return false
  end
end

local function run()
  --remove the welcome screen since no key was entered yet
  shell.execute("cls")
  --inform the user
  print("waiting for key...")
  while(not(keyCorrect)) do
    --print("new component available:")
    --print(address)
    --check for a keyfile
    local _, address, type = event.pull("component_added")
    foundKey = filesystem.exists(keyfilepath)
    if (foundKey) then
      print("found keyfile")
      keyCorrect = checkKey()
    end
  end

  print("Correct Key!")
  note.play("C4", 0.1)
  note.play("E4", 0.1)
  note.play("G4", 0.1)
  note.play("C5", 0.2)
end

--execution
run()
--put up the welcome screen
shell.execute("cls")
shell.execute("/etc/motd")

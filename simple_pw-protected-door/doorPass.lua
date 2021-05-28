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
--get sides api for redstone
local sides = require("sides")

--define other necessary variables

local keyfilepath = "/key/keyfile.txt"
local cmpfilepath = "/disk/keyhash.txt"

local openDoor = false;

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
    return false
  end
end

local function onComponentAdd()
  local foundKey = filesystem.exists(keyfilepath)
  if (foundKey) then
    print("found keyfile")
    openDoor = checkKey()
    shell.execute("cls")
    if (openDoor) then
      print("Correct Key!")
      note.play("C4", 0.1)
      note.play("E4", 0.1)
      note.play("G4", 0.1)
      note.play("C5", 0.2)
      --open the door
      component.redstone.setOutput(sides.right, 15)
    else
      print("Key incorrect!")
      print("waiting for key...")
      note.play("G4", 0.2)
      note.play("Eb4", 0.2)
      note.play("C4", 0.2)
    end
  end
end

local function onComponentRemove()
  --close the door
  component.redstone.setOutput(sides.right, 0)
  openDoor = false;
end

local function run()
  while(true) do
    --remove the welcome screen since no key was entered yet
    shell.execute("cls")
    --inform the user
    print("waiting for key...")
    local id, _, address, type = event.pullMultiple("component_added", "component_removed")
    if (id == "component_added") then
      onComponentAdd()
    elseif (id == "component_removed") then
      onComponentRemove()
    end
    os.sleep(1)
  end
end

--execution
shell.execute("resolution 20 6")
run()

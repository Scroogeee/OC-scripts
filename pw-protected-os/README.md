# Passwort-protection on OS startup
These files are for a password-on-floppy protection system.
The files in putThisOnFloppy should be put onto the floppydisk, autorun automatically mounts the floppy and the keyfile contains the proposed key.
The files in putThisInSystemComputer should be put onto the computer that does the checks.

## Usage
- cmpfilepath in keychecker.lua should be set to the path of the comp file where the hashed key is stored. (on the computer)
- keyfilepath in keychecker.lua should be set to the default path where the keyfile.txt (containing the proposed unhashed key) is expected on the "key-floppy"

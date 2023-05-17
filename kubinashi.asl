// Kubinashi Recollection AutoSplitter
// Tested on Steam version 1.02C



state("DullahanRecollection")
{
	int fileSelect: 0x443D4C, 0, 0xB4C, 0xC, 0xCC;
	int levelComplete: 0x443D4C, 0, 0x218, 0xC, 0xCC;
}

startup
{
	settings.Add("resetOnFileSelect", false, "Reset on File Select");
	settings.SetToolTip("resetOnFileSelect", "Disable if you are doing Alt+F4 cutscene skips");
}

start
{
	if (current.fileSelect == 1 && old.fileSelect == 0) {
		return true;
	}
}

split
{
	// print("fileSelect: " + current.fileSelect + "; " + old.fileSelect);
	// print("levelComplete: " + current.levelComplete + "; " + old.levelComplete);
	if (current.levelComplete == 1 && old.levelComplete == 0) {
		return true;
	}
}

reset
{
	if (!settings["resetOnFileSelect"]) return;
	if (current.fileSelect == 1 && old.fileSelect == 0) {
		return true;
	}
}

/*
// File Select
"DullahanRecollection.exe"+00443D4C, 0, B4C, C, CC
"DullahanRecollection.exe"+00443D4C, 0, B4C, C, D8
"DullahanRecollection.exe"+00443D4C, 0, B54, 2C, CC
"DullahanRecollection.exe"+00443D4C, 0, B54, 2C, D8

// Level Complete
"DullahanRecollection.exe"+00443D4C, 0, 218, C, CC
"DullahanRecollection.exe"+00443D4C, 0, 218, C, D8
"DullahanRecollection.exe"+00443D4C, 0, 220, 2C, CC
"DullahanRecollection.exe"+00443D4C, 0, 220, 2C, D8
"DullahanRecollection.exe"+00443D4C, 0, 934, C, CC
"DullahanRecollection.exe"+00443D4C, 0, 934, C, D8
"DullahanRecollection.exe"+00443D4C, 0, 93C, 2C, CC
"DullahanRecollection.exe"+00443D4C, 0, 93C, 2C, D8

// In Level
DullahanRecollection.exe+42C1E8

// 0 = NG skip prologue menu; 1 = not in level; 2 = in level
DullahanRecollection.exe+42C7F4
*/

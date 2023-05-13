// Kubinashi Recollection AutoSplitter
// Tested on Steam version 1.02C



state("DullahanRecollection")
{
	int levelComplete: 0x655F7C, 0x248, 0xC, 0xCC;
	int fileSelect: 0x655F80, 0xB6C, 0xC, 0xCC;
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
// Level Complete
"DullahanRecollection.exe"+00655F7C, CC, C, 248
"DullahanRecollection.exe"+00655F7C, CC, 2C, 250
"DullahanRecollection.exe"+00655F80, CC, C, 238
"DullahanRecollection.exe"+00655F80, CC, 2C, 240

// In Level
DullahanRecollection.exe+42C1E8

// 0 = NG skip prologue menu; 1 = not in level; 2 = in level
DullahanRecollection.exe+42C7F4

// File Select
"DullahanRecollection.exe"+00655F80, CC, C, B6C
"DullahanRecollection.exe"+00655F80, CC, 2C, B74
*/

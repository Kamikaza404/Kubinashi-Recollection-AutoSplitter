// Kubinashi Recollection AutoSplitter
// Tested on Steam version 1.02C


// rank update happens on the next frame after levelComplete
state("DullahanRecollection")
{
	// int levelComplete: 0x443D4C, 0, 0x218, 0xC, 0xCC;
	int fileSelect: 0x443D4C, 0, 0xB4C, 0xC, 0xCC;
	int room: 0x6561E0;
	int puzzlePiece: 0x443D4C, 0, 0x6E0, 0xC, 0xCC; // 0 = collected; 1 = not collected
	double rank: 0x445C40, 0x60, 0x10, 0x70, 0x2B0; // 1 = bronze; 2 = silver; 3 = gold; 4 = platinum
	double secretCreateInput: 0x445C40, 0x60, 0x10, 0x97C, 0; // 1367 (HEADLESS) (but outfit unlocks after 60 frames technically)
	double secretCreateEsc: 0x445C40, 0x60, 0x10, 0x970, 0;
	int passwordEntered: 0x443D4C, 0, 0x9D4, 0xC, 0xCC;
	double a_33: 0x445C40, 0x60, 0x10, 0x4, 0x1120; // Nine Head Clear
	double a_34: 0x445C40, 0x60, 0x10, 0x4, 0x1110; // Jelly Attack Platinum
	double a_40: 0x445C40, 0x60, 0x10, 0x4, 0x10B0; // All Achievements
}

startup
{
	// SETTINGS
	settings.Add("resetOnFileSelect", false, "Reset on File Select");
	settings.SetToolTip("resetOnFileSelect", "Disable if you are doing Alt+F4 cutscene skips");

	settings.Add("splitConditions", false, "Split only if these conditions have been met");
	settings.CurrentDefaultParent = "splitConditions";
	settings.Add("splitOnlyIfPuzzlePiece", false, "Puzzle piece was collected in the level");
	settings.Add("splitOnlyIfPlatinum", false, "The level was completed on platinum");
	settings.CurrentDefaultParent = null;

	settings.Add("splitOnHeadlessPassword", false, "Split on entering \"HEADLESS\" password");
	settings.Add("splitOnNineHeadClear", false, "Split on first Nine Head Mode clear");
	settings.SetToolTip("splitOnNineHeadClear", "It will only work on a new save file since it actually splits on getting the achievement for it");
	settings.Add("splitOnJellyAttackPlatinum", false, "Split on first Jelly Attack platinum");
	settings.SetToolTip("splitOnJellyAttackPlatinum", "It will only work on a new save file since it actually splits on getting the achievement for it");
	settings.Add("splitOnAllAchievements", false, "Split on completing all achievements");


	// ROOM LIST
	vars.rooms = new List<int> {
		30, 31, 32, 33, 34,         // rm_T01 - rm_T05
		36, 37, 38, 39, 40,         // rm_201 - rm_205
		42, 43, 44, 45, 46,         // rm_301 - rm_305
		48, 49, 50, 51, 52,         // rm_401 - rm_405
		54, 55, 56, 57, 58,         // rm_501 - rm_505
		60, 61, 62, 63, 64,         // rm_601 - rm_605
		66, 67, 68, 69, 70,         // rm_701 - rm_705
		72, 73, 74, 75, 76,         // rm_801 - rm_805
		78, 79, 80, 81, 82,         // rm_901 - rm_905
		84, 85, 86, 87, 88,         // rm_1001 - rm_1005
		93, 94, 95, 96, 97, 98, 99  // rm_omake - rm_omake7
	};

	// VARIABLES
	vars.splits = new List<int>();
	vars.pieces = new List<int>();
	vars.platinums = new List<int>();
	vars.headlessBanki = false;
	vars.nineHeadClear = false;
	vars.jellyAttackPlatinum = false;
	vars.allAchievements = false;
	vars.timerOldPhase = timer.CurrentPhase;

	// FUNCTIONS
	vars.Reset = (Func<bool>)(() => {
		print("reset");
		vars.splits.Clear();
		vars.pieces.Clear();
		vars.platinums.Clear();
		vars.headlessBanki = false;
		vars.nineHeadClear = false;
		vars.jellyAttackPlatinum = false;
		vars.allAchievements = false;
		return true;
	});
}

update
{
	// if (timer.CurrentPhase != vars.timerOldPhase) print(String.Format("TimerPhase: {0} => {1}", vars.timerOldPhase, timer.CurrentPhase));
	if (timer.CurrentPhase != vars.timerOldPhase) {
		if (timer.CurrentPhase == TimerPhase.NotRunning) {
			vars.Reset();
		}
		vars.timerOldPhase = timer.CurrentPhase;
	}
}

start
{
	if (current.fileSelect == 1 && old.fileSelect == 0) {
		return true;
	}
}

split
{
	// if (current.levelComplete != old.levelComplete) print(String.Format("levelComplete: {0} => {1}", old.levelComplete, current.levelComplete));
	// if (current.fileSelect != old.fileSelect) print(String.Format("fileSelect: {0} => {1}", old.fileSelect, current.fileSelect));
	// if (current.room != old.room) print(String.Format("room: {0} => {1}", old.room, current.room));
	// if (current.puzzlePiece != old.puzzlePiece) print(String.Format("puzzlePiece: {0} => {1}", old.puzzlePiece, current.puzzlePiece));
	// if (current.rank != old.rank) print(String.Format("rank: {0} => {1}", old.rank, current.rank));
	// if (current.secretCreateInput != old.secretCreateInput) print(String.Format("secretCreateInput: {0} => {1}", old.secretCreateInput, current.secretCreateInput));
	// if (current.secretCreateEsc != old.secretCreateEsc) print(String.Format("secretCreateEsc: {0} => {1}", old.secretCreateEsc, current.secretCreateEsc));
	// if (current.passwordEntered != old.passwordEntered) print(String.Format("passwordEntered: {0} => {1}", old.passwordEntered, current.passwordEntered));
	// if (current.a_33 != old.a_33) print(String.Format("a_33 (ninehead): {0} => {1}", old.a_33, current.a_33));
	// if (current.a_34 != old.a_34) print(String.Format("a_34 (jellyattack): {0} => {1}", old.a_34, current.a_34));
	// if (current.a_40 != old.a_40) print(String.Format("a_40 (allachievements): {0} => {1}", old.a_40, current.a_40));

	// Level Completion
	if (current.rank > 0 && old.rank == 0 && vars.rooms.Contains(current.room) && !vars.splits.Contains(current.room)) {
		// Platinums
		if (current.rank == 4 && !vars.platinums.Contains(current.room)) {
			vars.platinums.Add(current.room);
			// print("Platinum in " + current.room);
		}
		// Puzzle Pieces
		if (current.puzzlePiece == 0 && !vars.pieces.Contains(current.room)) {
			vars.pieces.Add(current.room);
			// print("Puzzle Piece in " + current.room);
		}
		// Split
		if (settings["splitOnlyIfPuzzlePiece"] && !vars.pieces.Contains(current.room)) return;
		if (settings["splitOnlyIfPlatinum"] && !vars.platinums.Contains(current.room)) return;
		if (!vars.splits.Contains(current.room)) {
			vars.splits.Add(current.room);
			return true;
		}
	}

	// Headless Banki Outfit
	if (settings["splitOnHeadlessPassword"] && !vars.headlessBanki
		&& (current.passwordEntered == 1 && old.passwordEntered == 0)
		&& (current.secretCreateInput == 1367 || current.secretCreateEsc == 1367))
	{
		vars.headlessBanki = true;
		return true;
	}

	// Nine Head Mode Achievement
	if (settings["splitOnNineHeadClear"] && !vars.nineHeadClear && current.a_33 == 1 && old.a_33 == 0) {
		vars.nineHeadClear = true;
		return true;
	}

	// Jelly Attack Achievement
	if (settings["splitOnJellyAttackPlatinum"] && !vars.jellyAttackPlatinum && current.a_34 == 1 && old.a_34 == 0) {
		vars.jellyAttackPlatinum = true;
		return true;
	}

	// All Achievements
	if (settings["splitOnAllAchievements"] && !vars.allAchievements && current.a_40 == 1 && old.a_40 == 0) {
		vars.allAchievements = true;
		return true;
	}

	// // Old
	// if (current.levelComplete == 1 && old.levelComplete == 0) {
	// 	return true;
	// }
}

reset
{
	if (!settings["resetOnFileSelect"]) return;
	if (current.fileSelect == 1 && old.fileSelect == 0) {
		vars.Reset();
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

// Room ID
DullahanRecollection.exe+6561E0

// Bad Puzzle Piece (0 = collected || paused || not in level; 1 = not collected && not paused && in level)
"DullahanRecollection.exe"+00443D4C, 0, 6E0, C, CC
"DullahanRecollection.exe"+00443D4C, 0, 6E0, C, D8
"DullahanRecollection.exe"+00443D4C, 0, 6E8, 2C, CC
"DullahanRecollection.exe"+00443D4C, 0, 6E8, 2C, D8

// global.rank
"DullahanRecollection.exe"+00445C40, 60, 10, 70, 2B0
"DullahanRecollection.exe"+00445C44, 60, 10, 70, 2B0

// global.secretCreate INPUT
"DullahanRecollection.exe"+00445C40, 60, 10, 97C, 0
"DullahanRecollection.exe"+00445C44, 60, 10, 97C, 0
"DullahanRecollection.exe"+0043550C, 0, 60, 10, 97C, 0

// global.secretCreate ESC
"DullahanRecollection.exe"+00445C40, 60, 10, 970, 0
"DullahanRecollection.exe"+00445C44, 60, 10, 970, 0
"DullahanRecollection.exe"+0043550C, 0, 60, 10, 970, 0

// Password Entered
"DullahanRecollection.exe"+00443D4C, 0, 9D4, C, CC
"DullahanRecollection.exe"+00443D4C, 0, 9D4, C, D8
"DullahanRecollection.exe"+00443D4C, 0, 9DC, 1C, CC
"DullahanRecollection.exe"+00443D4C, 0, 9DC, 1C, D8
"DullahanRecollection.exe"+00443D4C, 0, 9E4, 2C, CC
"DullahanRecollection.exe"+00443D4C, 0, 9E4, 2C, D8

// --- offset between achievement addresses = 0x10 (16) ---
// global.a_33 (first nine head mode clear)
"DullahanRecollection.exe"+00445C40, 60, 10, 4, 1120
"DullahanRecollection.exe"+00445C40, 60, 10, 10, 1130
"DullahanRecollection.exe"+00445C40, 60, 10, 1C, 1140

// global.a_34 (first jelly attack platinum)
"DullahanRecollection.exe"+00445C40, 60, 10, 4, 1110
"DullahanRecollection.exe"+00445C40, 60, 10, 10, 1120
"DullahanRecollection.exe"+00445C40, 60, 10, 1C, 1130

// global.a_40 (all achievements)
"DullahanRecollection.exe"+00445C40, 60, 10, 4, 10B0
"DullahanRecollection.exe"+00445C40, 60, 10, 10, 10C0
"DullahanRecollection.exe"+00445C40, 60, 10, 1C, 10D0


// In Level
DullahanRecollection.exe+42C1E8

// 0 = NG skip prologue menu; 1 = not in level; 2 = in level
DullahanRecollection.exe+42C7F4
*/

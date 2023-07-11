// Kubinashi Recollection AutoSplitter
// Tested on Steam version 1.02C


// rank update happens on the next frame after levelComplete
// offset between achievement addresses = 0x10 (16)
// Puzzle Piece (0 = collected || paused || not in level; 1 = not collected && not paused && in level)
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
	double a_28: 0x445C40, 0x60, 0x10, 0x4, 0x1170; // True Ending
	double a_31: 0x445C40, 0x60, 0x10, 0x4, 0x1140; // Die 100 times
	double a_32: 0x445C40, 0x60, 0x10, 0x4, 0x1130; // 100 Level Clears
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

	settings.Add("achievements", false, "Achievements");
	settings.CurrentDefaultParent = "achievements";
	settings.Add("splitOnTrueEnding", false, "Split on True Ending achievement");
	settings.Add("splitOn100Deaths", false, "Split on 100 deaths achievement");
	settings.Add("splitOn100Clears", false, "Split on 100 level clears achievements");
	settings.Add("splitOnNineHeadClear", false, "Split on Nine Head Mode clear achievement");
	settings.Add("splitOnJellyAttackPlatinum", false, "Split on Jelly Attack platinum achievement");
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
	vars.trueEnding = false;
	vars.die100Times = false;
	vars.levelClear100Times = false;
	vars.nineHeadClear = false;
	vars.jellyAttackPlatinum = false;
	vars.allAchievements = false;
	vars.timerOldPhase = timer.CurrentPhase;

	// FUNCTIONS
	Action Reset = () => {
		print("reset");
		vars.splits.Clear();
		vars.pieces.Clear();
		vars.platinums.Clear();
		vars.headlessBanki = false;
		vars.trueEnding = false;
		vars.die100Times = false;
		vars.levelClear100Times = false;
		vars.nineHeadClear = false;
		vars.jellyAttackPlatinum = false;
		vars.allAchievements = false;
	};
	vars.Reset = Reset;
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
	// if (current.a_28 != old.a_28) print(String.Format("a_28 (trueend): {0} => {1}", old.a_28, current.a_28));
	// if (current.a_31 != old.a_31) print(String.Format("a_31 (100deaths): {0} => {1}", old.a_31, current.a_31));
	// if (current.a_32 != old.a_32) print(String.Format("a_32 (100clears): {0} => {1}", old.a_32, current.a_32));
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

	// True Ending Achievement
	if (settings["splitOnTrueEnding"] && !vars.trueEnding && current.a_28 == 1 && old.a_28 == 0) {
		vars.trueEnding = true;
		return true;
	}

	// Die 100 Times Achievement
	if (settings["splitOn100Deaths"] && !vars.die100Times && current.a_31 == 1 && old.a_31 == 0) {
		vars.die100Times = true;
		return true;
	}

	// Level Clear 100 Times Achievement
	if (settings["splitOn100Clears"] && !vars.levelClear100Times && current.a_32 == 1 && old.a_32 == 0) {
		vars.levelClear100Times = true;
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

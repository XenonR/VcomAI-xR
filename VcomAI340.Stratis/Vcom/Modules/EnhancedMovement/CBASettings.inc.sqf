// Included only by the guarded Settings CBA entry point.

[
	"VCM_AISkills_General_EM", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
	"CHECKBOX", // setting type
	"AI will use Enhanced Movement", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
	"VCOM SETTINGS", // Pretty name of the category where the setting can be found. Can be stringtable entry.
	true,// data for this setting:
	true, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
	{
		params ["_value"];
		Vcm_AI_EM = _value;
	} // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;

[
	"VCM_AISkills_General_EM_CHN", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
	"SLIDER", // setting type
	"Chance AI squads will use Enhanced Movement - every 0.5 secs", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
	"VCOM SETTINGS", // Pretty name of the category where the setting can be found. Can be stringtable entry.
	[0,100,10,0], // data for this setting: [min, max, default, number of shown trailing decimals]
	true, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
	{
		params ["_value"];
		Vcm_AI_EM_CHN = _value;
	} // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;

[
	"VCM_AISkills_General_EM_CLDWN", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
	"SLIDER", // setting type
	"Cool down on Enhanced Movement - in secs", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
	"VCOM SETTINGS", // Pretty name of the category where the setting can be found. Can be stringtable entry.
	[0,1000,10,0], // data for this setting: [min, max, default, number of shown trailing decimals]
	true, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
	{
		params ["_value"];
		VCM_AI_EM_CLDWN = _value;
	} // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;

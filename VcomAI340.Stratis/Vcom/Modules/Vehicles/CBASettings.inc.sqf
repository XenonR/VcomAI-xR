// Included only by the guarded Settings CBA entry point.

[
	"VCM_CARGOCHNG", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
	"CHECKBOX", // setting type
	"Vcom handling of disembark/embarking for AI?", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
	"VCOM SETTINGS", // Pretty name of the category where the setting can be found. Can be stringtable entry.
	true,// data for this setting:
	true, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
	{
		params ["_value"];
		VCM_CARGOCHNG = _value;
	} // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;

[
	"VCM_TURRETUNLOAD", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
	"CHECKBOX", // setting type
	"Disembark from turret positions?", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
	"VCOM SETTINGS", // Pretty name of the category where the setting can be found. Can be stringtable entry.
	true,// data for this setting:
	true, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
	{
		params ["_value"];
		VCM_TURRETUNLOAD = _value;
	} // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;

[
	"VCM_DISEMBARKRANGE", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
	"SLIDER", // setting type
	"Distance AI disembark from the enemy?", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
	"VCOM SETTINGS", // Pretty name of the category where the setting can be found. Can be stringtable entry.
	[50,1000,200,0], // data for this setting: [min, max, default, number of shown trailing decimals]
	true, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
	{
		params ["_value"];
		VCM_DISEMBARKRANGE = _value;
	} // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;

[
	"VCM_StealVeh", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
	"CHECKBOX", // setting type
	"AI steal empty/unlocked vehicles?", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
	"VCOM SETTINGS", // Pretty name of the category where the setting can be found. Can be stringtable entry.
	true,// data for this setting:
	true, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
	{
		params ["_value"];
		VCM_StealVeh = _value;
	} // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;

[
	"VCM_ClassSteal", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
	"CHECKBOX", // setting type
	"Class restriction for stealing vehicles", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
	"VCOM SETTINGS", // Pretty name of the category where the setting can be found. Can be stringtable entry.
	true,// data for this setting:
	true, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
	{
		params ["_value"];
		VCM_ClassSteal = _value;
	} // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;

[
	"VCM_AIDISTANCEVEHPATH", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
	"SLIDER", // setting type
	"Distance AI will steal vehicles from.", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
	"VCOM SETTINGS", // Pretty name of the category where the setting can be found. Can be stringtable entry.
	[0,1000,100,0], // data for this setting:
	true, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
	{
		params ["_value"];
		VCM_AIDISTANCEVEHPATH = _value;
	} // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;

[
	"Vcm_DrivingActivated", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
	"CHECKBOX", // setting type
	"Experimental Improvements to AI driving.", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
	"VCOM SETTINGS", // Pretty name of the category where the setting can be found. Can be stringtable entry.
	false,// data for this setting:
	true, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
	{
		params ["_value"];
		Vcm_DrivingActivated = _value;
	} // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;

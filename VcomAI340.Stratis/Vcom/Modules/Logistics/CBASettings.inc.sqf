// Included only by the guarded Settings CBA entry point.

[
	"VCM_AIMagLimit", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
	"SLIDER", // setting type
	"Mag count AI begin to look for additional mags.", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
	"VCOM SETTINGS", // Pretty name of the category where the setting can be found. Can be stringtable entry.
	[2,10,5,0], // data for this setting: [min, max, default, number of shown trailing decimals]
	true, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
	{
		params ["_value"];
		VCM_AIMagLimit = _value;
	} // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;

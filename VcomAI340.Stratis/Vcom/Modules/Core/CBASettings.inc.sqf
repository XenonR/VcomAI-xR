// Included only by the guarded Settings CBA entry point.

[
	"VCM_ActivateAI", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
	"CHECKBOX", // setting type
	"Vcom Active", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
	"VCOM SETTINGS", // Pretty name of the category where the setting can be found. Can be stringtable entry.
	true, // data for this setting:
	true, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
	{
		params ["_value"];
		VCM_ActivateAI = _value;
	} // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;

[
	"VCM_SIDEENABLED", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
	"LIST", // setting type
	"Sides impacted by Vcom.", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
	"VCOM SETTINGS", // Pretty name of the category where the setting can be found. Can be stringtable entry.
	[[[west,east,Resistance],[west,east],[west],[east],[Resistance],[Resistance,west],[Resistance,east]],[["West, East, Resistance"],["West, East"],["West"],["East"],["Resistance"],["Resistance, West"],["Resistance, East"]],0], // data for this setting:
	true, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
	{
		params ["_value"];
		VCM_SIDEENABLED = _this;
	} // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;

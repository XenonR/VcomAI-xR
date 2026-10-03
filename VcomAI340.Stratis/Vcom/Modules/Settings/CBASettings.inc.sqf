// Included only by the guarded Settings CBA entry point.

[
	"VCM_USECBASETTINGS", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
	"CHECKBOX", // setting type
	"Use CBA-Vcom Settings?", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
	"VCOM SETTINGS", // Pretty name of the category where the setting can be found. Can be stringtable entry.
	true, // data for this setting:
	true, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
	{
		params ["_value"];
		VCM_USECBASETTINGS = _value;
	} // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;

[
	"VCM_SKILLCHANGE", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
	"CHECKBOX", // setting type
	"AI impacted by Vcom skill settings.", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
	"VCOM SETTINGS", // Pretty name of the category where the setting can be found. Can be stringtable entry.
	true,// data for this setting:
	true, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
	{
		params ["_value"];
		VCM_SKILLCHANGE = _value;
	} // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;

[
	"Vcm_PlayerAISkills", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
	"CHECKBOX", // setting type
	"Player AI recieve unique skill settings", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
	"VCOM SETTINGS", // Pretty name of the category where the setting can be found. Can be stringtable entry.
	true,// data for this setting:
	true, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
	{
		params ["_value"];
		Vcm_PlayerAISkills = _value;
	} // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;

[
	"Vcm_AISkills_SideSpecific", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
	"CHECKBOX", // setting type
	"AI skill settings are side specific", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
	"VCOM SETTINGS", // Pretty name of the category where the setting can be found. Can be stringtable entry.
	false,// data for this setting:
	true, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
	{
		params ["_value"];
		VCM_SIDESPECIFICSKILL = _value;
	} // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;

[
	"Vcm_AISkills_West_AimingAccuracy", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
	"SLIDER", // setting type
	"West aiming accuracy", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
	"VCOM AI West Skill", // Pretty name of the category where the setting can be found. Can be stringtable entry.
	[0,1,0.25,2], // data for this setting:
	false, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
	{
		params ["_value"];
		VCM_AIDIFWEST set [0,['aimingAccuracy',_value]];
		publicVariable "VCM_AIDIFWEST";
	} // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;

[
	"Vcm_AISkills_West_aimingShake", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
	"SLIDER", // setting type
	"West aiming shake", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
	"VCOM AI West Skill", // Pretty name of the category where the setting can be found. Can be stringtable entry.
	[0,1,0.15,2], // data for this setting:
	false, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
	{
		params ["_value"];
		VCM_AIDIFWEST set [1,['aimingShake',_value]];
		publicVariable "VCM_AIDIFWEST";
	} // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;

[
	"Vcm_AISkills_West_aimingSpeed", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
	"SLIDER", // setting type
	"West aiming speed", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
	"VCOM AI West Skill", // Pretty name of the category where the setting can be found. Can be stringtable entry.
	[0,1,0.15,2], // data for this setting:
	false, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
	{
		params ["_value"];
		VCM_AIDIFWEST set [2,['aimingSpeed',_value]];
		publicVariable "VCM_AIDIFWEST";
	} // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;

[
	"Vcm_AISkills_West_commanding", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
	"SLIDER", // setting type
	"West commanding", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
	"VCOM AI West Skill", // Pretty name of the category where the setting can be found. Can be stringtable entry.
	[0,1,0.85,2], // data for this setting:
	false, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
	{
		params ["_value"];
		VCM_AIDIFWEST set [3,['commanding',_value]];
		publicVariable "VCM_AIDIFWEST";
	} // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;

[
	"Vcm_AISkills_West_courage", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
	"SLIDER", // setting type
	"West courage", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
	"VCOM AI West Skill", // Pretty name of the category where the setting can be found. Can be stringtable entry.
	[0,1,0.5,2], // data for this setting:
	false, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
	{
		params ["_value"];
		VCM_AIDIFWEST set [4,['courage',_value]];
		publicVariable "VCM_AIDIFWEST";
	} // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;

[
	"Vcm_AISkills_West_general", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
	"SLIDER", // setting type
	"West general", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
	"VCOM AI West Skill", // Pretty name of the category where the setting can be found. Can be stringtable entry.
	[0,1,0.5,2], // data for this setting:
	false, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
	{
		params ["_value"];
		VCM_AIDIFWEST set [5,['general',_value]];
		publicVariable "VCM_AIDIFWEST";
	} // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;

[
	"Vcm_AISkills_West_reloadSpeed", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
	"SLIDER", // setting type
	"West reloadSpeed", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
	"VCOM AI West Skill", // Pretty name of the category where the setting can be found. Can be stringtable entry.
	[0,1,1,2], // data for this setting:
	false, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
	{
		params ["_value"];
		VCM_AIDIFWEST set [6,['reloadSpeed',_value]];
		publicVariable "VCM_AIDIFWEST";
	} // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;

[
	"Vcm_AISkills_West_spotDistance", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
	"SLIDER", // setting type
	"West spotDistance", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
	"VCOM AI West Skill", // Pretty name of the category where the setting can be found. Can be stringtable entry.
	[0,1,0.85,2], // data for this setting:
	false, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
	{
		params ["_value"];
		VCM_AIDIFWEST set [7,['spotDistance',_value]];
		publicVariable "VCM_AIDIFWEST";
	} // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;

[
	"Vcm_AISkills_West_spotTime", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
	"SLIDER", // setting type
	"West spotTime", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
	"VCOM AI West Skill", // Pretty name of the category where the setting can be found. Can be stringtable entry.
	[0,1,0.85,2], // data for this setting:
	false, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
	{
		params ["_value"];
		VCM_AIDIFWEST set [8,['spotTime',_value]];
		publicVariable "VCM_AIDIFWEST";
	} // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;

[
	"Vcm_AISkills_East_AimingAccuracy", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
	"SLIDER", // setting type
	"East aiming accuracy", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
	"VCOM AI East Skill", // Pretty name of the category where the setting can be found. Can be stringtable entry.
	[0,1,0.25,2], // data for this setting:
	false, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
	{
		params ["_value"];
		VCM_AIDIFEast set [0,['aimingAccuracy',_value]];
		publicVariable "VCM_AIDIFEast";
	} // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;

[
	"Vcm_AISkills_East_aimingShake", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
	"SLIDER", // setting type
	"East aiming shake", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
	"VCOM AI East Skill", // Pretty name of the category where the setting can be found. Can be stringtable entry.
	[0,1,0.15,2], // data for this setting:
	false, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
	{
		params ["_value"];
		VCM_AIDIFEast set [1,['aimingShake',_value]];
		publicVariable "VCM_AIDIFEast";
	} // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;

[
	"Vcm_AISkills_East_aimingSpeed", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
	"SLIDER", // setting type
	"East aiming speed", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
	"VCOM AI East Skill", // Pretty name of the category where the setting can be found. Can be stringtable entry.
	[0,1,0.15,2], // data for this setting:
	false, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
	{
		params ["_value"];
		VCM_AIDIFEast set [2,['aimingSpeed',_value]];
		publicVariable "VCM_AIDIFEast";
	} // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;

[
	"Vcm_AISkills_East_commanding", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
	"SLIDER", // setting type
	"East commanding", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
	"VCOM AI East Skill", // Pretty name of the category where the setting can be found. Can be stringtable entry.
	[0,1,0.85,2], // data for this setting:
	false, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
	{
		params ["_value"];
		VCM_AIDIFEast set [3,['commanding',_value]];
		publicVariable "VCM_AIDIFEast";
	} // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;

[
	"Vcm_AISkills_East_courage", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
	"SLIDER", // setting type
	"East courage", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
	"VCOM AI East Skill", // Pretty name of the category where the setting can be found. Can be stringtable entry.
	[0,1,0.5,2], // data for this setting:
	false, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
	{
		params ["_value"];
		VCM_AIDIFEast set [4,['courage',_value]];
		publicVariable "VCM_AIDIFEast";
	} // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;

[
	"Vcm_AISkills_East_general", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
	"SLIDER", // setting type
	"East general", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
	"VCOM AI East Skill", // Pretty name of the category where the setting can be found. Can be stringtable entry.
	[0,1,0.5,2], // data for this setting:
	false, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
	{
		params ["_value"];
		VCM_AIDIFEast set [5,['general',_value]];
		publicVariable "VCM_AIDIFEast";
	} // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;

[
	"Vcm_AISkills_East_reloadSpeed", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
	"SLIDER", // setting type
	"East reloadSpeed", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
	"VCOM AI East Skill", // Pretty name of the category where the setting can be found. Can be stringtable entry.
	[0,1,1,2], // data for this setting:
	false, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
	{
		params ["_value"];
		VCM_AIDIFEast set [6,['reloadSpeed',_value]];
		publicVariable "VCM_AIDIFEast";
	} // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;

[
	"Vcm_AISkills_East_spotDistance", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
	"SLIDER", // setting type
	"East spotDistance", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
	"VCOM AI East Skill", // Pretty name of the category where the setting can be found. Can be stringtable entry.
	[0,1,0.85,2], // data for this setting:
	false, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
	{
		params ["_value"];
		VCM_AIDIFEast set [7,['spotDistance',_value]];
		publicVariable "VCM_AIDIFEast";
	} // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;

[
	"Vcm_AISkills_East_spotTime", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
	"SLIDER", // setting type
	"East spotTime", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
	"VCOM AI East Skill", // Pretty name of the category where the setting can be found. Can be stringtable entry.
	[0,1,0.85,2], // data for this setting:
	false, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
	{
		params ["_value"];
		VCM_AIDIFEast set [8,['spotTime',_value]];
		publicVariable "VCM_AIDIFEast";
	} // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;

[
	"Vcm_AISkills_Resistance_AimingAccuracy", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
	"SLIDER", // setting type
	"Resistance aiming accuracy", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
	"VCOM AI Resistance Skill", // Pretty name of the category where the setting can be found. Can be stringtable entry.
	[0,1,0.25,2], // data for this setting:
	false, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
	{
		params ["_value"];
		VCM_AIDIFResistance set [0,['aimingAccuracy',_value]];
		publicVariable "VCM_AIDIFResistance";
	} // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;

[
	"Vcm_AISkills_Resistance_aimingShake", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
	"SLIDER", // setting type
	"Resistance aiming shake", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
	"VCOM AI Resistance Skill", // Pretty name of the category where the setting can be found. Can be stringtable entry.
	[0,1,0.15,2], // data for this setting:
	false, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
	{
		params ["_value"];
		VCM_AIDIFResistance set [1,['aimingShake',_value]];
		publicVariable "VCM_AIDIFResistance";
	} // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;

[
	"Vcm_AISkills_Resistance_aimingSpeed", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
	"SLIDER", // setting type
	"Resistance aiming speed", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
	"VCOM AI Resistance Skill", // Pretty name of the category where the setting can be found. Can be stringtable entry.
	[0,1,0.15,2], // data for this setting:
	false, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
	{
		params ["_value"];
		VCM_AIDIFResistance set [2,['aimingSpeed',_value]];
		publicVariable "VCM_AIDIFResistance";
	} // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;

[
	"Vcm_AISkills_Resistance_commanding", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
	"SLIDER", // setting type
	"Resistance commanding", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
	"VCOM AI Resistance Skill", // Pretty name of the category where the setting can be found. Can be stringtable entry.
	[0,1,0.85,2], // data for this setting:
	false, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
	{
		params ["_value"];
		VCM_AIDIFResistance set [3,['commanding',_value]];
		publicVariable "VCM_AIDIFResistance";
	} // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;

[
	"Vcm_AISkills_Resistance_courage", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
	"SLIDER", // setting type
	"Resistance courage", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
	"VCOM AI Resistance Skill", // Pretty name of the category where the setting can be found. Can be stringtable entry.
	[0,1,0.5,2], // data for this setting:
	false, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
	{
		params ["_value"];
		VCM_AIDIFResistance set [4,['courage',_value]];
		publicVariable "VCM_AIDIFResistance";
	} // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;

[
	"Vcm_AISkills_Resistance_general", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
	"SLIDER", // setting type
	"Resistance general", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
	"VCOM AI Resistance Skill", // Pretty name of the category where the setting can be found. Can be stringtable entry.
	[0,1,0.5,2], // data for this setting:
	false, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
	{
		params ["_value"];
		VCM_AIDIFResistance set [5,['general',_value]];
		publicVariable "VCM_AIDIFResistance";
	} // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;

[
	"Vcm_AISkills_Resistance_reloadSpeed", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
	"SLIDER", // setting type
	"Resistance reloadSpeed", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
	"VCOM AI Resistance Skill", // Pretty name of the category where the setting can be found. Can be stringtable entry.
	[0,1,1,2], // data for this setting:
	false, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
	{
		params ["_value"];
		VCM_AIDIFResistance set [6,['reloadSpeed',_value]];
		publicVariable "VCM_AIDIFResistance";
	} // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;

[
	"Vcm_AISkills_Resistance_spotDistance", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
	"SLIDER", // setting type
	"Resistance spotDistance", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
	"VCOM AI Resistance Skill", // Pretty name of the category where the setting can be found. Can be stringtable entry.
	[0,1,0.85,2], // data for this setting:
	false, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
	{
		params ["_value"];
		VCM_AIDIFResistance set [7,['spotDistance',_value]];
		publicVariable "VCM_AIDIFResistance";
	} // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;

[
	"Vcm_AISkills_Resistance_spotTime", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
	"SLIDER", // setting type
	"Resistance spotTime", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
	"VCOM AI Resistance Skill", // Pretty name of the category where the setting can be found. Can be stringtable entry.
	[0,1,0.85,2], // data for this setting:
	false, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
	{
		params ["_value"];
		VCM_AIDIFResistance set [8,['spotTime',_value]];
		publicVariable "VCM_AIDIFResistance";
	} // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;

[
	"Vcm_AISkills_General_AimingAccuracy", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
	"SLIDER", // setting type
	"General aiming accuracy", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
	"VCOM AI General Skill", // Pretty name of the category where the setting can be found. Can be stringtable entry.
	[0,1,0.25,2], // data for this setting:
	false, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
	{
		params ["_value"];
		VCM_AIDIFA set [0,['aimingAccuracy',_value]];
		publicVariable "VCM_AIDIFA";
	} // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;

[
	"Vcm_AISkills_General_aimingShake", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
	"SLIDER", // setting type
	"General aiming shake", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
	"VCOM AI General Skill", // Pretty name of the category where the setting can be found. Can be stringtable entry.
	[0,1,0.15,2], // data for this setting:
	false, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
	{
		params ["_value"];
		VCM_AIDIFA set [1,['aimingShake',_value]];
		publicVariable "VCM_AIDIFA";
	} // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;

[
	"Vcm_AISkills_General_aimingSpeed", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
	"SLIDER", // setting type
	"General aiming speed", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
	"VCOM AI General Skill", // Pretty name of the category where the setting can be found. Can be stringtable entry.
	[0,1,0.35,2], // data for this setting:
	false, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
	{
		params ["_value"];
		VCM_AIDIFA set [2,['aimingSpeed',_value]];
		publicVariable "VCM_AIDIFA";
	} // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;

[
	"Vcm_AISkills_General_commanding", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
	"SLIDER", // setting type
	"General commanding", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
	"VCOM AI General Skill", // Pretty name of the category where the setting can be found. Can be stringtable entry.
	[0,1,0.85,2], // data for this setting:
	false, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
	{
		params ["_value"];
		VCM_AIDIFA set [3,['commanding',_value]];
		publicVariable "VCM_AIDIFA";
	} // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;

[
	"Vcm_AISkills_General_courage", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
	"SLIDER", // setting type
	"General courage", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
	"VCOM AI General Skill", // Pretty name of the category where the setting can be found. Can be stringtable entry.
	[0,1,0.5,2], // data for this setting:
	false, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
	{
		params ["_value"];
		VCM_AIDIFA set [4,['courage',_value]];
		publicVariable "VCM_AIDIFA";
	} // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;

[
	"Vcm_AISkills_General_general", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
	"SLIDER", // setting type
	"General general", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
	"VCOM AI General Skill", // Pretty name of the category where the setting can be found. Can be stringtable entry.
	[0,1,0.5,2], // data for this setting:
	false, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
	{
		params ["_value"];
		VCM_AIDIFA set [5,['general',_value]];
		publicVariable "VCM_AIDIFA";
	} // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;

[
	"Vcm_AISkills_General_reloadSpeed", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
	"SLIDER", // setting type
	"General reloadSpeed", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
	"VCOM AI General Skill", // Pretty name of the category where the setting can be found. Can be stringtable entry.
	[0,1,1,2], // data for this setting:
	false, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
	{
		params ["_value"];
		VCM_AIDIFA set [6,['reloadSpeed',_value]];
		publicVariable "VCM_AIDIFA";
	} // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;

[
	"Vcm_AISkills_General_spotDistance", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
	"SLIDER", // setting type
	"General spotDistance", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
	"VCOM AI General Skill", // Pretty name of the category where the setting can be found. Can be stringtable entry.
	[0,1,0.85,2], // data for this setting:
	false, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
	{
		params ["_value"];
		VCM_AIDIFA set [7,['spotDistance',_value]];
		publicVariable "VCM_AIDIFA";
	} // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;

[
	"Vcm_AISkills_General_spotTime", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
	"SLIDER", // setting type
	"General spotTime", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
	"VCOM AI General Skill", // Pretty name of the category where the setting can be found. Can be stringtable entry.
	[0,1,0.85,2], // data for this setting:
	false, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
	{
		params ["_value"];
		VCM_AIDIFA set [8,['spotTime',_value]];
		publicVariable "VCM_AIDIFA";
	} // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;

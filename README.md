# VcomAI-xR

Vcom AI for Arma 3, organized as feature modules within the existing Stratis
mission distribution. This refactor keeps the legacy `VCM_fnc_*` function names,
configuration variables, and feature switches.

## Install and start

Open `VcomAI340.Stratis` as a mission in Eden, or copy its `Vcom` directory into
another mission. Include `Vcom\cfgFunctions.hpp` inside that mission's
`CfgFunctions`, and start Vcom from its `init.sqf`:

```sqf
[] spawn VCM_fnc_VcomInit;
```

For CBA settings, also copy the `Extended_PreInit_EventHandlers` entry from
`description.ext`; it points to the guarded Settings entry point. Merge these
sections with existing mission configuration instead of replacing it.

The server loads `\userconfig\VCOM_AI\AISettingsV3.hpp` when file patching is
enabled and that file is present. The supplied userconfig template remains in
the mission's installation folder. Otherwise, the server loads the bundled
Settings defaults. The old mission path
`Vcom\Functions\VcomAI_DefaultSettings.sqf` remains a compatibility include.
When CBA is available and `VCM_USECBASETTINGS` is true, existing CBA settings
override the file defaults through their original callbacks.

## Modules

Each folder under `Vcom/Modules` has an explicit `cfgFunctions.hpp` and a
`Functions` directory. The central registration includes all eleven modules
under the existing `VCOM` class with the `VCM` tag.

| Module | Owns |
| --- | --- |
| Core | Startup, settings synchronization, scheduling, group/unit lifecycle, shared queries, squad FSM |
| Settings | Default settings, CBA entry point, skill helpers, player-squad FSM |
| Perception | Enemy knowledge, hearing, IR detection, reinforcement alerts |
| Movement | Cover, flanking, formations, garrisons, building clearing, animations |
| Combat | Snipers, suppression, grenades, mines, satchels, static weapons |
| Artillery | Artillery discovery, management, and fire requests |
| Medical | Self-healing and medic coordination |
| Logistics | Equipment scanning and rearming |
| Vehicles | Drivers, transports, commandeering, vehicle waypoints, driving FSM |
| EnhancedMovement | Optional obstacle traversal |
| Debug | Debug text, lines, and path visualization |

Each feature's `CBASettings.inc.sqf` contains its settings definitions. Only
`VCM_fnc_CBASettings` includes these fragments; it guards both pending and
completed registration. The duplicate `VCM_ADVANCEDMOVEMENT` definition was
removed without renaming its setting. Other IDs, defaults, and callbacks remain
unchanged.

Unregistered prototypes, copied scripts, and experiments live in `Vcom/Legacy`.
Nothing includes or registers that directory.

## Startup and lifecycle

1. CfgFunctions registers module functions and the three FSM entry points. CBA
   pre-init can request settings registration; it waits for startup settings.
2. `VCM_fnc_VcomInit` starts once on each machine. The server loads and applies
   the settings callback, then broadcasts it through `VCM_PublicScript`.
   Clients and headless clients request `Vcm_Settings` through `VCM_ServerAsk`;
   the server waits until that callback exists before replying. Each machine
   applies settings once, even if both delivery paths arrive.
3. Startup detects CBA and Enhanced Movement and preserves the legacy ACE
   medical check. ACE detection can force Vcom medical off; its absence does
   not overwrite a configured false value. This retains the old
   `ACE_Medical_enableFor` integration rather than introducing a new ACE API.
4. After the existing two-second delay, startup launches the driving FSM and
   scheduler. Interface clients wait for a player, install player handlers,
   and start the optional player-squad FSM.
5. Every ten seconds the scheduler asks Core to register eligible local AI
   groups. Registration happens before spawning the squad FSM, preventing
   duplicate starts. The FSM's state graph, priorities, and timed conditions
   remain intact.
6. Shared helpers install one local handler set per AI unit, transfer that
   record between groups, and remove Vcom handlers on departure or FSM exit.
   Global/group disablement stops the squad FSM. Traversal also checks
   ownership and eligibility, and releases Vcom-disabled movement on local
   units when cancelled.

Player respawn removes the inherited Vcom respawn handler before installing
the new player's handler pair. Arma can transfer persistent handlers across
respawn; see the [Bohemia event-handler reference](https://community.bistudio.com/wiki/Arma_3:_Event_Handlers).
Other missions' handler IDs are never removed.

## Interfaces and extending a feature

Existing registrations keep their `VCM_fnc_<name>` names regardless of module.
Calls such as `group call VCM_fnc_SquadExc` remain valid. The legacy callbacks
`group call VCM_AIDIFSET` and `unit call VCM_AISIDESPEC` remain available; the
shipped settings delegate them to Settings functions. Existing custom
userconfig callbacks still receive their original arguments.

| Helper | Arguments | Result | Execution |
| --- | --- | --- | --- |
| `VCM_fnc_VcomInit` | `[]` | nil | `spawn`, once on each machine |
| `VCM_fnc_ApplySettings` | `[settingsCode]` | nil | `call`, each receiving machine |
| `VCM_fnc_SquadExc` | group or `[group]` | nil | `call`, group owner |
| `VCM_fnc_InitUnit` | `[unit, group]` | nil | `call`, local AI/group owner |
| `VCM_fnc_CleanupUnit` | `[unit, previousGroup]` | nil | `call`, previous owner; handler removal remains local |
| `VCM_fnc_CleanupGroup` | `[group, trackedUnits]` | nil | `call`, exiting FSM machine, including after ownership changes |
| `VCM_fnc_InitPlayer` | `[playerUnit]` | nil | `call`, interface client |
| `VCM_fnc_ApplyUnitSkills` | `[unit]` | nil | `call`, AI unit owner |
| `VCM_fnc_ApplyGroupSkills` | `[group]` | nil | `call`, AI group owner |
| `VCM_fnc_ApplySideSkills` | `[unit]` | nil | `call`, AI unit owner |
| `VCM_fnc_ApplyPlayerSkills` | `[group]` | current AI members | `call`, player-led group owner |
| `VCM_fnc_CBASettings` | `[]` | nil | `call`, each machine; registration suspends in its own spawned script |

Unit handler IDs (`VCM_EventHandlers`) and their group (`VCM_HandlerGroup`) are
local lifecycle records. Do not broadcast or edit them from mission code.
The separate `VCM_EMMoving` recovery marker is shared: a new owner can release
movement disabled during an interrupted climb. Handler IDs and the local
traversal owner are not shared.
General skill application preserves the order of general defaults, classname
overrides, then side overrides. `VCM_SKILLCHANGE` and `VCM_Skilldisable` gate
ordinary AI skill changes, including new members and sniper adjustments.
Player-squad skills retain their separate `Vcm_PlayerAISkills` setting and
respect the per-group opt-out.

To add a function:

1. Put `fn_<name>.sqf` in the owning module's `Functions` directory. Document
   argument types, return value, locality, and whether it suspends.
2. Add `class <name> {};` to that module's registration. Use an existing feature
   function or FSM action to call it with explicit arguments.
3. Add any required CBA definition to the feature fragment using a unique ID.
   Keep existing setting IDs and feature controls compatible.
4. Run the checks below and the relevant Arma scenarios. See `AGENTS.md` for
   YAGNI, KISS, staging, and Conventional Commit guidelines.

## Validation

Requires Python 3.10 or later; no Python packages are needed:

```powershell
python tools/validate_modules.py
python -m unittest discover -s tools -p "test_*.py" -v
git diff --check
```

The validator resolves includes and registrations with exact path casing,
detects duplicate exports and unresolved Vcom references, checks balanced
delimiters in SQF and decoded FSM fields, and verifies FSM targets. The
compatibility fixture preserves the 70 original exports, each FSM's states,
targets, priorities and timed conditions, and the 74 unique original CBA
definitions using token hashes. The tests inject broken wiring into temporary
copies to check that these failures are detected.

These checks are structural: they do not compile or execute SQF, verify engine
command types, or establish multiplayer/gameplay correctness. Engine smoke
tests remain necessary. Intentional interface, settings, or FSM timing changes
must explicitly review the compatibility fixture rather than regenerate it
to bypass a failure.

### Arma smoke tests

Use an isolated copy of the Stratis mission with script-error reporting and
RPT logging enabled. Run owner-specific checks on the machine that owns the
group. Give AI groups distinct names and record the loaded optional mods and
settings for each run.

| Scenario | Acceptance checks |
| --- | --- |
| Vanilla single-player | `VCM_Initialized` becomes true; eligible groups enter `VcmAI_ActiveList` once. Calling initialization and `SquadExc` again adds no scheduler, FSM, mine monitor, or unit handler set. |
| Dedicated server and JIP | Server/client startup finishes, including a client joining during startup and another joining later. Settings arrive and apply once; active lists are not reset by a second delivery. |
| Headless-client ownership | Transfer a group server to HC and back. The former owner exits and clears its list/handler records; the new owner registers once at the existing scan interval. AI behavior runs on the current owner. |
| Joining/leaving units | Join an AI to an active group, move it to another active group, and move it to a disabled group. Each managed unit has four tracked Vcom handlers; departed units lose the previous group's handlers. A separately installed mission handler still works. |
| Group/global disablement | Disable a group, or set `Vcm_ActivateAI` false. Its FSM exits and its active-list entry is removed safely. Re-enable and verify one FSM restarts through the scheduler. Repeat with an empty/deleted group. |
| Player respawn/group changes | Respawn repeatedly and change player-led groups. There is one Vcom player handler pair, one IR monitor, and player skills apply to the current group's AI without affecting players. |
| Skill opt-outs | Set `VCM_SKILLCHANGE` false or group `VCM_Skilldisable` true before startup and before adding a member. Skills stay untouched. With opt-outs off, verify general, classname, and side precedence, including near/far sniper adjustments. |
| CBA settings | Start without CBA, with CBA enabled, and with `VCM_USECBASETTINGS` false. Available settings register once, the advanced-movement setting appears once, saved values apply, and live callbacks still update their legacy variables. |
| Medical/ACE | With CBA file overrides disabled, configure medical false and start without ACE: it remains false. Enable medical and injure AI/medics to exercise healing. Check the retained legacy ACE flag forces medical off when applicable. |
| Static weapons | Test no weapon, a destroyed weapon, an occupied/reserved weapon, a free weapon beyond range, and an occupied nearest weapon with another free weapon nearby. Only available weapons trigger arming. |
| Vehicle commandeering | Enable `VCM_StealVeh`, provide an unlocked empty vehicle, and run the five-minute squad check. The actual group reaches the commandeering function without an undefined `group` operand. |
| Mines | Place a Vcom mine, bring an enemy into its 2.5 m trigger radius, and hold it there over several frames. One delayed detonation is queued and its monitor entries are removed. Friendly-only proximity does not trigger it. |
| Enhanced Movement | Run with/without its legacy integration, test normal traversal, then disable the group, kill/remove a unit, or transfer ownership during approach/climb. Processing stops; a local unit does not remain with Vcom-disabled movement. |
| Combat regression | Exercise cover/flanking, building clearing, artillery, rearming, grenades and ranged behavior. Compare cooldowns and settings with the original mission. |

Useful owner-side diagnostics:

```sqf
diag_log ["VCOM startup", missionNamespace getVariable ["VCM_Initialized", false]];
diag_log ["VCOM active groups", VcmAI_ActiveList];
diag_log ["VCOM unit handlers", testUnit getVariable ["VCM_EventHandlers", []]];
diag_log ["VCOM CBA registered", missionNamespace getVariable ["VCM_CBASettingsRegistered", false]];
```

Inspect every participating machine's RPT for undefined variables/functions,
script errors, missing files, duplicate CBA registration, or repeated FSM
startup. Record runtime results separately from the Python checks.

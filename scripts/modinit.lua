local function earlyInit( modApi )
	modApi.requirements =
	{
		-- step_carefully must wrap the frost grenade astar_handler changes.
		"Neptune Corporation",
	}
end

-- init will be called once
local function init( modApi )
	include( modApi:getScriptPath() .. "/monkey_patch" )

	modApi:addGenerationOption("precise_ap", STRINGS.MOD_UI_TWEAKS.OPTIONS.PRECISE_AP, STRINGS.MOD_UI_TWEAKS.OPTIONS.PRECISE_AP_TIP, {
		noUpdate=true,
		values={ false, 0.5 },
		value=0.5,
		strings={ STRINGS.MOD_UI_TWEAKS.OPTIONS.VANILLA, STRINGS.MOD_UI_TWEAKS.OPTIONS.PRECISE_AP_HALF },
	})
	modApi:addGenerationOption("empty_pockets", STRINGS.MOD_UI_TWEAKS.OPTIONS.EMPTY_POCKETS, STRINGS.MOD_UI_TWEAKS.OPTIONS.EMPTY_POCKETS_TIP, { noUpdate=true })
	modApi:addGenerationOption("inv_drag_drop", STRINGS.MOD_UI_TWEAKS.OPTIONS.INV_DRAGDROP, STRINGS.MOD_UI_TWEAKS.OPTIONS.INV_DRAGDROP_TIP, { noUpdate=true })
	modApi:addGenerationOption("precise_icons", STRINGS.MOD_UI_TWEAKS.OPTIONS.PRECISE_ICONS, STRINGS.MOD_UI_TWEAKS.OPTIONS.PRECISE_ICONS_TIP, { noUpdate=true })
	modApi:addGenerationOption("doors_while_dragging", STRINGS.MOD_UI_TWEAKS.OPTIONS.DOORS_WHILE_DRAGGING, STRINGS.MOD_UI_TWEAKS.OPTIONS.DOORS_WHILE_DRAGGING_TIP, { noUpdate=true })
	modApi:addGenerationOption("colored_tracks", STRINGS.MOD_UI_TWEAKS.OPTIONS.COLORED_TRACKS, STRINGS.MOD_UI_TWEAKS.OPTIONS.COLORED_TRACKS_TIP, {
		noUpdate=true,
		values={ false, 1 },
		value=1,
		strings={ STRINGS.MOD_UI_TWEAKS.OPTIONS.VANILLA, STRINGS.MOD_UI_TWEAKS.OPTIONS.COLORED_TRACKS_A },
	})
	modApi:addGenerationOption("step_carefully", STRINGS.MOD_UI_TWEAKS.OPTIONS.STEP_CAREFULLY, STRINGS.MOD_UI_TWEAKS.OPTIONS.STEP_CAREFULLY_TIP, { noUpdate=true })

	local dataPath = modApi:getDataPath()
	KLEIResourceMgr.MountPackage( dataPath .. "/gui.kwad", "data" )

	include( modApi:getScriptPath() .. "/doors_while_dragging" )
	include( modApi:getScriptPath() .. "/empty_pockets" )
	include( modApi:getScriptPath() .. "/item_dragdrop" )
	include( modApi:getScriptPath() .. "/precise_ap" )
	include( modApi:getScriptPath() .. "/step_carefully" )
	include( modApi:getScriptPath() .. "/tracks" )
end

-- if older version of ui-tweaks was installed, auto-enable functions for which we
-- have no user state.
local function autoEnable( options, option )
	if not options[option] then
		options[option] = { enabled = true }
	end
end

-- load may be called multiple times with different options enabled
-- params is present iff Sim Constructor is installed and this is a new campaign.
local function load( modApi, options, params )
	local i_need_a_dollar = include( modApi:getScriptPath() .. "/need_a_dollar" )
	local precise_icons = include( modApi:getScriptPath() .. "/precise_icons" )

	autoEnable(options, "precise_icons")

	-- On new campaign, clear `need_a_dollar` in case Generation Presets preserved it from an earlier version.
	if params and options["need_a_dollar"] then
		options["need_a_dollar"] = nil
	end
	-- `need_a_dollar` changes the sim state, so retain behavior for existing saves.
	i_need_a_dollar( options["need_a_dollar"] and options["need_a_dollar"].enabled )

	precise_icons( options["precise_icons"].enabled )

	if params then
		params.uiTweaks = {}

		params.uiTweaks.coloredTracks = options["colored_tracks"] and options["colored_tracks"].value
		params.uiTweaks.doorsWhileDragging = options["doors_while_dragging"] and options["doors_while_dragging"].enabled
		params.uiTweaks.emptyPockets = options["empty_pockets"] and options["empty_pockets"].enabled
		params.uiTweaks.invDragDrop = options["inv_drag_drop"] and options["inv_drag_drop"].enabled
		params.uiTweaks.preciseAp = options["precise_ap"] and options["precise_ap"].value
		params.uiTweaks.stepCarefully = options["step_carefully"] and options["step_carefully"].enabled
	end
end

function _reload_tweaks()
	package.loaded[ 'workshop-581951281/tracks' ] = nil
	return mod_manager:mountContentMod('workshop-581951281')
end

-- gets called before localization occurs and before content is loaded
local function initStrings( modApi )
	local scriptPath = modApi:getScriptPath()

	local strings = include( scriptPath .. "/strings" )
	modApi:addStrings( modApi:getDataPath(), "MOD_UI_TWEAKS", strings )
end

return {
	earlyInit = earlyInit,
	init = init,
	load = load,
	initStrings = initStrings,
}

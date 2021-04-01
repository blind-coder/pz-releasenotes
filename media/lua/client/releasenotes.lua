require "OptionScreens/MainScreen"
require "ISUI/ISRichTextPanel"
require "ISUI/ISCollapsableWindow"
require "bcUtils";

BCRELNOTES = {};
BCRELNOTES.oldReleaseNotes = {};
BCRELNOTES.oldFile = "mod_releasenotes.ini";

function BCRELNOTES.checkForUpdate() -- {{{
	local relNotes = " <H1> <LEFT> Mod Release Notes <LINE> <TEXT> <LINE> ";
	local showRelnotes = false;
	for i,k in ipairs(getModDirectoryTable()) do
		local addModHeader = true;
		local modInfo = getModInfo(k);
		mod = modInfo:getId();
		if BCRELNOTES.oldReleaseNotes[mod] == nil then
			BCRELNOTES.oldReleaseNotes[mod] = {}
		end
		local f = bcUtils.readModINI(mod, "releasenotes.ini");

		for version,details in pairs(f) do
			if BCRELNOTES.oldReleaseNotes[mod][version] == nil then
				-- show relnotes
				showRelnotes = true;
				BCRELNOTES.oldReleaseNotes[mod][version] = 1;
				if addModHeader then
					relNotes = relNotes .. " <H2> " .. modInfo:getName() .. " (" .. mod .. ")";
					relNotes = relNotes .. " <LINE> <TEXT> <LINE> ";
					addModHeader = false;
				end
				relNotes = relNotes .. " <SIZE:medium> " .. version .. " - " .. details.title .. " <LINE> <TEXT> ";
				relNotes = relNotes .. details.description .. " <LINE> ";
				relNotes = relNotes .. " <LINE> ";
			end
		end
	end

	if showRelnotes then
		local cwindow = ISCollapsableWindow:new(50, 50, getCore():getScreenWidth() - 100, getCore():getScreenHeight() - 100);
		cwindow:addToUIManager();
		local window = ISRichTextPanel:new(4, 32, cwindow.width-8, cwindow.height-40);
		window.autosetheight = false;
		window.clip = true;
		window:addScrollBars();
		window.text = relNotes;
		window:paginate();
		cwindow:addChild(window);
	end

	if showRelnotes then
		bcUtils.writeINI(BCRELNOTES.oldFile, BCRELNOTES.oldReleaseNotes);
	end
end -- }}}

BCRELNOTES.init = function() -- {{{
	BCRELNOTES.oldReleaseNotes = bcUtils.readINI(BCRELNOTES.oldFile);
	BCRELNOTES.checkForUpdate();
end
-- }}}
Events.OnMainMenuEnter.Add(BCRELNOTES.init);

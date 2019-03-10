-- Author: Souldoubt
-- Date: 11/2/2016
-- Let's talk some Smack. 


-- Global variables
-- After refactor to be array with numeric indicies, can probably remove numRules
rules = {}
numRules = 0

smackEventReg = {}
numRegEvt = 0


--============================ On Load and Event Registering =======================
function smack_OnLoad()
	SLASH_SMACKCONFIG1 = "/smack"
	local function smack_WindowToggle(msg, editbox)
		SmackTalkMain:Show()
	end
	
	-- Register function to slash command
	SlashCmdList["SMACKCONFIG"] = smack_WindowToggle
	
	-- Register for login / zoning
	SmackTalkMain:RegisterEvent("PLAYER_LOGIN")
	SmackTalkMain:RegisterEvent("PLAYER_ENTERING_WORLD")

end

function smackTalkRegisterEvent(smackEvent)
	local found = false
	
	if smackEventReg ~= nil then
		for k,v in pairs(smackEventReg) do
	 		if smackEventReg[k] == smackEvent then
	 			found = true
	 			break
	 		end
		end
	end
	
	-- Don't try to double register events
	if (found == false) then
		numRegEvt = numRegEvt + 1
		smackEventReg[numRegEvt] = smackEvent
		SmackTalkMain:RegisterEvent(smackEvent)
		--printf("Attemping to register:"..smackEvent)
	--else
		--printf("Event Already Registered")
		-- Register Event
	end
	
end

function processRuleEvents(rules)
	-- for i,v in pairs(rules) do
	-- 	--rules[i].trigger
	-- end
end

--============================ Accessor/Utility Methods ====================================
function getRNG(percentToProc)
	randomRoll = math.random(1, (100/percentToProc))
	return randomRoll
end

--======== Do some stuff
function talkSmack(percentProc, ruleID)
	--printf("talkSmack()"..percentProc..ruleID)
	if getRNG(percentProc) == 1 then
		--fix me, put in IF's to handle 1 or 2 strings
		--since there are 3 strings, getRNG(33) is 33% chance
		--so talking smack is across only those strings.
		local strID = getRNG(33)
		local myFaction = UnitFactionGroup("player")
		if (myFaction == "Alliance") then
			SendChatMessage(rules[ruleID].strings[strID], "SAY", "Common")
		else
			SendChatMessage(rules[ruleID].strings[strID], "SAY", "Orcish");
		end
	end
end

function ruleExists(ruleID)
	if rules[ruleID] == nil then
		return false
	else
		return true
	end
end

--============================ Rule Constructor/Destructor/Mutator Methods =========
function createNewRule(theTrigger, theProcRate, theNumStr, strArray, thefilterStr)
	local ruleTable = {trigger=theTrigger, procRate=theProcRate, numStr=theNumStr, strings=strArray, filterStr=thefilterStr}
	numRules = numRules+1 --Create and index one higher than the current index
	rules[numRules]=ruleTable
end
 
function modifyRule(ruleID, newTrigger, newProcRate, newNumStr, newStrArray, newFilterStr)
  if ruleExists(ruleID) then
	rules[ruleID].trigger = newTrigger
	rules[ruleID].procRate = newProcRate
	rules[ruleID].numStr = newNumStr
	rules[ruleID].strings = newStrArray
	rules[ruleID].filterStr = newFilterStr
  end
end

function replaceRule(ruleID, newRuleTable)
	if ruleExists(ruleID) then
		rules[ruleID] = newRuleTable
	else
		printf("Nothing to replace, derp derp")
	end
end

function deleteRule(ruleID)
	if ruleExists(ruleID) then
		table.remove(rules, ruleID)
		numRules = numRules - 1
	else
		printf("Rule "..ruleID.." doesn't exist!")
	end
end

function smackHardReset()
	printcolor(cSEXTEAL, "Resetting Smack Talk Values to DEFAULT!")
	rules = {}
	numRules = 0
	smackEventReg = {}
	numRegEvt = 0
	SmackTalkMain:UnregisterAllEvents()
end

--==================================================================================
--================ Modify Notification strings in exisiting rule ===================
function addStrToRule(ruleID, newString)
	if ruleExists(ruleID) then
		rules[ruleID].numStr = rules[ruleID].numStr + 1   -- increment numStr in table
		table.insert(rules[ruleID].strings, newString)
	end
end


function deleteStrFromRule(ruleID, strToDelete)
	if ruleExists(ruleID) then
		for i=1,rules[ruleID].numStr do
			if string.find(rules[ruleID].strings[i], strToDelete) ~= nil then
				table.remove(rules[ruleID].strings, i)
				rules[ruleID].numStr = rules[ruleID].numStr - 1
			end
		end
	else
		printf("Rule "..i.." doesn't exist!")
	end
end


--============================ Event Handler(s) =====================================
function smackEventHandler()
	if ( event == "PLAYER_LOGIN") then
		smack_CreateMenuFrames()
	end
	
	if ( event == "PLAYER_ENTERING_WORLD") then
		-- Register the events in smackEventReg
		-- I had to move this here, instead of normal
		-- onLoad handler. Didn't seem to re-register events.
		if smackEventReg ~= nil then
			for k,v in pairs(smackEventReg) do
		 		SmackTalkMain:RegisterEvent(v)
			end
		end
	end
	
	for i,v in pairs(rules) do
		
		if (rules[i].trigger == event) then
			--printf("Yup"..event)
			if (rules[i].filterStr == nil) then 
				talkSmack(rules[i].procRate, i)
			elseif strfind(arg1, rules[i].filterStr) ~= nil then
				talkSmack(rules[i].procRate, i)
			end
		end
	end
	--printEvents(event, smackMsg)
	-- if ( event == "COMBAT_TEXT_UPDATE" ) then
	-- 	printf("Arg2: "..arg2)
	-- 	printf("Arg3: "..arg3)
	-- 	printf("Arg4: "..arg4)
	-- 	printf("Arg5: "..arg5)
	-- 	printf("Arg6: "..arg6)

	-- end
end

--============================ printf Entire Rule Table Func() ======================
function printRuleTable()
	for i,v in pairs(rules) do
		printf("=========== Rule "..i.." ==========")
		printf("Trigger: "..rules[i].trigger)
		printf("Proc %:  "..rules[i].procRate)
		printf("numStr:  "..rules[i].numStr)
	
		for y=1,rules[i].numStr do
		      printf("String "..y.." : "..rules[i].strings[y])
		end
	      printf("\n")
	end
end

--======================== printEvent debug function  ============================
function printEvents(theEvt, theMsg)
	printcolor(cMAGENTA, "EVENT: "..theEvt)
	printcolor(cSEXTEAL, "MESSAGE: "..theMsg)
end

--==================== MISC Printf Wrapper stuff==================================
function printf(guts)
	DEFAULT_CHAT_FRAME:AddMessage(guts);
end

function printcolor(hex, guts)
	DEFAULT_CHAT_FRAME:AddMessage("|"..hex..guts);	
end

function printbox(guts)
	message(guts);
end


function select (index, ...)
	local tbl = arg
	if type(arg[1]) == "table" and arg[2] == nil then
		tbl = arg[1]
	end
	if index == "#" then
		return tbl and table.getn(tbl) or 0
	else
		return tbl and tbl[index]
	end
end

--======================= Color Codes for print color ==============================================

cLIGHTRED     	=	"cffff6060"
cLIGHTBLUE    	=	"cff00ccff"
cTORQUISEBLUE	=	"cff00C78C"
cSPRINGGREEN	=	"cff00FF7F"
cGREENYELLOW  	=	"cffADFF2F"
cBLUE         	=	"cff0000ff"
cPURPLE			=	"cffDA70D6"
cGREEN	    	=	"cff00ff00"
cRED          	=	"cffff0000"
cGOLD         	=	"cffffcc00"
cGOLD2			=	"cffFFC125"
cGREY         	=	"cff888888"
cWHITE        	=	"cffffffff"
cSUBWHITE     	=	"cffbbbbbb"
cMAGENTA      	=	"cffff00ff"
cYELLOW       	=	"cffffff00"
cORANGEY		=	"cffFF4500"
cCHOCOLATE		=	"cffCD661D"
cCYAN         	=	"cff00ffff"
cIVORY			=	"cff8B8B83"
cLIGHTYELLOW	=	"cffFFFFE0"
cSEXGREEN		=	"cff71C671"
cSEXTEAL		=	"cff388E8E"
cSEXPINK		=	"cffC67171"
cSEXBLUE		=	"cff00E5EE"
cSEXHOTPINK		=	"cffFF6EB4"
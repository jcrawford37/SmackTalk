-- Author: Souldoubt
-- Date: 11/2/2016
-- Let's talk some Smack. 


-- Global stuff
triggerTable = {}
triggerTable.WhiteHit = 1
triggerTable.SpellSpecial = 2
triggerTable.IncomingMelee = 3
triggerTable.DamageOverTime = 4
triggerTable.SelfBuffs = 5

function smack_CreateMenuFrames()
--==============  Create the drop down list of supported trigger events ==================================
--========================================================================================================
	-- Create Trigger Event Drop Down frame
	dropDownFrame = CreateFrame("Frame", "SmackTriggerDropDown", SmackTalkMain, "SmackDropdownTemplate")
	dropDownFrame:SetPoint("BOTTOMLEFT", SmackTalkMain, "TOPLEFT", 18, -100)

	-- Create label for Trigger Event drop down
	dropDownLabel = SmackTriggerDropDown:CreateFontString("TriggerFontString", "OVERLAY", "GameFontNormal")
	dropDownLabel:SetText("Trigger Event")
	dropDownLabel:SetPoint("BOTTOMLEFT", SmackTriggerDropDown, "TOPLEFT", 18, 1)

--==============  Create edit box for entering the integer for % to proc the rule ========================
--========================================================================================================
	-- Create Edit box for %Proc
	procEditBox = CreateFrame("EditBox", "SmackProcEditBox" , SmackTalkMain, "Smack_EditBoxTemplate")
	procEditBox:SetWidth(125)
	procEditBox:SetHeight(20)
	procEditBox:SetPoint("TOPLEFT", SmackTalkMain, "TOPLEFT", 40, -120)

	-- Create Label for %Proc Edit Box
	procLabel = SmackProcEditBox:CreateFontString("ProcFontString", "OVERLAY", "GameFontNormal")
	procLabel:SetText("Proc Rate %")
	procLabel:SetPoint("BOTTOMLEFT", SmackProcEditBox, "TOPLEFT", 0, 1)


--==============  Create edit box for entering custom filters ========================
--========================================================================================================
	-- Create Edit box for %Proc
	filtEditBox = CreateFrame("EditBox", "SmackFiltEditBox" , SmackTalkMain, "Smack_EditBoxTemplate")
	filtEditBox:SetWidth(125)
	filtEditBox:SetHeight(20)
	filtEditBox:SetPoint("TOPLEFT", SmackTalkMain, "TOPLEFT", 40, -160)

	-- Create Label for %Proc Edit Box
	filtLabel = SmackFiltEditBox:CreateFontString("FiltFontString", "OVERLAY", "GameFontNormal")
	filtLabel:SetText("Custom Filter")
	filtLabel:SetPoint("BOTTOMLEFT", SmackFiltEditBox, "TOPLEFT", 0, 1)


--============  Create the 3 String entry boxes for each smack rule "/say" ===============================
--========================================================================================================
	-- Create Edit box for String 1 of smack to talk
	smackStr1EditBox = CreateFrame("EditBox", "SmackStringEditBox" , SmackTalkMain, "Smack_EditBoxTemplate")
	smackStr1EditBox:SetWidth(425)
	smackStr1EditBox:SetHeight(20)
	smackStr1EditBox:SetPoint("TOPLEFT", SmackTalkMain, "TOPLEFT", 40, -220)
	
	-- Create Label for String 1 Edit Box
	strOneLabel = SmackStringEditBox:CreateFontString("strOneFontString", "OVERLAY", "GameFontNormal")
	strOneLabel:SetText("Smack String 1")
	strOneLabel:SetPoint("BOTTOMLEFT", SmackStringEditBox, "TOPLEFT", 0, 1)

	-- Create Edit box for String 2 of smack to talk
	smackStr2EditBox = CreateFrame("EditBox", "SmackString2EditBox" , SmackTalkMain, "Smack_EditBoxTemplate")
	smackStr2EditBox:SetWidth(425)
	smackStr2EditBox:SetHeight(20)
	smackStr2EditBox:SetPoint("TOPLEFT", SmackTalkMain, "TOPLEFT", 40, -260)

	-- Create Label for String 2 Edit Box
	strTwoLabel = SmackString2EditBox:CreateFontString("strOneFontString", "OVERLAY", "GameFontNormal")
	strTwoLabel:SetText("Smack String 2")
	strTwoLabel:SetPoint("BOTTOMLEFT", SmackString2EditBox, "TOPLEFT", 0, 1)

	-- Create Edit box for String 3 of smack to talk
	smackStr3EditBox = CreateFrame("EditBox", "SmackString3EditBox" , SmackTalkMain, "Smack_EditBoxTemplate")
	smackStr3EditBox:SetWidth(425)
	smackStr3EditBox:SetHeight(20)
	smackStr3EditBox:SetPoint("TOPLEFT", SmackTalkMain, "TOPLEFT", 40, -300)

	-- Create Label for String 3 Edit Box
	strThreeLabel = SmackString3EditBox:CreateFontString("strOneFontString", "OVERLAY", "GameFontNormal")
	strThreeLabel:SetText("Smack String 3")
	strThreeLabel:SetPoint("BOTTOMLEFT", SmackString3EditBox, "TOPLEFT", 0, 1)

	-- Create Rule Display scrollframe. We'll make it scroll later
	-- ruleScrollFrame = CreateFrame("ScrollFrame", "SmackRuleScrollFrame", SmackTalkMain, "Smack_ScrollFrameTemplate") 
	-- ruleScrollFrame:SetPoint("TOPLEFT", SmackTalkMainSaveRule, "TOPRIGHT", 15, 0)
	-- ruleScrollFrame:SetPoint("BOTTOMRIGHT", smackStr1EditBox, "TOPRIGHT", -5, 10)
	-- ruleScrollFrame:SetAlpha(0.5)
	-- ruleScrollFrame:SetScript("OnShow", smack_RuleScrollUpdate)
	-- ruleScrollFrame:SetScript("OnVerticalScroll",  FauxScrollFrame_OnVerticalScroll(self, offset, 16, smack_RuleScrollUpdate))
	-- local texture = ruleScrollFrame:CreateTexture() 
	-- texture:SetAllPoints() 
	-- texture:SetTexture(.2,.2,.2,0.5) 



	-- Create all the frames then go away
	SmackTalkMain:Hide()
end

function smack_RuleScrollUpdate()
	printf("RuleScrollUpdate was called")
end

function smack_OnVertScroll()
	printf("Essscrollando!")
	-- 50 is max entries, 5 is number of lines, 16 is pixel height of each line
	FauxScrollFrame_Update(SmackRuleScrollFrame,50,5,16);
	printf("We're at "..FauxScrollFrame_GetOffset(SmackRuleScrollFrame))
end

function smack_OnValueChanged()
	printf("Slider:"..this:GetValue())
	smackSlider:SetValue(this:GetValue())
end

function smack_dropDownInit()
	if string.find(this:GetName(), "SmackTriggerDropDown") then
		local infoTable = {}
		infoTable.remaining = false


		infoTable.text = "White Hit"
		infoTable.value = 1
		infoTable.func = smackTrigger1_callBack
		UIDropDownMenu_AddButton(infoTable)
		
		infoTable = {}
		infoTable.remaining = false

		infoTable.text = "Spell or Special"
		infoTable.value = 2
		infoTable.func = smackTrigger1_callBack
		UIDropDownMenu_AddButton(infoTable)

		infoTable = {}
		infoTable.remaining = false

		infoTable.text = "Incoming Melee"
		infoTable.value = 3
		infoTable.func = smackTrigger1_callBack
		UIDropDownMenu_AddButton(infoTable)

		infoTable = {}
		infoTable.remaining = false

		infoTable.text = "Damage Over Time"
		infoTable.value = 4
		infoTable.func = smackTrigger1_callBack
		UIDropDownMenu_AddButton(infoTable)

		infoTable = {}
		infoTable.remaining = false

		infoTable.text = "Periodic Self Buffs"
		infoTable.value = 5
		infoTable.func = smackTrigger1_callBack
		UIDropDownMenu_AddButton(infoTable)
	end

end

function smackTrigger1_callBack()
	local dropDownListID = this:GetID()
	UIDropDownMenu_SetSelectedID(SmackTriggerDropDown, dropDownListID)
	--printf(dropDownListID)
end

function smackCloseButtonHandler()
	SmackTalkMain:Hide()
end

function smackSaveRuleButtonHandler()
	local trigger, numProc, numStr
	local tmpStrArray = {}
	-- Get DropDown ID Compare against a dropdown table 
	-- Get text in % proc window probably
	-- Get Num strings, basically check nils in string1/2/3
	-- Get String Text, put in "array"

	if UIDropDownMenu_GetSelectedID(SmackTriggerDropDown) == triggerTable.WhiteHit then
		trigger = "CHAT_MSG_COMBAT_SELF_HITS"
	elseif UIDropDownMenu_GetSelectedID(SmackTriggerDropDown) == triggerTable.SpellSpecial then
		trigger = "CHAT_MSG_SPELL_SELF_DAMAGE"
	elseif UIDropDownMenu_GetSelectedID(SmackTriggerDropDown) == triggerTable.IncomingMelee then
		trigger = "CHAT_MSG_COMBAT_CREATURE_VS_SELF_HITS"
	elseif UIDropDownMenu_GetSelectedID(SmackTriggerDropDown) == triggerTable.DamageOverTime then
		trigger = "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE"
	elseif UIDropDownMenu_GetSelectedID(SmackTriggerDropDown) == triggerTable.SelfBuffs then
		trigger = "CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS"
		
		-- Probably add more elseif's here as dropdown grows
	end

	-- Get % to proc for new rule
	numProc = procEditBox:GetNumber()

	-- Get filter string(s)
	filtStr = filtEditBox:GetText()
	
	-- Get Number of filled out strings
	numStr = 0
	if SmackStringEditBox:GetNumLetters() > 0 then
		numStr = numStr + 1
		tmpStrArray[numStr] = SmackStringEditBox:GetText()
	end

	if SmackString2EditBox:GetNumLetters() > 0 then
		numStr = numStr + 1
		tmpStrArray[numStr] = SmackString2EditBox:GetText()
	end

	if SmackString3EditBox:GetNumLetters() > 0 then
		numStr = numStr + 1
		tmpStrArray[numStr] = SmackString3EditBox:GetText()
	end


	if trigger ~= nil and numProc > 0 and numStr > 0 then
		printf("Saving Rule!")
		printf("Trigger - "..trigger)
		printf("% Proc - "..numProc)
		printf("NumStr - "..numStr)
		printf("Filter - "..filtStr)
		createNewRule(trigger, numProc, numStr, tmpStrArray, filtStr)
		smackTalkRegisterEvent(trigger)
	else
		printf("Somethings missing...")
	end

end

function smackDeleteRuleButtonHandler()
 	-- Loop through rule table, see if any other rule uses same trigger
 	-- If not, Unregister event
 	-- Reset drop down
 	-- If no other rules remove from rule box
 	--UIDropDownMenu_SetSelectedID(SmackTriggerDropDown, 0)
 	smackHardReset()
end

function smackUpdateRuleBox()
	-- Need to make a rule box
	-- Should use the table of rules in SmackTalk.lua
	-- Populate this when saveButtonHandler
	-- De-populate when deleteButtonHandler
end



--================
-- ScrollBar stuff
--================
-- Main Test Frame
-- local mainTestFrame=CreateFrame("ScrollFrame","myFrame",UIParent)
-- mainTestFrame:SetBackdrop(StaticPopup1:GetBackdrop())
-- mainTestFrame:SetSize(300,400)
-- mainTestFrame:ClearAllPoints()
-- mainTestFrame:SetPoint("LEFT",75,75)
-- mainTestFrame:EnableMouse(true)
-- mainTestFrame:SetMovable(true)
-- mainTestFrame:RegisterForDrag("LeftButton")
-- mainTestFrame:SetScript("OnDragStart",mainTestFrame.StartMoving)
-- mainTestFrame:SetScript("OnDragStop",mainTestFrame.StopMovingOrSizing)
-- mainTestFrame:SetHitRectInsets(10,10,10,10)
-- -- Scroll Bar
-- scrollbar = CreateFrame("Slider","sb",mainTestFrame,"UIPanelScrollBarTemplate") 
-- scrollbar:SetPoint("TOPLEFT",mainTestFrame,"TOPRIGHT",5,-20) 
-- scrollbar:SetPoint("BOTTOMLEFT",mainTestFrame,"BOTTOMRIGHT",5,20) 
-- scrollbar:SetMinMaxValues(1,200) 
-- scrollbar:SetValueStep(1) 
-- scrollbar.scrollStep = 20
-- scrollbar:SetValue(0) 
-- scrollbar:SetWidth(16)
-- scrollbar:SetScript("OnValueChanged",function(self,value) 
--       self:GetParent():SetVerticalScroll(value) 
-- end) 
-- -- Scroll Content Frame
-- local content = CreateFrame("ScrollingMessageFrame","sc",mainTestFrame) 
-- content:SetSize(295,340)
-- content:SetPoint("TOPLEFT",0, 10) 
-- content:SetPoint("BOTTOMLEFT", 30, 20)
-- for i = 1,10 do
--    content:AddMessage("Here is scrollfame message number "..i)
--    print("Here is print message number "..i)
-- end
-- -- Scroll Content Frame test background
-- local texture = content:CreateTexture(nil,"BACKGROUND")
-- texture:SetPoint("TOP",0,0)
-- texture:SetAllPoints() 
-- texture:SetTexture(1,1,1,.1)

-- mainTestFrame.content = content 
-- mainTestFrame:SetScrollChild(content)


--============================
-- WORKING, but want to try better method
--============================
-- Create Rule Display scrollframe. We'll make it scroll later
	-- ruleScrollframe = CreateFrame("ScrollFrame", "SmackRuleScrollFrame", SmackTalkMain, "Smack_ScrollFrameTemplate") 
	-- ruleScrollframe:SetPoint("TOPLEFT", SmackTalkMainSaveRule, "TOPRIGHT", 15, 0)
	-- ruleScrollframe:SetPoint("BOTTOMRIGHT", smackStr1EditBox, "TOPRIGHT", -5, 10)
	-- ruleScrollframe:SetAlpha(0.5)
	-- local texture = ruleScrollframe:CreateTexture() 
	-- texture:SetAllPoints() 
	-- texture:SetTexture(.2,.2,.2,0.5) 

	-- -- Create Slider bar for that scroll window
	-- smackScroller = CreateFrame("Slider", "smackSlider", SmackTalkMain,"UIPanelScrollBarTemplate") 
	-- smackScroller:SetPoint("TOPRIGHT",SmackRuleScrollFrame,"TOPRIGHT",20,-15) 
	-- smackScroller:SetPoint("BOTTOMRIGHT",SmackRuleScrollFrame,"BOTTOMRIGHT",20,15) 
	-- smackScroller:SetMinMaxValues(1,10) 
	-- smackScroller:SetValueStep(1.0) 
	-- smackScroller:SetScript("OnValueChanged", smack_OnValueChanged) 
	-- smackScroller:SetWidth(16)
	-- smackScroller:SetValue(1)
	-- local texture = smackScroller:CreateTexture() 
	-- texture:SetAllPoints() 
	-- texture:SetTexture(.2,.2,.2,0.5)

	-- --Create Scroll Message Frame to actually hold the rules
	-- local smackScrollContent = CreateFrame("ScrollingMessageFrame","SmackScrollContent",SmackTalkMain) 
	-- smackScrollContent:SetPoint("TOPLEFT",SmackRuleScrollFrame,"TOPLEFT",0,0) 
	-- smackScrollContent:SetPoint("BOTTOMRIGHT",SmackRuleScrollFrame,"BOTTOMRIGHT",0,0) 
	-- for i = 1,10 do
	--    smackScrollContent:AddMessage("Here is scrollfame message number "..i)
	--    printf("Here is print message number "..i)
	-- end
	-- -- Scroll smackScrollContent Frame test background
	-- local texture = smackScrollContent:CreateTexture()
	-- texture:SetAllPoints() 
	-- texture:SetTexture(1,1,1,.1)
	
	-- ruleScrollframe.smackScrollContent = smackScrollContent 
	-- ruleScrollframe:SetScrollChild(smackScrollContent) 

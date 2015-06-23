-- Tarikin New Player Festival
-- www.tarkin.org
-- Created by R. Bassett Jr. (Tatwi) www.tpot.ca 2015
-- Function: A quest where the player follows the bread crumbs to various locations. 

-- This file can be used a template for future "bread crumb quests". 
-- 1. Replace all instances of CivicInspectorScreenPlay and civicinspector_convo_handler, and change the value of questName, className, with something unique.
-- 2. Make a custom character and conversation for that character. Keep in mind the important convo steps that trigger the quest actions.
-- 3. Spawn your character in the spawnMobiles() function.
-- 4. Customize the questConfig table to your liking.
-- That gets you a new quest with minimal effort. As the quest is self contained, not part of a standard framework, you can add new functionality as you see fit, confident that your mods won't break something else.
-- Note that this quest method does not require a client side update, provided your convo lua file is hand made with NPC customDialogText and reply options.

local ObjectManager = require("managers.object.object_manager")


CivicInspectorScreenPlay = ScreenPlay:new {
  numberOfActs = 1,
  screenplayName = "CivicInspectorScreenPlay",
  states = {
    active = 2,
    complete = 4,
  }, 
  questConfig={
    planetName = "naboo",
    questName="CivicInspector",  -- Internal trackname , should be unique to the track
    className="CivicInspectorScreenPlay", -- Class name of this class
    timeResolution=0, -- number of decimal places to use for the time updates 0 = none
    expiryTime = 3600, --Amount of time in seconds that a player will be expired from the quest
    waypointRadius=3, -- size of the waypoint observer. 3 is good for on foot, 10 for when in a vehicle. 1 makes it kind of annoying to trigger.
    cashReward = 2000, -- set to "" for no cash reward
    giveItems = "true", -- set set false if there isn't an item reward.
    rewardType = "random", -- Pick One: all = give whole list, random = pick one item from the list, lootgroup = pick 1 item from the lootGroup
    lootGroup = "junk", -- any single loot group
    lootMinStackSize = 1, -- For stacks of loot when using a loot group
    lootMaxStackSize = 5, -- Size chosen at random between min and max
    itemRewards = {
      "object/tangible/component/clothing/synthetic_cloth.iff",
      "object/tangible/component/clothing/reinforced_fiber_panels.iff",
      "object/tangible/component/droid/r2_droid_chassis.iff",
      "object/tangible/component/food/container_large_glass.iff",
      "object/tangible/component/structure/wall_module.iff",
      "object/tangible/component/droid/droid_storage_compartment.iff",
      "object/tangible/deed/player_house_deed/naboo_house_small_style_02_deed.iff",
      "object/tangible/loot/simple_kit/tumble_blender.iff",
      "object/tangible/loot/simple_kit/heating_element.iff",
      "object/tangible/painting/painting_waterfall.iff",
    },
    acceptMessage = "You're now a Civil Inspector.", -- followed by " You have [expiryTime/60] minutes to complete your mission."
    waypoints = { 
      {x = -4873, y = 4031, wpName = "Your first stop is checking on the cloning facilities..."},
      {x = -5014, y = 4008, wpName = "Next up is the automated vegetable farm. You notice a note in margins indicating that septic tank leakage is normal. Gross..."},
      {x = -5003, y = 4043, wpName = "On to the Moff's tower to ensure the elevator ride is still smooth and quiet..."},
      {x = -5137, y = 4162, wpName = "Looks like the bank is the next spot on the list..."},
      {x = -5098, y = 4215, wpName = "Now to the automated garage facility..."},
      {x = -5395, y = 4105, wpName = "Interesting, the Mayor's office is next. Check the management terminal for defects, it says..."},
      {x = -5518, y = 4107, wpName = "Ooo... Check in with the bath house droid. Remind him that Wookiees make for clogged filters! ..."},
      {x = -5633, y = 4108, wpName = "Next are the tanks at the west end garage..."},
      {x = -5712, y = 4173, wpName = "Then the west end bank... boy this is a big job..."},
      {x = -5891, y = 4227, wpName = "The Resource Shack? Wow, can't wait to see that! I wonder if they have one for radios..."},
      {x = -5887, y = 4302, wpName = "Moving onto the west end cloning facilities..."},
      {x = -5707, y = 4392, wpName = "Next up is the pool room at Shamm's Place. Make sure the city watermain isn't leaking into the basement..."},
      {x = -5408, y = 4340, wpName = "Oh boy, next I get to thoroughly inspect all terminals and viewscreens at the C.O.M.P.N.O.R. Office..."},
      {x = -5324, y = 4315, wpName = "On to check that the elevator in the observation tower is up to code..."},
      {x = -5102, y = 4579, wpName = "Issue yet another parking violation to the hunk of junk rusting by the falls. Do I even have any tickets in this book? ..."},
      {x = -4680, y = 4239, wpName = "Now to the last item on the list: Check the erosion dampening generator at the hanger and main falls..."},
      {x = -4884, y = 4150, wpName = "Great work! Report back to the Civil Inspector for your reward."} -- Return to quest giver
    }
  } -- End questConfig1
}

registerScreenPlay("CivicInspectorScreenPlay", true)

function CivicInspectorScreenPlay:start()
  if (isZoneEnabled("naboo")) then
    self:spawnSceneObjects()
    self:spawnMobiles()
    self:createBreadCrumbs()
  end
end

function CivicInspectorScreenPlay:spawnSceneObjects()
  -- Decorations
end

function CivicInspectorScreenPlay:spawnMobiles()
  local pCoord = spawnMobile("naboo", "civic_inspector", 1, -4884.86, 7.01562, 4150.41, 35, 0)
end



-- Handle Quest

function CivicInspectorScreenPlay:enteredWaypoint(pActiveArea, pObject)
  return self:processWaypoint(pActiveArea, pObject)
end


function CivicInspectorScreenPlay:createBreadCrumbs()
  for lc = 1, table.getn(self.questConfig.waypoints) , 1 do
    local pWaypointAA = spawnActiveArea(self.questConfig.planetName, "object/active_area.iff", self.questConfig.waypoints[lc].x, 0, self.questConfig.waypoints[lc].y, self.questConfig.waypointRadius, 0)

    if (pWaypointAA ~= nil) then
      createObserver(ENTEREDAREA, self.questConfig.className, "enteredWaypoint" , pWaypointAA)
    end
  end
end

function CivicInspectorScreenPlay:startRacing(pObject)
  ObjectManager.withCreatureAndPlayerObject(pObject, function(creatureObject, playerObject)
    clearScreenPlayData(pObject,self.questConfig.questName )
    self:createResetPlayerUnfinishedEvent(pObject)
    local waypointID = playerObject:addWaypoint(self.questConfig.planetName, self.questConfig.waypoints[1].wpName, "", self.questConfig.waypoints[1].x, self.questConfig.waypoints[1].y, WAYPOINTWHITE,true,true,WAYPOINTRACETRACK)
    local time = getTimestampMilli()
    writeScreenPlayData(pObject, self.questConfig.questName, "starttime", time)
    writeScreenPlayData(pObject, self.questConfig.questName, "waypoint", 1)
    creatureObject:setScreenPlayState(CivicInspectorScreenPlay.states.active, CivicInspectorScreenPlay.screenplayName) -- Set quest active
    creatureObject:sendSystemMessage(self.questConfig.acceptMessage .. " You have " .. (self :roundNumber(self.questConfig.expiryTime/60)) .. " minutes to complete your mission.")
    creatureObject:sendSystemMessage(self.questConfig.waypoints[1].wpName) -- Display first location
    creatureObject:playMusicMessage("sound/music_themequest_acc_criminal.snd")
  end)
end

function CivicInspectorScreenPlay:processWaypoint(pActiveArea, pObject)
  if not SceneObject(pObject):isPlayerCreature() then
    return 0
  end

  local lastIndex =  readScreenPlayData(pObject, self.questConfig.questName, "waypoint")
  if lastIndex ~= "" then
    local index = self:getWaypointIndex(pActiveArea)
    if tonumber(lastIndex)==index then
      if tonumber(index)==table.getn(self.questConfig.waypoints) then
        self:finalWaypoint(pActiveArea, pObject)
      else
        self:actuallyProcessWaypoint(pObject,index)
      end
      
    end
  end

  return 0
end

function CivicInspectorScreenPlay:roundNumber(num)
  local mult = 10 ^ (self.questConfig.timeResolution or 0 )
  return math.floor(num * mult + 0.5) / mult
end


function CivicInspectorScreenPlay:actuallyProcessWaypoint(pObject,index)
  ObjectManager.withCreatureAndPlayerObject(pObject, function(creatureObject,playerObject)
    local waypointID = playerObject:addWaypoint(self.questConfig.planetName, self.questConfig.waypoints[index+1].wpName, "", self.questConfig.waypoints[index+1].x, self.questConfig.waypoints[index+1].y, WAYPOINTWHITE,true,true,WAYPOINTRACETRACK)
    writeScreenPlayData(pObject,self.questConfig.questName, "waypoint", index+1)
    
    -- Update Player on quest status 
    local timePassed = self:getLaptime(pObject) / 1000 -- miliseconds to seconds
    local timeLeft = self.questConfig.expiryTime - timePassed 
    local timeType = " minutes"
    if (timeLeft < 60) then
      timeType = " seconds"
    else
      if (timeLeft < 120) then
        timeType = " minute" -- because pluralization matters people! :)
      end
      timeLeft = timeLeft / 60 -- show time in minutes
    end
    timeLeft = self:roundNumber(timeLeft) -- drop the decimal places
    
    creatureObject:sendSystemMessage("You have " .. timeLeft .. timeType .. " to complete your mission.")
    creatureObject:sendSystemMessage(self.questConfig.waypoints[index+1].wpName) -- Next waypoint is...
    creatureObject:playMusicMessage("sound/ui_select_info.snd")
  end)
end

function CivicInspectorScreenPlay:finalWaypoint(pActiveArea, pObject)
  ObjectManager.withCreatureAndPlayerObject(pObject, function(creatureObject,playerObject)
    playerObject:removeWaypointBySpecialType(WAYPOINTRACETRACK)
    -- set as complete for use in conversation
    creatureObject:setScreenPlayState(CivicInspectorScreenPlay.states.complete, CivicInspectorScreenPlay.screenplayName)
    creatureObject:playMusicMessage("sound/music_combat_bfield_vict.snd")
    clearScreenPlayData(pObject,self.questConfig.questName )
  end)
end

function CivicInspectorScreenPlay:resetQuest(pObject)
  ObjectManager.withCreatureAndPlayerObject(pObject, function(creatureObject, playerObject)
    clearScreenPlayData(pObject,self.questConfig.questName )
    creatureObject:removeScreenPlayState(CivicInspectorScreenPlay.states.active, CivicInspectorScreenPlay.screenplayName)
    creatureObject:removeScreenPlayState(CivicInspectorScreenPlay.states.complete, CivicInspectorScreenPlay.screenplayName)
    creatureObject:sendSystemMessage("You have succesfullly abandoned your mission.")
    creatureObject:playMusicMessage("sound/music_themequest_fail_imperial.snd")
  end)
end


function CivicInspectorScreenPlay:getLaptime(pObject)
  local startTime = readScreenPlayData(pObject, self.questConfig.questName, "starttime")
  local seconds = getTimestampMilli() - tonumber(startTime)
  writeScreenPlayData(pObject, self.questConfig.questName, "laptime",seconds)
  return seconds
end


function CivicInspectorScreenPlay:getWaypointIndex(pActiveArea)
  return ObjectManager.withSceneObject(pActiveArea, function(sceneObject)
    local index = 0
    local wpX = sceneObject:getPositionX()
    local wpY = sceneObject:getPositionY()
    for lc = 1, table.getn(self.questConfig.waypoints) , 1 do
      if self.questConfig.waypoints[lc].x==wpX and self.questConfig.waypoints[lc].y==wpY then
        index = lc
        break
      end
    end
    return index
  end)
end

function CivicInspectorScreenPlay:createResetPlayerUnfinishedEvent(pObject)
  createEvent(self.questConfig.expiryTime*1000, self.questConfig.className, "resetPlayerUnfinishedEventHandler",pObject)
end

function CivicInspectorScreenPlay:resetPlayerUnfinishedEventHandler(pObject)
  ObjectManager.withCreatureAndPlayerObject(pObject, function(creatureObject,playerObject)
    local startTime = tonumber(readScreenPlayData(pObject, self.questConfig.questName , "starttime"))
    if not(startTime == nil) then 
      local time = getTimestampMilli()
      if  math.abs((time/1000) - (startTime/1000)) > (self.questConfig.expiryTime-5) then
        clearScreenPlayData(pObject,self.questConfig.questName )
        playerObject:removeWaypointBySpecialType(WAYPOINTRACETRACK)
        
        creatureObject:removeScreenPlayState(CivicInspectorScreenPlay.states.active, CivicInspectorScreenPlay.screenplayName)
        creatureObject:removeScreenPlayState(CivicInspectorScreenPlay.states.complete, CivicInspectorScreenPlay.screenplayName)
        creatureObject:sendSystemMessage("Sorry, you have failed to complete your mission in time.")
        creatureObject:playMusicMessage("sound/music_themequest_fail_imperial.snd")
      end 
    end
  end)
end





-- Handle Conversation

civicinspector_convo_handler = Object:new {
  tstring = "myconversation"
 }
 
 function CivicInspectorScreenPlay:makeWaypoints()
 
 end
 
 


function civicinspector_convo_handler:getNextConversationScreen(conversationTemplate, conversingPlayer, selectedOption)
  local creature = LuaCreatureObject(conversingPlayer)
  local convosession = creature:getConversationSession()
  local pInventory = creature:getSlottedObject("inventory")
  local inventory = LuaSceneObject(pInventory)
  local notenoughspace = "false"
  
  lastConversation = nil

  local conversation = LuaConversationTemplate(conversationTemplate)
  
  local nextConversationScreen 
  
  if ( conversation ~= nil ) then
    if ( convosession ~= nil ) then 
       local session = LuaConversationSession(convosession)
       
       if ( session ~= nil ) then
        lastConversationScreen = session:getLastConversationScreen()
       end
    end
    
    
    if ( lastConversationScreen == nil ) then
      local questActive = creature:hasScreenPlayState(CivicInspectorScreenPlay.states.active, CivicInspectorScreenPlay.screenplayName)
       
      if ( questActive == 0) then -- true or false question
        -- Quest has not started
        nextConversationScreen = conversation:getInitialScreen()
      elseif ( creature:hasScreenPlayState(CivicInspectorScreenPlay.states.complete, CivicInspectorScreenPlay.screenplayName) == 1 ) then
        -- Quest completed
        nextConversationScreen = conversation:getScreen("quest_complete")  
      else
      -- Quest is active
        nextConversationScreen = conversation:getScreen("quest_active")
      end 
    else    
      local luaLastConversationScreen = LuaConversationScreen(lastConversationScreen)
      local optionLink = luaLastConversationScreen:getOptionLink(selectedOption)
      
      if (optionLink == "quest_accept") then
        -- Player has accepted the quest
        creature:setScreenPlayState(CivicInspectorScreenPlay.states.active, CivicInspectorScreenPlay.screenplayName)
      end
      
      if (optionLink == "give_rewards") then
        local pieces = #CivicInspectorScreenPlay.questConfig.itemRewards -- gets # of items in the reward list
        
        -- Check for room in inventory
        local numberOfItems = inventory:getContainerObjectsSize()
        local freeSpace = 80 - numberOfItems
        
        if (inventory:hasFullContainerObjects() == true and CivicInspectorScreenPlay.questConfig.rewardType ~= "all") then
          -- Bail if the player doesn't have enough space in their inventory.
          notenoughspace = "true"
          creature:sendSystemMessage("You need 1 available inventory space to complete this quest.")
        elseif (CivicInspectorScreenPlay.questConfig.rewardType == "all" and freeSpace < pieces) then
          -- Bail if the player doesn't have enough space in their inventory.
          notenoughspace = "true"
          creature:sendSystemMessage("You do not have enough inventory space to complete this quest. Please free up " .. pieces .. " spaces and speak to the quest giver again")
        else
          -- Reset quest state
          creature:removeScreenPlayState(CivicInspectorScreenPlay.states.active, CivicInspectorScreenPlay.screenplayName)
          creature:removeScreenPlayState(CivicInspectorScreenPlay.states.complete, CivicInspectorScreenPlay.screenplayName)
          
          -- Grant cash reward, if there is one
          if (CivicInspectorScreenPlay.questConfig.cashReward ~= nil) then
            creature:addCashCredits(CivicInspectorScreenPlay.questConfig.cashReward, true)
            creature:sendSystemMessage("You have earned " .. CivicInspectorScreenPlay.questConfig.cashReward .. " credits.")
          end
          
          -- Grant item rewards, if there are any
          if (CivicInspectorScreenPlay.questConfig.giveItems == "true") then
            if (CivicInspectorScreenPlay.questConfig.rewardType == "random") then
              -- Give 1 random item from your list
              local rndNum = getRandomNumber(1, pieces)
              local pItem = giveItem(pInventory, CivicInspectorScreenPlay.questConfig.itemRewards[rndNum], -1)
            elseif (CivicInspectorScreenPlay.questConfig.rewardType == "all") then
              -- Give all items
              for itemCount = 1, pieces do
                local pItem = giveItem(pInventory, CivicInspectorScreenPlay.questConfig.itemRewards[itemCount], -1)
              end
            elseif (CivicInspectorScreenPlay.questConfig.rewardType == "lootgroup") then
              -- Give loot group items
              local rndNum = getRandomNumber(CivicInspectorScreenPlay.questConfig.lootMinStackSize, CivicInspectorScreenPlay.questConfig.lootMaxStackSize)
              createLoot(pInventory, CivicInspectorScreenPlay.questConfig.lootGroup, rndNum, true)
            end
            creature:sendSystemMessage("Loot was placed into your inventory!")
          end  
        end
      end
      
      -- Nearly always this will just play the next screen in the convo
      if (notenoughspace == "true") then
        nextConversationScreen = conversation:getScreen("no_space")
      else
        nextConversationScreen = conversation:getScreen(optionLink)
      end

    end  -- ending if ( lastConversationScreen == nil )
  end -- ending if ( conversation ~= nil )
  
  return nextConversationScreen
end


function civicinspector_convo_handler:runScreenHandlers(conversationTemplate, conversingPlayer, conversingNPC, selectedOption, conversationScreen)
  -- Plays the screens of the conversation.
  local player = LuaSceneObject(conversingPlayer)
  local screen = LuaConversationScreen(conversationScreen)
  local screenID = screen:getScreenID()
  
  if ( screenID == "quest_accept" ) then
    CivicInspectorScreenPlay:startRacing(conversingPlayer)
  end
  
  if ( screenID == "quest_reset" ) then
    CivicInspectorScreenPlay:resetQuest(conversingPlayer)
  end

  return conversationScreen
end


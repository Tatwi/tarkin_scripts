-- Tarikin New Player Festival
-- www.tarkin.org
-- Created by R. Bassett Jr. (Tatwi) www.tpot.ca 2015
-- Based upon the racetrack engine
-- Function: A collection of activities to help new players better understand the game.


local ObjectManager = require("managers.object.object_manager")


CivicInspectorScreenPlay = ScreenPlay:new {
  numberOfActs = 1,
  screenplayName = "CivicInspectorScreenPlay",
  states = {
    active = 2,
    complete = 4,
  }, 
  trackConfig={
    debugMode=1, -- 0 = off, 1 = print debug messages
    planetName = "naboo",
    trackName="CivicInspector",  -- Internal trackname , should be unique to the track
    className="CivicInspectorScreenPlay", -- Class name of this class
    timeResolution=0, -- number of decimal places to use for the time updates 0 = none
    expiryTime = 3600, --Amount of time in seconds that a player will be expired from the quest
    waypointRadius=3, -- size of the waypoint observer
    cashReward = 500, -- set to "" for no cash reward
    rewardType = "all", -- Pick One: all = give whole list, random = pick one item from the list, lootgroup = pick 1 item from the lootGroup
    lootGroup = "junk", -- any single loot group
    itemRewards = {
      "object/tangible/component/structure/wall_module.iff",
      "object/tangible/furniture/all/frn_all_lamp_desk_s01.iff",
      "object/tangible/furniture/all/frn_all_chair_kitchen_s2.iff",
      "object/tangible/loot/misc/ledger_s01.iff",
    },
    waypoints = { 
      {x = -4913, y = 4160, wpName = "Your first stop is over by that lady..."},
      {x = -4936, y = 4149, wpName = "Next up is the crafting station..."},
      {x = -5061, y = 4098, wpName = "The Hotel fountain, techinally operated by the city..."},
      {x = -4884, y = 4150, wpName = "Great work! Report back to the Civil Inspector for your reward."} -- Return to quest giver
    }
  } -- End trackConfig1
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
  for lc = 1, table.getn(self.trackConfig.waypoints) , 1 do
    local pWaypointAA = spawnActiveArea(self.trackConfig.planetName, "object/active_area.iff", self.trackConfig.waypoints[lc].x, 0, self.trackConfig.waypoints[lc].y, self.trackConfig.waypointRadius, 0)

    if (pWaypointAA ~= nil) then
      createObserver(ENTEREDAREA, self.trackConfig.className, "enteredWaypoint" , pWaypointAA)
    end
  end
end

function CivicInspectorScreenPlay:startRacing(pObject)
  ObjectManager.withCreatureAndPlayerObject(pObject, function(creatureObject, playerObject)
    clearScreenPlayData(pObject,self.trackConfig.trackName )
    self:createResetPlayerUnfinishedEvent(pObject)
    local waypointID = playerObject:addWaypoint(self.trackConfig.planetName, self.trackConfig.waypoints[1].wpName, "", self.trackConfig.waypoints[1].x, self.trackConfig.waypoints[1].y, WAYPOINTWHITE,true,true,WAYPOINTRACETRACK)
    local time = getTimestampMilli()
    writeScreenPlayData(pObject, self.trackConfig.trackName, "starttime", time)
    writeScreenPlayData(pObject, self.trackConfig.trackName, "waypoint", 1)
    creatureObject:setScreenPlayState(CivicInspectorScreenPlay.states.active, CivicInspectorScreenPlay.screenplayName) -- Set quest active
    creatureObject:sendSystemMessage("You're now a Civil Inspector. You have 1 hour to complete your job.")
    creatureObject:sendSystemMessage(self.trackConfig.waypoints[1].wpName) -- Display first location
  end)
end

function CivicInspectorScreenPlay:processWaypoint(pActiveArea, pObject)
  if not SceneObject(pObject):isPlayerCreature() then
    return 0
  end

  local lastIndex =  readScreenPlayData(pObject, self.trackConfig.trackName, "waypoint")
  if lastIndex ~= "" then
    local index = self:getWaypointIndex(pActiveArea)
    if tonumber(lastIndex)==index then
      if tonumber(index)==table.getn(self.trackConfig.waypoints) then
        self:finalWaypoint(pActiveArea, pObject)
      else
        self:actuallyProcessWaypoint(pObject,index)
      end
      
    end
  end

  return 0
end

function CivicInspectorScreenPlay:roundNumber(num)
  local mult = 10 ^ (self.trackConfig.timeResolution or 0 )
  return math.floor(num * mult + 0.5) / mult
end


function CivicInspectorScreenPlay:actuallyProcessWaypoint(pObject,index)
  ObjectManager.withCreatureAndPlayerObject(pObject, function(creatureObject,playerObject)
    local waypointID = playerObject:addWaypoint(self.trackConfig.planetName, self.trackConfig.waypoints[index+1].wpName, "", self.trackConfig.waypoints[index+1].x, self.trackConfig.waypoints[index+1].y, WAYPOINTWHITE,true,true,WAYPOINTRACETRACK)
    writeScreenPlayData(pObject,self.trackConfig.trackName, "waypoint", index+1)
    
    -- Update Player on quest status 
    local timePassed = self:getLaptime(pObject) / 1000 -- miliseconds to seconds
    local timeLeft = self.trackConfig.expiryTime - timePassed 
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
    creatureObject:sendSystemMessage(self.trackConfig.waypoints[index+1].wpName) -- Next waypoint is...
    creatureObject:playMusicMessage("sound/ui_select_info.snd")
  end)
end

function  CivicInspectorScreenPlay:finalWaypoint(pActiveArea, pObject)
  ObjectManager.withCreatureAndPlayerObject(pObject, function(creatureObject,playerObject)
    playerObject:removeWaypointBySpecialType(WAYPOINTRACETRACK)
    -- set as complete for use in conversation
    creatureObject:setScreenPlayState(CivicInspectorScreenPlay.states.complete, CivicInspectorScreenPlay.screenplayName)
    creatureObject:playMusicMessage("sound/music_combat_bfield_vict.snd")
    clearScreenPlayData(pObject,self.trackConfig.trackName )
  end)
end


function CivicInspectorScreenPlay:getLaptime(pObject)
  local startTime = readScreenPlayData(pObject, self.trackConfig.trackName, "starttime")
  local seconds = getTimestampMilli() - tonumber(startTime)
  writeScreenPlayData(pObject, self.trackConfig.trackName, "laptime",seconds)
  return seconds
end


function CivicInspectorScreenPlay:getWaypointIndex(pActiveArea)
  return ObjectManager.withSceneObject(pActiveArea, function(sceneObject)
    local index = 0
    local wpX = sceneObject:getPositionX()
    local wpY = sceneObject:getPositionY()
    for lc = 1, table.getn(self.trackConfig.waypoints) , 1 do
      if self.trackConfig.waypoints[lc].x==wpX and self.trackConfig.waypoints[lc].y==wpY then
        index = lc
        break
      end
    end
    return index
  end)
end

function CivicInspectorScreenPlay:createResetPlayerUnfinishedEvent(pObject)
  createEvent(self.trackConfig.expiryTime*1000, self.trackConfig.className, "resetPlayerUnfinishedEventHandler",pObject)
  if self.trackConfig.debugMode==1 then
    printf("Created Reset Player CallBack Event for :" .. self.trackConfig.trackName .. " in \n")
  end
end

function CivicInspectorScreenPlay:resetPlayerUnfinishedEventHandler(pObject)
  ObjectManager.withCreatureAndPlayerObject(pObject, function(creatureObject,playerObject)
    local startTime = tonumber(readScreenPlayData(pObject, self.trackConfig.trackName , "starttime"))
    if not(startTime == nil) then 
      local time = getTimestampMilli()
      if  math.abs((time/1000) - (startTime/1000)) > (self.trackConfig.expiryTime-5) then
        clearScreenPlayData(pObject,self.trackConfig.trackName )
        playerObject:removeWaypointBySpecialType(WAYPOINTRACETRACK)
        
        creatureObject:removeScreenPlayState(CivicInspectorScreenPlay.states.active, CivicInspectorScreenPlay.screenplayName)
        creatureObject:removeScreenPlayState(CivicInspectorScreenPlay.states.complete, CivicInspectorScreenPlay.screenplayName)
        creatureObject:sendSystemMessage("Sorry, you have failed to complete your mission in time.")
        creatureObject:playMusicMessage("sound/music_themequest_fail_imperial.snd")
        if self.trackConfig.debugMode==1 then
          printf("Reset Player for :" .. self.trackConfig.trackName .. "\n")
        end
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
      
            
      print("questActive is " .. questActive)
        
      if ( questActive == 0) then -- true or false question
        -- Quest has not started
        print("no screenplaystate so must not be active")
        nextConversationScreen = conversation:getInitialScreen()
      elseif ( creature:hasScreenPlayState(CivicInspectorScreenPlay.states.complete, CivicInspectorScreenPlay.screenplayName) == 1 ) then
        -- Quest completed
        nextConversationScreen = conversation:getScreen("quest_complete")  
      else
      -- Quest is active
       print("Quest is currently active")
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
        local pieces = #CivicInspectorScreenPlay.trackConfig.itemRewards -- gets # of items in the reward list
        
        -- Check for room in inventory
        local numberOfItems = inventory:getContainerObjectsSize()
        local freeSpace = 80 - numberOfItems
        
        print("Items in inventory: " .. numberOfItems)
        print("Free Space: " .. freeSpace)
        print("Pieces of loot: " .. pieces)
        
        if (inventory:hasFullContainerObjects() == true and CivicInspectorScreenPlay.trackConfig.rewardType ~= "all") then
          -- Bail if the player doesn't have enough space in their inventory.
          notenoughspace = "true"
          creature:sendSystemMessage("You need 1 available inventory space to complete this quest.")
        elseif (CivicInspectorScreenPlay.trackConfig.rewardType == "all" and freeSpace < pieces) then
          -- Bail if the player doesn't have enough space in their inventory.
          notenoughspace = "true"
          creature:sendSystemMessage("You do not have enough inventory space to complete this quest. Please free up " .. pieces .. " spaces and speak to the quest giver again")
        else
          -- Reset quest state
          creature:removeScreenPlayState(CivicInspectorScreenPlay.states.active, CivicInspectorScreenPlay.screenplayName)
          creature:removeScreenPlayState(CivicInspectorScreenPlay.states.complete, CivicInspectorScreenPlay.screenplayName)
          
          -- Grant cash reward, if there is one
          if (CivicInspectorScreenPlay.trackConfig.cashReward ~= 0) then
            creature:addCashCredits(CivicInspectorScreenPlay.trackConfig.cashReward, true)
            creature:sendSystemMessage("You have earned " .. CivicInspectorScreenPlay.trackConfig.cashReward .. " credits.")
          end
          
          -- Grant item rewards, if there are any
          if (CivicInspectorScreenPlay.trackConfig.itemRewards[1] ~= "") then
            if (CivicInspectorScreenPlay.trackConfig.rewardType == "random") then
              -- Give 1 random item from your list
              rndNum = getRandomNumber(1, pieces)
              local pItem = giveItem(pInventory, CivicInspectorScreenPlay.trackConfig.itemRewards[rndNum], -1)
            elseif (CivicInspectorScreenPlay.trackConfig.rewardType == "all") then
              -- Give all items
              for itemCount = 1, pieces do
                local pItem = giveItem(pInventory, CivicInspectorScreenPlay.trackConfig.itemRewards[itemCount], -1)
              end
            elseif (CivicInspectorScreenPlay.trackConfig.rewardType == "lootgroup") then
              -- Give 1 loot item
              createLoot(pInventory, CivicInspectorScreenPlay.trackConfig.lootGroup, 0, true)
            end
            creature:sendSystemMessage("You were given " .. pieces .. " pieces of loot.")
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

  return conversationScreen
end


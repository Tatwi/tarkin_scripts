-- Tarikin New Player Festival
-- www.tarkin.org
-- Created by R. Bassett Jr. (Tatwi) www.tpot.ca 2015
-- Function: A collection of activities to help new players better understand the game.


local ObjectManager = require("managers.object.object_manager")


CivicInspectorScreenPlay = ScreenPlay:new {
  numberOfActs = 1,
  screenplayName = "CivicInspectorScreenPlay",
  
  trackConfig={
    debugMode=1, -- 0 = off, 1 = print debug messages
    planetName = "naboo",
    trackName="WESTEND",  -- Internal trackname , should be unique to the track
    className="CivicInspectorScreenPlay", -- Class name of this class
    trackCheckpoint="@theme_park/racing/racing:keren_waypoint_name_checkpoint", --Waypoint names
    timeResolution=2, -- number of decimal places to use for the laptimes 0 = none, 1 = well 1 etc
    expiryTime = (1*3600), --Amount of time in seconds that a player will be expired from the track (stops silly times over this limit)
    resetTime = (22*3600)+(10*60), --Time of day in seconds that track resets High Scores
    waypointRadius=3, -- size of the waypoint observer
    cashReward = 500,
    itemReward = "",
    waypoints = { 
      {x = -4913, y = 4160, wpName = "Your first stop is over by that lady..."},
      {x = -4936, y = 4149, wpName = "Next up is the crafting station..."},
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
    local seconds = self:getLaptime(pObject)
    -- Update Player on status
    creatureObject:sendSystemMessage("Time Elapsed:" .. self:roundNumber(seconds/1000/60) .. "minutes")
    creatureObject:sendSystemMessage(self.trackConfig.waypoints[index+1].wpName)
    writeScreenPlayData(pObject,self.trackConfig.trackName, "waypoint", index+1)
  end)
end

function  CivicInspectorScreenPlay:finalWaypoint(pActiveArea, pObject)
  ObjectManager.withCreatureAndPlayerObject(pObject, function(creatureObject,playerObject)
    creatureObject:playMusicMessage("sound/music_combat_bfield_vict.snd")
    -- Grant reward
    creatureObject:addCashCredits(500, true)
    
    clearScreenPlayData(pObject,self.trackConfig.trackName )
    playerObject:removeWaypointBySpecialType(WAYPOINTRACETRACK)
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
  ObjectManager.withCreaturePlayerObject(pObject, function(playerObject)
    local startTime = tonumber(readScreenPlayData(pObject, self.trackConfig.trackName , "starttime"))
    if not(startTime == nil) then 
      local time = getTimestampMilli()
      if  math.abs((time/1000) - (startTime/1000)) > (self.trackConfig.expiryTime-5) then
        clearScreenPlayData(pObject,self.trackConfig.trackName )
        playerObject:removeWaypointBySpecialType(WAYPOINTRACETRACK)
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
  local credits = creature:getCashCredits()
  
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
    
    local insufficientFunds = "false"
    
    if ( lastConversationScreen == nil ) then
      nextConversationScreen = conversation:getInitialScreen()
    else    
      local luaLastConversationScreen = LuaConversationScreen(lastConversationScreen)
      local optionLink = luaLastConversationScreen:getOptionLink(selectedOption)
      
      nextConversationScreen = conversation:getScreen(optionLink)

    end  -- ending if ( lastConversationScreen == nil )
  end -- ending if ( conversation ~= nil )
  
  return nextConversationScreen
end


function civicinspector_convo_handler:runScreenHandlers(conversationTemplate, conversingPlayer, conversingNPC, selectedOption, conversationScreen)
  -- Plays the screens of the conversation.
  local player = LuaSceneObject(conversingPlayer)
  local screen = LuaConversationScreen(conversationScreen)
  local screenID = screen:getScreenID()
  
  if ( screenID == "quest_west" ) then
    CivicInspectorScreenPlay:startRacing(conversingPlayer)
  end

  return conversationScreen
end


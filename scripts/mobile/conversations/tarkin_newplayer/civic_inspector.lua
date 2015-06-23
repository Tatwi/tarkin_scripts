-- Tarkin New Player Festival

civicinspector_template = ConvoTemplate:new {
	initialScreen = "start",
	templateType = "Lua",
	luaClassHandler = "civicinspector_convo_handler",
	screens = {}
}



civicinspector_start = ConvoScreen:new {
  id = "start",
  leftDialog = "",
  customDialogText = "Hello, Citizen. Is there something important I can help you with? If not, I am very busy inspecting these tanks... and the rest of this Festival... In fact, I am TOO busy!",
  stopConversation = "false",
  options = {
    {"What can you tell me about Theed?", "theed"},
    {"You're TOO busy, eh? I can help you with that.", "quest_start"},
    {"Sorry, I have to be going.", "bye"}
  }
}
civicinspector_template:addScreen(civicinspector_start);

civicinspector_bye = ConvoScreen:new {
  id = "bye",
  leftDialog = "",
  customDialogText = "Take care.",
  stopConversation = "true",
  options = { 
  }
}
civicinspector_template:addScreen(civicinspector_bye);


-- Quest

civicinspector_quest_start = ConvoScreen:new {
  id = "quest_start",
  leftDialog = "",
  customDialogText = "Normally we have more inspectors, but with illnesses and poor Phylo getting eaten by a Tuskcat the other day, I'm the only inspector in town. I just don't have time to do the daily rounds in all three districts, let alone keep an eye on this Festival.",
  stopConversation = "false",
  options = {
    {"That's terrible. Sorry to hear about Phylo...", "quest2"}
  }
}
civicinspector_template:addScreen(civicinspector_quest_start);


civicinspector_quest2 = ConvoScreen:new {
  id = "quest2",
  leftDialog = "",
  customDialogText = "Thanks. Look, if I give you a checklist and my guide book, could you complete our routes for me, please?",
  stopConversation = "false",
  options = {
    {"I don't know... what's in it for me?", "quest3"},
    {"On second thought, I don't have time right now.", "bye"}
  }
}
civicinspector_template:addScreen(civicinspector_quest2);


civicinspector_quest3 = ConvoScreen:new {
  id = "quest3",
  leftDialog = "",
  customDialogText = "I can put in a requisition order for some new equipment *wink* *wink* and pay you ...  2000 credits. Heck, I can even throw in something from the city's unclaimed lost and found! I just need this done in a hour. What do you say?",
  stopConversation = "false",
  options = {
    {"Was just pulling your leg. Sure I'll help you!", "quest_accept"},
    {"Sorry, I am not interested.", "bye"}
  }
}
civicinspector_template:addScreen(civicinspector_quest3);


civicinspector_quest_accept = ConvoScreen:new {
  id = "quest_accept",
  leftDialog = "",
  customDialogText = "You can walk, drive, or take the shuttle if you would like. It's also helpful to toggle on the On Screen Waypoint Monitor. You will find in the Options Menu by pressing ctl+o and selecting the Misc page.",
  stopConversation = "true",
  options = { 
  }
}
civicinspector_template:addScreen(civicinspector_quest_accept);



civicinspector_quest_active = ConvoScreen:new {
  id = "quest_active",
  leftDialog = "",
  customDialogText = "Didn't I give you a job to do?.",
  stopConversation = "false",
  options = { 
    {"You sure did, I will get right on it!", "bye"},
    {"I don't want to do this job anymore.", "confirm_reset"}
  }
}
civicinspector_template:addScreen(civicinspector_quest_active);

civicinspector_confirm_reset = ConvoScreen:new {
  id = "confirm_reset",
  leftDialog = "",
  customDialogText = "Are you sure you want to abandon this mission?",
  stopConversation = "false",
  options = { 
    {"Yes, I am sure I want to abandon this mission.", "quest_reset"},
    {"No, I want to keep trying.", "bye"}
  }
}
civicinspector_template:addScreen(civicinspector_confirm_reset);


civicinspector_quest_reset = ConvoScreen:new {
  id = "quest_reset",
  leftDialog = "",
  customDialogText = "Come back and see me if you would like to try again later.",
  stopConversation = "true",
  options = { 
  }
}
civicinspector_template:addScreen(civicinspector_quest_reset);


civicinspector_quest_complete = ConvoScreen:new {
  id = "quest_complete",
  leftDialog = "",
  customDialogText = "Hmmm... looks like you did well enough. Here's the payment we talked about earlier.",
  stopConversation = "false",
  options = { 
    {"Great, thanks!", "give_rewards"}
  }
}
civicinspector_template:addScreen(civicinspector_quest_complete);

civicinspector_give_rewards = ConvoScreen:new {
  id = "give_rewards",
  leftDialog = "",
  customDialogText = "Thanks for all your help. If you're willing to do the route for me another time, please come see me again.",
  stopConversation = "true",
  options = { 
  }
}
civicinspector_template:addScreen(civicinspector_give_rewards);

civicinspector_no_space = ConvoScreen:new {
  id = "no_space",
  leftDialog = "",
  customDialogText = "Looks like you need to make some room in your inventory before I can give you a reward!",
  stopConversation = "true",
  options = { 
  }
}
civicinspector_template:addScreen(civicinspector_no_space);

-- About Theed

civicinspector_theed = ConvoScreen:new {
  id = "theed",
  leftDialog = "",
  customDialogText = "Theed is a player run city, where you are welcome work and live. City Hall is located in the Theed Center district. For more information about the city, including how to contact the Mayor, please visit city hall and access the City Management Terminal. You will also notice that there is a large variety of interesting structures around the city. They are based on plans obtained from dangerous locations, so I have heard. To me Theed really feels like the center of the universe - just so much to see and do!",
  stopConversation = "false",
  options = {
    {"Is there anything else I should know about player cities?", "theed2"}, 
    {"Interesting. Thanks for the information.", "bye"}
  }
}
civicinspector_template:addScreen(civicinspector_theed);

civicinspector_theed2 = ConvoScreen:new {
  id = "theed2",
  leftDialog = "",
  customDialogText = "Player cities and the Politician profession are granted by one of the Grand Moffs of Tarkin, provided that the would-be mayor can prove he has the population to justify starting a new player city. Should a fledgling mayor earn a city, a Grand Moff will construct a city hall in his honor at the location of his choosing. From there it is the mayor's responsibility to manage his city and maintain or lose his power during elections.",
  stopConversation = "false",
  options = {
    {"I understand. Thanks for your time.", "bye"}
  }
}
civicinspector_template:addScreen(civicinspector_theed2);



-- Template Footer
addConversationTemplate("civicinspector_template", civicinspector_template);
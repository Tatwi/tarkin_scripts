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
  customDialogText = "Thanks. Look, if I give you a checklist and my guide book, could you complete one the three routes for me, please? The routes are broken by region: West End, Theed Center, and East End. Let me know which you would like to do.",
  stopConversation = "false",
  options = {
    {"I'll take the West End.", "quest_west"},
    {"Theed Center sounds good.", "quest_center"},
    {"East End, that's near by.", "quest_east"},
    {"On second thought, I don't have time right now.", "bye"}
  }
}
civicinspector_template:addScreen(civicinspector_quest2);

civicinspector_quest_west = ConvoScreen:new {
  id = "quest_west",
  leftDialog = "",
  customDialogText = "You can walk, drive, or take the shuttle to the West End to get started.",
  stopConversation = "true",
  options = { 
  }
}
civicinspector_template:addScreen(civicinspector_quest_west);

civicinspector_quest_center = ConvoScreen:new {
  id = "quest_center",
  leftDialog = "",
  customDialogText = "Have fun storming the castle!",
  stopConversation = "true",
  options = { 
  }
}
civicinspector_template:addScreen(civicinspector_quest_center);

civicinspector_quest_east = ConvoScreen:new {
  id = "quest_east",
  leftDialog = "",
  customDialogText = "Thanks. I have to get back to work...",
  stopConversation = "true",
  options = { 
  }
}
civicinspector_template:addScreen(civicinspector_quest_east);


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
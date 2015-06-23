-- Tarkin New Player Festival
-- www.tarkin.org 2015


NewPlayerFestivalScreenPlay = ScreenPlay:new {
  numberOfActs = 1,
}

registerScreenPlay("NewPlayerFestivalScreenPlay", true)


function NewPlayerFestivalScreenPlay:start()
  self:spawnSceneObjects()
  self:spawnMobiles()
end

function NewPlayerFestivalScreenPlay:spawnSceneObjects()
  -- Tent Area
  spawnSceneObject("naboo", "object/tangible/camp/camp_pavilion_s2.iff", -4872.47, 6.6, 4148.42, 0, 0.900907, 0, -0.434013, 0)
  spawnSceneObject("naboo", "object/static/structure/general/naboo_garden_base_lrg_01.iff", -4872.47, 6.0, 4148.42, 0, 0.93709, 0, 0.349086, 0)
  
  -- Race Track Start/Finish Line
  spawnSceneObject("naboo", "object/static/structure/general/streetlamp_medium_style_02_on.iff", -4871.97, 7.0, 4150.59, 0, 0.939125, 0, 0.343575, 0)
  spawnSceneObject("naboo", "object/static/structure/military/military_wall_weak_imperial_32_style_01.iff", -4871.97, 4.2, 4150.59, 0, 0.939125, 0, 0.343575, 0)
  spawnSceneObject("naboo", "object/static/structure/military/military_column_weak_imperial_style_01.iff", -4879.26, 6.0, 4166.44, 0, 0, 0, 1, 0)
  spawnSceneObject("naboo", "object/static/particle/pt_airport_race_light.iff", -4879.26, 10.0, 4166.44, 0, 0, 0, 1, 0)
  
  spawnSceneObject("naboo", "object/static/structure/general/streetlamp_medium_style_02_on.iff", -4867.27, 7.0, 4155.62, 0, -0.361026, 0, 0.932556, 0)
  spawnSceneObject("naboo", "object/static/structure/military/military_wall_weak_imperial_32_style_01.iff", -4867.27, 4.2, 4155.62, 0, -0.361026, 0, 0.932556, 0)
  spawnSceneObject("naboo", "object/static/structure/military/military_column_weak_imperial_style_01.iff", -4883.86, 6.0, 4160.8, 0, 0, 0, 1, 0)
  spawnSceneObject("naboo", "object/static/particle/pt_airport_race_light.iff", -4883.86, 10.0, 4160.8, 0, 0, 0, 1, 0)
  
  -- Swoop Bikes
  spawnSceneObject("naboo", "object/static/vehicle/static_speeder_bike.iff", -4856.42, 7.0, 4149.77, 0, 0.98458, 0, -0.174936, 0)
  spawnSceneObject("naboo", "object/static/vehicle/static_swoop_bike.iff", -4857.65, 7.0, 4149.08, 0, 0.98458, 0, -0.174936, 0)
  
   -- Pit Crew
   spawnSceneObject("naboo", "object/static/vehicle/e3/landspeeder.iff", -4862.08, 6, 4131.24, 0,  0.316668, 0, 0.948537, 0) 
   spawnSceneObject("naboo", "object/static/creature/droids_lin_demolition.iff", -4858.77, 6, 4130.31, 0, 0.850401, 0, -0.526136, 0)
   spawnSceneObject("naboo", "object/static/structure/corellia/corl_power_transformer_s02.iff", -4859.75, 7.01562, 4134.48, 0, 0.45141, 0, 0.892316, 0)
   spawnSceneObject("naboo", "object/static/particle/pt_poi_broken_electronics.iff", -4860.66, 7.01562, 4130.31, 0, 0.242801, 0, 0.970076, 0)
  
  -- Terminals
  spawnSceneObject("naboo", "object/tangible/terminal/terminal_character_builder.iff", -4882.02, 7.01562, 4151.88, 0, 0.970232, 0, -0.242177, 0)
  spawnSceneObject("naboo", "object/tangible/terminal/terminal_newsnet.iff", -4880.2, 7.01562, 4142.46, 0, 0.486433, 0, -0.705894, 0)
  spawnSceneObject("naboo", "object/tangible/terminal/terminal_bazaar.iff", -4875.47, 7.01562, 4141.17, 0, 0.457332, 0, 0.873718, 0)
  spawnSceneObject("naboo", "object/tangible/terminal/terminal_bank.iff", -4870.32, 7.01562, 4147.48, 0, -0.312945, 0, 0.949771, 0)
  
  -- Decorations
  spawnSceneObject("naboo", "object/static/flora/flora_tree_rori_mkpodtree.iff", -4871.36, 7.01562, 4132.38, 0, 0.998695, 0, -0.0510641, 0)  
  spawnSceneObject("naboo", "object/static/flora/flora_tree_rori_windswept_s01.iff", -4872.7, 7.01562, 4164.07, 0, 0.950794, 0, 0.309823, 0)  
  spawnSceneObject("naboo", "object/static/flora/flora_tree_rori_windswept_s02.iff", -4869.04, 7.01562, 4160.79, 0, 0.589691, 0, 0.807629, 0)  
  spawnSceneObject("naboo", "object/tangible/furniture/all/frn_bench_generic.iff", -4871.74, 7.01562, 4161.63, 0, 0.953987, 0, 0.299849, 0) 
  spawnSceneObject("naboo", "object/tangible/furniture/all/frn_bench_generic.iff", -4871.37, 7.01562, 4134, 0, 0.982631, 0, -0.185568, 0) 
  spawnSceneObject("naboo", "object/static/item/item_scrolling_screen.iff", -4872.7, 9.81562, 4148.3, 0, 0.126386, 0, 0.991981, 0)  
  spawnSceneObject("naboo", "object/tangible/camp/camp_spit_s3.iff", -4877.46, 7.01562, 4141.59, 0, -0.338941, 0, 0.940808, 0)
  spawnSceneObject("naboo", "object/tangible/camp/camp_spit_s2.iff", -4876.15, 7.01562, 4141.9, 0, 0.477719, 0, 0.878513, 0)
  spawnSceneObject("naboo", "object/tangible/furniture/modern/bar_piece_straight_s1.iff", -4877.81, 7.01562, 4144.04, 0, -0.320394, 0, 0.947284, 0)
  spawnSceneObject("naboo", "object/tangible/furniture/tatooine/frn_tato_fruit_stand_small_style_01.iff", -4878.9, 7.01562, 4140.45, 0, -0.242179, 0, 0.970232, 0)
  spawnSceneObject("naboo", "object/tangible/ui/ui_planet_naboo.iff", -4869.73, 9.01562, 4143.65, 0, 0.950979, 0, -0.309255, 0)
  spawnSceneObject("naboo", "object/tangible/furniture/jedi/frn_all_table_light_02.iff", -4869.73, 7.01562, 4143.65, 0, 0.950979, 0, -0.309255, 0)
  spawnSceneObject("naboo", "object/tangible/beta/donham_terminal.iff", -4874.91, 7.01562, 4149.18, 0, -0.315708, 0, 0.948856, 0)
  spawnSceneObject("naboo", "object/tangible/crafting/station/public_weapon_station.iff", -4876.21, 7.01562, 4151.15, 0, -0.308281, 0, 0.951295, 0)
  spawnSceneObject("naboo", "object/static/structure/general/tankfarm_s01.iff", -4884.1, 7.01562, 4153.75, 0, 0.428693, 0, 0.90345, 0)
  spawnSceneObject("naboo", "object/tangible/instrument/nalargon.iff", -4886.65, 7.01562, 4146.28, 0, 0.805027, 0, 0.593239, 0)
  spawnSceneObject("naboo", "object/static/creature/tatooine_bantha_saddle.iff", -4875.9, 7.01562, 4136.26, 0, -0.597793, 0, 0.801651, 0)
  spawnSceneObject("naboo", "object/tangible/camp/camp_cot_s3.iff", -4863.73, 7.01562, 4141.65, 0, -0.30979, 0, 0.950805, 0)
  spawnSceneObject("naboo", "object/static/item/item_con_bag_ingredients_lg_s1.iff", -4862.57, 7.01562, 4140.54, 0, -0.255617, 0, 0.966778, 0)
  spawnSceneObject("naboo", "object/static/item/item_medic_medpack_lg.iff", -4865.01, 7.01562, 4141.12, 0, 0.988908, 0, -0.148527, 0)
  
  -- Theed Waterfall
  spawnSceneObject("naboo", "object/static/installation/mockup_power_generator_fusion_style_1.iff", -4685.18, 6.0, 4234.13, 0, 0.933026, 0, 0.359808, 0)



end


function NewPlayerFestivalScreenPlay:spawnMobiles()
  -- Characters at Start
  local Swooper1 = spawnMobile("naboo", "swooper_corellia", 1, -4858.19, 7.01562, 4151.29, -15, 0 )
  local Swooper2 = spawnMobile("naboo", "desert_swooper", 1, -4858.34, 7.01562, 4152.8, 173, 0 )
  local PitDroid = spawnMobile("naboo", "le_repair_droid", 1, -4864.25, 6.0, 4130.86, 81, 0 )
  local Medic = spawnMobile("naboo", "medic", 1, -4864.23, 6.0, 4140.41, -157, 0 )
  local Artisan = spawnMobile("naboo", "artisan", 1, -4879.58, 6.0, 4151.49,-166, 0 )
  local Ent = spawnMobile("naboo", "twilek_slave", 1, -4886.65, 6.0, 4146.28, 94, 0 )
  local Chef = spawnMobile("naboo", "commoner_old", 1, -4877.13, 6.0, 4142.73, -52, 0 )
  local Traveler = spawnMobile("naboo", "judge", 1, -4869.19, 6.0, 4141.64, -103, 0 )
  local Scout = spawnMobile("naboo", "farmer", 1, -4878.72, 6.0, 4137.69, 127, 0 )
  --local Engineer = spawnMobile("naboo", "noble", 1, -4884.86, 6.0, 4150.41, -14, 0 )
  

end
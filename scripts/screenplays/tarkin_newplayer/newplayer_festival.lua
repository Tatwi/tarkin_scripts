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
  spawnSceneObject("naboo", "object/static/structure/general/corellia_garden_base_lrg_01.iff", -4872.47, 6.0, 4148.42, 0, 0.93709, 0, 0.349086, 0)
  
  -- Race Track Start/Finish Line
  spawnSceneObject("naboo", "object/static/structure/general/streetlamp_medium_style_02_on.iff", -4871.97, 7.0, 4150.59, 0, 0.939125, 0, 0.343575, 0)
  spawnSceneObject("naboo", "object/static/structure/military/military_wall_weak_imperial_32_style_01.iff", -4871.97, 4.6, 4150.59, 0, 0.939125, 0, 0.343575, 0)
  spawnSceneObject("naboo", "object/static/structure/military/military_column_weak_imperial_style_01.iff", -4879.26, 6.0, 4166.44, 0, 0, 0, 1, 0)
  
  spawnSceneObject("naboo", "object/static/particle/pt_airport_race_light.iff", -4879.26, 10.0, 4166.44, 0, 0, 0, 1, 0)
  
  
  spawnSceneObject("naboo", "object/static/structure/general/streetlamp_medium_style_02_on.iff", -4867.27, 7.0, 4155.62, 0, -0.361026, 0, 0.932556, 0)
  spawnSceneObject("naboo", "object/static/structure/military/military_wall_weak_imperial_32_style_01.iff", -4867.27, 4.6, 4155.62, 0, -0.361026, 0, 0.932556, 0)
  spawnSceneObject("naboo", "object/static/structure/military/military_column_weak_imperial_style_01.iff", -4883.86, 6.0, 4160.8, 0, 0, 0, 1, 0)
  
  spawnSceneObject("naboo", "object/static/particle/pt_airport_race_light.iff", -4883.86, 10.0, 4160.8, 0, 0, 0, 1, 0)
  
  -- Decorations
  spawnSceneObject("naboo", "object/static/vehicle/static_speeder_bike.iff", -4856.42, 7.0, 4149.77, 0, 0.98458, 0, -0.174936, 0)
  spawnSceneObject("naboo", "object/static/vehicle/static_swoop_bike.iff", -4857.65, 7.0, 4149.08, 0, 0.98458, 0, -0.174936, 0)  



end


function NewPlayerFestivalScreenPlay:spawnMobiles()
  -- Characters
  local Vendor1 = spawnMobile("naboo", "swooper_corellia", 1, -4858.19, 7.01562, 4151.29, -15, 0 )
  local Vendor1 = spawnMobile("naboo", "desert_swooper", 1, -4858.34, 7.01562, 4152.8, 173, 0 )
  
end
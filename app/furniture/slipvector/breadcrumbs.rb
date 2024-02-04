# frozen_string_literal: true

# @see https://github.com/kzkn/gretel

crumb :slipvector_survey do |survey|
  parent :slipvector_star_system, survey.star_system
  link survey.id, survey.location
end

crumb :slipvector_star_system do |star_system|
  parent :slipvector_surveyors_guild, star_system.surveyors_guild
  link star_system.name, star_system.location
end


crumb :slipvector_surveyors_guild do |surveyors_guild|
  parent :room, surveyors_guild.room
  link "Surveyors Guild", surveyors_guild.location
end

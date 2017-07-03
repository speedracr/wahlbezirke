# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# Create states from seed file
File.readlines("#{Rails.root}/db/seeds/states.csv").drop(1).each do |state|
  name, abbreviation = state.split(';')
  State.create(name: name, abbreviation: abbreviation)
end

# Create districts from seed file
# FILE CONTAINS SAMPLE VALUES ONLY
File.readlines("#{Rails.root}/db/seeds/districts.csv").drop(1).
  each do |district|
  state_id, district_identifier, name = district.split(';')
  District.create(state: State.find(state_id),
                  district_identifier: district_identifier, name: name)
end

# Create municipalities from seed file
# FILE CONTAINS SAMPLE VALUES ONLY
File.readlines("#{Rails.root}/db/seeds/municipalities.csv").drop(1).
  each do |municipality|
  name, municipality_identifier, district_id = municipality.split(';')
  Municipality.create(name: name,
                      municipality_identifier: municipality_identifier,
                      district: District.find(district_id))
end

# Create precincts with random data
Municipality.all.each do |municipality|
  i = 1
  (Random.rand(20) + 3).times do
    score = Random.rand(1000000)/1000000.to_f
    Precinct.create(municipality: municipality,
                    district_score: score, precinct_identifier: i)
    i += 1
  end
end

# Sort precincts
# Municipality.last.precincts.sort_by { |precinct| precinct.district_score }.each

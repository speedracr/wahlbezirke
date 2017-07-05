# Create states from seed file
File.readlines("#{Rails.root}/db/seeds/states.csv").drop(1).each do |state|
  name, abbreviation = state.chomp.split(';')
  State.create(name: name, abbreviation: abbreviation)
  print '.'
end

# Create districts from seed file
# FILE CONTAINS SAMPLE VALUES ONLY
puts 'Creating districts...'
File.readlines("#{Rails.root}/db/seeds/districts.csv").drop(1).
  each do |district|
  state_id, district_identifier, name = district.chomp.split(';')
  District.create(state: State.find(state_id),
                  district_identifier: district_identifier, name: name)
  print '.'
end

# Create municipalities from seed file
# FILE CONTAINS SAMPLE VALUES ONLY
puts 'Creating municipalities...'
File.readlines("#{Rails.root}/db/seeds/municipalities.csv").drop(1).
  each do |municipality|
  name, municipality_identifier, district_identifier = municipality.
    chomp.split(';')
  Municipality.create(name: name,
                      municipality_identifier: municipality_identifier,
                      district: District.
                        find_by(district_identifier: district_identifier))
  print '.'
end

# Create precincts with random data
puts 'Creating precincts...'
i = 1
Municipality.all.each do |municipality|
  (Random.rand(15) + 8).times do
    score = Random.rand(1000000)/1000000.to_f
    Precinct.create(municipality: municipality,
                    district_score: score, precinct_identifier: i)
    i += 1
    print '.'
  end
end

# Assign municipality rank
puts 'Assigning municipality rank...'
Municipality.all.each do |municipality|
  i = 1
  municipality.precincts.sort_by { |precinct| precinct.district_score }.
    reverse.each do |p|
      p.update(municipality_rank: i)
      i += 1
      print '.'
  end
end

# Assign district rank
puts 'Assigning district rank...'
District.all.each do |district|
  i = 1
  district.precincts.sort_by { |precinct| precinct.district_score }.
    reverse.each do |p|
      p.update(district_rank: i)
      i += 1
      print '.'
  end
end

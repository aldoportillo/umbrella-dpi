# Import Gems
require "http"
require "json"
require 'ascii_charts'

# Get Location
pp "What's your location? "
location = gets.chomp

pp "Getting forecast for #{location}..."

# Get Coordinates using Maps API

GMAPS_URI = "https://maps.googleapis.com/maps/api/geocode/json?address=#{location}&key=#{ENV.fetch("GMAPS_KEY")}"

gmaps_req = HTTP.get(GMAPS_URI)

gmaps_res = JSON.parse(gmaps_req)

lat = gmaps_res.fetch("results").at(0).fetch("geometry").fetch("location").fetch("lat")
lng = gmaps_res.fetch("results").at(0).fetch("geometry").fetch("location").fetch("lng")
 
pp "Your coordinates are #{lat}, #{lng}"
# Get weather using Pirate API
PIRATE_URI = "https://api.pirateweather.net/forecast/#{ENV.fetch("PIRATE_WEATHER_KEY")}/#{lat},#{lng}" #Might need to swap coordinates

pirate_req = HTTP.get(PIRATE_URI) ##If I were to further this app with a UI, I would write a function for these two to modulate the app...not dry at all
pirate_res = JSON.parse(pirate_req) 

current_temp = pirate_res.fetch("currently").fetch("temperature")

hourly_data_arr = pirate_res.fetch("hourly").fetch("data").slice(0,10)

next_hour_summary = hourly_data_arr.at(0).fetch("summary")

pp "It is currently #{current_temp}°F"
pp "Next hour: #{next_hour_summary}"

# Map through hourly data to see if we should carry an umbrella

rain = false
hour_count = 1
chart_data = []

hourly_data_arr.each{|hour|
  #For ASCII charts
  chart_data.push([hour_count, (100 * hour.fetch("precipProbability")).floor()])
  

  #For printing rain propbabilities
  if(hour.fetch("precipProbability") > 0.10)
    pp "In #{hour_count} hours, there is a #{(100 * hour.fetch("precipProbability")).floor()}% chance of percipitation"
    rain = true
    hour_count += 1
  end
 
}

#Should you carry umbrella ?

if(rain)
  # Print chart
  puts ""
  puts "Hours from now vs Precipitation probability"
  puts AsciiCharts::Cartesian.new(chart_data, :bar => true, :hide_zero => true).draw
  pp "You might want to carry an umbrella"
else 
  pp "You probably won't need an umbrella today"
end

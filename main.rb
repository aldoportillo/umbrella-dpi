#Import Gems
require "http"
require "json"

#Get Location
pp "What's your location? "
location = "chicago"

#Get Coordinates

URI = "https://maps.googleapis.com/maps/api/geocode/json?address=#{location}&key=#{ENV.fetch("GMAPS_KEY")}"

req = HTTP.get(URI)

res = JSON.parse(req)

lat = res.fetch("results").at(0).fetch("geometry").fetch("location").fetch("lat")
lng = res.fetch("results").at(0).fetch("geometry").fetch("location").fetch("lng")
 
pp lat
pp lng

pp location

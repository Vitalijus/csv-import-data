require 'csv' 

namespace :united_kingdom do
	desc 'Import car charge points data'
	task :import_data => :environment do 
		filepath = File.join Rails.root, "csv/charge_points_uk.csv"
		counter = 0

		CSV.foreach(filepath, headers: true) do |row|
			latitude = Station.where(latitude: row["latitude"])
			longitude = Station.where(longitude: row["longitude"])

			if (latitude.count == 1) and (longitude.count == 1) # check if record exist
				puts "Update attributes" # WRITE METHOD TO UPDATE ATTRIBUTES
			else
				station = Station.create(country: "United Kingdom", latitude: row["latitude"], longitude: row["longitude"]) #save records to db
				puts "#{latitude} / #{longitude} - #{station.errors.full_message.join(",")}" if station.errors.any? #show errors if any
				counter += 1 if station.persisted? # counter to see how many records have been created
			end # if
		end # CSV.foreach

		puts "Imported #{counter} stations" # just to see output in terminal after calling rake task
	end # task
end # namespace
module ConvertTimeStamp

	def convert_to_time_obj(time_stamp)
		# example time stamp: "20140902T083008+0100"
		# split as follows: 2014 09 02 T 08 30 08 +01 00
		# collects within (), returns series of 'matches', numbered in sequential order
		# unhuman code for unhuman timestamps...
		split_stamp = time_stamp.match(/(\d{4})(\d{2})(\d{2})T(\d{2})(\d{2})(\d{2})(.{3})(\d{2})/)

		year = split_stamp[1] # first match, first in sequence, as year is first in timestamp
		month =  split_stamp[2]
		day = split_stamp[3]

		hour = split_stamp[4]
		minutes = split_stamp[5]
		seconds = split_stamp[6]

		time_zone_hour = split_stamp[7]
		time_zone_minute = split_stamp[8]
		time_zone = "#{time_zone_hour}:#{time_zone_minute}" # time class expects string with :

		Time.new(year, month, day, hour, minutes, seconds, time_zone)
	end


end
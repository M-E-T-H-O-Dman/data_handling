class Timeline

	def initialize(data)
		@data = data
		@timeslots = []
	end

	def steps
		@data.steps
	end

	def places
		@data.places
	end

	def output
		[]
	end

	def timeslots
		@timeslots
	end

	def make_timeslots_for(current_datetime)

		next_date = day_after(current_datetime)

		while current_datetime != next_date do

			timeslot_structure = { 'timeslot_start' => current_datetime, 'locations' => [] }

			@timeslots << timeslot_structure

			current_datetime = next_timeslot(current_datetime)

		end

	end

	def day_after(current_date)
		current_date + (60 * 60 * 24)
	end

	def next_timeslot(current_datetime)
		current_datetime + 300
	end

	def step_belongs_to_timeslot?(step_time, current_datetime)
		current_datetime <= step_time && step_time < (next_timeslot(current_datetime))
	end

	def get_steps

		@timeslots.each_with_index do |timeslot, timeslot_index|

			current_timeslot = timeslot['timeslot_start']

			match_steps_to(current_timeslot, timeslot_index)

		end

	end

	def match_steps_to(current_timeslot, timeslot_index)

		@data.steps.each do |step|

			if step_belongs_to_timeslot?(step['time'], current_timeslot)

				put_into_timeslot(step, timeslot_index)

			end

		end

	end

	def put_into_timeslot(info, index)
		@timeslots[index]['locations'] << info
	end

	def get_places

		@timeslots.each_with_index do |timeslot, timeslot_index|

			current_timeslot = timeslot['timeslot_start']

			match_places_to(current_timeslot, timeslot_index)

		end

		# puts @timeslots
	end

	def match_places_to(current_timeslot, timeslot_index)
		@data.places.each do |place|

			if place_belongs_to_timeslot?(place['startTime'], place['endTime'], current_timeslot)

				put_into_timeslot(place, timeslot_index)

			end

		end

	end

	def place_belongs_to_timeslot?(place_startTime, place_endTime, current_datetime)
		next_datetime = next_timeslot(current_datetime)

		place_extends_into_timeslot = (place_startTime >= current_datetime && place_startTime < next_datetime)

		place_extends_out_of_timeslot = (place_startTime < current_datetime && place_endTime > current_datetime)

		place_extends_into_timeslot || place_extends_out_of_timeslot
	end

	def print_all
		puts '*' * 20
		if @timeslots
			@timeslots.each do |timeslot|
				puts
				puts "#{timeslot['timeslot_start']} ---------------------------"
				timeslot['locations'].each do |location|
					puts "#{location['time']}#{location['startTime']}: #{location['lat']}, #{location['lon']} : #{location['endTime']}"
				end
			end
		else
			puts "Run"
			puts "make_timeslots_for(current_datetime)"
			puts "get_steps"
			puts "get_places"
		end
		puts '*' * 20
	end

end
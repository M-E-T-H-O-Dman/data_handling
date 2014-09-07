require_relative 'convert_timestamp'

class FormattedData

	include ConvertTimeStamp

	def initialize(raw_data)
		@raw_data = raw_data
		@steps = []
		@places = []
		format!
	end

	def raw_data
		@raw_data
	end

	def steps
		@steps
	end

	def places
		@places
	end

	def format!
		segments = @raw_data[0]['segments']

		segments.each_with_index do |val, segment_index|

			get_steps(segments, segment_index)
			get_places(segments, segment_index)

		end
	end

	def get_places(segments, segment_index)
		current_segment = segments[segment_index]
		segment_type = current_segment['type']

		if segment_type == 'place'
			get_place_info(current_segment)
		end
	end

	def get_place_info(current_segment)
		lat = current_segment['place']['location']['lat']
		lon = current_segment['place']['location']['lon']
		startTime = convert_to_time_obj(current_segment['startTime'])
		endTime = convert_to_time_obj(current_segment['endTime'])

		place = {'lat'=>lat,'lon'=>lon,  'startTime'=>startTime, 'endTime'=>endTime}
		@places << place
	end

	def get_steps(segments, segment_index)
		activities = segments[segment_index]['activities']

		if activities
			get_steps_from(activities)
		end
	end

	def get_steps_from(activities)
		activities.each_with_index do |val, activity_index|

			steps = activities[activity_index]['trackPoints']

			get_all(steps)
		end
	end

	def get_all(steps)
		steps.each do |step|

			step['time'] = convert_to_time_obj(step['time'])
			@steps << step

		end
	end

end
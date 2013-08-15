class Music

	def initialize (file_path)
		@name = File.basename(file_path)
		@path = File.dirname(file_path)
	end

	def name
		@name
	end

	def path
		@path
	end

	def full_path
		path+'/'+name
	end	

	class << self
		def remove_kbps_info(file_name)
			file_name.gsub(/(\s?-?\s?)(\d\d\d(K|k)bps)(\s?)/, "")
		end

		def remove_square_bracket_string(file_name)
			file_name.gsub(/(\s?)(\[)[^\]]+(\])(\s?)/, "")	
		end
		
		def remove_piracy_branding(file_name)
			file_name.downcase.gsub(/(\s)?(-|@)?(\s)?(\(?)(www\.)?((#{stains})((\.)(#{dot_stains}))?)(\)?)(\s?)/, "")
		end

		def titleize(file_name)
			just_name = file_name.split('.')
			parts = just_name[0].split('-')
			just_name[0] = parts.size>1 ? parts.collect{|p| p.strip.titleize}.join(' - ') : just_name[0].titleize
			just_name.join('.')
		end

		def strip_special_chars(file_name)
			file_name.gsub(/(\A[^a-zA-Z]*|[^a-zA-Z0-9\)]*\z)/, "")
		end

		#Not required if using strip_special_chars
		def remove_count_prefix(file_name)
			file_name.gsub(/\A(\d+)(\s?)(-|\.)(\s*)/, "")
		end

		def stains
			["songs", "songslover", "spreadmp3", "songsdl"].join("|")
		end

		def dot_stains
			["com", "pk"].join("|")
		end
	end	
		
end	

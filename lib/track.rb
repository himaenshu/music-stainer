class Track < Music
	
	def cleanup
		new_track_name = Track.original_track_name(name)
		if name!=new_track_name
			p "Old Track Name: "+name
			p "New Track Name: "+new_track_name
			File.rename(full_path, path+'/'+new_track_name)
		end
	rescue => e
		p "Failed for track: "+name
		p e
	end

	def self.original_track_name(track_name)
		new_track_name = remove_kbps_info(track_name)
		new_track_name = remove_square_bracket_string(new_track_name)
		new_track_name = remove_piracy_branding(new_track_name)
		new_track_name = remove_album_name(new_track_name)
		new_track_name = titleize(new_track_name)
		strip_special_chars(new_track_name)
	end

	#WARNING:This could remove the actual file name
	#Execute with test data before using.
	def self.remove_album_name(track_name)
		parts = track_name.split('-')
		(parts.size==2 and parts[1].to_i==0) ? parts[1].strip : track_name 
	end

end

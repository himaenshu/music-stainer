class Album < Music
	
	def cleanup
		new_album_name = Album.original_album_name(name)
		if name!=new_album_name
			p "Old Album Name: "+name
			p "New Album Name: "+new_album_name
			File.rename(full_path, path+'/'+new_album_name)
		end
	rescue => e
		p "Failed for album: "+name
		p e
	end

	def self.original_album_name(album_name)
		new_album_name = remove_kbps_info(album_name)
		new_album_name = remove_square_bracket_string(new_album_name)
		new_album_name = remove_piracy_branding(new_album_name)
		new_album_name = titleize(new_album_name)
		strip_special_chars(new_album_name)
	end

end

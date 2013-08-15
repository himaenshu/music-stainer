class Album << Music
	
	def cleanup
		new_album_name = Album.simplfied_name(name)
		if name!=new_album_name
			p "Old Album Name: "+name
			p "New Album Name: "+new_album_name
			File.rename(path+'/'+name, path+'/'+new_album_name)
		end
		album_path+'/'+new_album_name
	rescue => e
		p "Failed for album: "+name
		p e
	end

	def self.simplfied_name(album_name)
		new_album_name = remove_kbps_info(album_name)
		new_album_name = remove_square_bracket_string(new_album_name)
		new_album_name = remove_piracy_branding(new_album_name)
		new_album_name = titleize(new_album_name)
		strip_special_chars(new_album_name)
	end

end

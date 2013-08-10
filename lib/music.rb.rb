require 'rubygems'
require "active_support/core_ext"

class MusicManager
	#DIR = "J:/My Music"
	#DIR = "E:/Music"
	DIR = "C:/Users/Himanshu/Downloads/Music"

	LOWERCASE_SOURCE_LIST = ["songs", 
							"songslover", 
							"spreadmp3", 
							"songsdl",
							]

	def self.valid_dir?(dir_name)
		not [".", ".."].include?(dir_name)  
	end
	
	def self.pk?(file_name)
		file_name.downcase.match("songs.pk")
	end
	
	def self.songslover?(file_name)
		file_name.downcase.match("songslover")	
	end
	
	def self.spreadmp3?(file_name)
		file_name.downcase.match("spreadmp3")
	end	
	
	def self.fix_naming(album_path = MusicManager::DIR)
		albums = []
		Dir.foreach(album_path) do |file_name|
			next unless MusicManager.valid_dir?(file_name)
			file = album_path+"/"+file_name
			if File.directory?(file)
				albums << {:album_path => album_path, :album_name => file_name}
				fix_naming(file)
			else
				MusicFile.format_name(album_path, file_name)
				#break
			end
		end
		albums.each do |album|
			MusicAlbum.format_name(album[:album_path], album[:album_name])
		end		
	end

	def self.simplfied_name(file_name, remove_album_name=false)
		new_file_name = self.remove_kbps_info(file_name)
		new_file_name = self.remove_square_bracket_string(new_file_name)
		new_file_name = self.remove_source_info(new_file_name)
		new_file_name = remove_album_name ? self.remove_album_name(new_file_name) : self.titleize(new_file_name)
		self.strip_special_chars(new_file_name)
	end	

	def self.remove_kbps_info(file_name)
		file_name.gsub(/(\s?-?\s?)(\d\d\d(K|k)bps)(\s?)/, "")
	end

	def self.remove_square_bracket_string(file_name)
		file_name.gsub(/(\s?)(\[)[^\]]+(\])(\s?)/, "")	
	end
	
	def self.remove_source_info(file_name)
		source_list_str = MusicManager::LOWERCASE_SOURCE_LIST.join("|")
		file_name.downcase.gsub(/(\s)?(-|@)?(\s)?(\(?)(www\.)?((#{source_list_str})((\.)(pk|com))?)(\)?)(\s?)/, "")
	end

	def self.titleize(file_name)
		just_name = file_name.split('.')
		parts = just_name[0].split('-')
		just_name[0] = parts.size>1 ? parts.collect{|p| p.strip.titleize}.join(' - ') : just_name[0].titleize
		just_name.join('.')
	end

	#WARNING:This could remove the actual file name
	#Execute with test data before using.
	def self.remove_album_name(file_name)
		parts = file_name.split('-')
		new_file_name = (parts.size==2 and parts[1].to_i==0) ? parts[1].strip : file_name
		self.titleize(new_file_name) 
	end

	def self.strip_special_chars(file_name)
		file_name.gsub(/(\A[^a-zA-Z]*|[^a-zA-Z0-9\)]*\z)/, "")
	end

	#Not required if using strip_special_chars
	def self.remove_count_prefix(file_name)
		file_name.gsub(/\A(\d+)(\s?)(-|\.)(\s*)/, "")
	end

end	

class MusicAlbum
	
	def self.format_name(album_path, album_name)
		new_album_name = MusicManager.simplfied_name(album_name)
		if album_name!=new_album_name
			p "Old Album Name: "+album_name
			p "New Album Name: "+new_album_name
			File.rename(album_path+'/'+album_name, album_path+'/'+new_album_name)
		end
		album_path+'/'+new_album_name
	rescue => e
		p "Failed for album: "+album_name
		p e
	end
end

class MusicFile
		
	def self.format_name(album_name, file_name)
		new_file_name = MusicManager.simplfied_name(file_name, true)
		if file_name!=new_file_name
			p "Old File Name: "+file_name
			p "New File Name: "+new_file_name
			File.rename(album_name+'/'+file_name, album_name+'/'+new_file_name)
		end
	rescue => e
		p "Failed for file: "+file_name
		p e
	end
	
end

MusicManager.fix_naming

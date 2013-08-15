require 'rubygems'
require 'active_support/core_ext'

require 'lib'

class MusicStainer

	def self.repository_path
		"C:/Users/Himanshu/Downloads/Music"
	end	

	def self.valid_directory?(file_name)
		not [".", ".."].include?(file_name)  
	end

	def self.album?(file_name)
		File.directory?(file_name) and valid?(file_name)
	end	

	def self.song?(file_name)
		not File.directory?(file_name)
	end	

	def self.clean_piracy_branding
		albums = []
		Dir.foreach(repository_path) do |file_name|
			file = album_path+"/"+file_name
			if album?(file)
				albums << Album.new(file)
				fix_naming(file)
			elsif song?
				song = Track.new(file)
				song.cleanup
				#break
			end
		end
		albums.each do |album|
			album.cleanup
		end		
	end

end	

MusicStainer.clean_piracy_branding

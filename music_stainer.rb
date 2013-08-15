require 'rubygems'
require 'active_support/core_ext'

require 'lib/music.rb'
require 'lib/album.rb'
require 'lib/track.rb'

class MusicStainer

	def self.repository_path
		"D:/Workspace/test"
	end	

	def self.valid_directory?(file_name)
		not [".", ".."].include?(file_name)  
	end

	def self.album?(file_name)
		File.directory?(file_name) and not [".", ".."].include?(file_name)
	end	

	def self.song?(file_name)
		not File.directory?(file_name)
	end	

	def self.clean_piracy_branding(album_path=repository_path)
		albums = []
		Dir.foreach(album_path) do |file_name|
			file_path = album_path+"/"+file_name
			if album?(file_name)
				albums << Album.new(file_path)
				clean_piracy_branding(file_path)
			elsif song?(file_name)
				song = Track.new(file_path)
				song.cleanup
				#break
			else
				next	
			end
		end
		p "Tracks cleaned-up."
		albums.each do |album|
			album.cleanup
		end
		p "Albums cleaned-up."		
	end

end	

p "*********************************************"
p "*************** MUSIC STAINER ***************"
p "*********************************************"
p "Cleaning piracy branding..."

MusicStainer.clean_piracy_branding

p "We are done! Enjoy the music. "
p "*********************************************"

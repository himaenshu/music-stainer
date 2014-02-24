lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "music-stainer"
  spec.version       = "0.0.1"
  spec.authors       = ["Himanshu Joshi"]
  spec.email				 = ["himaenshu@gmail.com"]
  spec.summary       = "Music Stainer cleans up the piracy branding from the music tracks and albums"
  spec.files         = ["lib/music_stainer.rb"]
  spec.require_paths = ["lib"]
end

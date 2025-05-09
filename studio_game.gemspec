Gem::Specification.new do |spec|
  spec.name        = "JB_Studio_Game"
  spec.version     = "1.0.0"
  spec.author      = "Julia Baumberg"
  spec.email       = "juliabaumberg@gmail.com"
  spec.summary     = "Fun little game; roll some die, win some points!"
  spec.homepage    = ""
  spec.license     = "MIT"

  spec.files       = Dir["{bin,lib}/**/*"]

  spec.executables = ["studio_game"]

  spec.required_ruby_version = ">= 3.2.0"
end
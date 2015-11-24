$:.push File.expand_path("../lib", __FILE__)

require 'comfy_blog/version'

Gem::Specification.new do |s|
  s.name        = 'comfy_blog'
  s.version     = ComfyBlog::VERSION
  s.authors     = ["Oleg Khabarov", "Demitry Toumilovich"]
  s.email       = ["oleg@khabarov.ca", "demitry.toumilovich@hitfoxgroupcom"]
  s.homepage    = "https://github.com/DemitryT/comfy-blog"
  s.summary     = "Blog component for ComfortableMexicanLoveseat"
  s.description = "Easily integrate a blog with a comfy site built on top of ComfortableMexicanLoveseat"
  s.license     = 'MIT'

  s.files         = `git ls-files`.split("\n")
  s.platform      = Gem::Platform::RUBY
  s.require_paths = ['lib']

  s.add_dependency 'comfortable_mexican_loveseat', '0.0.20'
end

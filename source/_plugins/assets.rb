require "coffee_script"
require "jekyll-assets"
require "jekyll-assets/compass"
require "sprockets"

require "breakpoint"
breakpoint_root = Gem::Specification.find_by_name("breakpoint").gem_dir
Sprockets.append_path File.join(breakpoint_root, "stylesheets")

require "compass-normalize"
normalize_root = Gem::Specification.find_by_name("compass-normalize").gem_dir
Sprockets.append_path File.join(normalize_root, "stylesheets")

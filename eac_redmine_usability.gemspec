# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

require 'eac_redmine_usability/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = ::EacRedmineUsability::SLUG
  s.version     = ::EacRedmineUsability::VERSION
  s.authors     = [::EacRedmineUsability::AUTHOR]
  s.summary     = ::EacRedmineUsability::SUMMARY

  s.files = Dir['{app,config,db,lib}/**/*', 'init.rb']

  s.add_dependency 'eac_ruby_utils', '~> 0.33', '>= 0.33.1'
end

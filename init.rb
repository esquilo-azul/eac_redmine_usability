# frozen_string_literal: true

require 'redmine'
require 'eac_redmine_usability/version'

Redmine::Plugin.register EacRedmineUsability::SLUG.to_sym do
  name EacRedmineUsability::NAME
  author EacRedmineUsability::AUTHOR
  description EacRedmineUsability::SUMMARY
  version EacRedmineUsability::VERSION
end

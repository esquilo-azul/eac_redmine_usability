# frozen_string_literal: true

source = ::EacRedmineUsability::Undeletable
[::Issue, ::User].each do |target|
  target.send(:include, source) unless target.included_modules.include? source
end

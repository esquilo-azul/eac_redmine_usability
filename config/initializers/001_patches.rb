# frozen_string_literal: true

source = ::EacRedmineUsability::Undeletable
[::Issue, ::Project, ::User, ::Wiki, ::WikiPage].each do |target|
  target.send(:include, source) unless target.included_modules.include? source
end

# frozen_string_literal: true

namespace :eac_redmine_usability do
  Rake::TestTask.new(test: 'db:test:prepare') do |t|
    plugin_root = ::File.dirname(::File.dirname(__dir__))

    t.description = 'Run plugin eac_redmine_usability\'s tests.'
    t.libs << 'test'
    t.test_files = ["#{plugin_root}/test/**/*_test.rb"]
    t.verbose = true
  end
end

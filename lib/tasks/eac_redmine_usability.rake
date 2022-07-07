# frozen_string_literal: true

require 'rake/testtask'

namespace :eac_redmine_usability do
  Rake::TestTask.new(test: 'db:test:prepare') do |t|
    plugin_root = ::File.dirname(::File.dirname(__dir__))

    t.description = 'Run plugin eac_redmine_usability\'s tests.'
    t.libs << 'test'
    t.test_files = FileList["#{plugin_root}/test/**/*_test.rb"]
    t.verbose = false
    t.warning = false
  end

  desc 'Close projects no longer used.'
  task :close_unused_projects, %i[expire_days confirm] => :environment do |_t, args|
    ::EacRedmineUsability::CloseUnusedProjects.new(
      args.expire_days.to_i,
      args.confirm.present?
    ).run
  end
end

# frozen_string_literal: true

require 'redmine_plugins_helper/test_tasks/auto'
RedminePluginsHelper::TestTasks::Auto.register(:eac_redmine_usability)

namespace :eac_redmine_usability do
  desc 'Close projects no longer used.'
  task :close_unused_projects, %i[expire_days confirm] => :environment do |_t, args|
    ::EacRedmineUsability::CloseUnusedProjects.new(
      args.expire_days.to_i,
      args.confirm.present?
    ).run
  end
end

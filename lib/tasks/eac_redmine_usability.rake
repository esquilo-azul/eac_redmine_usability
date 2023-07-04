# frozen_string_literal: true

require 'redmine_plugins_helper/plugin_rake_task'
::RedminePluginsHelper::PluginRakeTask.register(:eac_redmine_usability, :test)

namespace :eac_redmine_usability do
  desc 'Close projects no longer used.'
  task :close_unused_projects, %i[expire_days confirm] => :environment do |_t, args|
    ::EacRedmineUsability::CloseUnusedProjects.new(
      args.expire_days.to_i,
      args.confirm.present?
    ).run
  end
end

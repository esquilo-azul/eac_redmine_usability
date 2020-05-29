# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module EacRedmineUsability
  class CloseUnusedProjects
    DEFAULT_EXPIRE_DAYS = 180

    require_sub __FILE__
    enable_simple_cache
    common_constructor :expire_days, :confirm do
      self.expire_days = DEFAULT_EXPIRE_DAYS unless expire_days.is_a?(::Integer) &&
                                                    expire_days.positive?
      self.confirm = confirm ? true : false
    end

    def run
      start_bunner
      expired_projects.each(&:run)
    end

    private

    def active_projects_uncached
      ::Project.active.map { |project| ProjectCheck.new(self, project) }
    end

    def expired_projects_uncached
      active_projects.select(&:expired?).sort_by { |p| [p.expired_time] }
    end

    def now_uncached
      ::Time.zone.now
    end

    def start_bunner
      ::Rails.logger.info("Expire days: #{expire_days}")
      ::Rails.logger.info("Confirm: #{confirm}")
      ::Rails.logger.info("Active projects: #{active_projects.count}")
      ::Rails.logger.info("Expired projects: #{expired_projects.count}")
    end

    def to_fetch_activity_user_uncached
      ::User.admin.first || raise('None admin user found')
    end
  end
end

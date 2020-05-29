# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module EacRedmineUsability
  class CloseUnusedProjects
    class ProjectCheck
      enable_simple_cache
      common_constructor :parent, :project

      def run
        start_banner
        close
      end

      def expired?
        expired_days > parent.expire_days
      end

      private

      def start_banner
        ::Rails.logger.info("Project: #{project}")
        ::Rails.logger.info("  * Last update: #{last_update}")
        ::Rails.logger.info("  * Expired days: #{expired_days}")
      end

      def close
        return unless parent.confirm

        if project.active?
          ::Rails.logger.info('  * Closing...')
          project.close
        else
          ::Rails.logger.info('  * Project is not active')
        end
      end

      def expired_time_uncached
        parent.now - last_update
      end

      def expired_days
        (expired_time / (24 * 60 * 60)).to_i
      end

      def last_update_uncached
        ([self_last_update] + subprojects.map(&:last_update)).max
      end

      def self_last_update
        updates = [project.updated_on]
        self_last_update_by_events.if_present { |v| updates << v }
        updates.max
      end

      def self_last_update_by_events
        ::Redmine::Activity::Fetcher.new(
          parent.to_fetch_activity_user, project: project, with_subprojects: false
        ).events.first.try(:created_on)
      end

      def subprojects_uncached
        project.children.active.map { |child| self.class.new(parent, child) }
      end
    end
  end
end

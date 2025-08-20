# frozen_string_literal: true

module EacRedmineUsability
  module Patches
    module TestCase
      extend ::ActiveSupport::Concern

      included do
        setup do
          ::EacRedmineUsability::Undeletable.allow_destroy = true
        end

        teardown do
          ::EacRedmineUsability::Undeletable.allow_destroy = false
        end
      end
    end
  end
end

if Rails.env.test?
  patch = EacRedmineUsability::Patches::TestCase
  target = ActiveSupport::TestCase
  target.send(:include, patch) unless target.included_modules.include?(patch)
end

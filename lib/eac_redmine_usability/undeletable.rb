# frozen_string_literal: true

module EacRedmineUsability
  module Undeletable
    extend ::ActiveSupport::Concern

    included do
      before_destroy :block_destroy, prepend: true
      include InstanceMethods
    end

    class << self
      attr_accessor :allow_destroy

      def on_allow_destroy(allow)
        old_value = allow_destroy
        begin
          self.allow_destroy = allow
          yield
        ensure
          self.allow_destroy = old_value
        end
      end
    end

    module InstanceMethods
      def block_destroy
        return if ::EacRedmineUsability::Undeletable.allow_destroy

        errors.add :base, 'Este registro não pode ser removido. Em vez disso tente associá-lo a ' \
                          'um status como "Rejeitado" ou "Depreciado".'

        throw(:abort)
      end
    end
  end
end

# frozen_string_literal: true

module EacRedmineUsability
  module Undeletable
    extend ::ActiveSupport::Concern

    included do
      before_destroy :block_destroy, prepend: true
      include InstanceMethods
    end

    module InstanceMethods
      def block_destroy
        errors.add :base, 'Este registro não pode ser removido. Em vez disso tente associá-lo a ' \
          'um status como "Rejeitado" ou "Depreciado".'
        false
      end
    end
  end
end

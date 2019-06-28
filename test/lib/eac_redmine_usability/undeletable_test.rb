# frozen_string_literal: true

require 'test_helper'

module EacRedmineUsability
  class UndeletableTest < ActiveSupport::TestCase
    fixtures :issues, :issue_statuses, :users, :wikis

    [::Issue, ::User, ::Wiki].each do |klass|
      test "#{klass.name.humanize.downcase} cannot be deleted" do
        cannot_be_deleted_test(klass)
      end
    end

    private

    def cannot_be_deleted_test(klass)
      record = klass.first
      assert record.is_a?(klass), 'Nenhum registro encontrado - provável ausência do fixture '\
        "\":#{klass.name.underscore.pluralize}."

      id = record.id
      assert record.errors[:base].blank?
      assert_not record.destroy, 'Registro foi removido.'
      assert record.errors[:base].present?, 'Não foi encontrada mensagem de erro.'
      assert klass.find(id), 'Registro não foi encontrado após tentativa de remoção.'
    end
  end
end

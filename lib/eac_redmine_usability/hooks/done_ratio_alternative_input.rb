# frozen_string_literal: true

module EacRedmineUsability
  module Hooks
    class DoneRatioAlternativeInput < ::Redmine::Hook::ViewListener
      attr_accessor :output_buffer

      ORIGINAL_INPUT_ID = 'issue_done_ratio'
      ALTERNATIVE_INPUT_ID = ORIGINAL_INPUT_ID + '_alternative'
      CHANGER_CONTROL_ID = ORIGINAL_INPUT_ID + '_changer'
      HIDDEN_CONTENT_ID = ORIGINAL_INPUT_ID + '_hidden_content'
      ELEMENTS_IDS = [ORIGINAL_INPUT_ID, ALTERNATIVE_INPUT_ID, CHANGER_CONTROL_ID,
                      HIDDEN_CONTENT_ID].freeze

      MINIMUM_VALUE = 0
      MAXIMUM_VALUE = 100

      # @param context [Hash]
      # return [ActiveSupport::SafeBuffer]
      def view_issues_form_details_bottom(context = {})
        safe_join([hidden_content(context[:issue]), script_tag])
      end

      private

      # return [ActiveSupport::SafeBuffer]
      def alternative_input(issue)
        tag(:input, id: ALTERNATIVE_INPUT_ID, type: 'number', value: issue.done_ratio,
                    min: MINIMUM_VALUE, max: MAXIMUM_VALUE)
      end

      # return [ActiveSupport::SafeBuffer]
      def changer_control
        link_to('', '#', id: CHANGER_CONTROL_ID, class: 'icon icon-move',
                         title: I18n.t('issue_done_ratio_change_control'))
      end

      # @return [String]
      def elements_ids_argument_list
        ELEMENTS_IDS.map { |id| "'#{id}'" }.join(', ')
      end

      # return [ActiveSupport::SafeBuffer]
      def hidden_content(issue)
        tag.div(id: HIDDEN_CONTENT_ID, style: 'display: none;') do
          safe_join([alternative_input(issue), changer_control])
        end
      end

      # return [String]
      def script_content
        <<~SCRIPT
          $(document).ready(function() {
            (new IssueDoneRatioAlternativeInput(#{elements_ids_argument_list})).init();
          });
        SCRIPT
      end

      # return [ActiveSupport::SafeBuffer]
      def script_tag
        javascript_tag script_content
      end
    end
  end
end

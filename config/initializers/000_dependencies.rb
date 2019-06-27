# frozen_string_literal: true

Redmine::Plugin.post_register :eac_redmine_usability do
  # Source: https://github.com/esquilo-azul/redmine_plugins_helper
  requires_redmine_plugin(:redmine_plugins_helper, version_or_higher: '0.4.0')
end

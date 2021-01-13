require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module RailsApp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2
    config.time_zone = 'Asia/Tokyo'
    config.active_record.default_timezone = :local
    config.action_view.field_error_proc = Proc.new do |html_tag, instance|
      unless instance.kind_of?(ActionView::Helpers::Tags::Label)
        "#{html_tag}<p class=\"help is-danger\">#{instance.error_message.first}</p>".html_safe
      end
    end

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end

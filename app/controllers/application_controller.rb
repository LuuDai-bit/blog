class ApplicationController < ActionController::Base
  include Pagy::Backend

  before_action do
    too_many_requests if log.access_count > ENV.fetch('MAX_REQUEST_ALLOW').to_i
  end

  after_action do
    log.access_count += 1
    log.save!
  end

  def default_url_options
    { locale: I18n.locale }
  end

  def switch_locale(&action)
    locale = params[:locale] || I18n.default_locale
    return unless I18n.available_locales.include?(locale.to_sym)

    I18n.with_locale(locale, &action)
  end

  private

  def log
    @log ||= Log.where('DATE(created_at) = CURRENT_DATE')
                .find_or_initialize_by(ip_address: request.remote_ip)
  end

  def too_many_requests
    render file: 'public/429.html', status: :too_many_requests, layout:false
  end
end

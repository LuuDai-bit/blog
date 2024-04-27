class User::UserController < ApplicationController
  layout 'user/application'

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_404_exception

  around_action :switch_locale

  def default_url_options
    { locale: I18n.locale }
  end

  def switch_locale(&action)
    locale = params[:locale] || I18n.default_locale
    locale = I18n.default_locale unless I18n.available_locales.include?(locale.to_sym)

    I18n.with_locale(locale, &action)
  end

  private

  def rescue_404_exception
    render file: Rails.root.join("public", "404.html").to_s, layout: false,
           status: :not_found
  end
end

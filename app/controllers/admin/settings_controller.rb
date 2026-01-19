class Admin::SettingsController < Admin::AdminController
  def index; end

  def edit
    settings = Setting.all
    @theme = settings.detect{ |setting| setting.name == 'theme' }&.value
    @theme = 'default' if @theme.blank?
  end

  def update
    settings = Setting.where(name: setting_params.keys)
    setting_params.keys.each do |setting_key|
      setting = settings.detect { |s| s.name == setting_key.to_s }
      if setting.present?
        setting.update!(value: setting_params[setting_key])
      else
        Setting.create!(name: setting_key.to_s, value: setting_params[setting_key])
      end
    end

    flash[:notice] = 'Settings updated successfully.'

    redirect_to admin_settings_path

  rescue StandardError => e
    flash.now[:alert] = "Failed to update settings: #{e.message}"
  end

  private

  def setting_params
    params.require(:settings).permit(:theme)
  end
end

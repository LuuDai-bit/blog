module ApplicationHelper
  include Pagy::Frontend

  def display_error object, method, name
    return unless object&.errors.present? && object.errors.key?(method)

    error = "#{name} #{object.errors.messages[method][0]}"
    content_tag :div, error, class: "error-feedback"
  end

  def toastr_flash
    flash.each_with_object([]) do |(type, message), flash_messages|
      type = 'success' if type == 'notice'
      type = 'error' if type == 'alert'
      text = "<script>toastr.#{type}('#{message}', '', { closeButton: false, progressBar: true })</script>"
      flash_messages << text.html_safe if message
    end.join("\n").html_safe
  end

  def current_controller?(options)
    path = request.original_fullpath
    path.include?(options)
  end

  def default_locale?
    I18n.locale == :vi
  end

  def format_datetime(date, format='%d-%m-%Y')
    return unless date.methods.include?(:strftime)

    date.strftime(format)
  end

  def display_image(url, options={})
    if File.exist?("#{Rails.public_path}/public/images/#{url}")
      image = image_tag("#{url}",options)
    else
      image = image_tag("no_image", options)
    end

    image
  end
end

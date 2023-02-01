module ApplicationHelper
  include Pagy::Frontend

  def display_error object, method, name
    return unless object&.errors.present? && object.errors.key?(method)

    error = "#{name} #{object.errors.messages[method][0]}"
    content_tag :div, error, class: "error-feedback"
  end
end

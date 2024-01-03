# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend
  def btn_disabled_animation
    html = <<-HTML
      <i class='bi bi-hourglass-split'></i> Yukleniyor...
    HTML
    html.html_safe
  end

  def errors_for(model, key)
    tag.div(class: "mt-2 form-error") do
      model.errors.messages_for(key).join(", ")
    end
  end
end

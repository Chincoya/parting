# frozen_string_literal: true

module ApplicationHelper
  def title_helper(title)
    return title.upcase if title != ''

    'PARTING'
  end

  def action_button_helper(button)
    return '<div class="action-button"></div>'.html_safe if button.blank?

    button
  end
end

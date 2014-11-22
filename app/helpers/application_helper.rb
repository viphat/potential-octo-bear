module ApplicationHelper
  def markdown(text)
    unless text.nil?
      renderer = Redcarpet::Render::HTML.new(autolinks: true, hard_wrap: true,
                                             filter_html: true,
                                            )
      markdown = Redcarpet::Markdown.new(renderer, extensions = {})
      markdown.render(text).html_safe
    else
      text
    end
    # renderer.render(text).to_html.html_safe
  end
end

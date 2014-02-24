module ApplicationHelper
  def view_role(user)
    if user.super_user?
      "管理者"
    else
      "一般"
    end
  end

  def abbreviation(str, max_length=10)
    if str.size > max_length
      "#{str.slice(0, max_length)}..."
    else
      str
    end
  end

  def time_format(time)
    time.strftime("%Y/%m/%d %H:%M:%S")
  end

  def markdown(text)
    redcarpet = Redcarpet::Markdown.new(
      Redcarpet::Render::HTML.new(filter_html: true, hard_wrap: true), 
      fenced_code_blocks: true,
      autolink: true)
    redcarpet.render(text).html_safe
  end
end

module ApplicationHelper
	# Returns the full title on a per-page basis.
  def full_title(page_title = '')
    base_title = "NoteIt"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end
  def user_name(user)
    if user.name.nil?
      user.email
    else
      user.name
    end
  end
  def javascript(*args)
  	content_for(:head) { javascript_include_tag(*args) }
  end
end

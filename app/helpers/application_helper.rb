module ApplicationHelper
  def render_logo
    render :partial => 'shared/logo'
  end

  def render_footer
    render :partial => 'shared/footer'
  end

  def render_messages
    render :partial => 'shared/messages'
  end

  def render_userbar
    render :partial => 'shared/userbar'
  end
end

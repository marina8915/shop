class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def redirect_access(path)
    redirect_to path, alert: 'Access is denied.'
  end

  def check_access(item)
    if current_user
      current_user.access && current_user.id == item.user_id
    else
      false
    end
  end

  def set_categories_filters
    @categories = Category.all
    @filters = Filter.all
    @pages = Page.all
  end

  helper_method :current_user, :redirect_access, :check_access
end

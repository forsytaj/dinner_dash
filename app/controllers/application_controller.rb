class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  #before_action :miniprofiler if Rails.env.development?
  
  private
  helper_method :current_cart, :current_user, :is_admin?, :user_signed_in?, :per_page
  
  def per_page
    params[:per_page] || 10
  end 
  
  def current_cart
    @current_cart ||= Cart.new(session)
  end
  
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end 
  
  def authorize
    redirect_to signin_url, notice: "Not authorized!" unless user_signed_in?
  end 
  
  def authorized_for_admin?
    redirect_to root_path, notice: 'Not authorized!' unless is_admin?
  end
  
  def authorized_for_self?
    redirect_to root_path, notice: 'Not authorized!' unless user_signed_in? && (current_user.id.to_s == params[:id])
  end
  
  
  def is_admin?
    user_signed_in? && current_user.admin?
  end
  
  def user_signed_in?
    !current_user.nil?
  end
end

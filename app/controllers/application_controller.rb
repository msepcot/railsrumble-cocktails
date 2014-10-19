class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :current_or_guest_user

  # if user is logged in, return current_user, else return guest_user
  def current_or_guest_user
    if @current_user
      if session[:guest_user_id] && session[:guest_user_id] != @current_user.id
        guest_user(with_retry = false).try(:destroy)
        session[:guest_user_id] = nil
      end
      @current_user
    else
      guest_user
    end
  end

  # find guest_user object associated with the current session,
  # creating one as needed
  def guest_user(with_retry = true)
    # Cache the value the first time it's gotten.
    @cached_guest_user ||= User.find(session[:guest_user_id] ||= create_guest_user.id)

  rescue ActiveRecord::RecordNotFound # if session[:guest_user_id] invalid
    session[:guest_user_id] = nil
    guest_user if with_retry
  end

  private

  # login action here to set current user

  def create_guest_user
    u = User.new_guest
    u.save!(:validate => false)
    session[:guest_user_id] = u.id
    u
  end
end

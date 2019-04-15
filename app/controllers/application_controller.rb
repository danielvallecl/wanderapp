class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
# The helper_method syntax makes the methods available in all views
  helper_method :current_user, :logged_in?, :latitudes, :longitudes, :titles, :addresses, :eventowner, :ids

# If Current user exists don't do anything, if it doesn't it avaliates as the right side of the equation
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

# Converts current_user to a Boolean
  def logged_in?
    !!current_user
  end

# Creates an admin log in

  def require_user
    if !logged_in?
      flash[:danger] = 'Please Log In to access the App'
      redirect_to root_path
    end
  end

def ids
  search = Event.all
  @id = []
  search.each do |e|
    if e.latitude != nil
      @id << e.id
    end
  end
  return @id
end

# Gets Title data for Maps
def titles
  search = Event.all
  @title = []
  search.each do |e|
    if e.latitude != nil
      @title << e.title
    end
  end
  return @title
end

def addresses
  search = Event.all
  @addresses = []
  search.each do |e|
    if e.latitude != nil
      @addresses << e.formattedaddress
    end
  end
  return @addresses
end

def eventowner
  search = Event.all
  @eventowner = []
  search.each do |e|
    if e.latitude != nil && e.user_id == current_user.id
      @eventowner << true
    else
      @eventowner << false if e.latitude != nil
    end
  end
  return @eventowner
end

def latitudes
  search = Event.all
  @latitudes = []
  search.each do |e|
    if e.latitude != nil
      @latitudes << e.latitude
    end
  end
  return @latitudes
end

  def longitudes
    search = Event.all
    @longitudes = []
      search.each do |e|
        if e.longitude != nil
          @longitudes << e.longitude
        end
      end
      return @longitudes
  end


end

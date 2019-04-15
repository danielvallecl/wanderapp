class PagesController < ApplicationController
  # redirects to Events page when a user is logged in

  def home
    @user = User.new
    if logged_in?
      redirect_to events_path
    else
      # Counting number of events
      @eventsbycategory = []
      @totalevents = Event.all.count
      search = Event.all
      catall = Category.all
      catall.each do |c|
        @eventsbycategorycount = search.where(category: c.name).count
        @eventsbycategory += [c.name => @eventsbycategorycount]
      end

      # Getting latitude and longitude of all Events
    end
  end

  def about
  end

end

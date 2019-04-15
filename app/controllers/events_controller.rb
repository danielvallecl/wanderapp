class EventsController < ApplicationController
  before_action :require_login, only:[:edit, :update, :destroy, :show, :index]
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  # Restrict unlogged access to all actions except for index and show
  before_action :require_user, except: [:index, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]

# Adding pagination to the index action

  def index
    if logged_in?

      @places = Event.order('created_at DESC')
      @events_ordered = Event.order('startdate ASC')
      filter_by_city(params["city"])
      @categories = Category.all
      filter_by_category(params["category"])
      search_results
      # Search by city for paginate
      if params["city"] != nil
        city_events = []
        @events_by_city.each do |e|
          city_events << @events_ordered.find(e)
        end
        @events = city_events.paginate(page: params[:page], per_page: 12)
      else
        # Search by category for paginate
        if params["category"] != nil
          cat_events = []
          @events_by_category.each do |e|
            cat_events << @events_ordered.find(e)
          end
          @events = cat_events.paginate(page: params[:page], per_page: 6)
        else
          @events = @events_ordered.paginate(page: params[:page], per_page: 12)
        end
      end

    else
      flash[:danger] = "You don't have permission to perform this action."
      redirect_to root_path
    end
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @event = Event.find(params[:id])
    filter_by_city(params["city"])
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)
    #Makes so that the created event is tied to the active user
    @event.user = current_user
    respond_to do |format|
      if @event.save
        # Event owner must join the event
        event = Event.last
        event_id = event.id
        event_user_id = event.user_id
        event_obs = 'I am the owner of this event'
        event_status = true
        act = Active.new(user_id: event_user_id, event_id: event_id, status: event_status, obs: event_obs)
        act.save
        save_events_file("eventlist.txt")
        # end of joining event
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end


  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

#============= Custom Methods ==============#

# Saves a list of all events to a file

def save_events_file(filename)
  if !File.exists?("wander_logs/#{filename}")
    save_events = File.new("wander_logs/#{filename}", "w+")
    save_events.puts("File #{filename} was created at #{Time.now}")
    save_events.close
  end
  save_events = File.new("wander_logs/#{filename}", "w+")
  buffer = Event.all.order('title ASC')
  buffer.each do |e|
    buffer_out = "#{e.title}, #{e.description}, #{e.category}, #{e.startdate}, #{e.starttime}, #{e.duration}, #{e.owner}, #{e.city}, #{e.country}, #{e.formattedaddress}, #{e.latitude}, #{e.longitude}, #{e.state}"
    save_events.puts(buffer_out)
  end
  save_events.close
end



def search_results
  search_request = params["search"]
  if search_request != ''
    search = Event.all
    @search_results = search.where('title ILIKE :search', search: "%#{search_request}%")
    @search_results += search.where('country ILIKE :search', search: "%#{search_request}%")
    @search_results += search.where('city ILIKE :search', search: "%#{search_request}%")

    @search_count = @search_results.count
    cat = Category.all
    begin
      cat_result = cat.where('name ILIKE :search', search: "%#{params["search"]}%")
      @category_results = search.where('category ILIKE :search', search: "%#{cat_result[0].name}%")
      @category_count = @category_results.count
    rescue
      @category_results = []
      @category_count = 0
    end
  else
    @search_count = 0
    @category_count = 0
    @category_results = []
  end
end

def filter_by_city(city)
  @events_by_city = []
  if city != nil
    @current_city = city
      Event.all.each do |e|
        if e.city == @current_city
          @events_by_city += [Event.all.find(e.id).id]     #e.id has to become an array to be appended into events_by_city
        end
      end
    @events_by_city = @events_by_city.sort
  end
end

def filter_by_category(category)
  @events_by_category = []
  if category != nil
    @current_category = category
      Event.all.each do |e|
        if e.category == @current_category
          @events_by_category += [Event.all.find(e.id).id]     #e.id has to become an array to be appended into events_by_city
        end
      end
    @events_by_category = @events_by_category.sort
  end
end

  private

    def require_same_user
       # Checks if the current user is either the creator of the event or an admin
      if current_user != @event.user and !current_user.admin?
        flash[:danger] = "You don't have permission to perform this action."
        redirect_to root_path
      end
    end

    def require_login
      if !logged_in?
        flash[:danger] = "You must log in to perform this action."
        redirect_to root_path
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_event
      exist_event = Event.where(id: params[:id])
      if exist_event != [] and logged_in?
        @event = Event.find(params[:id])
      else
        flash[:danger] = "You don't have permission to perform this action."
        if !logged_in?
          redirect_to root_path
        else
          redirect_to events_path
        end
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:title, :description, :category, :startdate, :starttime, :duration, :owner, :city, :country, :address, :formattedaddress, :obs, :active, :aux1, :aux2, :aux3)
    end

end

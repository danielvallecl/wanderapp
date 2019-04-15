class UsersController < ApplicationController

  before_action :require_login, only:[:edit, :update, :destroy, :show, :index]
  # Applies the set_user function to the show, edit, update and destroy actions

  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # Destroy gives permission for the admin to delete

  before_action :require_same_user, only: [:edit, :update, :destroy]
  before_action :require_admin, only: [:destroy, :index, :show]

  # GET /users
  # GET /users.json
  def index
    @users = User.paginate(page: params[:page], per_page: 10)
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @events_ordered = Event.order('startdate ASC')
    joined_event = []
    event_user = []
    if params["from"]=="myevents"
      act = Active.where(user_id: current_user.id)
      act.each do |active|
        joined = @events_ordered.find(active.event_id)
        if joined.user_id != current_user.id
          joined_event << joined
        end
      end

      event_user = @events_ordered.where(user_id: current_user.id)
      ev = joined_event + event_user
      @user_events = ev.paginate(page: params[:page], per_page: 5)
    else
      @user_events = @user.events.paginate(page: params[:page], per_page: 5)
    end
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        session[:user_id] = @user.id
        @edit = false     # Variable criated to differentiate edit and create when entering user edit _form.html.erb
        format.html { redirect_to events_path, notice: "Welcome #{@user.firstname}!"}
        format.json { render :show, status: :created, location: @user }
      else
        flash.now[:notice] = 'Username or Password already exists'
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        @edit = true     # Variable criated to differentiate edit and create when entering user edit _form.html.erb
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_path, notice: 'The user and all associated events were successfully deleted.'}
      format.json { head :no_content }
    end

  end

  private

    def require_admin
      if !logged_in?
        flash[:danger] = "You don't have permission for this action."
        redirect_to root_path
      else
        if !current_user.admin? and params['from'] == nil and @edit == false
          flash[:danger] = "You don't have permission for this action."
          redirect_to root_path
        else

        end
      end
    end

    def require_same_user
      begin
        if current_user != @user and !current_user.admin?
          flash[:danger] = "You don't have permission for this action."
          redirect_to root_path
        end
      rescue
        flash[:danger] = "You don't have permission for this action."
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
    def set_user
      begin
        user = User.find(params[:id])
        if user != []
          @user = user
        else
          flash[:danger] = "You don't have permission for this action."
          redirect_to events_path
        end
      rescue
        flash[:danger] = "You don't have permission for this action."
        redirect_to events_path
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:username, :email, :password, :firstname, :lastname, :country, :city, )
    end
end

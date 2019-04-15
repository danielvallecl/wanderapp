class PreferencesController < ApplicationController
  before_action :require_login, only:[:edit, :update, :destroy, :show, :index]
  before_action :set_preference, only: [:show, :edit, :update, :destroy]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  # GET /preferences
  # GET /preferences.json
  def index
    @categories = Category.order("name ASC")
    @user_preferences = nil
    # Returns User Preferences
    @preferences = Preference.all
    @current_user_pref = params["user_id_pref"].to_i   #Params brings the current user's id from the link_to on the navbar
    @preferences.each do |pref|
      if pref.user_id == @current_user_pref  #Filters only rows that belong to that ID.
        @user_preferences = pref
        return
      end
    end
  end

  # GET /preferences/1
  # GET /preferences/1.json
  def show
    @categories = Category.order("name ASC")
  end

  # GET /preferences/new
  def new
    @preference = Preference.new
  end

  # GET /preferences/1/edit
  def edit
    @categories = Category.order("name ASC")
  end

  # POST /preferences
  # POST /preferences.json
  def create
    @preference = Preference.new(preference_params)
    if Preference.where(user_id: current_user.id).count == 0
      respond_to do |format|
        if @preference.save
          format.html { redirect_to @preference, notice: 'Preference was successfully created.' }
          format.json { render :show, status: :created, location: @preference }
        else
          format.html { render :new }
          format.json { render json: @preference.errors, status: :unprocessable_entity }
        end
      end
    else
      flash[:danger] = "You have already setup your preference."
      redirect_to preferences_path
    end
  end

  # PATCH/PUT /preferences/1
  # PATCH/PUT /preferences/1.json
  def update
    respond_to do |format|
      if @preference.update(preference_params)
        format.html { redirect_to @preference, notice: 'Preference was successfully updated.' }
        format.json { render :show, status: :ok, location: @preference }
      else
        format.html { render :edit }
        format.json { render json: @preference.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /preferences/1
  # DELETE /preferences/1.json
  def destroy
    @preference = Preference.find(params[:id])
    user = User.find(current_user.id)
    user.pref_id = ""
    user.save
    @preference.destroy
    respond_to do |format|
      format.html { redirect_to preferences_url, notice: 'Preference was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_preference
      begin
        @preference = Preference.find(params[:id])
      rescue
        flash[:danger] = "You don't have permission for this action."
        redirect_to preferences_path
      end
    end

    def require_login
      if !logged_in?
        flash[:danger] = "You must log in to perform this action."
        redirect_to root_path
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def preference_params
      params.require(:options)
      params.require(:obs)
      params.require(:aux1)
      params.require(:user_id)
      params.permit(:options, :obs, :aux1, :user_id)
    end

    def require_same_user
      if current_user.id != @preference.user_id and !current_user.admin?
        flash[:danger] = "You don't have permission for this action."
        redirect_to preferences_path
      end
    end
end

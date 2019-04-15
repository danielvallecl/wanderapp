class ActivesController < ApplicationController
  before_action :set_active, only: [:show, :edit, :update, :destroy]

  # GET /actives
  # GET /actives.json
  def index
    @actives = Active.all
  end

  # GET /actives/1
  # GET /actives/1.json
  def show
  end

  # GET /actives/new
  def new
    @active = Active.new
  end

  # GET /actives/1/edit
  def edit
  end

  # POST /actives
  # POST /actives.json
  def create
    @active = Active.new(active_params)
    if check_join_event == true

      respond_to do |format|
        if @active.save
          format.html { redirect_to user_path(current_user, :from => 'myevents'), notice: 'You have joined this event, have fun!' }
          format.json { render :show, status: :created, location: @active }
        else
          format.html { render :new }
          format.json { render json: @active.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to events_path, notice: 'Joining this Event already done.'
    end
  end

  # PATCH/PUT /actives/1
  # PATCH/PUT /actives/1.json
  def update
    respond_to do |format|
      if @active.update(active_params)
        format.html { redirect_to @active, notice: 'Join event was successfully updated.' }
        format.json { render :show, status: :ok, location: @active }
      else
        format.html { render :edit }
        format.json { render json: @active.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /actives/1
  # DELETE /actives/1.json
  def destroy
    @active.destroy
    respond_to do |format|
      format.html { redirect_to actives_url, notice: 'Join event was successfully deleted.' }
      format.json { head :no_content }
    end
  end

# =============== CUSTOM FUNCTIONS ===================== #

# Checks if a User's event has been joined already
# Params such as ID have to be converted to an interger because params always returns a string type.
# exist[0] is to get the first item of the array


def check_join_event
  exist = Active.where(user_id: active_params['user_id'].to_i, event_id: active_params['event_id'].to_i)
  if exist[0] == nil
    return true
  else
    return false
  end
end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_active
      @active = Active.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def active_params
      params.require(:active).permit(:user_id, :event_id, :status, :obs)
    end
end

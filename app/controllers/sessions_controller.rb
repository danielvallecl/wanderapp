class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:success] = "Welcome Back #{user.firstname}!"

      # A function to print out logins and logouts
      login_logout

      redirect_to events_path
    else
      flash.now[:danger] = 'Log In Information Incorrect'
      render 'new'
    end
  end

  def destroy
    # The function is called before the session's user becomes nil.
    login_logout
    session[:user_id] = nil
    flash[:warning] = "You have logged out"
    redirect_to root_path
  end


  # A Function to print out login and logout

  def login_logout
    if !File.exists?("wander_logs/loginlogout.txt")
      loginlogout = File.new("wander_logs/loginlogout.txt", "w+")
      loginlogout.puts("Log of Wander application started at #{Time.now}")
      if params["action"] == "destroy"
        loginlogout.puts("#{current_user.email} logged out at: #{Time.now}")
      else
        loginlogout.puts("#{params[:session][:email]} logged in at: #{Time.now}")
      end
      loginlogout.close
    else
      loginlogout = File.new("wander_logs/loginlogout.txt", "a")
      if params["action"] == "destroy"
        loginlogout.puts("#{current_user.email} logged out at: #{Time.now}")
      else
        loginlogout.puts("#{params[:session][:email]} logged in at: #{Time.now}")
      end
      loginlogout.close
    end
  end

end

# flash.now has the half-life of only one HTTP request, as oppose to flash which persists.

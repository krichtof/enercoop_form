class UsersController < Clearance::UsersController
  def new
    @user = User.find_by(registration_token: session[:registration_token]) || User.new

    if @user.step_one_completed?
      render 'step_two'
    else
      @form = UserStepOneForm.from_model @user
      render 'step_one'
    end
  end

  def step_one
    @form = UserStepOneForm.from_params params
    SignupStepOne.call(@form) do
      redirect_to sign_up_path
    end
  end

  def create
    @user = user_from_params

    if @user.save
      sign_in @user

      redirect_back_or url_after_create
    else
      render :new
    end
  end

end

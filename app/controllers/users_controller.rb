class UsersController < Clearance::UsersController
  def new
    @user = User.find_by(registration_token: session[:registration_token]) || User.new

    if @user.step_one_completed?
      @form = UserStepTwoForm.from_model @user
      render 'step_two'
    else
      @form = UserStepOneForm.from_model @user
      render 'step_one'
    end
  end

  def step_one
    @form = UserStepOneForm.from_params params
    SignupStepOne.call(@form) do
      on(:ok) { redirect_to sign_up_path }
      on(:invalid) { render :step_one }
    end
  end

  def step_two
    @form = UserStepTwoForm.from_params params
    SignupStepTwo.call(@form) do
      on(:ok) { redirect_to signed_in_root_path }
      on(:invalid) { render :step_two }
      on(:failed_login) { redirect_to root_path }
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

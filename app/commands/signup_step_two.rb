class SignupStepTwo < Rectify::Command
  def initialize(form)
    @form = form
  end

  def call
    return broadcast(:invalid) if form.invalid?

    transaction do
      find_user!
      update_user_attributes!
      update_user_state!
    end

    session.delete(:registration_token)
    sign_in(@user) do |status|
      broadcast(:failed_login) unless status.success?
    end

    broadcast(:ok)
  end

  private

    attr_reader :form, :user

    def find_user!
      @user = User.find_by! registration_token: session[:registration_token]
    end

    def update_user_attributes!
      user.update!(
        situation: form.situation,
        pdl: form.pdl
      )
    end

    def update_user_state!
      if user.may_submit_step_two?
        user.submit_step_two!
      end
    end
end

class SignupStepOne < Rectify::Command
  def initialize(form)
    @form = form
  end

  def call
    return broadcast(:invalid) if form.invalid?
    transaction do
      find_or_create_user
      update_user_attributes!
      update_user_state!
      store_registration_token_in_session
    end

    broadcast(:ok)
  end

  private

    attr_reader :form, :user
    def find_or_create_user
      if session[:registration_token]
        @user = User.find_or_create_by registration_token: session[:registration_token]
      else
        @user = User.create
      end
    end

    def update_user_attributes!
      user.update!(
        first_name: form.first_name,
        last_name: form.last_name,
        street_number: form.street_number,
        street_name: form.street_name,
        zip_code: form.zip_code,
        city: form.city,
        email: form.email,
        password: form.password,
      )
    end

    def update_user_state!
      if user.may_submit_step_one?
        user.submit_step_one!
      end
    end

    def store_registration_token_in_session
      session[:registration_token] = user.registration_token
    end
end

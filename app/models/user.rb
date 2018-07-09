class User < ApplicationRecord
  include Clearance::User
  include AASM

  aasm do
    state :empty, initial: true
    state :step_one_completed

    event :submit_step_one do
      transitions from: :empty, to: :step_one_completed
    end
  end

  before_create :generate_registration_token

  def generate_registration_token
    self.registration_token = SecureRandom.uuid
  end
end

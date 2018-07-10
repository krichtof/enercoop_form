class User < ApplicationRecord
  include Clearance::User
  include AASM

  aasm do
    state :empty, initial: true
    state :step_one_completed, :step_two_completed

    event :submit_step_one do
      transitions from: :empty, to: :step_one_completed
    end

    event :submit_step_two do
      transitions from: :step_one_completed, to: :step_two_completed
    end
  end

  before_create :generate_registration_token

  def generate_registration_token
    self.registration_token = SecureRandom.uuid
  end

  enum situation: {
    move_in: 0,
    new_house: 1,
    temporary_access: 2
  }
end

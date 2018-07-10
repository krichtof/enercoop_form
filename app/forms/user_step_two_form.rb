class UserStepTwoForm < Rectify::Form
  mimic :user

  attribute :situation, Integer
  attribute :pdl, String
end

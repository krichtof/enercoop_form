class UserStepOneForm < Rectify::Form
  mimic :user

  attribute :first_name, String
  attribute :last_name, String
  attribute :street_number, String
  attribute :street_name, String
  attribute :zip_code, String
  attribute :city, String
  attribute :email, String
  attribute :password, String

end


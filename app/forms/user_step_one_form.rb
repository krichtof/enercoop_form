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

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates_presence_of :first_name, :last_name, :street_name, :zip_code, :city, :email, :password
end

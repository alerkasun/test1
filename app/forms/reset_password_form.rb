class ResetPasswordForm < FormBase
  attribute :password, String

  validates :password, presence: true, confirmation: true
end

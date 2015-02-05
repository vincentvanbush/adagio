class CreateAdminService
  require 'iso/iban'

  def call
    user = User.find_or_create_by!(email: Rails.application.secrets.admin_email) do |user|
        user.password = Rails.application.secrets.admin_password
        user.password_confirmation = Rails.application.secrets.admin_password
        user.account_number = ISO::IBAN.generate('PL', '', '').compact
        user.admin = true
      end
  end
end

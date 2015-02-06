class CreateAdminService
  require 'iso/iban'

  def call
    user = User.find_or_create_by!(email: Rails.application.secrets.admin_email) do |user|
        user.password = Rails.application.secrets.admin_password
        user.password_confirmation = Rails.application.secrets.admin_password
        user.name = "Buszek Suszek"
        user.account_number = ISO::IBAN.generate('PL', '', '').compact
        user.city = Faker::Address.city
        user.street = Faker::Address.street_name
        user.house_number = Faker::Address.building_number
        user.postal_code = "12-345"
        user.admin = true
      end
  end
end

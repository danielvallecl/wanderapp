class User < ApplicationRecord
  # Asssociations

  # dependent: :destroy ensures that if you delete the user the associated events are also deleted
  has_many :events, dependent: :destroy
  has_many :actives, dependent: :destroy
  has_many :preferences, dependent: :destroy

  # Validations

  before_save { self.email = email.downcase }
  validates :firstname, presence: true, length: {minimum: 2, maximum: 20}
  validates :lastname, presence: true, length: {minimum: 2, maximum: 20}
  validates :username, presence: true,
            uniqueness: { case_sensitive: false},
            length: {minimum: 3, maximum: 12}

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :email, presence: true, length: {maximum: 105},
            uniqueness: {case_sentitive: false},
            format: {with: VALID_EMAIL_REGEX}

# Geolocation

obj = @user
geocoded_by :ipaddress, latitude: :latitude, longitude: :longitude do |obj, results|
  if geo = results.first
    obj.latitude = geo.latitude
    obj.longitude = geo.longitude
    obj.city = geo.city
    obj.state = geo.state
    obj.statecode =geo.state_code
    obj.country = geo.country
  end
end

after_validation :geocode

# geocoded_by :ipaddress, latitude: :latitude, longitude: :longitude, country: :country, city: :city
# after_validation :geocode, if: ->(obj){ obj.ipaddress.present? and obj.ipaddress_changed? }

# bcrypt passwords
has_secure_password
end

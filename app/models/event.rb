class Event < ApplicationRecord

  #========== ASSOCIATIONS ==========#
  belongs_to :user
  has_many :actives, dependent: :destroy

  #========== VALIDATIONS ===========#

  validates :title, presence: true, length: {minimum: 3, maximum: 30}
  validates :description, presence: true, length: {minimum: 3, maximum: 500}
  validates :category, presence: true, length: {minimum: 3, maximum: 30}
  validates :duration, presence: true
  validates_length_of :duration, in: 1..72
  validates :user_id, presence: true
  validates :startdate, presence: true
  validate :check_time



  #========== CUSTOM METHODS ============#

  # Checks if the event was created in the past

def check_time
  if startdate.nil?
    errors[:base] << "Please fill in Event date."
    return false
  elsif startdate.past?
    errors[:base] << "An Event cannot be in the past"
    return false
  else
    if startdate == startdate.today?
      if starttime.time.hour > Time.now.hour
        errors[:base] << "An Event has to be created at least 6 hours in advance"
        return false
      end
    end
  end
  return true
end

  # Geocoding

  # Loops through the resulsts of the geocode query and adds them to the database

  obj = @event
  geocoded_by :address, latitude: :latitude, longitude: :longitude do |obj, results|
    if geo = results.first
      obj.latitude = geo.latitude
      obj.longitude = geo.longitude
      obj.city = geo.city
      obj.state = geo.state
      obj.statecode = geo.state_code
      obj.country = geo.country
      obj.formattedaddress = geo.formatted_address
    end
  end

  after_validation :geocode #, if: ->(obj){ obj.address.present? and obj.address_changed? }

end

json.extract! event, :id, :title, :description, :category, :startdate, :starttime, :duration, :owner, :city, :country, :address, :obs, :active, :aux1, :aux2, :aux3, :created_at, :updated_at
json.url event_url(event, format: :json)

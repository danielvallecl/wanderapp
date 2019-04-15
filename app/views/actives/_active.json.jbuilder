json.extract! active, :id, :user_id, :event_id, :status, :obs, :created_at, :updated_at
json.url active_url(active, format: :json)

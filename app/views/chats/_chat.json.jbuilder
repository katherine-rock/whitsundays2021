json.extract! chat, :id, :comment, :created_at, :updated_at
json.url chat_url(chat, format: :json)
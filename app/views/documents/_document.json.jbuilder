json.extract! document, :id, :title, :description, :category, :document, :created_at, :updated_at, :user_id
json.url document_url(document, format: :json)

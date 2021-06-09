json.extract! contact, :id, :contact, :firstname, :lastname, :category, :email, :phone, :company, :comment, :user_id, :created_at, :updated_at
json.url contact_url(contact, format: :json)
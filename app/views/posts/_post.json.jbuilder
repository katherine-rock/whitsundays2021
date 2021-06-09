json.extract! post, :id, :title, :comment, :post, :created_at, :updated_at, :user_id
json.url post_url(post, format: :json)

json.extract! usuario, :id, :nome, :permissao, :email, :password, :created_at, :updated_at
json.url admin_usuario_url(usuario, format: :json)

class CreateAdmin < SeedMigration::Migration
  def up
    Usuario.create({nome: "Administrador", email: "ti@prefeiturademossoro.com.br", permissao: "admin", password: "G3t1c@2023"})
  end

  def down

  end
end

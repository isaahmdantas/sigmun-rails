# Guia de configuração do Rails

O primeiro passo é instalar as dependências para compilar o Ruby. Abra seu Terminal e execute os seguintes comandos para instalá-los: 

```
sudo apt-get update
```

```
sudo apt-get install git-core zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev software-properties-common libffi-dev
```

Em seguida, instalaremos o Ruby usando um gerenciador de versão chamado [rvm](https://rvm.io/):

```
gpg2 --keyserver keyserver.ubuntu.com --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
```

```
\curl -sSL https://get.rvm.io | bash

```

Para instalar o Ruby e definir a versão padrão, executaremos os seguintes comandos:

```
rvm install 3.2.2
```

```
rvm use 3.2.2 --default
```

Confirme se a versão padrão do Ruby corresponde à versão que você acabou de instalar: 

```
ruby -v
```

Em seguida, podemos instalar o rails:

```
gem install rails -v 7.0.4.2 --no-document
```

## Configurando o NodeJs 
```
curl -sL https://deb.nodesource.com/setup_16.x -o /tmp/nodesource_setup.sh
```

```
sudo bash /tmp/nodesource_setup.sh
```

```
sudo apt install nodejs
```

Verificar se deu certo a instalação: 
```
node -v
```

## Configurando o Yarn 

```
npm install --global yarn
```

Checar a instalação: 

```
yarn --version
```

## Configurando o Git

```
git config --global color.ui true
git config --global user.name "YOUR NAME"
git config --global user.email "YOUR@EMAIL.com"
ssh-keygen -t ed25519 -C "YOUR@EMAIL.com"
```

A próxima etapa é pegar a chave SSH recém-gerada e adicioná-la à sua conta do Github. Você deseja copiar e colar a saída do seguinte comando e coloar no Github .

```
cat ~/.ssh/id_ed25519.pub
```

Depois de fazer isso, você pode verificar e ver se funcionou:

```
ssh -T git@github.com
```

Você deve receber uma mensagem como esta:

```
Hi excid3! You've successfully authenticated, but GitHub does not provide shell access.
```

### Configurando um banco de dados

Para o PostgreSQL, vamos adicionar um novo repositório para instalar facilmente uma versão recente do Postgres.

```
sudo apt install postgresql libpq-dev
```

### Utilizar o postgresql sem senha: 

- Configurar o Postgresql:
```
sudo nano /etc/postgresql/:version/main/pg_hba.conf
```
- Alterar a linha a baixo de peer para trust: 
```
local all postgres peer
```
-  Reiniciar o serviço: 
```
service postgresql restart
```
- Testar acesso ao banco de dados:
```
psql -U postgres
```

# Iniciando um projeto Rails

Para criar um projeto Rails, basta usar o `rails new` comando, assim:

```
rails new sigmun -d postgresql
```

Ou considere usar o template criado para os futuros projetos da PMM: 

```bash
rails new sigmun -d postgresql -m https://raw.githubusercontent.com/isaahmdantas/rails-swift/main/template.rb
```

ou 

```bash
rails new sigmun -d postgresql -m ~/rails-swift/main/template.rb
```

Rodar a aplicação: 

```bash
bin/dev 
```
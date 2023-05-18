# isaahmdantas/rails-swift


## Descrição

Template para criar projetos em Ruby on Rails para os futuros projetos da Prefeitura Municipal de Mossoró utilizando o template [sigmun-hero](https://github.com/heronildesjr/sigmun-hero) que foi desenvolvido para o sistema de gestão de municípios SIGMun.

## Requisitos 

Este template atualmente funciona com: 

* Rails 7.0.x
* Bundler 2.x 
* PostgreSQL
* Node 16 ou superior 
* Yarn 1.x 

Se precisar de ajuda para configurar um ambiente de desenvolvimento Ruby on Rails, confira meu [Guia de Instalação](https://github.com/isaahmdantas/rails-swift/INSTALAR_RAILS.md)

## Instalação

- Executar o template apartir da máquina local: 
```
    git clone https://github.com/isaahmdantas/rails-swift.git 
```


*Opcional.*

- Para tornar este o modelo de aplicativo Rails padrão em seu sistema, crie um arquivo `~/.railsrc` com este conteúdo:

```
    -d postgresql
    -m https://raw.githubusercontent.com/isaahmdantas/rails-swift/main/template.rb
```
ou 

```
    -d postgresql
    -m ~/rails-swift/main/template.rb
```


## Utilização

Para gerar uma aplicação Rails usando este template, passe a opção `-m` para `rails new`, assim: 

```bash
    rails new sigmun -d postgresql -m https://raw.githubusercontent.com/isaahmdantas/rails-swift/main/template.rb
```

Gerar aplicação rails utilizando o template apartir da sua máquina: 

```bash
    rails new sigmun -d postgresql -m ~/rails-swift/main/template.rb
```


*Lembre-se que as opções devem vir após o nome do aplicativo.* 
O único banco de dados suportado por este template é o `postgresql`.


Se você instalou este template como padrão (usando `~/.railsrc` conforme descrito acima), tudo o que você precisa fazer é executar:

```bash
    rails new sigmun
```

## O que isso faz?

O template executará as seguintes etapas:

1. Gera os arquivos e diretórios da aplicação com base nos estilos e componentes do 'sigmun-hero'
2. Cria os banco de dados de desenvolvimento e teste 

#### Essas gems são adicionadas à pilha padrão do Rails

* Essencial: 
    * [sidekiq](https://github.com/sidekiq/sidekiq) - Implementação de fila de tarefas baseada em Redis para o ActiveJob.

* Configuração:
    * [figaro](https://github.com/laserlemon/figaro) - Configurar váriaveis de ambiente 

* Estilo:
    * [bootstrap](https://getbootstrap.com/) - Kit de ferramentas de front-end poderoso, extensível e repleto de recursos;
    * [bootstrap-icons](https://icons.getbootstrap.com/) - Biblioteca de ícones de código aberto e de alta qualidade com mais de 1.800 ícones.

* Utilidades:
    * [acts_as_paranoid](https://github.com/ActsAsParanoid/acts_as_paranoid) - Esta gema pode ser usada para ocultar registros ao invés de excluí-los, tornando-os recuperáveis ​​posteriormente.
    * [audited](https://github.com/collectiveidea/audited) - é uma extensão ORM que registra todas as alterações em seus modelos.
    * [exception_notification](https://github.com/smartinez87/exception_notification) - Enviar notificações quando ocorrem erros em uma aplicação Rack/Rails.
    * [whenever](https://github.com/javan/whenever) - É uma gem Ruby que fornece uma sintaxe clara para escrever e implantar tarefas cron.
    * [cocoon](https://github.com/nathanvda/cocoon) - O Cocoon facilita o manuseio de formulários aninhados.
    * [kaminari](https://github.com/kaminari/kaminari) - Um paginador baseado em Scope & Engine, limpo, poderoso, personalizável e sofisticado para estruturas modernas de aplicativos da Web e ORMs.
    * [array_enum](https://github.com/freeletics/array_enum) - A extensão para ActiveRecordisso adiciona suporte para PostgreSQLcolunas de matriz, mapeando valores de string para inteiros.
    * [auto_increment](https://github.com/felipediesel/auto_increment) - auto_increment fornece incrementação automática para campos inteiros ou strings no Rails.
    * [wicked_pdf](https://github.com/mileszs/wicked_pdf) - Wicked PDF usa o utilitário shell wkhtmltopdf para servir um arquivo PDF para um usuário de HTML.
    * [protokoll](https://github.com/celsodantas/protokoll) - Protokoll é um plug-in Rails simples para simplificar o gerenciamento de um valor de autoincremento personalizado para um modelo.
    * [seed_migration](https://github.com/pboling/seed_migration) - Uma biblioteca de migração de dados, semelhante à migração de esquema integrada do Rails.

* Segurança: 
    * [brakeman](https://github.com/presidentbeef/brakeman) - Brakeman é uma ferramenta de análise estática que verifica os aplicativos Ruby on Rails em busca de vulnerabilidades de segurança.
    * [rack-attack](https://github.com/rack/rack-attack) - Rack::Attack permite que você decida facilmente quando permitir , bloquear e acelerar com base nas propriedades da solicitação.

* Teste: 
    * [rspec-rails](https://github.com/rspec/rspec-rails) - é uma biblioteca (gem) que facilita a prática de testes em aplicações Ruby ou Rails
    * [shoulda](https://github.com/thoughtbot/shoulda) - Shoulda ajuda você a escrever testes específicos do Rails mais compreensíveis e sustentáveis ​​sob Minitest e Test::Unit.
    * [factory_bot_rails](https://github.com/thoughtbot/factory_bot_rails)
    * [faker](https://github.com/faker-ruby/faker) - É uma biblioteca para gerar dados falsos, como nomes, endereços e números de telefone.


## Créditos 

* Este projeto foi desenvolvido com base no template do [mattbrictson/rails-template](https://github.com/mattbrictson/rails-template). Agradeço aos criadores do template por fornecerem uma estrutura sólida e inspiração para este template.
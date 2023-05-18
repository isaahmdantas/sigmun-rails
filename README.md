# isaahmdantas/rails-swift


## Descrição

Template para criar projetos em Ruby on Rails para os futuros projetos da Prefeitura Municipal de Mossoró utilizando o template ['sigmun-hero'](https://github.com/heronildesjr/sigmun-hero) que foi desenvolvido para o sistema de gestão de municípios SIGMun.

## Requisitos 

Este template atualmente funciona com: 

* Rails 7.0.x
* Bundler 2.x 
* PostgreSQL
* Node 16 ou superior 
* Yarn 1.x 

Se precisar de ajuda para configurar um ambiente de desenvolvimento Ruby on Rails, configura meu [Guia de Instalação] (https://github.com/isaahmdantas/rails-swift/INSTALAR_RAILS.md)

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
    rails new sigmun \
    -d postgresql \
    -m https://raw.githubusercontent.com/isaahmdantas/rails-swift/main/template.rb
```

### Gerar aplicação rails utilizando o template apartir da sua máquina: 

```bash
    rails new sigmun \
    -d postgresql \
    -m ~/rails-swift/main/template.rb
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
2. Cria os bancodes de dados de desenvolvimento e teste 

#### Essas gems são adicionadas à pilha padrão do Rails

* Essencial: 

* Configuração:

* Estilo:

* Utilidades:

* Segurança: 

* Teste: 
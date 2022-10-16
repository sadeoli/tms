TRANSPORTATION MANAGEMENT SYSTEM

A presente aplicação refere-se ao projeto de desenvolvimento individual para a fase 1 do TreinaDev, pela Campus Code. Status: em desenvolvimento.

_O Projeto
O projeto simula um sistema de frete para e-commerce (em inglês, transportation management system). É de uso comum em transportadoras que realizam a retirada e a entrega de pedidos (cargas) através das mais diversas modalidades de transporte e seus veículos.

__Instalação
1. Utilize o 'bin/setup' para configurar a aplicação.
2. Rode 'rails db:seeds' para popular a aplicação.
3. Visite a página 'http://localhost:3000/' no seu navegador.

__Gems
As gems presentes do projeto são:
1. Gem "rspec-rails" - Realização de testes
2. Gem "capybara" - Realização de testes
3. Gem "devise" - Auxílio na gestão de usuários e autenticação


___Usuários
Caso não tenha utilizado o db:seeds, será necessário cadastrar os usuários atráves do console. A aplicação se apresenta diferentemente para usuários tipo 'Regular' e para os de tipo 'Administrador'.

Sugestão de criação - Utilizar esses mesmos e-mails e senhas para acesso: 
#User.create!(name: 'Usuário Regular 1', email: 'regular1@sistemadefrete.com.br', password: 'password', access_group: :regular)
#User.create!(name: 'Usuário Admin 1', email: 'admin1@sistemadefrete.com.br', password: 'password', access_group: :admin)

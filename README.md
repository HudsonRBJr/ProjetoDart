# Projeto Avaliativo 2º Bimestre — Controle de Consumo de Água

## Identificação do projeto

**Nome da temática do aplicativo:** Controle de Consumo de Água

**Integrante 1:** Hudson Ribeiro Barbara Junior — [@HudsonRBJr](https://github.com/HudsonRBJr)
**Integrante 2:** Gustavo Schizari — [@schizary](https://github.com/schizary)
**Integrante 3:** Eduardo Gibertone — [@EduardoGibertoni](https://github.com/EduardoGibertoni)

---

## Sobre o projeto

Este projeto é uma continuação do aplicativo Flutter desenvolvido no 1º bimestre, mantendo a temática de **controle de consumo de água**.

Nesta etapa, o aplicativo foi evoluído para trabalhar com persistência de dados local e remota. O app permite cadastrar, listar, editar e excluir registros de consumo de água, contendo informações como atividade realizada, quantidade de litros utilizados e horário do consumo.

O projeto utiliza:

* **SQLite** para persistência local no aplicativo Flutter;
* **API própria em Node.js com Express**, publicada no Render;
* **PostgreSQL no Render** para persistência remota;
* **Camada service** para comunicação com a API;
* **Camada repository** para organizar a escolha entre persistência local e remota.

---

## Tecnologias utilizadas

### Aplicativo mobile

* Dart
* Flutter
* SQLite
* HTTP

### API

* Node.js
* Express
* PostgreSQL
* Render

---

## Estrutura completa do projeto

```text
ProjetoDart/
├── android/
├── api/
│   ├── src/
│   │   ├── database.js
│   │   └── server.js
│   ├── .env.example
│   ├── .gitignore
│   ├── package.json
│   └── README.md
├── docs/
├── ios/
├── lib/
│   ├── components/
│   ├── db/
│   ├── models/
│   ├── repository/
│   ├── screens/
│   ├── services/
│   └── main.dart
├── linux/
├── macos/
├── test/
├── web/
│   ├── icons/
│   ├── favicon.png
│   ├── index.html
│   └── manifest.json
├── windows/
├── .gitignore
├── .metadata
├── analysis_options.yaml
├── pubspec.lock
├── pubspec.yaml
├── read.me
├── README.md
└── render.yaml
```

### Descrição das principais pastas

* `android`: arquivos de configuração para execução do app em dispositivos Android.
* `ios`: arquivos de configuração para execução do app em dispositivos iOS.
* `lib`: pasta principal do aplicativo Flutter.
* `components`: componentes reutilizáveis da interface.
* `db`: configuração e operações relacionadas ao SQLite.
* `models`: modelos de dados utilizados no aplicativo.
* `repository`: camada responsável por organizar a escolha entre persistência local e remota.
* `screens`: telas do aplicativo.
* `services`: camada responsável pela comunicação com a API remota.
* `api`: API própria desenvolvida em Node.js com Express.
* `api/src/database.js`: configuração de conexão com o PostgreSQL.
* `api/src/server.js`: arquivo principal da API, contendo as rotas.
* `docs`: pasta para documentação do projeto.
* `web`, `windows`, `linux` e `macos`: arquivos gerados pelo Flutter para suporte a outras plataformas.
* `read.me`: arquivo de identificação solicitado no enunciado.
* `README.md`: documentação principal do projeto.
* `render.yaml`: arquivo de configuração relacionado ao deploy no Render.

---

## Funcionalidades do aplicativo

O aplicativo possui:

* Tela inicial/dashboard;
* Tela de listagem de registros;
* Formulário de cadastro;
* Cadastro de consumo de água;
* Listagem dos registros cadastrados;
* Edição de registros;
* Exclusão de registros;
* Atualização visual da lista após cadastro, edição ou exclusão;
* Mensagens de erro ou sucesso quando necessário;
* Alternância entre persistência local e remota.

---

## Persistência local com SQLite

O aplicativo utiliza SQLite para armazenar os registros localmente no dispositivo.

Dessa forma, os dados cadastrados no modo local continuam disponíveis mesmo após fechar e abrir o aplicativo novamente.

---

## API publicada no Render

A API foi desenvolvida utilizando **Node.js** e **Express**, publicada no **Render** e conectada a um banco **PostgreSQL** também hospedado no Render.

**Link da API publicada:**

```text
https://controle-agua-api.onrender.com
```

---

## Rotas da API

### Verificar status da API

```http
GET /health
```

Exemplo:

```text
https://controle-agua-api.onrender.com/health
```

---

### Listar registros

```http
GET /consumos
```

Exemplo:

```text
https://controle-agua-api.onrender.com/consumos
```

---

### Cadastrar registro

```http
POST /consumos
```

Exemplo de corpo da requisição:

```json
{
  "atividade": "Banho",
  "litros": 50,
  "horario": "19:30"
}
```

---

### Atualizar registro

```http
PUT /consumos/:id
```

Exemplo:

```text
https://controle-agua-api.onrender.com/consumos/1
```

Exemplo de corpo da requisição:

```json
{
  "atividade": "Banho atualizado",
  "litros": 60,
  "horario": "20:00"
}
```

---

### Deletar registro

```http
DELETE /consumos/:id
```

Exemplo:

```text
https://controle-agua-api.onrender.com/consumos/1
```

---

## Integração do Flutter com a API

O aplicativo possui uma camada de serviço responsável pela comunicação com a API remota.

A URL da API pode ser informada na execução do aplicativo com o comando:

```bash
flutter run --dart-define=API_URL=https://controle-agua-api.onrender.com
```

O app permite utilizar os dados de duas formas:

* **Local:** utilizando SQLite;
* **Remoto:** utilizando a API publicada no Render com PostgreSQL.

A tela principal não acessa diretamente o SQLite ou a API. A comunicação é organizada por meio da camada `repository`.

---

## Como executar o projeto Flutter

Instale as dependências:

```bash
flutter pub get
```

Execute o aplicativo usando a API publicada no Render:

```bash
flutter run --dart-define=API_URL=https://controle-agua-api.onrender.com
```

---

## Como executar a API localmente

Entre na pasta da API:

```bash
cd api
```

Instale as dependências:

```bash
npm install
```

Crie um arquivo `.env` com a variável de conexão do PostgreSQL:

```env
DATABASE_URL=sua_url_do_postgresql
PORT=3000
```

Execute a API:

```bash
npm start
```

---

## Entrega

O projeto Flutter e a API estão no mesmo repositório.

A API está localizada na pasta:

```text
/api
```

**Link da API publicada no Render:**

```text
https://controle-agua-api.onrender.com
```

O vídeo demonstrativo apresenta o funcionamento do aplicativo mobile, mostrando:

* abertura do aplicativo;
* listagem dos registros;
* cadastro de um novo registro;
* atualização visual da lista;
* edição ou exclusão de registro;
* funcionamento com persistência local e remota.

# Controle de Consumo de Água

## Identificação do projeto

```text
Nome da temática do aplicativo: Controle de Consumo de Água
Integrante 1: Hudson Ribeiro Barbara Junior
Integrante 2 (se houver):
Integrante 3 (se houver):
```

Caso o repositório fique privado, adicione o professor:

```text
@adrianoprof
```

---

## Descrição

Este projeto é a continuação do aplicativo Flutter do 1º bimestre. A temática mantida é **Controle de Consumo de Água**.

O aplicativo permite cadastrar, listar, editar e excluir registros de consumo de água, informando:

- atividade;
- quantidade de litros;
- horário.

Nesta versão do 2º bimestre, o projeto foi organizado para trabalhar com:

- persistência local com SQLite;
- API própria em Node.js/Express;
- PostgreSQL no Render;
- camada `services` para comunicação com a API;
- camada `repository` para escolher entre persistência local e remota.

---

## Estrutura principal do Flutter

```text
lib/
├── components/
│   └── editor.dart
├── db/
│   └── app_database.dart
├── models/
│   └── consumo_agua.dart
├── repository/
│   └── consumo_agua_repository.dart
├── screens/
│   ├── dashboard.dart
│   └── consumo_agua/
│       ├── formulario.dart
│       └── lista.dart
├── services/
│   └── consumo_agua_service.dart
└── main.dart
```

A tela principal não acessa SQLite nem API diretamente. Ela utiliza a camada `repository`, que decide se os dados serão gravados localmente ou remotamente.

---

## Estrutura da API

```text
api/
├── src/
│   ├── database.js
│   └── server.js
├── .env.example
├── .gitignore
├── package.json
└── README.md
```

A API utiliza:

- Node.js;
- Express;
- PostgreSQL;
- pacote `pg`;
- variável de ambiente `DATABASE_URL`.

---

## Rotas da API

URL base local:

```text
http://localhost:3000
```

Depois de publicar no Render, a URL será parecida com:

```text
https://sua-api.onrender.com
```

| Método | Rota | Função | Parâmetros/Corpo |
| --- | --- | --- | --- |
| GET | `/health` | Verificar funcionamento da API | nenhum |
| GET | `/consumos` | Listar registros | nenhum |
| POST | `/consumos` | Cadastrar registro | `{ "atividade": "Banho", "litros": 50, "horario": "19:30" }` |
| PUT | `/consumos/:id` | Atualizar registro | parâmetro `id` e corpo com `atividade`, `litros`, `horario` |
| DELETE | `/consumos/:id` | Deletar registro | parâmetro `id` |

---

## Como rodar o Flutter

Na pasta raiz do projeto Flutter:

```bash
flutter pub get
flutter run
```

Por padrão, o app usa a URL placeholder:

```text
https://sua-api-controle-agua.onrender.com
```

Após publicar a API no Render, rode o app informando a URL real:

```bash
flutter run --dart-define=API_URL=https://sua-api.onrender.com
```

Também é possível alterar a URL diretamente no arquivo:

```text
lib/services/consumo_agua_service.dart
```

---

## Como rodar a API localmente

Entre na pasta da API:

```bash
cd api
npm install
cp .env.example .env
npm run dev
```

No arquivo `.env`, configure a variável:

```text
DATABASE_URL=postgresql://usuario:senha@host:5432/banco
```

---

## Como publicar a API no Render

O arquivo `render.yaml` foi incluído para facilitar o deploy como Blueprint, mas você também pode fazer manualmente.

1. Crie um banco PostgreSQL no Render.
2. Copie a URL interna do banco.
3. Crie um Web Service no Render apontando para este repositório.
4. Configure a pasta da API como serviço Node.js.
5. Use:

```text
Build Command: npm install
Start Command: npm start
```

6. Adicione as variáveis de ambiente:

```text
DATABASE_URL=URL_DO_POSTGRESQL_DO_RENDER
NODE_ENV=production
```

7. Depois que a API publicar, copie a URL pública e use no Flutter com `--dart-define=API_URL=...`.

---

## Funcionalidades implementadas

- Tela inicial/dashboard.
- Tela de listagem.
- Tela de formulário.
- Navegação com `Navigator.push()` e `Navigator.pop()`.
- Cadastro de consumo.
- Edição de consumo.
- Exclusão de consumo.
- Atualização visual da lista após cadastro, edição ou exclusão.
- Mensagens de erro e sucesso com `SnackBar`.
- Persistência local com SQLite.
- Integração remota via API.
- Repository para escolher entre SQLite local e API remota.

---

## O que demonstrar no vídeo

O vídeo deve mostrar apenas o funcionamento do aplicativo mobile:

1. abrir o aplicativo;
2. mostrar o dashboard;
3. abrir a listagem com SQLite local;
4. cadastrar um novo consumo;
5. mostrar a atualização da lista;
6. editar ou excluir um consumo;
7. abrir a opção remota após publicar a API no Render;
8. mostrar o funcionamento geral relacionado ao controle de consumo de água.

---

## Observação importante

A API já está pronta no código, mas a publicação no Render precisa ser feita manualmente na conta do grupo, porque exige acesso ao GitHub/Render e criação do banco PostgreSQL.

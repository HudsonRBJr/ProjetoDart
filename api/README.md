# API - Controle de Consumo de Água

API própria feita com Node.js, Express e PostgreSQL para atender ao Projeto Avaliativo do 2º Bimestre.

## Como rodar localmente

```bash
cd api
npm install
cp .env.example .env
npm run dev
```

No arquivo `.env`, coloque a `DATABASE_URL` do PostgreSQL.

## Como publicar no Render

1. Suba este projeto no GitHub.
2. No Render, crie um banco PostgreSQL.
3. Crie um Web Service para a pasta `api`.
4. Configure:
   - Build Command: `npm install`
   - Start Command: `npm start`
   - Environment Variable: `DATABASE_URL` com a Internal Database URL do PostgreSQL do Render.
   - Environment Variable: `NODE_ENV=production`
5. Depois de publicar, copie a URL gerada pelo Render e use no Flutter com:

```bash
flutter run --dart-define=API_URL=https://sua-api.onrender.com
```

## Rotas

| Método | Rota | Função | Corpo/Parâmetro |
| --- | --- | --- | --- |
| GET | `/health` | Verificar se API está online | nenhum |
| GET | `/consumos` | Listar registros | nenhum |
| POST | `/consumos` | Cadastrar registro | `{ "atividade": "Banho", "litros": 50, "horario": "19:30" }` |
| PUT | `/consumos/:id` | Atualizar registro | parâmetro `id`; corpo com `atividade`, `litros`, `horario` |
| DELETE | `/consumos/:id` | Excluir registro | parâmetro `id` |

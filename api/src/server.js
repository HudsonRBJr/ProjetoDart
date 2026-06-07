import express from 'express';
import cors from 'cors';

import { criarTabelaConsumos, pool } from './database.js';

const app = express();
const port = process.env.PORT || 3000;

app.use(cors());
app.use(express.json());

app.get('/', (req, res) => {
  res.json({
    mensagem: 'API do Controle de Consumo de Água funcionando.',
    rotas: ['/health', '/consumos'],
  });
});

app.get('/health', (req, res) => {
  res.json({ status: 'ok' });
});

app.get('/consumos', async (req, res) => {
  try {
    const resultado = await pool.query(
      'SELECT id, atividade, litros::float AS litros, horario FROM consumos ORDER BY id DESC'
    );
    res.json(resultado.rows);
  } catch (erro) {
    console.error(erro);
    res.status(500).json({ erro: 'Erro ao listar consumos.' });
  }
});

app.post('/consumos', async (req, res) => {
  const { atividade, litros, horario } = req.body;

  if (!atividade || !litros || !horario || Number(litros) <= 0) {
    return res.status(400).json({
      erro: 'Informe atividade, litros maior que zero e horário.',
    });
  }

  try {
    const resultado = await pool.query(
      `INSERT INTO consumos (atividade, litros, horario)
       VALUES ($1, $2, $3)
       RETURNING id, atividade, litros::float AS litros, horario`,
      [atividade, litros, horario]
    );

    return res.status(201).json(resultado.rows[0]);
  } catch (erro) {
    console.error(erro);
    return res.status(500).json({ erro: 'Erro ao cadastrar consumo.' });
  }
});

app.put('/consumos/:id', async (req, res) => {
  const { id } = req.params;
  const { atividade, litros, horario } = req.body;

  if (!atividade || !litros || !horario || Number(litros) <= 0) {
    return res.status(400).json({
      erro: 'Informe atividade, litros maior que zero e horário.',
    });
  }

  try {
    const resultado = await pool.query(
      `UPDATE consumos
       SET atividade = $1, litros = $2, horario = $3
       WHERE id = $4
       RETURNING id, atividade, litros::float AS litros, horario`,
      [atividade, litros, horario, id]
    );

    if (resultado.rowCount === 0) {
      return res.status(404).json({ erro: 'Consumo não encontrado.' });
    }

    return res.json(resultado.rows[0]);
  } catch (erro) {
    console.error(erro);
    return res.status(500).json({ erro: 'Erro ao atualizar consumo.' });
  }
});

app.delete('/consumos/:id', async (req, res) => {
  const { id } = req.params;

  try {
    const resultado = await pool.query('DELETE FROM consumos WHERE id = $1', [id]);

    if (resultado.rowCount === 0) {
      return res.status(404).json({ erro: 'Consumo não encontrado.' });
    }

    return res.status(204).send();
  } catch (erro) {
    console.error(erro);
    return res.status(500).json({ erro: 'Erro ao deletar consumo.' });
  }
});

criarTabelaConsumos()
  .then(() => {
    app.listen(port, () => {
      console.log(`API rodando na porta ${port}`);
    });
  })
  .catch((erro) => {
    console.error('Erro ao iniciar a API:', erro);
    process.exit(1);
  });

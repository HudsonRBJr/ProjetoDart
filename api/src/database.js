import 'dotenv/config';
import pg from 'pg';

const { Pool } = pg;

const connectionString = process.env.DATABASE_URL;

if (!connectionString) {
  console.warn('Aviso: DATABASE_URL não foi definido. Configure essa variável no Render ou no arquivo .env local.');
}

export const pool = new Pool({
  connectionString,
  ssl: process.env.NODE_ENV === 'production'
    ? { rejectUnauthorized: false }
    : false,
});

export async function criarTabelaConsumos() {
  await pool.query(`
    CREATE TABLE IF NOT EXISTS consumos (
      id SERIAL PRIMARY KEY,
      atividade VARCHAR(120) NOT NULL,
      litros NUMERIC(10,2) NOT NULL,
      horario VARCHAR(20) NOT NULL,
      criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    );
  `);
}

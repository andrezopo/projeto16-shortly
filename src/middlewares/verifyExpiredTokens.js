import connection from "../dbStrategy/postgres.js";

async function verifyExpiredTokens() {
  const now = Date.now();
  const expired = now - 20000 * 60;

  await connection.query(
    `
  DELETE FROM sessions WHERE "updatedAt" < $1
  `,
    [expired]
  );
}

export default verifyExpiredTokens;

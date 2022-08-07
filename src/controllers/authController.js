import connection from "../dbStrategy/postgres.js";
import jwt from "jsonwebtoken";

export async function signUp(req, res) {
  try {
    const user = req.body;

    const { rows: alreadyUsed } = await connection.query(
      `
    SELECT email FROM users WHERE email = $1;
    `,
      [user.email]
    );

    if (alreadyUsed.length !== 0) {
      res.status(409).send("Revise os dados de preenchimento!");
      return;
    }
    const encryptedPassword = jwt.sign({ password: user.password }, "receba");

    await connection.query(
      `
    INSERT INTO users (name, email, password) VALUES ($1, $2, $3)
    `,
      [user.name, user.email, encryptedPassword]
    );
    res.sendStatus(201);
  } catch (err) {
    res.status(500).send("Erro interno!");
  }
}

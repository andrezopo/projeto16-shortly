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

export async function signIn(req, res) {
  try {
    const { email, password } = req.body;
    const { rows: user } = await connection.query(
      `
    SELECT * FROM users WHERE email = $1
    `,
      [email]
    );
    if (user.length === 0) {
      res.status(401).send("E-mail e/ou senha inválidos!");
      return;
    }
    const { password: decryptedPassword } = jwt.verify(
      user[0].password,
      "receba"
    );
    if (password !== decryptedPassword) {
      res.status(401).send("E-mail e/ou senha inválidos!");
      return;
    }
    const token = jwt.sign({ email: user[0].email }, "Reconhecimento Facial");
    await connection.query(
      `
    INSERT INTO sessions ("userId", token) VALUES ($1, $2)
    `,
      [user[0].id, token]
    );
    res.status(200).send(token);
  } catch (err) {
    res.status(500).send("Erro interno!");
  }
}

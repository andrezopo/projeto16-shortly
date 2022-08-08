import connection from "../dbStrategy/postgres.js";
import jwt from "jsonwebtoken";

async function validateToken(request, response, next) {
  const { authorization } = request.headers;
  const token = authorization?.replace("Bearer ", "");

  const { email } = jwt.verify(token, "Reconhecimento Facial");

  const { rows: user } = await connection.query(
    `
  SELECT u.* FROM sessions s JOIN users u ON s."userId" = u.id WHERE token = $1
  `,
    [token]
  );

  if (user.length === 0 || user[0]?.email !== email) {
    response.status(401).send();
    return;
  }

  response.locals.user = user[0];
  response.locals.token = token;

  next();
}

export default validateToken;

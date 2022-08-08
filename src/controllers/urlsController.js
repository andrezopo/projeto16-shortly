import { nanoid } from "nanoid";
import connection from "../dbStrategy/postgres.js";

export async function shortenUrl(req, res) {
  try {
    const { url } = req.body;
    const { user } = res.locals;
    const shortUrl = nanoid(8);

    await connection.query(
      `
    INSERT INTO "shortenedUrls" ("userId", "shortUrl", url) VALUES ($1, $2, $3)
    `,
      [user.id, shortUrl, url]
    );

    res.status(201).send({ shortUrl });
  } catch (err) {
    res.status(500).send("Erro interno!");
  }
}

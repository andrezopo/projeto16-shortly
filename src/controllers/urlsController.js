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

export async function getUrlById(req, res) {
  try {
    const { id } = req.params;

    const { rows: url } = await connection.query(
      `
      SELECT id, "shortUrl", url FROM "shortenedUrls" WHERE id = $1
      `,
      [id]
    );

    if (url.length === 0) {
      res.status(404).send("Url encurtada não encontrada!");
      return;
    }

    res.status(200).send(url[0]);
  } catch (err) {
    res.status(500).send("Erro interno!");
  }
}

export async function deleteUrlById(req, res) {
  try {
    const { id } = req.params;
    const { user } = res.locals;

    const { rows: url } = await connection.query(
      `
        SELECT id, "userId", "shortUrl", url FROM "shortenedUrls" WHERE id = $1
        `,
      [id]
    );

    if (url.length === 0) {
      res.status(404).send("Url encurtada não encontrada!");
      return;
    }

    if (url[0].userId !== user.id) {
      res.status(401).send("Esta URL não pertence ao seu usuário!");
      return;
    }

    await connection.query(
      `
    DELETE FROM "shortenedUrls" WHERE id = $1 AND "userId" = $2
    `,
      [id, user.id]
    );

    res.status(204).send();
  } catch (err) {
    res.status(500).send("Erro interno!");
  }
}

export async function visitShortUrl(req, res) {
  try {
    const { shortUrl } = req.params;

    const { rows: shortenedUrl } = await connection.query(
      `
        SELECT u.id as "userId", u."visitCount" as "visitedTotal", s.url, s."visitCount" FROM "shortenedUrls" s JOIN users u ON s."userId" = u.id WHERE "shortUrl" = $1
        `,
      [shortUrl]
    );

    if (shortenedUrl.length === 0) {
      res.status(404).send("Url encurtada não encontrada!");
      return;
    }

    await connection.query(
      `
    UPDATE "shortenedUrls" SET "visitCount" = $1 WHERE "shortUrl" = $2
    `,
      [shortenedUrl[0].visitCount + 1, shortUrl]
    );

    await connection.query(
      `
      UPDATE users SET "visitCount" = $1 WHERE id = $2
      `,
      [shortenedUrl[0].visitedTotal + 1, shortenedUrl[0].userId]
    );

    res.redirect(200, shortenedUrl[0].url);
  } catch (err) {
    res.status(500).send("Erro interno!");
  }
}

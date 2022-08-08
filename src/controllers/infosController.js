import connection from "../dbStrategy/postgres.js";

export async function getUserInfo(req, res) {
  try {
    const { user } = res.locals;

    const { rows: userUrls } = await connection.query(
      `
        SELECT id, "shortUrl", url, "visitCount" FROM "shortenedUrls" WHERE "userId" = $1
        `,
      [user.id]
    );

    if (!user) {
      res.status(404).send("Usuário não encontrado!");
      return;
    }

    const body = {
      id: user.id,
      name: user.name,
      visitCount: user.visitCount,
      shortenedUrls: userUrls,
    };

    res.status(200).send(body);
  } catch (err) {
    res.status(500).send("Erro interno!");
  }
}

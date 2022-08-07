import express from "express";
import dotenv from "dotenv";
import cors from "cors";
import bodyParser from "body-parser";
import authRouter from "./routes/authRouter.js";

dotenv.config();

const app = express();

app.use(bodyParser.urlencoded({ extended: false }));

app.use([cors(), express.json()]);

app.use(authRouter);

app.listen(process.env.PORT, () => {
  console.log(`servidor funfando de boas na porta ${process.env.PORT}`);
});

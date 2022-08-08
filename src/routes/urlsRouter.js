import { Router } from "express";
import {
  deleteUrlById,
  getUrlById,
  shortenUrl,
  visitShortUrl,
} from "../controllers/urlsController.js";
import validateSchema from "../middlewares/validateSchema.js";
import validateToken from "../middlewares/validateToken.js";
import urlSchema from "../schemas/urlSchema.js";

const router = Router();

router.post(
  "/urls/shorten",
  validateToken,
  validateSchema(urlSchema),
  shortenUrl
);

router.get("/urls/:id", getUrlById);

router.delete("/urls/:id", validateToken, deleteUrlById);

router.get("/urls/open/:shortUrl", visitShortUrl);

export default router;

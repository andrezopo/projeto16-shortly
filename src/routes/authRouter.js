import { Router } from "express";
import { signIn, signUp } from "../controllers/authController.js";
import validateSchema from "../middlewares/validateSchema.js";
import signInSchema from "../schemas/signInSchema.js";
import signUpSchema from "../schemas/signUpSchema.js";

const router = Router();

router.post("/signup", validateSchema(signUpSchema), signUp);

router.post("/signin", validateSchema(signInSchema), signIn);

export default router;

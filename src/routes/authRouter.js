import { Router } from "express";
import { signUp } from "../controllers/authController.js";
import validateSchema from "../middlewares/validateSchema.js";
import signInSchema from "../schemas/signInSchema.js";
import signUpSchema from "../schemas/signUpSchema.js";

const router = Router();

router.post("/cadastro", validateSchema(signUpSchema), signUp);

// router.post("/login", validateSchema(signInSchema), signIn);

export default router;

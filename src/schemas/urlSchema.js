import joi from "joi";

const urlSchema = joi.object({
  url: joi
    .string()
    .regex(/^https:\/\//)
    .required(),
});

export default urlSchema;

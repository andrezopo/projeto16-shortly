const validateSchema = (schema) => {
  return (req, res, next) => {
    const { error } = schema.validate(req.body, { abortEarly: false });
    if (error) {
      res.status(422).send(error.details.map((response) => response.message));
      return;
    }
    next();
  };
};

export default validateSchema;

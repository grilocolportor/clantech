class ValidatorFormError implements Exception {
  final String message;

  ValidatorFormError(this.message);
}
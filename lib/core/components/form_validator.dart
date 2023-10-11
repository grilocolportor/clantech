class FormValidator {
  static String validateEmail(String value) {
    if (value.isEmpty) {
      return 'Por favor, insira um endereço de e-mail.';
    } else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$').hasMatch(value)) {
      return 'Por favor, insira um e-mail válido.';
    }
    return '';
  }

  static String validatePassword(String value) {
    if (value.isEmpty) {
      return 'Por favor, insira uma senha.';
    } else if (value.length < 6) {
      return 'A senha deve ter pelo menos 6 caracteres.';
    }
    return '';
  }
}

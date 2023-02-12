class Validator {
  static String? emptyValidator(value) {
    return value.toString().trim().isEmpty ? 'Bidang tidak boleh kosong' : null;
  }

  static String? emailValidator(value) {
    bool emailValidate = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value);
    return !emailValidate ? 'Email tidak valid' : null;
  }

  static String? passwordValidator(value) {
    return value.toString().length < 8
        ? 'Kata sandi tidak boleh kurang dari 8 karakter'
        : null;
  }

  static String? teleponValidator(value) {
    return value.toString().length < 11 ? 'isi No. telepon dengan benar' : null;
  }
}

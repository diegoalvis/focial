final emailRegex = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$');
final RegExp passwordRegex =
    RegExp("^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#\$%\^&\*])(?=.{8,})");

class FormValidators {
  String validateEmail(String value) {
    if (emailRegex.hasMatch(value))
      return null;
    else
      return "Invalid email";
  }

  String validatePassword(String value) {
    if (passwordRegex.hasMatch(value))
      return null;
    else
      return "Password should have 1 special character,\n1 uppercase, 1 lowercase and 1 number";
  }
}

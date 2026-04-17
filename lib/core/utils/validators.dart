import 'package:se7ety/core/utils/validation.dart';

class Validators {
  String? validatorPassword(String? input) {
    if (input!.isEmpty) {
      return "Please enter your password";
    } else if (input.length < 6) {
      return "Password must be at least 6 characters";
    } else if (!isPassword(input)) {
      return "Password must contain at least one uppercase letter and one number";
    }
    return null;
  }

  String? validatorConfirmPassword(String? input, String password) {
    if (input!.isEmpty) {
      return "Please enter your password";
    } else if (input.length < 6) {
      return "Password must be at least 6 characters";
    } else if (!isConfirmPassword(password, input)) {
      return "Passwords do not match";
    }
    return null;
  }
  String? validatorEmail(String? value) {
    if (value!.isEmpty) {
      return "Please enter your email";
    } else if (!isEmailValid(value)) {
      return "Enter a valid email address";
    }
    return null;
  }

  String? validatorName(String? value) {
    if (value!.isEmpty) {
      return "Please enter your name";
    } else if (!isName(value)) {
      return "Enter a valid name";
    }
    return null;
  }

  String? validatorPhone(String? value) {
    if (value!.isEmpty) {
      return "Please enter your phone number";
    } else if (!isPhone(value)) {
      return "Enter a valid phone number";
    }
    return null;
  }

  String? validatorAddress(String? value) {
    if (value!.isEmpty) {
      return "Please enter your address";
    } else if (!isAddress(value)) {
      return "Enter a valid address";
    }
    return null;
  }

  String? validatorGovernorate(String? value) {
    if (value!.isEmpty) {
      return "Please select your governorate";
    } else if (!isGovernorate(value)) {
      return "Enter a valid governorate";
    }
    return null;
  }
}

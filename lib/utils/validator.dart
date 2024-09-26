import 'dart:developer';

import 'package:flutter/material.dart';

import 'date_format.dart';

// FormFieldValidator firstNameValidator(BuildContext context) {
//   return (value) {
//     if (value!.isEmpty) {
//       // context.read<AuthVM>().setFirstNameError(true);
//       return "Please enter first name";
//     }
//
//     // RegExp onlyLettersRegex = RegExp(r'^[A-Za-z]+$');
//     // RegExp onlyLettersRegex = RegExp(r'^[A-Za-z]+$');
//
//     // if (!onlyLettersRegex.hasMatch(value)) {
//     if (RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]').hasMatch(value)) {
//       // context.read<AuthVM>().setFirstNameError(true);
//       return 'Please use only letters';
//     }
//     // context.read<AuthVM>().setFirstNameError(false);
//
//     return null;
//   };
// }

FormFieldValidator phoneValidator() {
  return (value) {
    String valueN = (value ?? "").toString().trim().trimRight().trimLeft();
    if (valueN.isEmpty) {
      return "The phone number is a required field";
    }
    if (valueN.length < 7 || valueN.length > 12) {
      return "The number entered must be between 7 to 12 digits";
    }
    return null;
  };
}

String? phoneValidator2({required String value}) {
  String valueN = (value).toString().trim().trimRight().trimLeft();
  if (valueN.isEmpty) {
    return "The phone number is a required field";
  }
  if (valueN.length < 7 || valueN.length > 12) {
    return "The number entered must be between 7 to 12 digits";
  }
  return null;
}

FormFieldValidator emailValidator(BuildContext context, {bool? isOptional}) {
  return (value) {
    if (isOptional == true) {
      if (value.toString().trim() == "") {
        return null;
      }
    }

    if (value!.isEmpty) {
      // context.read<AuthVM>().setEmailError(true);
      return "Please enter email address";
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegex.hasMatch(value)) {
      // context.read<AuthVM>().setEmailError(true);
      return "Please enter a valid email address";
    }
    // context.read<AuthVM>().setEmailError(false);

    return null;
  };
}

FormFieldValidator dateOfBirthValidator(BuildContext context) {
  return (value) {
    if (value!.isEmpty) {
      // context.read<AuthVM>().setDateOfBirthError(true);
      return "Please select date of birth";
    }

    DateTime birthdate = getDateFormatParse(date: value);

    int age = _calculateAge(birthdate);

    if (age < 18) {
      // context.read<AuthVM>().setDateOfBirthError(true);
      return 'To use the app you must be 18 years old';
    }
    // context.read<AuthVM>().setDateOfBirthError(false);
    return null;
  };
}

int _calculateAge(DateTime birthdate) {
  final now = DateTime.now();
  final age = now.year -
      birthdate.year -
      (now.month > birthdate.month || (now.month == birthdate.month && now.day >= birthdate.day)
          ? 0
          : 1);
  return age;
}

FormFieldValidator locationValidator(BuildContext context) {
  return (value) {
    if (value == null) {
      // context.read<AuthVM>().setLocationError(true);
      return "Please select location";
    }

    // context.read<AuthVM>().setLocationError(false);
    return null;
  };
}

FormFieldValidator passwordValidation() {
  return (value) {
    if (value == null || value.isEmpty) {
      return "Please Enter Password";
    }

    // Check for at least one symbol
    // if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
    //   return "Password must contain at least one symbol";
    // }

    // Check for at least one capital letter
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one capital letter';
    }

    // Check for at least one number
    if (!value.contains(RegExp(r'[0-9]'))) {
      return "Password must contain at least one number";
    }

    // Check for length
    if (value.length < 8) {
      return "Password must be at least 8 characters long";
    }

    return null;
  };
}

FormFieldValidator passwordValidationForLogin() {
  return (value) {
    value = (value ?? "").toString().trim();
    if (value == null || value.isEmpty) {
      return "Please Enter Password";
    }

    // Check for at least one symbol
    // if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
    //   return "Password must contain at least one symbol";
    // }

    // Check for at least one capital letter
    // if (!value.contains(RegExp(r'[A-Z]'))) {
    //   return 'Password must contain at least one capital letter';
    // }
    //
    // Check for at least one number
    // if (!value.contains(RegExp(r'[0-9]'))) {
    //   return "Password must contain at least one number";
    // }
    //
    // Check for length
    // if (value.length < 8) {
    //   return "Password must be at least 8 characters long";
    // }

    return null;
  };
}

String? confirmPasswordValidation({required String passValue, required String? value}) {
  log("confirmPasswordValidation passValue -====>> $passValue");
  log("confirmPasswordValidation value -====>> $value");

  if (value == null || value.isEmpty) {
    return "Please Confirm Enter Password";
  }

  // Check for at least one symbol
  if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
    return "Password must contain at least one symbol";
  }

  // Check for at least one capital letter
  if (!value.contains(RegExp(r'[A-Z]'))) {
    return 'Password must contain at least one capital letter';
  }

  // Check for at least one number
  if (!value.contains(RegExp(r'[0-9]'))) {
    return "Password must contain at least one number";
  }

  // Check for length
  if (value.length < 8) {
    return "Password must be at least 8 characters long";
  }

  if (value != passValue) {
    return "Password and Confirm Password not match";
  }

  return null;
}

FormFieldValidator commonValidator({required String title, bool? isForDropDown}) {
  return (value) {
    String valueN = (value ?? "").toString().trim();
    if (valueN != "") {
      return null;
    }
    return "Please ${isForDropDown == true ? "Select" : "Enter"} $title";
  };
}

FormFieldValidator pinCodeValidator() {
  return (value) {
    if (value == null || value.isEmpty) {
      return 'Please enter pin code';
    } else if (value.length < 6) {
      return 'Pin code must be 6 digits';
    }
    return null;
  };
}

FormFieldValidator discountValidator() {
  return (value) {
    if (value == null || value.isEmpty) {
      // return "Please enter a discount value.";
      return null;
    } else {
      double discount = double.parse(value);
      if (discount > 100) {
        return "Discount cannot be greater than 100%";
      }
      return null; // No validation error
    }
  };
}

FormFieldValidator taxValidator() {
  return (value) {
    if (value == null || value.isEmpty) {
      // return "Please enter a discount value.";
      return null;
    } else {
      double discount = double.parse(value);
      if (discount > 100) {
        return "Tax cannot be greater than 100%";
      }
      return null; // No validation error
    }
  };
}

FormFieldValidator percentageValidator({required String title}) {
  return (value) {
    if (value == null || value.isEmpty) {
      return "Please enter a $title";
    } else {
      double discount = double.parse(value);
      if (discount > 100) {
        return "$title cannot be greater than 100%";
      }
      return null; // No validation error
    }
  };
}

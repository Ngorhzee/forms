typedef ValidatorFunction = String? Function(String?);

ValidatorFunction generateValidator(
    {required Map<String, dynamic> json, String? name}) {
  return (String? input) {
    if (json["required"] != null) {
      if (json["required"] == true) {
        if (input == null || input.isEmpty) {
          return "$name cannot be Empty";
        }
      }
    }
    if (json['minLength'] != null) {
      int minLength = json['minLength'];
      if (input != null && input.length < minLength) {
        return 'Input must be at least $minLength characters long!';
      }
    }
// 3. Handle maxLength validation
    if (json['maxLength'] != null) {
      int maxLength = json['maxLength'];
      if (input != null && input.length > maxLength) {
        return 'Input must be no more than $maxLength characters long!';
      }
    }
// 4. Handle minWords validation
    if (json['minWords'] != null) {
      int minWords = json['minWords'];
      if (input != null && input.split(' ').length < minWords) {
        return 'Input must have at least $minWords word(s)!';
      }
    }
// 5. Handle maxWords validation
    if (json['maxWords'] != null) {
      int maxWords = json['maxWords'];
      if (input != null && input.split(' ').length > maxWords) {
        return 'Input must have no more than $maxWords word(s)!';
      }
    }
    if (json['pattern'] != null) {
      if (RegExp(json["pattern"]).hasMatch(input!)) {
        return 'Not a valid $name!';
      }
    }
// 6. Handle custom equality validation from JSON
    var condition = json['json']['if'];
    if (condition != null && condition.length >= 2) {
      var equalityCheck = condition[0];
      var expectedValue = equalityCheck['==='][1];
      var errorMessage = condition[2] ?? "Error";
      if (input != expectedValue) {
        return errorMessage;
      }
    }
    return null;
  };
}

class FormModel {
  final String? key;
  final String? type;
  final bool? input;
  final String? label;
  final Validate? validate;
  final bool? tableView;
  final List<SelectModel> ?select;
  final Conditional? conditional;
  final String? placeholder;
  final String? defaultValue;

  FormModel({
    this.key,
    this.type,
    this.input,
    this.label,
    this.validate,
    this.select,
    this.tableView,
    this.conditional,
    this.placeholder,
    this.defaultValue,
  });

  factory FormModel.fromJson(Map<String, dynamic> json) => FormModel(
        key: json["key"],
        type: json["type"],
        input: json["input"],
        label: json["label"],
        select: json["data"]==null?null:json["data"]["values"]==null?null: List.from(json["data"]["values"]).map((e)=>SelectModel.fromJson(e)).toList(),
        validate: json["validate"] == null
            ? null
            : Validate.fromJson(json["validate"]),
        tableView: json["tableView"],
        conditional: json["conditional"] == null
            ? null
            : Conditional.fromJson(json["conditional"]),
        placeholder: json["placeholder"],
        defaultValue: json["defaultValue"],
      );

  Map<String, dynamic> toJson() => {
        "key": key,
        "type": type,
        "input": input,
        "label": label,
        "validate": validate?.toJson(),
        "tableView": tableView,
        "conditional": conditional?.toJson(),
        "placeholder": placeholder,
        "defaultValue": defaultValue,
      };
}

class Conditional {
  final bool? show;

  Conditional({
    this.show,
  });

  factory Conditional.fromJson(Map<String, dynamic> json) => Conditional(
        show: json["show"],
      );

  Map<String, dynamic> toJson() => {
        "show": show,
      };
}

class Validate {
  final Json? json;
  final int? maxWords;
  final int? minWords;
  final bool? required;
  final int? maxLength;
  final int? minLength;

  Validate({
    this.json,
    this.maxWords,
    this.minWords,
    this.required,
    this.maxLength,
    this.minLength,
  });

  factory Validate.fromJson(Map<String, dynamic> json) => Validate(
        json: json["json"] == null ? null : Json.fromJson(json["json"]),
        maxWords: json["maxWords"],
        minWords: json["minWords"],
        required: json["required"],
        maxLength: json["maxLength"],
        minLength: json["minLength"],
      );

  Map<String, dynamic> toJson() => {
        "json": json?.toJson(),
        "maxWords": maxWords,
        "minWords": minWords,
        "required": required,
        "maxLength": maxLength,
        "minLength": minLength,
      };
}

class Json {
  final List<dynamic>? jsonIf;

  Json({
    this.jsonIf,
  });

  factory Json.fromJson(Map<String, dynamic> json) => Json(
        jsonIf: json["if"] == null
            ? []
            : List<dynamic>.from(json["if"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "if": jsonIf == null ? [] : List<dynamic>.from(jsonIf!.map((x) => x)),
      };
}

class IfClass {
  final List<dynamic>? empty;

  IfClass({
    this.empty,
  });

  factory IfClass.fromJson(Map<String, dynamic> json) => IfClass(
        empty: json["==="] == null
            ? []
            : List<dynamic>.from(json["==="]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "===": empty == null ? [] : List<dynamic>.from(empty!.map((x) => x)),
      };
}

class Class {
  final String? purpleVar;

  Class({
    this.purpleVar,
  });

  factory Class.fromJson(Map<String, dynamic> json) => Class(
        purpleVar: json["var"],
      );

  Map<String, dynamic> toJson() => {
        "var": purpleVar,
      };
}

class SelectModel {
  final dynamic value;
  final dynamic label;
SelectModel({this.value, this.label});
  factory SelectModel.fromJson(Map<String, dynamic> json) =>
      SelectModel(value: json["value"], label: json["label"]);
@override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SelectModel &&
        other.value == value &&
        other.label == label;
  }

  // Override the hashCode getter
  @override
  int get hashCode => value.hashCode ^ label.hashCode;

  
}

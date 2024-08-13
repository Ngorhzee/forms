class FormModel {
  final String? key;
  final String? type;
  final bool? input;
  final String? label;
  final Map<String, dynamic>? validate;
  final bool? tableView;
  final List<SelectModel>? select;
  final Conditional? conditional;
  final String? placeholder;
  final String? defaultValue;
  final List<FormModel>? component;

  FormModel({
    this.key,
    this.type,
    this.input,
    this.label,
    this.validate,
    this.select,
    this.tableView,
    this.conditional,
    this.component,
    this.placeholder,
    this.defaultValue,
  });

  factory FormModel.fromJson(Map<String, dynamic> json) => FormModel(
        key: json["key"],
        type: json["type"],
        input: json["input"],
        label: json["label"],
        select: json["data"] == null
            ? []
            : json["data"]["values"] == null
                ? []
                : List.from(json["data"]["values"])
                    .map((e) => SelectModel.fromJson(e))
                    .toList(),
        component: json["components"] == null
            ? []
            : List.from(json["components"])
                .map((e) => FormModel.fromJson(e))
                .toList(),
        validate: json["validate"],
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
        "validate": validate,
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

    return other is SelectModel && other.value == value && other.label == label;
  }

  // Override the hashCode getter
  @override
  int get hashCode => value.hashCode ^ label.hashCode;
}

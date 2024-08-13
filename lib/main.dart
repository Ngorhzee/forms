import 'package:flutter/material.dart';
import 'package:form_test/form_builder.dart';
import 'package:form_test/model/form_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Homepage(),
    );
  }
}

class Homepage extends StatelessWidget {
  Homepage({super.key});
  List<FormModel> formList = [
    {
      "key": "firstName",
      "type": "textfield",
      "input": true,
      "label": "First Name",
      "validate": {
        "json": {
          "if": [
            {
              "===": [
                {"var": "input"},
                "Bob"
              ]
            },
            true,
            "Your name must be 'Bob'!"
          ]
        },
        "maxWords": 1,
        "minWords": 1,
        "required": true,
        "maxLength": 10,
        "minLength": 2
      },
      "tableView": true,
      "conditional": {"show": true},
      "placeholder": "Please enter your first name",
      "defaultValue": "James"
    },
    {
      "key": "gender",
      "data": {
        "values": [
          {"label": "Male", "value": "male"},
          {"label": "Female", "value": "female"},
          {"label": "Other", "value": "other"}
        ]
      },
      "type": "select",
      "input": true,
      "label": "Gender",
      "widget": "choicesjs",
      "validate": {"required": true},
      "tableView": true,
      "placeholder": "Select Gender"
    },
    {
      "key": "submit",
      "type": "button",
      "input": true,
      "label": "Submit",
      "tableView": false,
      "disableOnInvalid": true
    }
  ].map((e) => FormModel.fromJson(e)).toList();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 30, 16, 30),
        child: Form(
          child: FormBuilder(
            fields: formList,
          ),
        ),
      ),
    ));
  }
}

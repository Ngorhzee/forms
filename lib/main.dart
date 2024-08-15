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
      "key": "page1",
      "type": "panel",
      "input": false,
      "label": "Page 1",
      "title": "Step 1",
      "tableView": false,
      "components": [
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
          "key": "lastName",
          "type": "textfield",
          "input": true,
          "label": "Last Name",
          "errors": {
            "maxWords": "{{field}} can only have one word",
            "minWords": "{{field}} can only have one word",
            "required": "{{ field }} is required. Try again.",
            "maxLength": "{{ field }} is too long. Try again."
          },
          "validate": {
            "maxWords": 1,
            "minWords": 1,
            "required": true,
            "maxLength": 30,
            "minLength": 2
          },
          "tableView": true
        },
        {
          "key": "gender",
          "data": {
            "values": [
              {"label": "Male", "value": "Male"},
              {"label": "Female", "value": "Female"},
              {"label": "Other", "value": "Other"}
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
          "key": "ageGrade",
          "data": {
            "values": [
              {"label": "less_1", "value": "<1"},
              {"label": "1_4", "value": "1-4"},
              {"label": "5_9", "value": "5-9"},
              {"label": "10_14", "value": "10-14"},
              {"label": "15_19", "value": "15-19"},
              {"label": "20_24", "value": "20-24"},
              {"label": "25_29", "value": "25-29"},
              {"label": "above_30", "value": "30+"}
            ]
          },
          "type": "select",
          "input": true,
          "label": "Age ",
          "widget": "choicesjs",
          "validate": {"required": true, "onlyAvailableItems": true},
          "tableView": true
        }
      ],
      "collapsible": false,
      "saveOnEnter": false,
      "scrollToTop": false,
      "buttonSettings": {"next": true, "cancel": true, "previous": true},
      "navigateOnEnter": false,
      "breadcrumbClickable": true
    },
    {
      "key": "page2",
      "type": "panel",
      "input": false,
      "label": "Page 2",
      "title": "Step 2",
      "tableView": false,
      "components": [
        {
          "key": "pregnant",
          "type": "selectboxes",
          "input": true,
          "label": "Pregnant",
          "values": [
            {"label": "Yes", "value": "Yes", "shortcut": ""},
            {"label": "No", "value": "No", "shortcut": ""}
          ],
          "validate": {
            "required": true,
          },
          "inputType": "checkbox",
          "tableView": false,
          "conditional": {"eq": "Female", "show": true, "when": "gender"},
          "defaultValue": {"No": false, "Yes": false},
          "optionsLabelPosition": "right"
        },
        {
          "key": "breastFeeding",
          "type": "selectboxes",
          "input": true,
          "label": "Breast feeding",
          "validate": {
            "required": true,
            "minSelectedCount": 2,
            "maxSelectedCount": 3,
          },
          "values": [
            {"label": "Yes", "value": "Yes", "shortcut": ""},
            {"label": "No", "value": "No", "shortcut": ""},
            {"label": "probaly", "value": "probaly", "shortcut": ""},
            {"label": "meee", "value": "meee", "shortcut": ""},
          ],
          "inputType": "checkbox",
          "tableView": false,
          "conditional": {"eq": "No", "show": true, "when": "pregnant"},
          "optionsLabelPosition": "right"
        },
        {
          "label": "sick",
          "optionsLabelPosition": "right",
          "inline": false,
          "tableView": false,
          "values": [
            {"label": "Yes", "value": "yes", "shortcut": ""},
            {"label": "No", "value": "no", "shortcut": ""}
          ],
          "validate": {"required": true},
          "validateWhenHidden": false,
          "key": "sick",
          "type": "radio",
          "input": true
        },
        {
          "key": "hivStatus",
          "data": {
            "values": [
              {"label": "Positive", "value": "positive"},
              {"label": "Negative", "value": "negative"},
              {"label": "Unknown", "value": "unknown"}
            ]
          },
          "type": "select",
          "input": true,
          "label": "HIV Status",
          "widget": "choicesjs",
          "tableView": true
        }
      ],
      "collapsible": false,
      "saveOnEnter": false,
      "scrollToTop": false,
      "buttonSettings": {"next": true, "cancel": true, "previous": true},
      "navigateOnEnter": false,
      "breadcrumbClickable": true
    },
    {
      "label": "yess",
      "tableView": false,
      "defaultValue": false,
      "validate": {"required": true},
      "validateWhenHidden": false,
      "key": "checkbox",
      "type": "checkbox",
      "input": true
    }
  ].map((e) => FormModel.fromJson(e)).toList();
  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey();
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 30, 16, 30),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              Text("hola"),
              ...List.generate(formList.length,
                  (index) => FormBuilder(field: formList[index])),
              MaterialButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    print("Validate");
                  } else {}
                },
                textColor: Colors.black,
                child: Text("Submit"),
              )
            ],
          ),
        ),
      ),
    ));
  }
}

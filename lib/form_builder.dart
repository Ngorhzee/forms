import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_test/model/form_model.dart';
import 'package:form_test/validators/form_validator.dart';

class FormBuilder extends StatelessWidget {
  const FormBuilder({super.key, required this.field});
  final FormModel field;

  @override
  Widget build(BuildContext context) {
    if (field.type == "textfield") {
      return TextFieldWidget(field: field);
    } else if (field.type == "select") {
      return DropDownWidget(field: field);
    } else if (field.type == "panel") {
      return Column(
        children: [
          //Text("heyy")
          ...List.generate(field.component?.length ?? 0, (index) {
            FormModel panelField = field.component![index];
            if (panelField.type == "textfield") {
              return TextFieldWidget(field: panelField);
            } else if (panelField.type == "select") {
              return DropDownWidget(field: panelField);
            } else if (panelField.type == "selectboxes") {
              return SelectBoxesWidget(field: panelField);
            } else if (panelField.type == "radio") {
              return RadioButtonWidget(field: panelField);
            } else if (field.type == "checkbox") {
              return CheckBoxWidget(field: field);
            } else {
              return SizedBox();
            }
          })
        ],
      );
    } else if (field.type == "selectboxes") {
      return SelectBoxesWidget(field: field);
    } else if (field.type == "radio") {
      return RadioButtonWidget(field: field);
    } else if (field.type == "checkbox") {
      return CheckBoxWidget(field: field);
    } else {
      return SizedBox();
    }
    // return SizedBox();
  }
}

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    super.key,
    required this.field,
  });

  final FormModel field;

  @override
  Widget build(BuildContext context) {
    ValidatorFunction validator =
        generateValidator(json: field.validate ?? {}, name: field.label);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          field.label ?? "",
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
        ),
        SizedBox(
          height: 8,
        ),
        TextFormField(
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          maxLength: field.validate?["maxlength"],
          validator: validator,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 2),
              borderRadius: BorderRadius.circular(8),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 2),
              borderRadius: BorderRadius.circular(8),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 2),
              borderRadius: BorderRadius.circular(8),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 1),
              borderRadius: BorderRadius.circular(8),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 1),
              borderRadius: BorderRadius.circular(8),
            ),
            //   filled: true,
            // fillColor: Pallet.white,
            //contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24.0),
            hintText: field.placeholder,
            hintStyle: TextStyle(fontSize: 14, color: Colors.grey.shade400),

            isDense: true,
            // labelStyle: labelStyle ??
            //     titleStyle.copyWith(
            //       fontSize: setSp(16),
            //       height: 1.43,
            //       color: Pallet.white,
            //     ),
          ),
        ),
      ],
    );
  }
}

class RadioButtonWidget extends StatefulWidget {
  const RadioButtonWidget({super.key, required this.field});
  final FormModel field;
  @override
  State<RadioButtonWidget> createState() => _RadioButtonWidgetState();
}

class _RadioButtonWidgetState extends State<RadioButtonWidget> {
  SelectModel? groupValue;
  @override
  Widget build(BuildContext context) {
    ValidatorFunction validator = generateValidator(
        json: widget.field.validate ?? {}, name: widget.field.label);
    return FormField<SelectModel>(
        validator: (value) => validator(
              value?.value,
            ),
        builder: (state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.field.label ?? "",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 8,
              ),
              ...List.generate(
                  widget.field.selectboxes?.length ?? 0,
                  (index) => RadioListTile(
                        title: Text(widget.field.selectboxes![index].label),
                        groupValue: groupValue,
                        value: widget.field.selectboxes![index],
                        onChanged: (value) {
                          groupValue = value;
                          setState(() {});
                        },
                      )),
              state.hasError
                  ? Text(
                      state.errorText ?? "",
                      style: TextStyle(fontSize: 12, color: Colors.red),
                    )
                  : SizedBox(),
            ],
          );
        });
  }
}

class CheckBoxWidget extends StatefulWidget {
  const CheckBoxWidget({super.key, required this.field});
  final FormModel field;
  @override
  State<CheckBoxWidget> createState() => _CheckBoxWidgetState();
}

class _CheckBoxWidgetState extends State<CheckBoxWidget> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    ValidatorFunction validator = generateValidator(
        json: widget.field.validate ?? {}, name: widget.field.label);
    return FormField<bool>(
        validator: (value) => validator(value),
        autovalidateMode: AutovalidateMode.always,
        builder: (state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CheckboxListTile(
                value: isChecked,
                title: Text(widget.field.label ?? ""),
                onChanged: (value) {
                  isChecked = value!;
                  setState(() {});
                },
              ),
              state.hasError
                  ? Text(
                      state.errorText ?? "",
                      style: TextStyle(fontSize: 12, color: Colors.red),
                    )
                  : SizedBox(),
            ],
          );
        });
  }
}

class SelectBoxesWidget extends StatefulWidget {
  const SelectBoxesWidget({super.key, required this.field});
  final FormModel field;
  @override
  State<SelectBoxesWidget> createState() => _SelectBoxesWidgetState();
}

class _SelectBoxesWidgetState extends State<SelectBoxesWidget> {
  List<SelectModel> selectedFields = [];
  @override
  Widget build(BuildContext context) {
    ValidatorFunction validator = generateValidator(
        json: widget.field.validate ?? {}, name: widget.field.label);
    return FormField<SelectModel>(
        validator: (value) => validator(value?.value),
        builder: (state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.field.label ?? "",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 8,
              ),
              ...List.generate(
                  widget.field.selectboxes?.length ?? 0,
                  (index) => CheckboxListTile(
                        value: selectedFields
                            .contains(widget.field.selectboxes![index]),
                        onChanged: (bool? value) {
                          if (selectedFields
                              .contains(widget.field.selectboxes![index])) {
                            selectedFields
                                .remove(widget.field.selectboxes![index]);
                            setState(() {});
                          } else {
                            selectedFields
                                .add(widget.field.selectboxes![index]);
                            setState(() {});
                          }
                        },
                        title: Text(widget.field.selectboxes![index].label),
                      )),
              state.hasError
                  ? Text(
                      state.errorText ?? "",
                      style: TextStyle(fontSize: 12, color: Colors.red),
                    )
                  : SizedBox(),
            ],
          );
        });
  }
}

class DropDownWidget extends StatefulWidget {
  const DropDownWidget({super.key, required this.field});
  final FormModel field;

  @override
  State<DropDownWidget> createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {
  SelectModel? value;
  @override
  Widget build(BuildContext context) {
    ValidatorFunction validator = generateValidator(
        json: widget.field.validate ?? {}, name: widget.field.label);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.field.label ?? "",
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
        ),
        SizedBox(
          height: 8,
        ),
        FormField<SelectModel>(
          validator: (value) => validator(value?.value),
          builder: (FormFieldState<SelectModel> state) {
            return InputDecorator(
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
                error: state.hasError
                    ? Text(
                        state.errorText ?? "",
                        style: TextStyle(fontSize: 12, color: Colors.red),
                      )
                    : null,
                errorStyle: TextStyle(fontSize: 12, color: Colors.red),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 1),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 1),
                  borderRadius: BorderRadius.circular(8),
                ),
                //   filled: true,
                // fillColor: Pallet.white,
                //contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24.0),
                hintText: widget.field.placeholder,
                hintStyle: TextStyle(fontSize: 14, color: Colors.grey.shade400),

                isDense: true,
                // labelStyle: labelStyle ??
                //     titleStyle.copyWith(
                //       fontSize: setSp(16),
                //       height: 1.43,
                //       color: Pallet.white,
                //     ),
              ),
              isEmpty: value == null,
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                  isExpanded: true,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                  alignment: Alignment.center,
                  // icon: isLoading
                  //     ? const CupertinoActivityIndicator()
                  //     : Center(
                  //         child: suffixWidget ??
                  //             ImageLoader(
                  //               path: AppAssets.dropdown,
                  //               height: 20.w,
                  //               width: 20.w,
                  //               fit: BoxFit.none,
                  //             ),
                  //       ),
                  dropdownColor: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                  // iconSize: ScreenUtil().setHeight(25),
                  //iconEnabledColor: Pallet.hintColor,
                  value: value,
                  isDense: true,
                  items: widget.field.select!.map((SelectModel value) {
                    return DropdownMenuItem<SelectModel>(
                      value: value,
                      child: Text(
                        value.label,
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w400),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    );
                  }).toList(),
                  onChanged: (values) {
                    value = values;
                    setState(() {});
                  },
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

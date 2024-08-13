import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_test/model/form_model.dart';
import 'package:form_test/validators/form_validator.dart';

class FormBuilder extends StatefulWidget {
  const FormBuilder({super.key, required this.fields});
  final List<FormModel> fields;

  @override
  State<FormBuilder> createState() => _FormBuilderState();
}

class _FormBuilderState extends State<FormBuilder> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ...List.generate(widget.fields.length, (index) {
          FormModel field = widget.fields[index];

          if (field.type == "textfield") {
            return TextFieldWidget(field: field);
          } else if (field.type == "select") {
            return DropDownWidget(field: field);
          } else if (field.type == "panel") {
            Column(
              children: [
                ...List.generate(field.component?.length ?? 0, (index) {
                  if (field.type == "textfield") {
                    return TextFieldWidget(field: field);
                  } else if (field.type == "select") {
                    return DropDownWidget(field: field);
                  } else {
                    return SizedBox();
                  }
                })
              ],
            );
          } else {
            return SizedBox();
          }
          return SizedBox();
        })
      ],
    );
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
    ValidatorFunction validator = generateValidator(json: field.validate ?? {});
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
    ValidatorFunction validator =
        generateValidator(json: widget.field.validate ?? {});
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

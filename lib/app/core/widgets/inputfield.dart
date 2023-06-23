import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final bool isHidden;
  final Widget? icon;
  final Widget? safixIcon;
  final String? title;
  final Color? hintColor;
  final Color? color;
  final String hint;
  final bool isRequired;
  final double? border;
  final bool? autofocus;
  final TextEditingController controller;
  final bool readOnly;
  final int? maxLines;
  final TextInputType keyboardType;
  final void Function(String? value)? onSaved;
  final void Function(String? value)? onChanged;
  final String? Function(String? value)? validator;
  const InputField({
    Key? key,
    required this.isHidden,
    this.icon,
    this.title,
    this.hintColor,
    this.color,
    this.maxLines,
    required this.hint,
    required this.isRequired,
    this.border,
    this.autofocus,
    required this.controller,
    required this.readOnly,
    required this.keyboardType,
    this.onSaved,
    this.onChanged,
    this.validator,
    this.safixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: title != null
              ? Row(
                  children: [
                    Text(
                      title!,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    isRequired
                        ? Text(
                            '*',
                            style: TextStyle(color: Colors.red),
                          )
                        : SizedBox()
                  ],
                )
              : Text(''),
        ),
        title != null
            ? SizedBox(
                height: 5,
              )
            : SizedBox(),
        Container(
          margin: EdgeInsets.only(left: 2, right: 2),
          height: maxLines != null ? 120 : 78,
          child: TextFormField(
            maxLines: maxLines ?? 1,
            autofocus: autofocus ?? false,
            validator: validator,
            onChanged: onChanged,
            onSaved: onSaved,
            obscureText: isHidden,
            controller: controller,
            textAlign: TextAlign.start,
            textAlignVertical: TextAlignVertical.center,
            readOnly: readOnly,
            keyboardType: keyboardType,
            cursorColor: Color(0xff222222),
            decoration: InputDecoration(
              //contentPadding: EdgeInsets.only(top: 20, bottom: 20),
              helperText: '',

              fillColor: const Color(0xfff2f2f2),
              filled: true,
              prefixIcon: icon,
              suffix: safixIcon,
              prefixIconColor: Color(0xff655F74),
              //errorMaxLines: 4,
              //errorStyle: TextStyle(color: Colors.amber),
              //suffixIcon: icon ?? const SizedBox(),
              errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: color ?? const Color.fromARGB(255, 236, 20, 20),
                      width: 1.0),
                  borderRadius: BorderRadius.circular(border ?? 25)),
              focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: color ?? const Color.fromARGB(255, 236, 20, 20),
                      width: 1.0),
                  borderRadius: BorderRadius.circular(border ?? 25)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: color ?? const Color(0xff222222), width: 1.0),
                  borderRadius: BorderRadius.circular(border ?? 25)),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(border ?? 25),
                borderSide: BorderSide(
                    color: color ?? const Color(0xff222222), width: 1.0),
              ),

              hintText: hint,
              hintStyle:
                  TextStyle(color: hintColor ?? Colors.black.withOpacity(0.3)),
            ),
          ),
        ),
      ],
    );
  }
}

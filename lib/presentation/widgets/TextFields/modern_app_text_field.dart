import 'package:cinex_app/common/constants/size_constants.dart';
import 'package:cinex_app/presentation/themes/app_color.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class ModernAppTextField extends StatelessWidget {
  TextEditingController? textEditingController = TextEditingController();
  List<TextInputFormatter>? inputFormatters;
  Widget? suffixIcon;
  Widget? prefixIcon;
  bool? hasPrefixWithPadding;
  FloatingLabelBehavior? floatingLabelBehavior;
  TextInputType? textInputType;
  EdgeInsetsGeometry? contentPadding;
  bool passwordVisible = false;
  GlobalKey<FormState>? formKey;
  String validatorType;
  int mlength;
  int maxLines;
  double? suffixIconMaxHeight;
  double? topMargin;
  double? suffixIconMaxWidth;
  BoxConstraints suffixBoxConstrains;
  double? leftMargin;
  double? rightMargin;
  Color? fillColor;
  double? bottomMargin;
  final double textSize;
  String labeltext;
  String retypepassword;
  String hinttext;
  bool readonly;
  bool isEnabled;
  Function()? ontap;
  bool selfValidate;
  bool? isDense;
  FocusNode? focusNode;
  final Color focusBorderColor;
  Function(String)? onTextChanged;
  Function(String)? onSubmitted;
  final TextStyle? hintStyle;
  String? Function(String?)? validator;
  double? radius;
  final String? errorText;
  ModernAppTextField({
    super.key,
    this.textEditingController,
    this.suffixIcon,
    this.suffixIconMaxHeight,
    this.hasPrefixWithPadding,
    this.contentPadding = const EdgeInsets.fromLTRB(10, 32, 0, 0),
    this.inputFormatters,
    this.floatingLabelBehavior,
    this.topMargin,
    this.isDense,
    this.bottomMargin,
    this.fillColor,
    this.leftMargin,
    this.radius,
    this.suffixIconMaxWidth,
    this.suffixBoxConstrains = const BoxConstraints(
      maxHeight: 42,
      maxWidth: 42,
      minHeight: 40,
      minWidth: 40,
    ),
    this.rightMargin,
    this.textInputType,
    this.prefixIcon,
    this.passwordVisible = false,
    this.isEnabled = true,
    this.maxLines = 1,
    this.formKey,
    this.validatorType = "none",
    this.mlength = 30,
    this.retypepassword = "",
    this.readonly = false,
    this.labeltext = "",
    this.errorText,
    this.ontap,
    this.selfValidate = false,
    this.validator,
    this.textSize = 14,
    this.focusBorderColor = AppColor.primaryActionColor,
    this.onTextChanged,
    this.onSubmitted,
    this.focusNode,
    this.hinttext = "",
    this.hintStyle,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: focusBorderColor,
      inputFormatters: inputFormatters,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      //maxLines: passwordVisible? null: maxLines,
      readOnly: readonly,
      enabled: isEnabled,
      maxLines: maxLines,
      focusNode: focusNode,
      onFieldSubmitted: (value) {
        if (onSubmitted != null) {
          onSubmitted!(value);
        }
      },
      onChanged: (val) {
        if (onTextChanged != null) {
          onTextChanged!(val);
        }
      },
      validator: selfValidate
          ? validator
          : (value) {
              if (validatorType == "none") {
                return null;
              } else {
                if (validatorType == "name") {
                  if (value!.isEmpty) {
                    return "$labeltext  is required";
                  } else if (value.length < 31) {
                    return null;
                  }

                  return "Name Must Under 30 Char!";
                } else if (validatorType == "email") {
                  if (value!.isEmpty) {
                    return "Email is required";
                  } else if (!EmailValidator.validate(value)) {
                    return "Email Not Valid";
                  } else if (value.length > 40) {
                    return 'Must Be Under 40 Character ';
                  }

                  return null;
                } else if (validatorType == "mobile") {
                  if (value!.isEmpty) {
                    return "Mobile is required";
                  } else if (value.length == 10) {
                    return null;
                  }
                  return "Mobile number not valid type without country code";
                } else if (validatorType == "password") {
                  // String pattern ="/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}";
                  String pattern =
                      r'^(?=.?[a-z])(?=.?[a-z])(?=.?[0-9])(?=.?[!@#\$&*~]).{6,}$';
                  RegExp regExp = RegExp(pattern);
                  if (value!.isEmpty) {
                    return "Password is required";
                  } else if (!regExp.hasMatch(value)) {
                    return "1 Uppercase, 1 lowercase, Min Length 8, 1 Special Char ( ! @ # \$ & * ~ ))";
                  }

                  return null;
                } else if (validatorType == "retypepassword") {
                  if (value!.isEmpty) {
                    return "Confirm Your Password";
                  } else if (retypepassword != value) {
                    return "Password not Match!";
                  }

                  return null;
                }
              }
              return null;
            },
      keyboardType: validatorType == "mobile"
          ? TextInputType.number
          : textInputType,
      obscureText: passwordVisible,
      maxLength: mlength,
      controller: textEditingController,
      onTap: ontap,
      style: Theme.of(context).textTheme.bodyMedium,
      textAlign: TextAlign.left,
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        counterText: '',
        contentPadding: contentPadding ?? const EdgeInsets.fromLTRB(6, 0, 0, 0),
        //const EdgeInsets.symmetric(vertical: 20, horizontal: 18),
        hintText: hinttext,
        errorText: errorText,
        hintStyle: hintStyle,
        fillColor: fillColor ?? Theme.of(context).scaffoldBackgroundColor,
        filled: true,
        suffixIcon: Padding(
          padding: const EdgeInsets.only(left: 8, right: 15),
          child: suffixIcon,
        ),
        suffixIconConstraints: suffixBoxConstrains,
        prefixIcon: hasPrefixWithPadding == true
            ? Padding(
                padding: const EdgeInsets.only(left: 12, right: 12),
                child: prefixIcon,
              )
            : const SizedBox(),
        prefixIconConstraints: hasPrefixWithPadding == true
            ? const BoxConstraints(
                maxHeight: 42,
                maxWidth: 42,
                minHeight: 40,
                minWidth: 40,
              )
            : const BoxConstraints(
                maxHeight: 18,
                maxWidth: 18,
                minHeight: 18,
                minWidth: 18,
              ),
        // labelText: labeltext,
        alignLabelWithHint: true,
        isDense: isDense,
        floatingLabelBehavior:
            floatingLabelBehavior ?? FloatingLabelBehavior.auto,
        labelStyle: Theme.of(context).textTheme.bodyMedium,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Sizes.dimen_12),
          borderSide: BorderSide(color: focusBorderColor, width: 1.0),
        ),
        errorStyle: TextStyle(
          fontSize: 12, // Adjust the font size
          height: 0.5, // Reducing the height can help remove extra padding
          color: Colors.red.shade400, // You can change the error text color
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius ?? Sizes.dimen_12),
          borderSide: BorderSide(color: Colors.red.shade400, width: 1.0),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius ?? Sizes.dimen_12),
          borderSide: BorderSide(color: Colors.red.shade400, width: 1.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius ?? Sizes.dimen_12),
          borderSide: BorderSide(
            color: Theme.of(context).brightness == Brightness.dark
                ? AppColor.white
                : AppColor.black,
            width: 0,
          ),
        ),
      ),
    );
  }
}

import 'package:bus_tracking_users/core/constant/color.dart';
import 'package:flutter/material.dart';

class CostumTextForm extends StatelessWidget {
  final String hinttext;
  final String labeltext;
  final IconData icondata;
  final TextEditingController? mycontroller;
  final String? Function(String?) valid;
  final bool isNumber;
  final bool? obscure;
  final void Function()? onTapIcon;
  final bool hasClearIcon;
  final TextInputAction? textInputAction;

  const CostumTextForm({
    super.key,
    required this.hinttext,
    required this.labeltext,
    required this.icondata,
    this.mycontroller,
    required this.valid,
    required this.isNumber,
    this.obscure,
    this.onTapIcon,
    this.hasClearIcon = false,
    this.textInputAction,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: TextFormField(
        keyboardType: isNumber
            ? const TextInputType.numberWithOptions(decimal: true)
            : TextInputType.text,
        validator: valid,
        controller: mycontroller,
        obscureText: obscure ?? false,
        textInputAction: textInputAction ?? TextInputAction.done,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          labelText: labeltext,
          labelStyle: TextStyle(
            color: Colors.grey[600],
            fontSize: 14,
          ),
          hintText: hinttext,
          hintStyle: TextStyle(color: Colors.grey[400]),
          prefixIcon: Icon(
            icondata,
            color: AppColor.primaryColor,
          ),
          suffixIcon: hasClearIcon
              ? IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    mycontroller?.clear();
                  },
                )
              : InkWell(
                  onTap: onTapIcon,
                  child: Icon(
                    obscure ?? false ? Icons.visibility_off : Icons.visibility,
                    color: AppColor.primaryColor,
                  ),
                ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.grey.shade400, width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: AppColor.primaryColor, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.black, width: 1),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.red, width: 1),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.red, width: 2),
          ),
        ),
      ),
    );
  }
}

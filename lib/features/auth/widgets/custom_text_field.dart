import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wechat/config/theme/app_colors.dart';
import 'package:wechat/core/utils/size_config.dart';

class CustomTextField extends StatefulWidget {
  final bool? isPassword;
  final bool? isEmail;
  final TextEditingController controller;
  final String hintText;
  final IconData? prefixIcon;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.isEmail = false,
    this.isPassword = false,
    this.prefixIcon,
    this.validator,
    this.keyboardType,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(context.r(60)),
        color: AppColors.grey100,
      ),
      child: TextFormField(
        // Changed from TextField to TextFormField for validation
        keyboardType:
            widget.keyboardType ??
            (widget.isEmail! ? TextInputType.emailAddress : null),
        autocorrect: widget.isPassword! ? false : true,
        obscureText: widget.isPassword! && !isVisible ? true : false,
        controller: widget.controller,
        validator: widget.validator, // Added validator
        style: GoogleFonts.plusJakartaSans(
          fontWeight: FontWeight.w500,
          fontSize: context.sp(14),
          color: AppColors.black800,
        ),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(context.r(60)),
            borderSide: BorderSide(color: AppColors.blue800),
          ),
          hintText: widget.hintText,
          hintStyle: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: context.sp(14),
            color: Colors.grey.shade400,
          ),
          fillColor: AppColors.grey100,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(context.r(60)),
            borderSide: BorderSide(color: AppColors.grey100),
          ),
          errorBorder: OutlineInputBorder(
            // Added error border
            borderRadius: BorderRadius.circular(context.r(60)),
            borderSide: BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: OutlineInputBorder(
            // Added focused error border
            borderRadius: BorderRadius.circular(context.r(60)),
            borderSide: BorderSide(color: Colors.red),
          ),
          // Add prefix icon
          prefixIcon:
              widget.prefixIcon != null
                  ? Padding(
                    padding: EdgeInsets.symmetric(horizontal: context.w(15)),
                    child: Icon(
                      widget.prefixIcon,
                      color: Colors.grey.shade700,
                      size: context.sp(20),
                    ),
                  )
                  : null,
          prefixIconColor: Colors.grey.shade700,
          suffixIconColor: Colors.grey.shade700,
          contentPadding: EdgeInsets.symmetric(
            horizontal: context.w(20),
            vertical: context.h(15),
          ),
          suffixIcon:
              widget.isPassword!
                  ? GestureDetector(
                    onTap: () => setState(() => isVisible = !isVisible),
                    child: Icon(
                      isVisible
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                    ),
                  )
                  : null,
        ),
      ),
    );
  }
}

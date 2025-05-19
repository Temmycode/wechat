import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wechat/config/theme/app_colors.dart';
import 'package:wechat/core/utils/size_config.dart';
import 'package:wechat/features/profile/views/profile_screen.dart';

class PasswordTextfields extends StatefulWidget {
  final GlobalKey<FormState> formKey;

  const PasswordTextfields({super.key, required this.formKey});

  @override
  State<PasswordTextfields> createState() => _PasswordTextfieldsState();
}

class _PasswordTextfieldsState extends State<PasswordTextfields> {
  final TextEditingController controller1 = TextEditingController();
  final TextEditingController controller2 = TextEditingController();
  final TextEditingController controller3 = TextEditingController();
  final TextEditingController controller4 = TextEditingController();
  final TextEditingController controller5 = TextEditingController();
  final TextEditingController controller6 = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    controller1.dispose();
    controller2.dispose();
    controller3.dispose();
    controller4.dispose();
    controller5.dispose();
    controller6.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // THE LIST OF THE CONTAINERS FOR THE CODE VERIFICATION:AAA
          Container(
            alignment: Alignment.center,
            height: context.h(50),
            width: context.w(49),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(context.r(10)),
              color: AppColors.grey100,
            ),
            child: TextFormField(
              controller: controller1,
              keyboardType: TextInputType.visiblePassword,
              textAlign: TextAlign.center,
              obscureText: true,
              style: TextStyle(
                fontSize: context.sp(14),
                fontWeight: FontWeight.bold,
              ),
              inputFormatters: [
                LengthLimitingTextInputFormatter(1),
                FilteringTextInputFormatter.singleLineFormatter,
              ],
              onChanged: (value) {
                if (value.length == 1) {
                  FocusScope.of(context).nextFocus();
                }
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return '';
                } else {
                  return null;
                }
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(context.h(4)),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.grey100),
                  borderRadius: BorderRadius.circular(context.r(10)),
                ),
                border: OutlineInputBorder(
                  gapPadding: 0,
                  borderRadius: BorderRadius.circular(context.r(10)),
                  borderSide: BorderSide(color: AppColors.blue800),
                ),
                errorBorder: OutlineInputBorder(
                  gapPadding: 0,
                  borderRadius: BorderRadius.circular(context.r(10)),
                  borderSide: BorderSide(color: Colors.redAccent),
                ),
                errorStyle: const TextStyle(fontSize: 0),
              ),
            ),
          ),
          SizedBox(width: context.w(5)),
          Container(
            alignment: Alignment.center,
            height: context.h(50),
            width: context.w(49),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(context.r(10)),
              color: AppColors.grey100,
            ),
            child: TextFormField(
              controller: controller2,
              keyboardType: TextInputType.visiblePassword,
              textAlign: TextAlign.center,
              obscureText: true,
              style: TextStyle(
                fontSize: context.sp(14),
                fontWeight: FontWeight.bold,
              ),
              inputFormatters: [
                LengthLimitingTextInputFormatter(1),
                FilteringTextInputFormatter.singleLineFormatter,
              ],
              onChanged: (value) {
                if (value.length == 1) {
                  FocusScope.of(context).nextFocus();
                } else if (value.isEmpty) {
                  FocusScope.of(context).previousFocus();
                }
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return '';
                } else {
                  return null;
                }
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(context.h(4)),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.grey100),
                  borderRadius: BorderRadius.circular(context.r(10)),
                ),
                border: OutlineInputBorder(
                  gapPadding: 0,
                  borderRadius: BorderRadius.circular(context.r(10)),
                  borderSide: BorderSide(color: AppColors.blue800),
                ),
                errorBorder: OutlineInputBorder(
                  gapPadding: 0,
                  borderRadius: BorderRadius.circular(context.r(10)),
                  borderSide: BorderSide(color: Colors.redAccent),
                ),
                errorStyle: const TextStyle(fontSize: 0),
              ),
            ),
          ),
          SizedBox(width: context.w(5)),
          Container(
            alignment: Alignment.center,
            height: context.h(50),
            width: context.w(49),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(context.r(10)),
              color: AppColors.grey100,
            ),
            child: TextFormField(
              controller: controller3,
              keyboardType: TextInputType.visiblePassword,
              textAlign: TextAlign.center,
              obscureText: true,
              style: TextStyle(
                fontSize: context.sp(14),
                fontWeight: FontWeight.bold,
              ),
              inputFormatters: [
                LengthLimitingTextInputFormatter(1),
                FilteringTextInputFormatter.singleLineFormatter,
              ],
              onChanged: (value) {
                if (value.length == 1) {
                  FocusScope.of(context).nextFocus();
                } else if (value.isEmpty) {
                  FocusScope.of(context).previousFocus();
                }
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return '';
                } else {
                  return null;
                }
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(context.h(4)),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.grey100),
                  borderRadius: BorderRadius.circular(context.r(10)),
                ),
                border: OutlineInputBorder(
                  gapPadding: 0,
                  borderRadius: BorderRadius.circular(context.r(10)),
                  borderSide: BorderSide(color: AppColors.blue800),
                ),
                errorBorder: OutlineInputBorder(
                  gapPadding: 0,
                  borderRadius: BorderRadius.circular(context.r(10)),
                  borderSide: BorderSide(color: Colors.redAccent),
                ),
                errorStyle: const TextStyle(fontSize: 0),
              ),
            ),
          ),
          SizedBox(width: context.w(5)),
          Container(
            alignment: Alignment.center,
            height: context.h(50),
            width: context.w(49),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(context.r(10)),
              color: AppColors.grey100,
            ),
            child: TextFormField(
              controller: controller4,
              keyboardType: TextInputType.visiblePassword,
              textAlign: TextAlign.center,
              obscureText: true,
              style: TextStyle(
                fontSize: context.sp(14),
                fontWeight: FontWeight.bold,
              ),
              inputFormatters: [
                LengthLimitingTextInputFormatter(1),
                FilteringTextInputFormatter.singleLineFormatter,
              ],
              onChanged: (value) {
                if (value.length == 1) {
                  FocusScope.of(context).nextFocus();
                } else if (value.isEmpty) {
                  FocusScope.of(context).previousFocus();
                }
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return '';
                } else {
                  return null;
                }
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(context.h(4)),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.grey100),
                  borderRadius: BorderRadius.circular(context.r(10)),
                ),
                border: OutlineInputBorder(
                  gapPadding: 0,
                  borderRadius: BorderRadius.circular(context.r(10)),
                  borderSide: BorderSide(color: AppColors.blue800),
                ),
                errorBorder: OutlineInputBorder(
                  gapPadding: 0,
                  borderRadius: BorderRadius.circular(context.r(10)),
                  borderSide: BorderSide(color: Colors.redAccent),
                ),
                errorStyle: const TextStyle(fontSize: 0),
              ),
            ),
          ),
          SizedBox(width: context.w(5)),
          Container(
            alignment: Alignment.center,
            height: context.h(50),
            width: context.w(49),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(context.r(10)),
              color: AppColors.grey100,
            ),
            child: TextFormField(
              controller: controller5,
              keyboardType: TextInputType.visiblePassword,
              textAlign: TextAlign.center,
              obscureText: true,
              style: TextStyle(
                fontSize: context.sp(14),
                fontWeight: FontWeight.bold,
              ),
              inputFormatters: [
                LengthLimitingTextInputFormatter(1),
                FilteringTextInputFormatter.singleLineFormatter,
              ],
              onChanged: (value) {
                if (value.length == 1) {
                  FocusScope.of(context).nextFocus();
                } else if (value.isEmpty) {
                  FocusScope.of(context).previousFocus();
                }
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return '';
                } else {
                  return null;
                }
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(context.h(4)),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.grey100),
                  borderRadius: BorderRadius.circular(context.r(10)),
                ),
                border: OutlineInputBorder(
                  gapPadding: 0,
                  borderRadius: BorderRadius.circular(context.r(10)),
                  borderSide: BorderSide(color: AppColors.blue800),
                ),
                errorBorder: OutlineInputBorder(
                  gapPadding: 0,
                  borderRadius: BorderRadius.circular(context.r(10)),
                  borderSide: BorderSide(color: Colors.redAccent),
                ),
                errorStyle: const TextStyle(fontSize: 0),
              ),
            ),
          ),
          SizedBox(width: context.w(5)),
          Container(
            alignment: Alignment.center,
            height: context.h(50),
            width: context.w(49),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(context.r(10)),
              color: AppColors.grey100,
            ),
            child: TextFormField(
              controller: controller6,
              keyboardType: TextInputType.visiblePassword,
              textAlign: TextAlign.center,
              obscureText: true,
              style: TextStyle(
                fontSize: context.sp(14),
                fontWeight: FontWeight.bold,
              ),
              inputFormatters: [
                LengthLimitingTextInputFormatter(1),
                FilteringTextInputFormatter.singleLineFormatter,
              ],
              onChanged: (value) {
                if (value.isEmpty) {
                  FocusScope.of(context).previousFocus();
                } else if (value.length == 1) {
                  // TODO:  carry out the function to login the user
                  if (widget.formKey.currentState!.validate()) {
                    final String password =
                        controller1.text +
                        controller2.text +
                        controller3.text +
                        controller4.text +
                        controller5.text +
                        controller6.text;
                    Navigator.of(context).pushNamed(ProfileScreen.routeName);
                    // call the login functoin here
                    // i.e login() {
                    // ...
                    // }
                  }
                }
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return '';
                } else {
                  return null;
                }
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(context.h(4)),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.grey100),
                  borderRadius: BorderRadius.circular(context.r(10)),
                ),
                border: OutlineInputBorder(
                  gapPadding: 0,
                  borderRadius: BorderRadius.circular(context.r(10)),
                  borderSide: BorderSide(color: AppColors.blue800),
                ),
                errorBorder: OutlineInputBorder(
                  gapPadding: 0,
                  borderRadius: BorderRadius.circular(context.r(10)),
                  borderSide: BorderSide(color: Colors.redAccent),
                ),
                errorStyle: const TextStyle(fontSize: 0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

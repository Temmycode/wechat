import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wechat/config/theme/app_colors.dart';
import 'dart:math' as math;

import 'package:wechat/core/utils/app_images.dart';
import 'package:wechat/core/utils/extensions.dart';
import 'package:wechat/core/utils/size_config.dart';
import 'package:wechat/features/auth/widgets/custom_text_field.dart';
import 'package:wechat/features/auth/widgets/password_recovery_option_box.dart';
import 'package:wechat/features/auth/widgets/password_textfields.dart';
import 'package:wechat/features/chat/widgets/user_avatar.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  static const String routeName = 'forgot_password';
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen>
    with SingleTickerProviderStateMixin {
  bool recoveryIsSMS = true;
  late AnimationController _animationController;
  bool isPasswordRecoveryProceeded = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late Animation<double> _xPosition1;
  late Animation<double> _yPosition1;
  late Animation<double> _xPosition2;
  late Animation<double> _yPosition2;
  late Animation<double> _xPosition3;
  late Animation<double> _yPosition3;
  late Animation<double> _xPosition4;
  late Animation<double> _yPosition4;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    Tween<double> xTween = Tween<double>(
      begin: -70, // Your initial x position
      end: -60, // Your target x position
    );
    Tween<double> yTween = Tween<double>(
      begin: -130, // Your initial y position
      end: -100, // Your target y position
    );
    Tween<double> xTween2 = Tween<double>(
      begin: -130, // Your initial x position
      end: -120, // Your target x position
    );
    Tween<double> yTween2 = Tween<double>(
      begin: -180, // Your initial y position
      end: -160, // Your target y position
    );
    Tween<double> xTween3 = Tween<double>(
      begin: 330, // Your initial x position
      end: 400, // Your target x position
    );
    Tween<double> yTween3 = Tween<double>(
      begin: 300, // Your initial y position
      end: 280, // Your target y position
    );
    Tween<double> xTween4 = Tween<double>(
      begin: 200, // Your initial x position
      end: 200, // Your target x position
    );
    Tween<double> yTween4 = Tween<double>(
      begin: 580, // Your initial y position
      end: 900, // Your target y position
    );

    // Create animations
    _xPosition1 = xTween.animate(_animationController);
    _yPosition1 = yTween.animate(_animationController);
    _xPosition2 = xTween2.animate(_animationController);
    _yPosition2 = yTween2.animate(_animationController);
    _xPosition3 = xTween3.animate(_animationController);
    _yPosition3 = yTween3.animate(_animationController);
    _xPosition4 = xTween4.animate(_animationController);
    _yPosition4 = yTween4.animate(_animationController);
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(_xPosition1.value, _yPosition1.value),
                child: AppImages.blob4.toSvg(height: context.h(442)),
              );
            },
          ),
          AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(_xPosition2.value, _yPosition2.value),
                child: AppImages.blob1.toSvg(height: context.h(442)),
              );
            },
          ),
          AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(_xPosition3.value, _yPosition3.value),
                child: AppImages.blob3.toSvg(),
              );
            },
          ),
          AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(_xPosition4.value, _yPosition4.value),
                child: Transform.rotate(
                  angle: -50 * (math.pi / 180),
                  child: AppImages.blob2.toSvg(),
                ),
              );
            },
          ),
          Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: context.w(20)),
                child: Column(
                  children: [
                    SizedBox(height: context.h(148)),
                    const UserAvatar(),
                    SizedBox(height: context.h(12)),
                    Text(
                      "Password Recovery",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: context.sp(21),
                        color: const Color.fromARGB(255, 105, 105, 127),
                      ),
                    ),
                    SizedBox(height: context.h(5)),
                    if (recoveryIsSMS && isPasswordRecoveryProceeded)
                      recoveryCode()
                    else
                      Column(
                        children: [
                          SizedBox(
                            height: context.h(57),
                            width: context.w(290),
                            child: Text(
                              "How you would like to restore your password?",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: context.sp(19),
                                color: AppColors.black800,
                              ),
                            ),
                          ),
                          SizedBox(height: context.h(28)),
                          PasswordRecoveryOptionBox(
                            onTap: () {
                              setState(() {
                                recoveryIsSMS = true;
                              });
                            },
                            isActive: recoveryIsSMS ? true : false,
                            backgroundColor: AppColors.blue200,
                            foregroundColor: AppColors.blue800,
                            text: "SMS",
                          ),
                          SizedBox(height: context.h(10)),
                          // PasswordRecoveryOptionBox(
                          //   onTap: () {
                          //     setState(() {
                          //       recoveryIsSMS = false;
                          //       debugPrint(recoveryIsSMS.toString());
                          //     });
                          //   },
                          //   isActive: recoveryIsSMS ? false : true,
                          //   // backgroundColor: AppColors.pinkInactive,
                          //   // foregroundColor: AppColors.pink3,
                          //   text: "Email",
                          // ),
                          SizedBox(height: context.h(158)),
                          // PrimaryButton(
                          //   onTap: () {
                          //     setState(() {
                          //       isPasswordRecoveryProceeded = true;
                          //       _animationController.forward();
                          //     });
                          //   },
                          //   text: "Next",
                          // ),
                        ],
                      ),
                    SizedBox(height: context.h(10)),
                    // SecondaryButton(
                    //   onTap: () {
                    //     if (isPasswordRecoveryProceeded) {
                    //       setState(() {
                    //         isPasswordRecoveryProceeded =
                    //             !isPasswordRecoveryProceeded;
                    //       });
                    //     } else {
                    //       // do something
                    //     }
                    //   },
                    //   text: "Cancel",
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget recoveryCode() {
    return Column(
      children: [
        SizedBox(
          height: context.h(57),
          width: context.w(290),
          child: Text(
            "Enter 4-digits code we sent you on your phone number",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: context.sp(19),
              color: AppColors.black800,
            ),
          ),
        ),
        SizedBox(height: context.h(13)),
        Text(
          "+98*******00",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: context.sp(16),
            color: AppColors.black800,
          ),
        ),
        SizedBox(height: context.h(28)),
        PasswordTextfields(formKey: formKey),
        SizedBox(height: context.h(158)),
        InkWell(
          onTap: () {},
          child: Container(
            alignment: Alignment.center,
            height: context.h(50),
            width: context.w(201),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(context.r(16)),
              // color: AppColors.pink,
            ),
            child: Text(
              "Send Again",
              style: TextStyle(
                // color: AppColors.background,
                fontWeight: FontWeight.w300,
                fontSize: context.sp(22),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // TOD0: THE SCREEN FOR THE NEW PASSWORD
  Widget setupNewPassword() {
    final newPasswordController = ref.watch(newPasswordControllerProvider);
    final repeatPasswordController = ref.watch(
      repeatPasswordControllerProvider,
    );
    return Column(
      children: [
        SizedBox(height: context.h(148)),
        const UserAvatar(),
        SizedBox(height: context.h(12)),
        Text(
          "Setup New Password",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: context.sp(21),
            color: AppColors.black800,
          ),
        ),
        SizedBox(height: context.h(5)),
        Column(
          children: [
            SizedBox(
              height: context.h(57),
              width: context.w(290),
              child: Text(
                "Please, setup a new password for your account",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: context.sp(19),
                  color: AppColors.black800,
                ),
              ),
            ),
            SizedBox(height: context.h(23)),
            CustomTextField(
              controller: newPasswordController,
              hintText: "New Password",
            ),
            CustomTextField(
              controller: repeatPasswordController,
              hintText: "Repeat Password",
            ),
            SizedBox(height: context.h(158)),
            // PrimaryButton(
            //   onTap: () {
            //     setState(() {
            //       isPasswordRecoveryProceeded = true;
            //     });
            //   },
            //   text: "Next",
            // ),
          ],
        ),
        SizedBox(height: context.h(10)),
        // SecondaryButton(
        //   onTap: () {
        //     if (isPasswordRecoveryProceeded) {
        //       setState(() {
        //         isPasswordRecoveryProceeded = !isPasswordRecoveryProceeded;
        //       });
        //     } else {
        //       // do something
        //       setState(() {
        //         _animationController.reverse();
        //       });
        //     }
        //   },
        //   text: "Cancel",
        // ),
      ],
    );
  }
}

final newPasswordControllerProvider =
    Provider.autoDispose<TextEditingController>((_) => TextEditingController());
final repeatPasswordControllerProvider =
    Provider.autoDispose<TextEditingController>((_) => TextEditingController());

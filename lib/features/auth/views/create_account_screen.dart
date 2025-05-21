import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:wechat/config/theme/app_colors.dart';
import 'package:wechat/core/utils/app_images.dart';
import 'package:wechat/core/utils/equatable_date_time.dart';
import 'package:wechat/core/utils/extensions.dart';
import 'package:wechat/core/utils/size_config.dart';
import 'package:wechat/core/widgets/app_text.dart';
import 'package:wechat/core/widgets/custom_snackbar.dart';
import 'package:wechat/core/widgets/primary_button.dart';
import 'package:wechat/core/widgets/secondary_button.dart';
import 'package:wechat/features/auth/controllers/providers/auth_notifier_provider.dart';
import 'package:wechat/features/auth/models/user.dart';
import 'package:wechat/features/auth/views/login_screen.dart';
import 'package:wechat/features/auth/widgets/custom_text_field.dart';
import 'dart:math' as math;

class CreateAccountScreen extends ConsumerStatefulWidget {
  static const String routeName = '/create-account';
  const CreateAccountScreen({super.key});

  @override
  ConsumerState<CreateAccountScreen> createState() =>
      _CreateAccountScreenState();
}

class _CreateAccountScreenState extends ConsumerState<CreateAccountScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _xPosition1;
  late Animation<double> _yPosition1;
  late Animation<double> _xPosition2;
  late Animation<double> _yPosition2;

  // Form controllers
  final usernameController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Form state
  EquatableDateTime? dateOfBirth;
  int currentStep = 1;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _xPosition1 = Tween<double>(
      begin: -110,
      end: -60,
    ).animate(_animationController);
    _yPosition1 = Tween<double>(
      begin: -210,
      end: -240,
    ).animate(_animationController);
    _xPosition2 = Tween<double>(
      begin: 330,
      end: 400,
    ).animate(_animationController);
    _yPosition2 = Tween<double>(
      begin: 300,
      end: 280,
    ).animate(_animationController);

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    usernameController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  Widget _buildBackgroundBlobs() {
    return Stack(
      children: [
        AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(_xPosition1.value, _yPosition1.value),
              child: AppImages.blob1.toSvg(height: context.h(442)),
            );
          },
        ),
        AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(_xPosition2.value, _yPosition2.value),
              child: Transform.rotate(
                angle: -50 * (math.pi / 180),
                child: AppImages.blob3.toSvg(),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          "Create Account",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: context.sp(50),
            color: AppColors.black800,
          ),
        ),
        context.sbH(4),
        Row(
          children: [
            AppText(
              "Start your journey with us!",
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: context.sp(19),
                color: AppColors.black800,
              ),
            ),
            context.sbW(10.2),
            Icon(Icons.rocket_launch, size: context.sp(15.9)),
          ],
        ),
      ],
    );
  }

  Widget _buildForm() {
    return currentStep == 1 ? _buildFirstStep() : _buildSecondStep();
  }

  Widget _buildFirstStep() {
    return Column(
      children: [
        CustomTextField(
          controller: firstNameController,
          hintText: "First Name",
          prefixIcon: Icons.person_outline,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please enter your first name";
            }
            return null;
          },
        ),
        context.sbH(16),
        CustomTextField(
          controller: lastNameController,
          hintText: "Last Name",
          prefixIcon: Icons.person_outline,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please enter your last name";
            }
            return null;
          },
        ),
        context.sbH(16),
        CustomTextField(
          controller: usernameController,
          hintText: "Username",
          prefixIcon: Icons.alternate_email,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please enter a username";
            }
            if (value.length < 3) {
              return "Username should be at least 3 characters";
            }
            return null;
          },
        ),
        context.sbH(16),
        CustomTextField(
          controller: emailController,
          hintText: "Email",
          isEmail: true,
          prefixIcon: Icons.email_outlined,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please enter your email";
            }
            final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
            if (!emailRegex.hasMatch(value)) {
              return "Please enter a valid email";
            }
            return null;
          },
        ),
        context.sbH(36),
        PrimaryButton(
          onTap: () {
            if (formKey.currentState?.validate() ?? false) {
              setState(() => currentStep = 2);
            }
          },
          text: "Continue",
        ),
      ],
    );
  }

  Widget _buildSecondStep() {
    return Column(
      children: [
        CustomTextField(
          controller: phoneController,
          hintText: "Phone Number",
          prefixIcon: Icons.phone_outlined,
          keyboardType: TextInputType.phone,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please enter your phone number";
            }
            return null;
          },
        ),
        context.sbH(16),
        GestureDetector(
          onTap: () async {
            final date = await showDatePicker(
              context: context,
              initialDate: DateTime.now().subtract(
                const Duration(days: 365 * 18),
              ),
              firstDate: DateTime.now().subtract(
                const Duration(days: 365 * 100),
              ),
              lastDate: DateTime.now(),
            );
            if (date != null) {
              setState(
                () => dateOfBirth = EquatableDateTime.fromDateTime(date),
              );
            }
          },
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: context.w(20),
              vertical: context.h(15),
            ),
            decoration: BoxDecoration(
              color: AppColors.grey100,
              borderRadius: BorderRadius.circular(context.r(60)),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.calendar_today_outlined,
                  color: Colors.grey.shade700,
                  size: context.sp(20),
                ),
                context.sbW(15),
                AppText(
                  dateOfBirth == null
                      ? "Date of Birth"
                      : DateFormat('MMM dd, yyyy').format(dateOfBirth!),
                  style: TextStyle(
                    color:
                        dateOfBirth == null
                            ? Colors.grey.shade400
                            : AppColors.black800,
                    fontSize: context.sp(14),
                  ),
                ),
              ],
            ),
          ),
        ),
        context.sbH(16),
        CustomTextField(
          controller: passwordController,
          hintText: "Password",
          isPassword: true,
          prefixIcon: Icons.lock_outline,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please enter a password";
            }
            if (value.length < 6) {
              return "Password should be at least 6 characters";
            }
            return null;
          },
        ),
        context.sbH(16),
        CustomTextField(
          controller: confirmPasswordController,
          hintText: "Confirm Password",
          isPassword: true,
          prefixIcon: Icons.lock_outline,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please confirm your password";
            }
            if (value != passwordController.text) {
              return "Passwords do not match";
            }
            return null;
          },
        ),
        context.sbH(36),
        Row(
          children: [
            Expanded(
              child: SecondaryButton(
                onTap: () => setState(() => currentStep = 1),
                text: "Back",
              ),
            ),
            context.sbW(16),
            Expanded(
              child: PrimaryButton(
                isLoading: ref.watch(authNotifierProvider).isLoading,
                onTap: _handleSignUp,
                text: "Create Account",
              ),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _handleSignUp() async {
    if (formKey.currentState?.validate() ?? false) {
      if (dateOfBirth == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please select your date of birth")),
        );
        return;
      }

      final user = UserModel(
        username: usernameController.text.trim(),
        email: emailController.text.trim(),
        firstName: firstNameController.text.trim(),
        lastName: lastNameController.text.trim(),
        dateOfBirth: dateOfBirth!,
        phoneNumber: phoneController.text.trim(),
        password: passwordController.text.trim(),
      );

      await ref.read(authNotifierProvider.notifier).register(user: user);
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(authNotifierProvider, (previous, next) {
      if (next.error != null && context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(CustomSnackbar(message: next.error!));
      }
    });

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            _buildBackgroundBlobs(),
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: context.w(20)),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: context.h(100)),
                      _buildHeader(),
                      context.sbH(40),
                      _buildForm(),
                      if (currentStep == 1) ...[
                        context.sbH(16),
                        SecondaryButton(
                          onTap:
                              () => Navigator.pushReplacementNamed(
                                context,
                                LoginScreen.routeName,
                              ),
                          text: "Already have an account?",
                        ),
                      ],
                      context.sbH(20),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

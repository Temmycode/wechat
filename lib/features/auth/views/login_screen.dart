import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wechat/config/theme/app_colors.dart';
import 'package:wechat/core/utils/app_images.dart';
import 'package:wechat/core/utils/extensions.dart';
import 'package:wechat/core/utils/size_config.dart';
import 'package:wechat/core/widgets/app_text.dart';
import 'package:wechat/core/widgets/custom_snackbar.dart';
import 'package:wechat/core/widgets/primary_button.dart';
import 'package:wechat/core/widgets/secondary_button.dart';
import 'package:wechat/features/auth/controllers/providers/auth_notifier_provider.dart';
import 'package:wechat/features/auth/views/create_account_screen.dart';
import 'package:wechat/features/auth/views/forgot_password_screen.dart';
import 'package:wechat/features/auth/widgets/custom_text_field.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static const String routeName = '/login';

  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen>
    with SingleTickerProviderStateMixin {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late AnimationController _animationController;
  late Animation<double> _xPosition1;
  late Animation<double> _yPosition1;
  late Animation<double> _xPosition2;
  late Animation<double> _yPosition2;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _xPosition1 = Tween<double>(
      begin: -60,
      end: -110,
    ).animate(_animationController);
    _yPosition1 = Tween<double>(
      begin: -240,
      end: -210,
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
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
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
        child: Stack(children: [_buildBackgroundBlobs(), _buildMainContent()]),
      ),
    );
  }

  Widget _buildBackgroundBlobs() {
    return Stack(
      children: [
        AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(_xPosition1.value, _yPosition1.value),
              child: Transform.rotate(
                angle: 140 * (math.pi / 180),
                child: AppImages.blob1.toSvg(height: context.h(442)),
              ),
            );
          },
        ),
        AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(_xPosition2.value, _yPosition2.value),
              child: AppImages.blob3.toSvg(),
            );
          },
        ),
      ],
    );
  }

  Widget _buildMainContent() {
    return SingleChildScrollView(
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
              _buildLoginForm(),
              context.sbH(20),
              _buildButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          "Welcome Back",
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
              "Good to see you again!",
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: context.sp(19),
                color: AppColors.black800,
              ),
            ),
            context.sbW(10.2),
            Icon(Icons.favorite, size: context.sp(15.9)),
          ],
        ),
      ],
    );
  }

  Widget _buildLoginForm() {
    return Column(
      children: [
        CustomTextField(
          controller: emailController,
          hintText: "Email",
          isEmail: true,
          prefixIcon: Icons.email_outlined,
        ),
        context.sbH(16),
        CustomTextField(
          controller: passwordController,
          hintText: "Password",
          isPassword: true,
          prefixIcon: Icons.lock_outline,
        ),
        context.sbH(10),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed:
                () => Navigator.pushNamed(
                  context,
                  ForgotPasswordScreen.routeName,
                ),
            child: AppText(
              "Forgot Password?",
              style: TextStyle(
                fontSize: context.sp(14),
                color: AppColors.blue800,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildButtons() {
    final isLoading = ref.watch(authNotifierProvider).isLoading;

    return Column(
      children: [
        PrimaryButton(onTap: _handleLogin, text: "Login", isLoading: isLoading),
        context.sbH(16),
        SecondaryButton(
          onTap: () {
            Navigator.pushReplacementNamed(
              context,
              CreateAccountScreen.routeName,
            );
          },
          text: "Create New Account",
        ),
      ],
    );
  }

  Future<void> _handleLogin() async {
    if (formKey.currentState?.validate() ?? false) {
      await ref
          .read(authNotifierProvider.notifier)
          .login(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          );
    }
  }
}

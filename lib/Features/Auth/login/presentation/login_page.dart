import 'package:employee_application/Core/constant/colors_constant.dart';
import 'package:employee_application/Core/constant/image_constant.dart';
import 'package:employee_application/Core/error/network_exceptions.dart';
import 'package:employee_application/Core/error/validate.dart';
import 'package:employee_application/Core/extension/navigation_service.dart';
import 'package:employee_application/Core/extension/screen_size_extension.dart';
import 'package:employee_application/Features/Auth/login/Data/Model/login_entity.dart';
import 'package:employee_application/Features/Auth/login/cubit/login_cubit.dart';
import 'package:employee_application/Features/Auth/login/cubit/login_password_visibility_cubit.dart';
import 'package:employee_application/Features/User/transactions_page/presentation/transactions_page.dart';
import 'package:employee_application/Features/Widgets/custom_button.dart';
import 'package:employee_application/Features/Widgets/custom_text.dart';
import 'package:employee_application/Features/Widgets/custom_text_form_field.dart';
import 'package:employee_application/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController loginController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> keyLogin = GlobalKey<FormState>();

  @override
  void dispose() {
    loginController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => LoginPasswordVisibilityCubit()),
        BlocProvider(create: (context) => getIt<LoginCubit>()),
      ],
      child: Scaffold(
        backgroundColor: ColorConstant.deepGreen,
        body: SizedBox(
          width: context.screenWidth,
          height: context.screenHeight,
          child: Form(
            key: keyLogin,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: context.width(160),
                  height: context.height(140),
                  margin: EdgeInsets.only(top: context.height(88)),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(ImageConstant.logo),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                CustomText(
                  text: "تسجيل الدخول",
                  color: ColorConstant.white,
                  size: context.fontSize(24),
                  fontWeight: FontWeight.w400,
                  paddingTop: context.height(64),
                ),
                CustomText(
                  text: "يرجى إدخال بيانات الدخول للوصول إلى النظام",
                  color: ColorConstant.khaki,
                  size: context.fontSize(18),
                  paddingTop: context.height(18),
                ),
                CustomTextFormField(
                  widthFiled: context.width(500),
                  radius: context.width(12),
                  obscureText: false,
                  keyboardType: TextInputType.text,
                  readOnly: false,
                  hintText: "البريد الإلكتروني",
                  fillColor: ColorConstant.whiteLight,
                  controller: loginController,
                  validator: validateRequiredField,
                  fontSizeInput: context.fontSize(16),
                  suffix: Icon(
                    Icons.person,
                    size: context.iconSize(28),
                    color: ColorConstant.deepGreen,
                  ),
                  paddingTop: context.height(88),
                ),
                BlocBuilder<LoginPasswordVisibilityCubit, bool>(
                  builder: (context, isObscure) {
                    return CustomTextFormField(
                      widthFiled: context.width(500),
                      radius: context.width(12),
                      obscureText: isObscure,
                      keyboardType: TextInputType.text,
                      readOnly: false,
                      hintText: "كلمة المرور",
                      fillColor: ColorConstant.whiteLight,
                      controller: passwordController,
                      validator: validateRequiredField,
                      fontSizeInput: context.fontSize(16),
                      suffix: GestureDetector(
                        onTap: () => context
                            .read<LoginPasswordVisibilityCubit>()
                            .toggle(),
                        child: Icon(
                          isObscure ? Icons.visibility_off : Icons.visibility,
                          size: context.iconSize(26),
                          color: ColorConstant.deepGreen,
                        ),
                      ),
                      paddingTop: context.height(18),
                    );
                  },
                ),
                BlocConsumer<LoginCubit, LoginState>(
                  listener: (context, state) {
                    state.whenOrNull(
                      error: (NetworkExceptions networkExceptions) =>
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              margin: EdgeInsetsDirectional.symmetric(
                                horizontal: context.width(18),
                              ),
                              content: Text(
                                NetworkExceptions.getErrorMessage(
                                  networkExceptions,
                                ),
                              ),
                              backgroundColor: Colors.red,
                              behavior: SnackBarBehavior.floating,
                            ),
                          ),
                      success: (LoginEntity loginEntity) {
                        context.pushAndRemoveUntil(
                          TransactionsPage(
                            nameUser: loginEntity.nameUser,
                            imageUserUrl: loginEntity.imageUserUrl,
                            governmentEntityUser:
                                loginEntity.governmentEntityUser,
                          ),
                        );
                      },
                    );
                  },
                  builder: (context, state) {
                    final isLoading = state.maybeWhen(
                      loading: () => true,
                      orElse: () => false,
                    );
                    return CustomButton(
                      topPadding: context.height(100),
                      leftPadding: 0,
                      rightPadding: 0,
                      widthButton: context.width(220),
                      heightButton: context.height(64),
                      colorButton: ColorConstant.khaki,
                      raduisButton: context.width(12),
                      onTap: isLoading
                          ? null
                          : () {
                              if (keyLogin.currentState!.validate()) {
                                context.read<LoginCubit>().fakEmitLogin(
                                  loginController.text,
                                  passwordController.text,
                                );
                              }
                            },
                      child: isLoading
                          ? SizedBox(
                              width: context.width(24),
                              height: context.width(24),
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: ColorConstant.deepGreen,
                                  strokeWidth: context.width(3),
                                ),
                              ),
                            )
                          : CustomText(
                              text: "تسجيل الدخول",
                              color: ColorConstant.deepGreen,
                              size: context.fontSize(18),
                              fontWeight: FontWeight.bold,
                            ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

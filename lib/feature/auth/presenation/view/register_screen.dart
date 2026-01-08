import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/core/dialogs/app_dialogs.dart';
import 'package:tasky/core/dialogs/app_toasts.dart';
import 'package:tasky/core/utils/validator.dart';
import 'package:tasky/core/common/widgets/bottomtextwidget.dart';
import 'package:tasky/core/common/widgets/custom_textfield.dart';
import 'package:tasky/feature/auth/domain/usescases/login_use_case.dart';
import 'package:tasky/feature/auth/domain/usescases/register_usecase.dart';
import 'package:tasky/feature/auth/presenation/view_model/auth_cubit.dart';
import 'package:tasky/feature/auth/presenation/view_model/auth_state.dart';
import 'package:tasky/feature/home/presentation/view/home_screen.dart';
import 'package:toastification/toastification.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  static const String routeName = "RegisterScreen";

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formkey = GlobalKey<FormState>();
  late final TextEditingController emailcontroller;
  late final TextEditingController passwordcontroller;
  late final TextEditingController usernamecontroller;
  late final TextEditingController confirmPassword;
  late final AuthCubit _authCubit;

  @override
  void initState() {
    super.initState();
    usernamecontroller = TextEditingController();
    emailcontroller = TextEditingController();
    passwordcontroller = TextEditingController();
    confirmPassword = TextEditingController();
    // بنجهز الـ Cubit هنا
    _authCubit = AuthCubit(injectableloginUseCase(), injectableregisterUseCase());
  }

  @override
  void dispose() {
    usernamecontroller.dispose();
    emailcontroller.dispose();
    passwordcontroller.dispose();
    confirmPassword.dispose();
    _authCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _authCubit,
      child: Scaffold(
        body: BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is LoadingState) {
              AppDialogs.showLoadingDialog(context);
            } else if (state is ErrorSate) {
              Navigator.of(context, rootNavigator: true).pop(); // إغلاق الـ Loading
              AppToast.showToast(
                context: context,
                title: "Error",
                description: state.ErrorMessage,
                type: ToastificationType.error,
              );
            } else if (state is SucessState) {
              Navigator.of(context, rootNavigator: true).pop(); // إغلاق الـ Loading

              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
                    (route) => false,
              );
            }
          },
          child: SafeArea(
            child: Form(
              key: _formkey,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 50, bottom: 50),
                        child: Text("Register", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                      ),
                      const Text("UserName", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
                      const SizedBox(height: 10),
                      TextFormFieldWidget(
                        hintText: "Enter your username",
                        controller: usernamecontroller,
                        keyboardType: TextInputType.name,
                        validator: Validator.validateName,
                      ),
                      const SizedBox(height: 20),
                      const Text("Email", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
                      const SizedBox(height: 10),
                      TextFormFieldWidget(
                        hintText: "Enter your email",
                        controller: emailcontroller,
                        keyboardType: TextInputType.emailAddress,
                        validator: Validator.validateEmail,
                      ),
                      const SizedBox(height: 30),
                      const Text("Password", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
                      const SizedBox(height: 10),
                      TextFormFieldWidget(
                        hintText: "Password",
                        controller: passwordcontroller,
                        validator: Validator.validatePassword,
                        obscureText: true,
                        isPassword: true,
                      ),
                      const SizedBox(height: 20),
                      const Text("Confirm Password", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
                      const SizedBox(height: 10),
                      TextFormFieldWidget(
                        hintText: "Enter confirm password",
                        controller: confirmPassword,
                        isPassword: true,
                        obscureText: true,
                        validator: (val) => Validator.validateConfirmPassword(val, passwordcontroller.text),
                      ),
                      const SizedBox(height: 30),
                      Builder(
                          builder: (btnContext) {
                            return MaterialButton(
                              onPressed: () {
                                if (_formkey.currentState!.validate()) {
                                  btnContext.read<AuthCubit>().register(
                                    name: usernamecontroller.text,
                                    email: emailcontroller.text,
                                    password: passwordcontroller.text,
                                  );
                                }
                              },
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              minWidth: double.infinity,
                              color: const Color(0xff5F33E1),
                              child: const Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Text("Register", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white)),
                              ),
                            );
                          }
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Bottomtextwidget(
            title: "Already Have an Account?",
            subtitle: "Login",
            ontap: () => Navigator.of(context).pushNamed("LoginScreen"),
          ),
        ),
      ),
    );
  }
}
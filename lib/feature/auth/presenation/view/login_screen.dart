
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

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const String routeName = "LoginScreen";
  @override
  State<LoginScreen> createState() => _Login_ScreenState();
}

class _Login_ScreenState extends State<LoginScreen> {
late  final TextEditingController emailcontroller;
 late final TextEditingController passwordcontroller;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  late final AuthCubit cubit;
  @override
  void initState() {
    super.initState();
    emailcontroller=TextEditingController();
    passwordcontroller=TextEditingController();
    cubit=AuthCubit(injectableloginUseCase(), injectableregisterUseCase());
  }

  @override
  void dispose() {
    emailcontroller.dispose();
    passwordcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthCubit,AuthState>(
       bloc: cubit,
        listener: (context,state){
          if (state is LoadingState) {
            AppDialogs.showLoadingDialog(context);
          } else if (state is ErrorSate) {
            Navigator.pop(context); // close loading dialog
            AppToast.showToast(
              context: context,
              title: "Error",
              description: state.ErrorMessage, type:ToastificationType.error,
            );
          } else if (state is SucessState) {
            Navigator.of(context).pushNamedAndRemoveUntil(
                HomeScreen.routeName, (route) => false);
          }
        },
        child: SafeArea(
          child: Form(
            key: _formkey,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 110, bottom: 50),
                    child: const Text(
                      "Login",
                      style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                  ),

                  // Email
                  const Text(
                    "Email",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 10),
                  TextFormFieldWidget(
                    hintText: "enter username",
                    controller: emailcontroller,
                    validator: Validator.validateEmail,
                  ),
                  const SizedBox(height: 30),

                  // Password
                  const Text(
                    "Password",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 10),
                  TextFormFieldWidget(
                    hintText: "Password",
                    controller: passwordcontroller,
                    validator: Validator.validatePassword,
                    obscureText: true,
                    isPassword: true,
                  ),
                  const SizedBox(height: 30),

                  // Login Button
                  MaterialButton(
                    onPressed:()async{
                      if (_formkey.currentState!.validate()) {
                        await cubit.login(
                            email: emailcontroller.text,
                            password: passwordcontroller.text);
                      }
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    minWidth: double.infinity,
                    color: const Color(0xff5F33E1),
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Color(0xffFFFFFF),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),

      // Bottom Text
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Bottomtextwidget(
          title: "Don't Have an Account?",
          subtitle: "Register",
          ontap: () {
            Navigator.of(context).pushNamed("RegisterScreen");
          },
        ),
      ),
    );
  }

 /* void onpressedlogin() async {
    if (_formkey.currentState!.validate()) {
      AppDialog.showloading(context);

      final reslut = await FBFSAuthUser.loginuser(
          email: emailcontroller.text, pawword: passwordcontroller.text);

      switch (reslut) {
        case SucessFB<UserCredential>():
          Navigator.of(context).pop();
          emailcontroller.clear();
          passwordcontroller.clear();
          Navigator.pushNamed(context, 'HomeScreen');
        case ErrorFB<UserCredential>():
          Navigator.of(context).pop();
          AppDialog.showerror(context, error: reslut.toString());
      }
    }
  }*/
}

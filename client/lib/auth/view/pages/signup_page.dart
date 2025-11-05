import 'package:client/auth/view/pages/login_page.dart';
import 'package:client/auth/view/widgets/auth_gradient_button.dart';
import 'package:client/auth/viewmodel/auth_viewmodel.dart';
import 'package:client/core/theme/app_pallete.dart';
import 'package:client/core/widgets/custom_textfield.dart';
import 'package:client/core/widgets/loading_indicator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils.dart';

class SignupPage extends ConsumerStatefulWidget {
  const SignupPage({super.key});

  @override
  ConsumerState<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends ConsumerState<SignupPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>(); // storing the state of the form

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
    formKey.currentState!.validate();
  }

  @override
  Widget build(BuildContext context) {
    // Check Loading state whether it is doing or not.
    final isLoading = ref
        .watch(authViewModelProvider.select((val) => val?.isLoading == true));
    //listen for handling error or data. and loading
    ref.listen(
      authViewModelProvider,
      (_, next) {
        next?.when(
          data: (data) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(const SnackBar(
                content: Text('Account already Create, please login'),
              ));
            // whenever there is data, navigate from signup to login page
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginPage(),
                ));
          },
          error: (error, st) {
            showSnackBar(context, error.toString());
          },
          loading: () {
            // loading is not implemented here, because for loading part I want to
            // return a widget and it is not possible here.
            // return type of listen is void so it is not possible to return a widget
            // here.
          },
        );
      },
    );

    // see the state values
    return Scaffold(
      appBar: AppBar(),
      resizeToAvoidBottomInset: true,
      body: isLoading
          ? const LoadingIndicator()
          : SingleChildScrollView(
              // 👈 makes content scrollable
              padding: const EdgeInsets.all(15.0),
              child: Center(
                  // keeps it centered horizontally
                  child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),
                    const Text(
                      'Sign Up.',
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 30),
                    CustomField(
                      hintText: 'Name',
                      controller: nameController,
                    ),
                    const SizedBox(height: 15),
                    CustomField(
                      hintText: 'Email',
                      controller: emailController,
                    ),
                    const SizedBox(height: 15),
                    CustomField(
                      hintText: 'Password',
                      controller: passwordController,
                      isObscure: true,
                    ),
                    const SizedBox(height: 20),
                    AuthGradientButton(
                      text: "SIGN UP",
                      onTap: () async {
                        // call authViewModel here
                        // formkey checks if the form is not empty
                        if (formKey.currentState!.validate()) {
                          //here provider read values
                          await ref
                              .read(authViewModelProvider.notifier)
                              .signUpUser(
                                name: nameController.text,
                                email: emailController.text,
                                password: passwordController.text,
                              );
                        } else {
                          showSnackBar(context, 'Missing Fields.');
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                    RichText(
                      text: TextSpan(
                        text: "Already have an account? ",
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: Colors.white,
                                ),
                        children: [
                          TextSpan(
                            text: "Sign In",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Pallete.gradient2,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const LoginPage()),
                                );
                              },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              )),
            ),
    );
  }
}

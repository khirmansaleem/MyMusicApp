import 'package:client/auth/view/pages/signup_page.dart';
import 'package:client/auth/view/widgets/auth_gradient_button.dart';
import 'package:client/auth/viewmodel/auth_viewmodel.dart';
import 'package:client/core/theme/app_pallete.dart';
import 'package:client/core/utils.dart';
import 'package:client/core/widgets/custom_textfield.dart';
import 'package:client/core/widgets/loading_indicator.dart';
import 'package:client/home/view/pages/home_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>(); // storing the state of the form
  late final removeListener;

  @override
  void initState() {
    //listen for handling error or data. and loading
    removeListener = ref.listenManual(
      authViewModelProvider,
      (_, next) {
        next?.when(
          data: (data) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(const SnackBar(
                content: Text('User is successfully logged in. '),
              ));
            // navigate to homePage when user is logged In.
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
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
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    formKey.currentState!.validate();
    removeListener(); // Very important
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // widget is only loaded if the value of isLoading changes in authViewModel Provider
    final authState = ref.watch(authViewModelProvider);
    debugPrint('the auth state  is $authState');
    final isLoading = authState?.isLoading ?? false;

    return Scaffold(
      appBar: AppBar(),
      resizeToAvoidBottomInset: true,
      body: isLoading
          ? const LoadingIndicator()
          : SingleChildScrollView(
              //  makes content scrollable
              padding: const EdgeInsets.all(15.0),
              child: Center(
                  // keeps it centered horizontally
                  child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 50),
                    const Text(
                      'Sign In.',
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 30),
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
                      text: "SIGN IN",
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          await ref
                              .read(authViewModelProvider.notifier)
                              .LoginUser(
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
                        text: "Don't have an account? ",
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: Colors.white,
                                ),
                        children: [
                          TextSpan(
                            text: "Sign Up",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Pallete.gradient2,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const SignupPage()),
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

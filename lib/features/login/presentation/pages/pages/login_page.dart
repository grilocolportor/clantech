import 'package:clan_track/features/login/presentation/widgets/my_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/signup_bloc.dart';
import '../../widgets/my_button.dart';
import '../../widgets/square_tile.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  // text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final nameController = TextEditingController();

  // sign user in method
  signUserIn(BuildContext context) {
    context.read<AuthCubit>().signInWithEmailAndPassword(
        email: emailController.text, password: passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var fontSize = MediaQuery.of(context).textScaleFactor;
    return Center(
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, authState) {
          bool isSignup = context.watch<AuthCubit>().isSignup ;
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: size.height * 0.1),

              // logo
              Icon(
                Icons.lock,
                size: size.height * 0.09,
              ),

              SizedBox(height: size.height * 0.05),

              // welcome back, you've been missed!
              Text(
                'Welcome back you\'ve been missed!',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: fontSize * 20,
                ),
              ),

              SizedBox(height: size.height * 0.05),

              // username textfield
              MyTextField(
                controller: emailController,
                hintText: 'Email',
                obscureText: false,
              ),

              SizedBox(height: size.height * 0.01),

              // password textfield
              MyTextField(
                controller: passwordController,
                hintText: 'Password',
                obscureText: true,
              ),

              SizedBox(height: size.height * 0.01),

              AnimatedContainer(
                height: context.watch<AuthCubit>().isSignup
                    ? size.height * 0.18
                    : 0,
                duration: const Duration(milliseconds: 500),
                child: Column(
                  children: [
                    Expanded(
                      child: MyTextField(
                        controller: confirmPasswordController,
                        hintText: 'Email',
                        obscureText: false,
                      ),
                    ),
                    Expanded(
                      child: MyTextField(
                        controller: passwordController,
                        hintText: 'Password',
                        obscureText: true,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: size.height * 0.03),

              // forgot password?
              context.watch<AuthCubit>().isSignup
                  ? const SizedBox()
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Forgot Password?',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    ),

              SizedBox(height: size.height * 0.03),

              // sign in button
              MyButton(
                title:
                    context.watch<AuthCubit>().isSignup ? 'Sign Up' : 'Sign In',
                onTap: () async {
                  isSignup
                      ? 
                          await context
                              .read<AuthCubit>()
                              .createUserWithEmailAndPassword(
                                  email: emailController.text,
                                  password: passwordController.text)
                        
                      : await  context.read<AuthCubit>().signInWithEmailAndPassword(
                          email: emailController.text,
                          password: passwordController.text);
                  
                },
              ),

              SizedBox(height: size.height * 0.03),

              // or continue with
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 10.0),
              //   child: Row(
              //     children: [
              //       Expanded(
              //         child: Divider(
              //           thickness: 0.5,
              //           color: Colors.grey[400],
              //         ),
              //       ),
              //       Padding(
              //         padding: const EdgeInsets.symmetric(horizontal: 5.0),
              //         child: Text(
              //           'Or continue with',
              //           style: TextStyle(color: Colors.grey[700]),
              //         ),
              //       ),
              //       Expanded(
              //         child: Divider(
              //           thickness: 0.5,
              //           color: Colors.grey[400],
              //         ),
              //       ),
              //     ],
              //   ),
              // ),

              // SizedBox(height: size.height * 0.02),

              // google + apple sign in buttons
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     // google button
              //     InkWell(
              //         onTap: () {
              //           // context.read<AuthCubit>().signOut();
              //         },
              //         child:
              //             const SquareTile(imagePath: 'assets/images/google.png')),

              //     const SizedBox(width: 25),

              //     // apple button
              //     const InkWell(
              //         child: SquareTile(imagePath: 'assets/images/apple.png'))
              //   ],
              // ),

              SizedBox(height: size.height * 0.02),

              // not a member? register now
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    context.watch<AuthCubit>().isSignup
                        ? 'Aready member?'
                        : 'Not a member?',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  const SizedBox(width: 4),
                  InkWell(
                    onTap: () {
                      context.read<AuthCubit>().setIsSignup();
                    },
                    child: Text(
                      context.watch<AuthCubit>().isSignup
                          ? 'Sign In'
                          : 'Register now',
                      style: const TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              )
            ],
          );
        },
      ),
    );
  }
}

import 'package:clan_track/features/login/presentation/widgets/my_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../widgets/my_button.dart';
import '../../widgets/square_tile.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  // text editing controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  // sign user in method
  void signUserIn() {}

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var fontSize = MediaQuery.of(context).textScaleFactor;
    return Center(
      child: Column(
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
            controller: usernameController,
            hintText: 'Username',
            obscureText: false,
          ),

          SizedBox(height: size.height * 0.01),

          // password textfield
          MyTextField(
            controller: passwordController,
            hintText: 'Password',
            obscureText: true,
          ),

          SizedBox(height: size.height * 0.03),

          // forgot password?
          Padding(
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
            onTap: signUserIn,
          ),

          SizedBox(height: size.height * 0.03),

          // or continue with
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              children: [
                Expanded(
                  child: Divider(
                    thickness: 0.5,
                    color: Colors.grey[400],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Text(
                    'Or continue with',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                ),
                Expanded(
                  child: Divider(
                    thickness: 0.5,
                    color: Colors.grey[400],
                  ),
                ),
              ],
            ),
          ),
 
          SizedBox(height: size.height * 0.02),

          // google + apple sign in buttons
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // google button
              SquareTile(imagePath: 'assets/images/google.png'),

              SizedBox(width: 25),

              // apple button
              SquareTile(imagePath: 'assets/images/apple.png')
            ],
          ),

          SizedBox(height: size.height * 0.02),

          // not a member? register now
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Not a member?',
                style: TextStyle(color: Colors.grey[700]),
              ),
              const SizedBox(width: 4),
              const Text(
                'Register now',
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

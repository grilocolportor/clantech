import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/signup_bloc.dart';
import 'pages/login_page.dart';

class AuthView extends StatelessWidget {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          if (state is AuthInitial) {
            return buildInitialUI(); // Replace with your initial UI
          } else if (state is AuthLoading) {
            return buildLoadingUI(); // Replace with your loading UI
          } else if (state is AuthError) {
            return buildErrorUI(state.error); // Replace with your error UI
          } else if (state is AuthAuthenticated) {
            return buildAuthenticatedUI(
                context, state.user); // Replace with your authenticated UI
          } else {
            return buildInitialUI(); // Default to the initial UI
          }
        },
      ),
    );
  }

  Widget buildInitialUI() {
    return SingleChildScrollView(child: LoginPage());
  }

  Widget buildLoadingUI() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildErrorUI(String errorMessage) {
    return Center(
      child: Text('Error: $errorMessage'),
    );
  }

  Widget buildAuthenticatedUI(BuildContext context, User user) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Authenticated as ${user.email}'),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Implement sign out logic
              context.read<AuthCubit>().signOut();
            },
            child: Text('Sign Out'),
          ),
        ],
      ),
    );
  }
}

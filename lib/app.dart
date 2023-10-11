import 'package:clan_track/features/login/presentation/pages/aut_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/config/app_strings.dart';
import 'core/config/themes/theme_data.dart';
import 'features/login/presentation/blocs/signup_bloc.dart';

class ClanTracker extends StatefulWidget {
  const ClanTracker({super.key});

  @override
  State<ClanTracker> createState() => _ClanTrackerState();
}

class _ClanTrackerState extends State<ClanTracker> {
  final AuthCubit authCubit = AuthCubit();
  bool isDarkTheme = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      color: Theme.of(context).colorScheme.background,
      theme: isDarkTheme
          ? darkTheme
          : lightTheme,
      home: BlocProvider(
        create: (context) => authCubit,
        child: const AuthView(),
      ),
    );
  }
}

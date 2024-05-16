import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'preferences_cubit.dart';
import 'preferences_view.dart';

class PreferencesPage extends StatelessWidget {
  const PreferencesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Preferences Page",
      home: BlocProvider(
      create: (context) => PreferencesCubit(),
      child: const PreferencesView(),
    ),
    ) ;
    
  }
}

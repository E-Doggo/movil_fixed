import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyecto_progra_movil/register/ui/bloc_builder.dart';
import 'package:proyecto_progra_movil/register/bloc/register_bloc.dart';
import 'package:proyecto_progra_movil/register/data_source/register_data_source.dart';
import 'package:proyecto_progra_movil/register/repository/register_repository.dart';

class RegisterProvider extends StatelessWidget {
  const RegisterProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          RegisterBloc(registerRepo: RegisterRepo(dataSource: RegDataSource())),
      child: const RegisterScreen(),
    );
  }
}

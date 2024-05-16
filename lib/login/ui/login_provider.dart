import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyecto_progra_movil/login/bloc/login_bloc.dart';

import 'package:proyecto_progra_movil/login/ui/login_builder.dart';
import 'package:proyecto_progra_movil/login/data_source/login_source.dart';
import 'package:proyecto_progra_movil/login/repository/login_repository.dart';

class LoginProvider extends StatelessWidget {
  const LoginProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          LoginBloc(loginRepo: LoginRepo(loginDataSource: DataSource())),
      child: const LoginScreenNew(),
    );
  }
}

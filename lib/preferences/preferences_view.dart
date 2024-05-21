import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:proyecto_progra_movil/firebase_auth_implementation/firebase_auth_services.dart';
import 'package:proyecto_progra_movil/firebase_auth_implementation/firebase_firestore.dart';
import 'preferences_cubit.dart';
import 'comida.dart';

class PreferencesView extends StatelessWidget {
  const PreferencesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PreferencesCubit preferencesCubit =
        BlocProvider.of<PreferencesCubit>(context);
    final FireStore DB = FireStore();
    final FireBaseAuthService auth = FireBaseAuthService();

    Future<String?> _getCurrentEmail() async {
      final response = await auth.getCurrentUser();
      if (response != null) {
        return response.toString();
      } else {
        print("Error al cargar email");
      }
    }
    // Llama a _getCurrentEmail() para obtener el usuario actual

    final List<Comida> foodPreferences = [
      Comida(
          nombre: 'Italiana', imagenUrl: 'assets/images/opcion-italiana.jpg'),
      Comida(
          nombre: 'Mexicana', imagenUrl: 'assets/images/opcion-mexicana.jpg'),
      Comida(nombre: 'China', imagenUrl: 'assets/images/opcion-china.jpg'),
      Comida(
          nombre: 'Japonesa', imagenUrl: 'assets/images/opcion-japonesa.jpg'),
      Comida(
          nombre: 'Vegetariana',
          imagenUrl: 'assets/images/opcion-vegetariana.jpg'),
    ];

    return BlocBuilder<PreferencesCubit, List<String>>(
      builder: (context, selectedPreferences) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'ESCOGE TUS PREFERENCIAS',
              style: TextStyle(
                color: const Color.fromRGBO(89, 206, 143, 1),
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: Container(
            padding: EdgeInsets.all(10.0),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
              ),
              itemCount: foodPreferences.length,
              itemBuilder: (context, index) {
                final comida = foodPreferences[index];
                final isSelected = selectedPreferences.contains(comida.nombre);
                return GestureDetector(
                  onTap: () {
                    preferencesCubit.togglePreference(comida.nombre);
                  },
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    color: isSelected ? Colors.blue : Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          comida.imagenUrl,
                          height: 300,
                          width: 300,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(height: 10),
                        Text(
                          comida.nombre,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          floatingActionButton: Container(
            margin: EdgeInsets.all(10.0),
            child: FloatingActionButton(
              onPressed: () async {
                // Imprimir las preferencias seleccionadas en la consola
                final email = await _getCurrentEmail();
                print(email);
                print(selectedPreferences);
                await DB.uploadPreferences(email, selectedPreferences);
                context.go("/mainPage");
              },
              child: Icon(Icons.check),
            ),
          ),
        );
      },
    );
  }
}

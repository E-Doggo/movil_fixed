import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:proyecto_progra_movil/app_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'RUTA GOURMET'),
      body: Stack(
        children: [
          // Imagen de fondo
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/images/silpancho-background-homepage.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            children: [
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 150.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () => context.go("/login"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromRGBO(89, 206, 143, 1),
                          fixedSize: const Size(300, 60),
                        ),
                        child: const Text(
                          'Iniciar Sesion',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () => context.go("/register"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromRGBO(89, 206, 143, 1),
                          fixedSize: const Size(300, 60),
                        ),
                        child: const Text(
                          'Registrarse',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

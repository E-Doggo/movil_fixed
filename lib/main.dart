import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:proyecto_progra_movil/home_page.dart';
import 'package:proyecto_progra_movil/login/ui/login_provider.dart';
import 'package:proyecto_progra_movil/maps_restaurant/ui/restaurant_provider.dart';
import 'package:proyecto_progra_movil/maps_screen/ui/maps_provider.dart';
import 'package:proyecto_progra_movil/preferences/preferences_screen.dart';
import 'package:proyecto_progra_movil/register/ui/bloc_provider.dart';
import 'firebase_options.dart';

//custom MENU icon
const IconData menu = IconData(0xe3dc, fontFamily: 'MaterialIcons');

Future main() async {
  await dotenv.load(fileName: "assets/env");

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const HomePage();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'register',
          builder: (BuildContext context, GoRouterState state) {
            return const RegisterProvider();
          },
        ),
        GoRoute(
          path: 'login',
          builder: (BuildContext context, GoRouterState state) {
            return const LoginProvider();
          },
        ),
        GoRoute(
          path: 'preferences',
          builder: (BuildContext context, GoRouterState state) {
            return const PreferencesPage();
          },
        ),
        GoRoute(
            path: 'mainPage',
            builder: (BuildContext context, GoRouterState state) {
              return const MapProvider();
            },
            routes: <RouteBase>[
              GoRoute(
                name: "restaurant-info",
                path: 'restaurant-info',
                builder: (BuildContext context, GoRouterState state) {
                  return const RestaurantProvider();
                },
              ),
            ]),
      ],
    ),
  ],
);

ThemeData defaultTheme = ThemeData(
    // fontFamily: 'Pangolin',
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color.fromRGBO(89, 206, 143, 1),
      brightness: Brightness.light,
    ),
    primaryColor: Colors.lightGreenAccent,
    appBarTheme: const AppBarTheme(
        color: Color.fromRGBO(89, 206, 143, 1),
        iconTheme: IconThemeData(color: Colors.white)),
    textTheme: const TextTheme(
        displayLarge: TextStyle(
      fontSize: 72,
      fontWeight: FontWeight.bold,
    )));

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: defaultTheme,
      routerConfig: _router,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: HomePage(),
    );
  }
}

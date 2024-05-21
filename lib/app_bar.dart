import 'package:flutter/material.dart';


class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({super.key, required this.title});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 36.0,
          fontStyle: FontStyle.italic,
          color: Colors.white,
          decoration: TextDecoration.none,
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 89, 206, 144),
      centerTitle: true,
      automaticallyImplyLeading: true,
    );
  }
}
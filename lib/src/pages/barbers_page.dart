import 'package:flutter/material.dart';

class BarbersPage extends StatelessWidget {
  const BarbersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Barberos"),
      ),
      body: const Center(child: Text("Barberos Page"),),
    );
  }
}
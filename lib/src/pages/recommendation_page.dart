import 'package:flutter/material.dart';

class RecommendationPage extends StatelessWidget {
  const RecommendationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Recomendacion"),
      ),
      body: const Center(child: Text("Recomendacion Page"),),
    );
  }
}
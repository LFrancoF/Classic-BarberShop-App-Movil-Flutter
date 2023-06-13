import 'package:flutter/material.dart';

import 'package:app_classic/src/widgets/option_button.dart';
import 'package:app_classic/src/widgets/sidebar_menu.dart';
import 'package:app_classic/src/routes/routes.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bienvenido a Classic"),
      ),
      drawer: const SidebarMenu(),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          OptionButton(
            texto: "Clientes",
            
            onPress: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => pageRoutes[1].page,));
            },
          ),
          OptionButton(
            texto: "Barberos",
            color1: const Color.fromARGB(255, 248, 157, 39),
            color2: const Color.fromARGB(255, 85, 11, 6),
            onPress: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => pageRoutes[2].page,));
            },
          ),
          OptionButton(
            texto: "Servicios",
            
            onPress: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => pageRoutes[3].page,));
            },
          ),
          OptionButton(
            texto: "Recomendacion",
            color1: const Color.fromARGB(255, 248, 157, 39),
            color2: const Color.fromARGB(255, 85, 11, 6),
            onPress: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => pageRoutes[4].page,));
            },
          ),
          OptionButton(
            texto: "Citas",
            
            onPress: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => pageRoutes[5].page,));
            },
          ),
          OptionButton(
            texto: "Reportes",
            color1: const Color.fromARGB(255, 248, 157, 39),
            color2: const Color.fromARGB(255, 85, 11, 6),
            onPress: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => pageRoutes[6].page,));
            },
          ),
        ],
      ),
    );
  }
}
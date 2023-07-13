import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_classic/src/services/services.dart';

import 'package:app_classic/src/widgets/option_button.dart';
import 'package:app_classic/src/widgets/sidebar_menu.dart';
import 'package:app_classic/src/routes/routes.dart';

import '../share_preferences/user.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<ServicesService>(context);
    Provider.of<BarberService>(context);
    Provider.of<CategoriesService>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bienvenido a Classic"),
      ),
      drawer: const SidebarMenu(),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          OptionButton(
            texto: "Ver Servicios",
            onPress: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => pageRoutes[2].page,));
            },
          ),
          OptionButton(
            texto: "Recomendacion",
            onPress: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => pageRoutes[3].page,));
            },
          ),
          OptionButton(
            texto: "Agendar Cita",
            onPress: () {
              User.formRecomend = '';
              Navigator.push(context, MaterialPageRoute(builder: (context) => pageRoutes[4].page,));
            },
          ),
        ],
      ),
    );
  }
}
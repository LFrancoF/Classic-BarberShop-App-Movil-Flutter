import 'package:flutter/material.dart';
import 'package:app_classic/src/pages/pages.dart';
import 'package:app_classic/src/services/services.dart';
import 'package:app_classic/src/widgets/widgets.dart';
import 'package:app_classic/src/routes/routes.dart';
import 'package:app_classic/src/theme/theme.dart';
import 'package:provider/provider.dart';

class ListRecomendPage extends StatelessWidget {
   
  const ListRecomendPage({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    final String imagen = ModalRoute.of(context)!.settings.arguments as String;

    final servicesService = Provider.of<ServicesService>(context);

    final appTheme = Provider.of<ThemeChanger>(context);

    if (servicesService.isLoading){
      return const LoadingPage();
    }

    final services = servicesService.services;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Servicios Recomendados'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 200, 
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 50, top: 20),
                  width: 200, 
                  height: 200, 
                  child: FadeInImage(
                    placeholder: const AssetImage('assets/jar-loading.gif'), 
                    image: NetworkImage(imagen),
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 10),
                  child: const Text('Foto analizada'),
                )
              ],
            ),
          ),
          const Divider(
            color: Colors.black, // Color de la línea
            thickness: 1, // Grosor de la línea
            indent: 20, // Sangría izquierda
            endIndent: 20, // Sangría derecha
          ),
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: services.length,
              itemBuilder: (_, index) => GestureDetector(
                child: ServiceCard(service: services[index]),
                ),
              
            ),
          )
        ],
      ),
      drawer: const SidebarMenu(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: appTheme.currentTheme.primaryColor,
        onPressed: () {
          
          Navigator.push(context, MaterialPageRoute(builder: (context) => pageRoutes[7].page));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
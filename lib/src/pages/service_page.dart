import 'package:flutter/material.dart';
import 'package:app_classic/src/widgets/widgets.dart';
import 'package:app_classic/src/services/services.dart';
import 'package:app_classic/src/routes/routes.dart';
import 'package:app_classic/src/theme/theme.dart';
import 'package:provider/provider.dart';

class ServicePage extends StatelessWidget {
  const ServicePage({super.key});

  @override
  Widget build(BuildContext context) {

    final appTheme = Provider.of<ThemeChanger>(context);

    final servicesService = Provider.of<ServicesService>(context);
    final service = servicesService.selectedService;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles'),
      ),
      drawer: const SidebarMenu(),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        scrollDirection : Axis.vertical,
        children: [
          SizedBox(
            width: double.infinity,
            height: 500,
            child: service.imagen == null 
            ? const Image(image: AssetImage('assets/no-image.png'), fit: BoxFit.contain,)
            : FadeInImage(
              placeholder: const AssetImage('assets/jar-loading.gif'), 
              image: NetworkImage(service.imagen!),
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 10),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            margin: const EdgeInsets.all(5),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  service.nombre!,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          const SizedBox(height: 5),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            margin: const EdgeInsets.all(5),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  'cat: ${service.categoria}',
                  style: const TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
                ),
              ),
            ),
          ),
          const SizedBox(height: 5),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            margin: const EdgeInsets.all(5),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  '${service.descripcion}',
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ),
          ),
          const SizedBox(height: 5),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            margin: const EdgeInsets.all(5),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  'Bs. ${service.precio.toString()}',
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ),
          ),
          const SizedBox(height: 5),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            margin: const EdgeInsets.all(5),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  'duracion aprox: ${service.duracion! ~/ 60} h - ${service.duracion! % 60} m',
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ),
          ),
          const SizedBox(height: 5),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: appTheme.currentTheme.primaryColor,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => pageRoutes[4].page));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
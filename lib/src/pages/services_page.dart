import 'package:flutter/material.dart';
import 'package:app_classic/src/pages/pages.dart';
import 'package:app_classic/src/services/services.dart';
import 'package:app_classic/src/widgets/widgets.dart';
import 'package:app_classic/src/routes/routes.dart';
import 'package:provider/provider.dart';

class ServicesPage extends StatelessWidget {
   
  const ServicesPage({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    final servicesService = Provider.of<ServicesService>(context);

    if (servicesService.isLoading){
      return const LoadingPage();
    }

    final services = servicesService.services;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Servicios'),
        centerTitle: true,
      ),
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: services.length,
        itemBuilder: (_, index) => GestureDetector(
          child: ServiceCard(service: services[index]),
          onTap: () {
            servicesService.selectedService = services[index].copy();
            Navigator.push(context, MaterialPageRoute(builder: (context) => pageRoutes[5].page));
          }
          ),
        
      ),
      drawer: const SidebarMenu()
    );
  }
}
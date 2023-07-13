import 'package:app_classic/src/models/models.dart';
import 'package:flutter/material.dart';
import 'package:app_classic/src/theme/theme.dart';
import 'package:provider/provider.dart';

class ServiceCard extends StatelessWidget {
  
  final Service service;

  const ServiceCard({super.key, required this.service});

  @override
  Widget build(BuildContext context) {

    final appTheme = Provider.of<ThemeChanger>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        margin: const EdgeInsets.only(top: 30, bottom: 50),
        width: double.infinity, height: 400,
        decoration: _cardBorders(appTheme),
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            _BackgroundImage(service.imagen),
            _ServiceDetails(name: service.nombre!, categoria: service.categoria!),
            Positioned(
              top: 0, right: 0,
              child: _PriceTag(price: service.precio!)
            ),
          ],
        ),
      ),
    );
  }

  BoxDecoration _cardBorders(appTheme) => BoxDecoration(
    color: appTheme.currentTheme.primaryColor,
    borderRadius: BorderRadius.circular(25),
    boxShadow: const [
      BoxShadow(
        color: Colors.black12,
        blurRadius: 10,
        offset: Offset(0, 7)
      ),
    ]
  );
}

class _BackgroundImage extends StatelessWidget {

  final String? url;

  const _BackgroundImage(this.url);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: SizedBox(
        width: double.infinity, height: 400,
        child: url == null 
        ? const Image(image: AssetImage('assets/no-image.png'), fit: BoxFit.cover,)
        : FadeInImage(
          placeholder: const AssetImage('assets/jar-loading.gif'), 
          image: NetworkImage(url!),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _ServiceDetails extends StatelessWidget {

  final String name; final String categoria;

  const _ServiceDetails({
    super.key, required this.name, required this.categoria
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<ThemeChanger>(context);

    return Padding(
      padding: const EdgeInsets.only(right: 50),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        width: double.infinity, height: 70,
        decoration: _buildBoxDecoration(appTheme),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: const TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              categoria,
              style: const TextStyle(fontSize: 15, color: Colors.white),
            ),
            
          ],
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration(appTheme) => BoxDecoration(
    color: appTheme.currentTheme.primaryColor,
    borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(25), topRight:  Radius.circular(25))
  );
}

class _PriceTag extends StatelessWidget {

  final double price;

  const _PriceTag({
    super.key, required this.price,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<ThemeChanger>(context);

    return Container(
      width: 100, height: 70,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: appTheme.currentTheme.primaryColor,
        borderRadius: const BorderRadius.only(topRight: Radius.circular(25), bottomLeft: Radius.circular(25))
      ),
      child: FittedBox(
        fit: BoxFit.contain,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'Bs. ${price.toString()}',
            style: const TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    );
  }
}
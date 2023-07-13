import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:app_classic/src/pages/pages.dart';

final pageRoutes = <_Route>[
  _Route(FontAwesomeIcons.amazon, "Perfil", const ProfilePage()),
  _Route(FontAwesomeIcons.amazon, "Home", const HomePage()),
  _Route(FontAwesomeIcons.amazon, "Servicios", const ServicesPage()),
  _Route(FontAwesomeIcons.amazon, "Recomendacion", const RecommendationPage()),
  _Route(FontAwesomeIcons.amazon, "Citas", const CitaPage()),
  _Route(FontAwesomeIcons.amazon, "Servicio", const ServicePage()),
  _Route(FontAwesomeIcons.amazon, "ListaRecomendaciones", const ListRecomendPage()),
  _Route(FontAwesomeIcons.amazon, "CitaRecomendacion",  const CitaRecomendPage()),
];

class _Route {
  
  final IconData icon;
  final String title;
  final Widget page;

  _Route(this.icon, this.title, this.page, );

}
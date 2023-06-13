import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:app_classic/src/pages/profile_page.dart';
import 'package:app_classic/src/pages/clients_page.dart';
import 'package:app_classic/src/pages/services_page.dart';
import 'package:app_classic/src/pages/recommendation_page.dart';
import 'package:app_classic/src/pages/appointment_page.dart';
import 'package:app_classic/src/pages/barbers_page.dart';
import 'package:app_classic/src/pages/reports_page.dart';

final pageRoutes = <_Route>[
  _Route(FontAwesomeIcons.amazon, "Perfil", const ProfilePage()),
  _Route(FontAwesomeIcons.slideshare, "Clientes", const ClientsPage()),
  _Route(FontAwesomeIcons.amazon, "Barberos", const BarbersPage()),
  _Route(FontAwesomeIcons.amazon, "Servicios", const ServicesPage()),
  _Route(FontAwesomeIcons.amazon, "Recomendacion", const RecommendationPage()),
  _Route(FontAwesomeIcons.amazon, "Citas", const AppointmentsPage()),
  _Route(FontAwesomeIcons.amazon, "Reportes", const ReportsPage()),
];

class _Route {
  
  final IconData icon;
  final String title;
  final Widget page;

  _Route(this.icon, this.title, this.page);

}
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:app_classic/src/share_preferences/user.dart';

import 'package:app_classic/src/pages/pages.dart';
import 'package:app_classic/src/theme/theme.dart';
import 'package:app_classic/src/services/services.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await User.init();
  runApp(
    MultiProvider(
        providers: [
          ChangeNotifierProvider( create: (_) => ThemeChanger(3) ),
          ChangeNotifierProvider( create: (_) => AuthService() ),
          ChangeNotifierProvider( create: (_) => ServicesService() ),
          ChangeNotifierProvider( create: (_) => CategoriesService() ),
          ChangeNotifierProvider( create: (_) => BarberService() ),
          ChangeNotifierProvider( create: (_) => CitaService() ),
          ChangeNotifierProvider( create: (_) => FormRecomendService() ),
        ],
        child: const MyApp(),
      ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    final currentTheme = Provider.of<ThemeChanger>(context).currentTheme;

    return MaterialApp(
      theme: currentTheme,
      debugShowCheckedModeBanner: false,
      title: 'Barber App',
      initialRoute: 'login',
      routes: {
        'login'    :(_) => User.token=='' ? const LoginPage() : const HomePage(),
        'home'     :(_) => User.token=='' ? const LoginPage() : const HomePage(),
        'register' :(_) => const RegisterPage(),
        'listrecomend' :(_) => const ListRecomendPage()
      },
      scaffoldMessengerKey: NotificationsService.messengerKey,
    );
  }
}
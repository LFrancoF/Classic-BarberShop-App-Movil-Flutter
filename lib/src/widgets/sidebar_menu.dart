import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:app_classic/src/services/services.dart';
import 'package:app_classic/src/theme/theme.dart';
import 'package:app_classic/src/routes/routes.dart';

class SidebarMenu extends StatelessWidget {
  const SidebarMenu({super.key});

  @override
  Widget build(BuildContext context) {

    final appTheme = Provider.of<ThemeChanger>(context);

    return Drawer(
      child: Container(
        child: Column(
          children: [
            SafeArea(
              child: Container(
                padding: const EdgeInsets.all(20),
                width: double.infinity,
                height: 200,
                child: CircleAvatar(
                  backgroundColor: appTheme.currentTheme.primaryColor,
                  child: const Text("GF", style: TextStyle(fontSize: 50),),
                ),
              ),
            ),
            const Expanded(child: _OptionsList()),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: ListTile(
                leading: Icon(Icons.lightbulb_outline, color: appTheme.currentTheme.primaryColor,),
                title: const Text("Dark Mode"),
                trailing: Switch.adaptive(
                  value: appTheme.darkTheme,
                  activeColor: appTheme.currentTheme.primaryColor,
                  onChanged: (value) => appTheme.darkTheme = value,
                ),
              ),
            ),
            // SafeArea(
            //   bottom: true, top: false, left: false, right: false,
            //   child: ListTile(
            //     leading: Icon(Icons.add_to_home_screen, color: appTheme.currentTheme.primaryColor,),
            //     title: const Text("Custom Theme"),
            //     trailing: Switch.adaptive(
            //       value: appTheme.customTheme,
            //       activeColor: appTheme.currentTheme.primaryColor,
            //       onChanged: (value) => appTheme.customTheme = value,
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

class _OptionsList extends StatelessWidget {
  const _OptionsList({super.key});

  @override
  Widget build(BuildContext context) {

  final appTheme = Provider.of<ThemeChanger>(context).currentTheme;

  return ListView(
    children: [
      ListTile(
        leading: Icon(Icons.house, color: appTheme.primaryColor,),
        title: Text(pageRoutes[1].title),
        trailing: Icon(Icons.chevron_right, color: appTheme.primaryColor,),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => pageRoutes[1].page,));
        },
      ),
      ListTile(
        leading: Icon(Icons.logout, color: appTheme.primaryColor,),
        title: const Text("Logout"),
        trailing: Icon(Icons.chevron_right, color: appTheme.primaryColor,),
        onTap: () async{

          final authService = Provider.of<AuthService>(context, listen: false);
          await authService.logout();
          // ignore: use_build_context_synchronously
          Navigator.pushReplacementNamed(context, 'login');
        },
      ),
    ],
  );
    
  }
}
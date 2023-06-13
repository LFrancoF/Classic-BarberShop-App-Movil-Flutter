import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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

    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) => ListTile(
        leading: FaIcon(pageRoutes[index].icon, color: appTheme.primaryColor,),
        title: Text(pageRoutes[index].title),
        trailing: Icon(Icons.chevron_right, color: appTheme.primaryColor,),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => pageRoutes[index].page,));
        },
      ),
      separatorBuilder: (context, index) => Divider(
        color: appTheme.primaryColorLight,
      ),
      itemCount: pageRoutes.length
    );
  }
}
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class OptionButton extends StatelessWidget {

  final IconData? icon;
  final String texto;
  final Color? color1;
  final Color? color2;
  final Function() onPress;

  const OptionButton({
    super.key, 
    this.icon = FontAwesomeIcons.shop, 
    required this.texto, 
    this.color1 = const Color(0xff6989F5), 
    this.color2 = const Color(0xff906EF5), 
    required this.onPress
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Stack(
        children: [
          _OptionButtonBackground(icon: icon!, color1: color1!, color2: color2!,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 140, width: 40,),
              FaIcon(icon, size: 40, color: Colors.white),
              const SizedBox(width: 20,),
              Expanded(child: Text(texto, style: TextStyle(color: Colors.white, fontSize: 18),)),
              const FaIcon(FontAwesomeIcons.chevronRight, color: Colors.white,),
              const SizedBox(width: 40,)
            ],
          )
        ],
      ),
    );
  }
}

class _OptionButtonBackground extends StatelessWidget {
  final IconData icon;
  final Color color1;
  final Color color2;

  const _OptionButtonBackground({
    super.key, required this.icon, required this.color1, required this.color2,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, height: 100,
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.red,
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.2), offset: const Offset(4, 6), blurRadius: 10)
        ],
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(
          colors: [
            color1,
            color2
          ]
        )
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Stack(
          children: [
            Positioned(
              right: -20, top: -10,
              child: FaIcon(FontAwesomeIcons.shop, size: 100, color: Colors.white.withOpacity(0.2),)
            )
          ],
        ),
      ),
    );
  }
}
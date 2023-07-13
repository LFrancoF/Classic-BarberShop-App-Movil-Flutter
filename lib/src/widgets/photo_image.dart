import 'dart:io';

import 'package:flutter/material.dart';

class PhotoImage extends StatelessWidget {
  
  final String? url;
  
  const PhotoImage({super.key, this.url});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Container(
        decoration: _buildBoxDecoration(),
        width: double.infinity, height: 450,
        child: ClipRRect(
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(45), topRight: Radius.circular(45)),
          child: _getImage(url)
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
    borderRadius: const BorderRadius.only(topLeft: Radius.circular(45), topRight: Radius.circular(45)),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.05),
        blurRadius: 10,
        offset: const Offset(0, 5)
      ),
      
    ]
  );

  Widget _getImage(String? image){
    if (image == null) {
      return const Image(
        image: AssetImage('assets/no-image.png'), fit: BoxFit.cover
      );
    }

    if (image.startsWith('http')) {
      return FadeInImage(
        placeholder: const AssetImage('assets/jar-loading.gif'), 
        image: NetworkImage(image),
        fit: BoxFit.cover,
      );
    }

    //Si no es ninguna de las anteriores entonces es un path del dispositivo
    return Image.file(
      File(image),
      fit: BoxFit.cover,
    );
  }
}
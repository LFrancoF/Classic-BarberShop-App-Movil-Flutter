import 'package:flutter/material.dart';
 
class DialogImage extends StatelessWidget {
  const DialogImage({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        backgroundColor: Colors.grey[100],
        title: const Text('Seleccione una imagen o tome una fotografía'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(1),
                      child: const Column(
                        children: [
                          Icon(Icons.camera_alt, size: 50, color: Colors.indigo),
                          Text('Cámara')
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(2),
                      child: const Column(
                        children: [
                          Icon(Icons.storage, size: 50, color: Colors.indigo),
                          Text('Galería')
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Icon(Icons.close_rounded, color: Colors.red, size: 40),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
  }
}



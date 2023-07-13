import 'package:flutter/material.dart';
import 'package:app_classic/src/share_preferences/user.dart';

import 'package:provider/provider.dart';
import 'package:app_classic/src/models/models.dart';

import 'package:app_classic/src/services/services.dart';
import 'package:app_classic/src/widgets/widgets.dart';
import 'package:image_picker/image_picker.dart';

import 'package:app_classic/src/routes/routes.dart';

class RecommendationPage extends StatefulWidget {
  const RecommendationPage({super.key,});

  @override
  State<RecommendationPage> createState() => _RecommendationPage();
}

class _RecommendationPage extends State<RecommendationPage> {

  Category? _selectedCategory;
  List<Category> _categories= [];
  String? _selectedImage;
  bool _disabled = true;
  FormRecomendService? _formFunctions;

  @override
  void initState() {
    super.initState();

    //traer las categorias
    final catService = Provider.of<CategoriesService>(context, listen: false);
    _categories = catService.categories;
    //asignar valor inicial
    _selectedCategory = _categories.isNotEmpty ? _categories.first : null;

    final formFunctions = Provider.of<FormRecomendService>(context, listen: false);
    _formFunctions = formFunctions;
  
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          children: [
            Stack(
              children: [
        
                PhotoImage(url: _selectedImage),
        
                Positioned(
                  top: 60, left: 20,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.horizontal(left: Radius.elliptical(20, 30), right: Radius.circular(10)),
                    child: Container(
                      color: Colors.black.withOpacity(0.25),
                      child: IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(Icons.arrow_back_sharp, size: 40, color: Colors.white,)
                      ),
                    ),
                  )
                ),
        
                Positioned(
                  top: 60, right: 20,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      color: Colors.black.withOpacity(0.25),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: IconButton(
                          onPressed: ()async{
                            
                            final option = await _showMyDialog(context);
        
                            if (option == null) return; //si cancelamos ya no hacemos nada
        
                            final picker = ImagePicker();
                            final XFile? pickedfile = await picker.pickImage(
                              source: (option == 1)   //depende que seleccionamos en el cuadro de dialogo nos abrira la camara o galeria
                              ? ImageSource.camera
                              : ImageSource.gallery,
                              imageQuality: 100
                            );
        
                            if (pickedfile == null) return;  //si cancelamos al tomar foto o seleccionar de galeria no hacemos nada
        
                            setState(() {
                              _selectedImage = pickedfile.path;
                              _disabled = false;
                            });
        
                          },
                          icon: const Icon(Icons.camera_alt_outlined, size: 40, color: Colors.white,)
                        ),
                      ),
                    ),
                  ),
                ),
        
              ],
            ),
        
            const SizedBox(height: 16.0),
        
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              margin: const EdgeInsets.all(5),
              child: const Padding(
                padding: EdgeInsets.all(10),
                child: Center(
                  child: Text("Suba una fotografia, con un buen angulo, enfocando todo el rostro",
                    style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
                  ),
                ),
              ),
            ),
        
            const SizedBox(height: 16.0),
                
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: DropdownButtonFormField<Category>(
                value: _selectedCategory,
                items: _categories.map((Category catOption) {
                  return DropdownMenuItem<Category>(
                    value: catOption,
                    child: Text(catOption.nombre.toString()),
                  );
                }).toList(),
                onChanged: (Category? newCat) {
                  setState(() {
                    _selectedCategory = newCat;
                  });
                },
                decoration: const InputDecoration(
                  labelText: 'Categoria',
                ),
              ),
            ),
            
            const SizedBox(height: 50)
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: (_disabled) ? null : () async{
          
          final String? imageUrl = await _formFunctions!.uploadImage(_selectedImage!);

          if (imageUrl == null) {
            NotificationsService.showSnackbar("Error al subir la imagen, intente de nuevo");
            return;
          }

          final Map<String, dynamic> response = await _formFunctions!.createFormRecomend(imagen: imageUrl, idCategoria: _selectedCategory!.idCategoria.toString(), idCliente: User.idCliente.toString());
          if (response['error'] == null && response['form'] != null){
            // ignore: use_build_context_synchronously
            Navigator.pushNamed(context, 'listrecomend', arguments: imageUrl);
            //Navigator.push(context, MaterialPageRoute(builder: (context) => pageRoutes[6].page,));
          }else{
            //mostrar error de registro
            NotificationsService.showSnackbar(response['error']);
          }

          //print("recomendacion generada - cat: ${_selectedCategory!.idCategoria} - imagen: $_selectedImage");
          
          },
        child: const Icon(Icons.save_outlined),
      ),
    );
  }
}

//Funcion para llamar el widget de dialogo para escoger entre camara o galeria
Future<int?> _showMyDialog(context) async {
  return showDialog<int>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (context) => const DialogImage()
  );
}
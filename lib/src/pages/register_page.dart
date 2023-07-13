import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:app_classic/src/providers/register_form_provider.dart';
import 'package:app_classic/src/services/services.dart';

import 'package:app_classic/src/ui/input_decorations.dart';
import 'package:app_classic/src/widgets/widgets.dart';

class RegisterPage extends StatelessWidget {
   
  const RegisterPage({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBackground(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(height: 250,),
              CardContainer(
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Text('Registro', style: Theme.of(context).textTheme.headlineMedium),
                    const SizedBox(height: 30),

                    ChangeNotifierProvider(
                      create: (_) => RegisterFormProvider(),
                      child: const _RegisterForm(),  //solo el _Registerform tendra accesa al provider
                    )
                    
                  ],
                ),
              ),
              const SizedBox(height: 50),
              TextButton(
                onPressed: () => Navigator.pushReplacementNamed(context, 'login'),
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(Colors.indigo.withOpacity(0.1)),
                  shape: MaterialStateProperty.all(const StadiumBorder()),
                ),
                child: const Text('¿Ya tienes una cuenta?', style: TextStyle(fontSize: 18, color: Colors.black87)),
              ),
              const SizedBox(height: 50)
            ],
          ),
        )
      )
    );
  }
}

class _RegisterForm extends StatelessWidget {
  const _RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {

    final registerform = Provider.of<RegisterFormProvider>(context);

    return Container(
      child: Form(
        key: registerform.formkey,
        child: Column(
          children: [
            TextFormField(
              //autovalidateMode: AutovalidateMode.onUserInteraction,
              autocorrect: false,
              keyboardType: TextInputType.name,
              decoration: InputDecorations.authInputDecoration(
                hintText: 'Nombre',
                labelText: 'Nombre',
                prefixIcon: Icons.account_box
              ),
              style: const TextStyle(color: Colors.black),
              onChanged: (value) => registerform.nombre = value,
            ),

            const SizedBox(height: 30),

            TextFormField(
              //autovalidateMode: AutovalidateMode.onUserInteraction,
              autocorrect: false,
              keyboardType: TextInputType.name,
              decoration: InputDecorations.authInputDecoration(
                hintText: 'Apellido',
                labelText: 'Apellido',
                prefixIcon: Icons.account_box
              ),
              style: const TextStyle(color: Colors.black),
              onChanged: (value) => registerform.apellido = value,
            ),

            const SizedBox(height: 30),

            TextFormField(
              //autovalidateMode: AutovalidateMode.onUserInteraction,
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                hintText: 'someone@someone.com',
                labelText: 'Correo electrónico',
                prefixIcon: Icons.alternate_email_sharp
              ),
              style: const TextStyle(color: Colors.black),
              onChanged: (value) => registerform.email = value,
              validator: (value){
                String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                RegExp regExp  = RegExp(pattern);

                return regExp.hasMatch(value ?? '')
                  ? null
                  : 'El correo ingresado no es váido';
              }
            ),

            const SizedBox(height: 30),

            TextFormField(
              //autovalidateMode: AutovalidateMode.onUserInteraction,
              autocorrect: false,
              keyboardType: TextInputType.number,
              decoration: InputDecorations.authInputDecoration(
                hintText: 'Telefono',
                labelText: '77000077',
                prefixIcon: Icons.phone
              ),
              style: const TextStyle(color: Colors.black),
              onChanged: (value) => registerform.telefono = value,
            ),

            const SizedBox(height: 30),

            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              autocorrect: false,
              obscureText: true,
              keyboardType: TextInputType.text,
              decoration: InputDecorations.authInputDecoration(
                hintText: '',
                labelText: 'Contraseña',
                prefixIcon: Icons.lock_outline
              ),
              style: const TextStyle(color: Colors.black),
              onChanged: (value) => registerform.password = value,
              validator: (value){
                return (value != null && value.length >= 6 )
                  ? null
                  : 'La contraseña debe tener mínimo 6 caracteres';
              }
            ),

            const SizedBox(height: 30),

            MaterialButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              disabledColor: Colors.grey,
              elevation: 0,
              color: Colors.deepPurple,
              onPressed: registerform.isLoading ? null : () async{
                FocusManager.instance.primaryFocus?.unfocus();
                final authService = Provider.of<AuthService>(context, listen: false);
                if ( !registerform.isValidForm() ) return;

                registerform.isLoading = true;

                //validar si el correo ingresado ya existe o algun error
                final String? errorMessage = await authService.register(registerform.nombre, registerform.apellido, registerform.email, registerform.telefono, registerform.password);

                if (errorMessage == null){
                  // ignore: use_build_context_synchronously
                  Navigator.pushReplacementNamed(context, 'login');
                }else{
                  //mostrar error de registro
                  NotificationsService.showSnackbar(errorMessage);
                  registerform.isLoading = false;
                }
                
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                child: registerform.isLoading
                ? const SizedBox(height: 15, width: 15, child: CircularProgressIndicator(color: Colors.white))
                : const Text( 'Registrar', style: TextStyle(color: Colors.white))
              ),
            )
          ],
        )
      ),
    );
  }
}
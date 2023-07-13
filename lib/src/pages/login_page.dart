import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:app_classic/src/providers/login_form_provider.dart';
import 'package:app_classic/src/ui/input_decorations.dart';
import 'package:app_classic/src/widgets/widgets.dart';

import 'package:app_classic/src/services/services.dart';

class LoginPage extends StatelessWidget {
   
  const LoginPage({Key? key}) : super(key: key);
  
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
                    Text('Login', style: Theme.of(context).textTheme.headlineMedium),
                    const SizedBox(height: 30),

                    ChangeNotifierProvider(
                      create: (_) => LoginFormProvider(),
                      child: const _LoginForm(),  //solo el _LoginForm tendra accesa al provider
                    )
                    
                  ],
                ),
              ),
              const SizedBox(height: 50),
              TextButton(
                onPressed: () => Navigator.pushReplacementNamed(context, 'register'),
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(Colors.indigo.withOpacity(0.1)),
                  shape: MaterialStateProperty.all(const StadiumBorder()),
                ),
                child: const Text('Crear una nueva cuenta', style: TextStyle(fontSize: 18, color: Colors.black87)),
              ),
              const SizedBox(height: 50)
            ],
          ),
        )
      )
    );
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm({super.key});

  @override
  Widget build(BuildContext context) {

    final loginform = Provider.of<LoginFormProvider>(context);

    return Container(
      child: Form(
        key: loginform.formkey,
        child: Column(
          children: [
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
              onChanged: (value) => loginform.email = value,
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
              onChanged: (value) => loginform.password = value,
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
              onPressed: loginform.isLoading ? null : () async{
                FocusManager.instance.primaryFocus?.unfocus();
                final authService = Provider.of<AuthService>(context, listen: false);
                if ( !loginform.isValidForm() ) return;

                loginform.isLoading = true;

                //validar si el Login es correcto
                final Map<String, dynamic> response = await authService.login(loginform.email, loginform.password);
                
                if (response['error'] == null && response['user'] != null){
                  // ignore: use_build_context_synchronously
                  Navigator.pushReplacementNamed(context, 'home');
                }else{
                  //mostrar error de login
                  NotificationsService.showSnackbar(response['error']);
                  loginform.isLoading = false;
                }

              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                child: loginform.isLoading
                ? const SizedBox(height: 15, width: 15, child: CircularProgressIndicator(color: Colors.white))
                : const Text( 'Ingresar', style: TextStyle(color: Colors.white))
              ),
            )
          ],
        )
      ),
    );
  }
}
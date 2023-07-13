import 'package:app_classic/src/models/models.dart';
import 'package:app_classic/src/share_preferences/user.dart';
import 'package:app_classic/src/widgets/widgets.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:app_classic/src/services/services.dart';

import 'package:app_classic/src/pages/pages.dart';

class CitaRecomendPage extends StatefulWidget {
  const CitaRecomendPage({super.key});

  @override
  State<CitaRecomendPage> createState() => _CitaRecomendPageState();
}

class _CitaRecomendPageState extends State<CitaRecomendPage> {

  final TextEditingController _textController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  Service? _selectedService;
  List<Service> _services= [];
  Barber? _selectedBarber;
  List<Barber> _barbers= [];
  bool _isLoading = true;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    //traer los servicios
    final servicesService = Provider.of<ServicesService>(context, listen: false);
    _services = servicesService.services;
    //asignar valor inicial
    _selectedService = _services.isNotEmpty ? _services.first : null;

    //traer los barberos
    final barbersService = Provider.of<BarberService>(context, listen: false);
    _barbers = barbersService.barbers;
    //asignar valor inicial
    _selectedBarber = _barbers.isNotEmpty ? _barbers.first : null;

    _isLoading=false;
  
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    if (_isLoading){
      return const LoadingPage();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Agendar Cita'),
      ),
      drawer: const SidebarMenu(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListView(
              children: [
                ListTile(
                  title: const Text('Fecha'),
                  subtitle: Text(
                    '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                  ),
                  onTap: () {
                    _selectDate(context);
                  },
                ),
                const SizedBox(height: 16.0),
                ListTile(
                  title: const Text('Hora'),
                  subtitle: Text(_selectedTime.format(context)),
                  onTap: () {
                    _selectTime(context);
                  },
                ),

                const SizedBox(height: 16.0),
                
                DropdownButtonFormField<Service>(
                  value: _selectedService,
                  items: _services.map((Service serviceOption) {
                    return DropdownMenuItem<Service>(
                      value: serviceOption,
                      child: Text(serviceOption.nombre.toString()),
                    );
                  }).toList(),
                  onChanged: (Service? newService) {
                    setState(() {
                      _selectedService = newService;
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: 'Servicio',
                  ),
                ),

                const SizedBox(height: 16.0),

                DropdownButtonFormField<Barber>(
                  value: _selectedBarber,
                  items: _barbers.map((Barber barberOption) {
                    return DropdownMenuItem<Barber>(
                      value: barberOption,
                      child: Text('${barberOption.nombre} ${barberOption.apellido}'),
                    );
                  }).toList(),
                  onChanged: (Barber? newBarber) {
                    setState(() {
                      _selectedBarber = newBarber;
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: 'Barbero',
                  ),
                ),

                const SizedBox(height: 16.0),

                TextField(
                  controller: _textController,
                  maxLines: null,
                  decoration: const InputDecoration(
                    labelText: 'Nota',
                  ),
                ),

                const SizedBox(height: 30),

                MaterialButton(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  disabledColor: Colors.grey,
                  elevation: 0,
                  
                  color: Colors.deepPurple,
                  onPressed: () async{
                    final citaService = Provider.of<CitaService>(context, listen: false);
                    String dateString = _selectedDate.toString().split(' ')[0];
                    String timeString = '${_selectedTime.hour.toString().padLeft(2, '0')}:${_selectedTime.minute.toString().padLeft(2, '0')}'; // Formato "HH:mm"
                    final String? errorMessage = await citaService.createCita(
                      fecha: dateString,
                      hora: timeString,
                      idCliente : User.idCliente,
                      idBarbero : _selectedBarber!.idBarbero.toString(),
                      idServicio : _selectedService!.idServicio.toString(),
                      costo : _selectedService!.precio.toString(),
                      nota : _textController.text,
                      estado : 'Pendiente',
                      idForm: User.formRecomend
                    );

                    if (errorMessage == null){
                      User.formRecomend = '';
                      // ignore: use_build_context_synchronously
                      Navigator.pushReplacementNamed(context, 'home');
                    }else{
                      //mostrar error de registro
                      NotificationsService.showSnackbar(errorMessage);
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    child: const Text( 'Agendar', style: TextStyle(color: Colors.white))
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

import 'package:fast_location/src/services/cep_service.dart';

import 'package:fast_location/src/modules/history/page/history_page.dart';

import 'package:fast_location/src/shared/colors/app_colors.dart';

import 'package:fast_location/src/modules/home/model/address_model.dart';


class HomePage extends StatefulWidget {

  const HomePage({super.key});


  @override

  State<HomePage> createState() => _HomePageState();

}


class _HomePageState extends State<HomePage> {

  final CepService _cepService = CepService();

  final TextEditingController _cepController = TextEditingController();

  AddressModel? _address;

  String? _errorMessage;


  void _consultarCep() async {

    setState(() {

      _errorMessage = null;

    });

    try {

      AddressModel address = await _cepService.fetchAddress(_cepController.text);

      await _cepService.saveToHistory(address);

      setState(() {

        _address = address;

      });

    } catch (e) {

      setState(() {

        _errorMessage = e.toString();

      });

    }

  }


  @override

  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: AppColors.appPageBackground,

      appBar: AppBar(

        title: const Text("Fast Location"),

        backgroundColor: AppColors.appBarBackground,

      ),

      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,

          children: [

            TextField(

              controller: _cepController,

              decoration: const InputDecoration(

                labelText: "Digite o CEP",

              ),

              keyboardType: TextInputType.number,

            ),

            ElevatedButton(

              onPressed: _consultarCep,

              child: const Text("Consultar"),

            ),

            if (_errorMessage != null) ...[

              Text(_errorMessage!, style: TextStyle(color: Colors.red)),

            ],

            if (_address != null) ...[

              Text("Endereço: ${_address!.logradouro}, ${_address!.bairro}"),

              Text("Cidade: ${_address!.localidade} - ${_address!.uf}"),

            ],

            ElevatedButton(

              onPressed: () {

                Navigator.push(

                  context,

                  MaterialPageRoute(builder: (context) => const HistoryPage()),

                );

              },

              child: const Text("Histórico de Endereços"),

            ),

          ],

        ),

      ),

    );

  }

}

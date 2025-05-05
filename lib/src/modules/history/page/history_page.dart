import 'package:flutter/material.dart';

import 'package:fast_location/src/services/cep_service.dart';

import 'package:fast_location/src/modules/home/model/address_model.dart';


class HistoryPage extends StatefulWidget {

  const HistoryPage({super.key});


  @override

  State<HistoryPage> createState() => _HistoryPageState();

}


class _HistoryPageState extends State<HistoryPage> {

  final CepService _cepService = CepService();

  List<AddressModel> _history = [];


  @override

  void initState() {

    super.initState();

    _loadHistory();

  }


  Future<void> _loadHistory() async {

    List<AddressModel> history = await _cepService.getHistory();

    setState(() {

      _history = history;

    });

  }


  @override

  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: const Text("Histórico de Endereços"),

      ),

      body: ListView.builder(

        itemCount: _history.length,

        itemBuilder: (context, index) {

          final address = _history[index];

          return ListTile(

            title: Text(address.logradouro),

            subtitle: Text("${address.bairro}, ${address.localidade} - ${address.uf}"),

          );

        },

      ),

    );

  }

}

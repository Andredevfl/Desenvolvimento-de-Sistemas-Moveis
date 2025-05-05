import 'package:dio/dio.dart';

import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:fast_location/src/modules/home/model/address_model.dart';


class CepService {

  final Dio _dio = Dio();


  Future<AddressModel> fetchAddress(String cep) async {

    try {

      final response = await _dio.get('https://viacep.com.br/ws/$cep/json/');

      if (response.statusCode == 200) {

        return AddressModel.fromJson(response.data);

      } else {

        throw Exception('Erro ao pesquisar CEP');

      }

    } catch (e) {

      throw Exception('Erro interno');

    }

  }


  Future<void> saveToHistory(AddressModel address) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String>? history = prefs.getStringList('historico') ?? [];

    history.insert(0, address.toJson().toString());

    await prefs.setStringList('historico', history);

  }


  Future<List<AddressModel>> getHistory() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String>? history = prefs.getStringList('historico');

    return history?.map((json) => AddressModel.fromJsonLocal(jsonDecode(json))).toList() ?? [];

  }


  Future<void> clearHistory() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.remove('historico');

  }

}

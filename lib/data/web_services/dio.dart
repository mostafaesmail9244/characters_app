// ignore_for_file: avoid_print

import 'package:dio/dio.dart';

class CharactersWebServices {
  Dio? dio;
  CharactersWebServices() {
    dio = Dio(BaseOptions(
        baseUrl: 'https://rickandmortyapi.com/api/',
        receiveDataWhenStatusError: true,
        receiveTimeout: const Duration(seconds: 10),
        sendTimeout: const Duration(seconds: 10)));
  }

  Future<List<dynamic>> getCharacters() async {
    try {
      Response response = await dio!.get(
        'character',
      );
      print(response.data.toString());
      return response.data['results'];
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}

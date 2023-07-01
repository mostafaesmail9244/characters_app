import 'package:character/data/web_services/dio.dart';

import '../models/character_model.dart';

class CharactersReposrtory {
  final CharactersWebServices charactersWebServices;

  CharactersReposrtory(this.charactersWebServices);

  Future<List<CharacterModel>> getCharacters() async {
    final characters = await charactersWebServices.getCharacters();
    return characters
        .map((character) => CharacterModel.fromJson(character))
        .toList();
  }
}

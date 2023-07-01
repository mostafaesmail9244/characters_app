// ignore_for_file: avoid_print

import 'package:bloc/bloc.dart';
import 'package:character/data/repository/characters_repository.dart';

import '../../data/models/character_model.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  CharactersCubit(this.charactersReposrtory) : super(CharactersInitial());
  CharactersReposrtory charactersReposrtory;
  List<CharacterModel> characters = [];
  List<CharacterModel> getAllCharacters() {
    charactersReposrtory.getCharacters().then((characters) {
      emit(CharactersLoaded(characters));
      this.characters = characters;
    }).catchError((e) {
      print('=================');
      print(e.toString());
      print('=================');
    });
    return characters;
  }
}

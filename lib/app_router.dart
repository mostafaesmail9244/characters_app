// ignore_for_file: prefer_const_constructors

import 'package:character/business_logic/cubit/characters_cubit.dart';
import 'package:character/data/models/character_model.dart';
import 'package:character/data/repository/characters_repository.dart';
import 'package:character/data/web_services/dio.dart';
import 'package:character/presnation/screens/character_details.dart';
import 'package:character/presnation/screens/charactes_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'components/components.dart';

class AppRouter {
  late CharactersReposrtory charactersReposrtory;
  late CharactersCubit charactersCubit;
  AppRouter() {
    charactersReposrtory = CharactersReposrtory(CharactersWebServices());
    charactersCubit = CharactersCubit(charactersReposrtory);
  }
  Route? generateRout(RouteSettings settings) {
    switch (settings.name) {
      case charactersScreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => charactersCubit,
                  child: CharactersScreen(),
                ));
      case characterDetailsScreen:
        final characterModel = settings.arguments as CharacterModel;
        return MaterialPageRoute(
            builder: (_) => CharacterDetilasScreen(
                  characterModel: characterModel,
                ));
    }
    return null;
  }
}

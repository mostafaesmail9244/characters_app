// ignore_for_file: prefer_const_constructors

import 'package:character/business_logic/cubit/characters_cubit.dart';
import 'package:character/components/my_colors.dart';
import 'package:character/data/models/character_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';

import '../widgets/character_item.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({super.key});

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  late List<CharacterModel> allCharacters;
  late List<CharacterModel> searchedForCharacters;
  bool isSearching = false;
  final textController = TextEditingController();
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CharactersCubit>(context).getAllCharacters();
  }

  Widget buildSearchedField() => TextField(
        controller: textController,
        cursorColor: MyColors.myGrey,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Find a character...',
          hintStyle: TextStyle(color: MyColors.myGrey, fontSize: 18),
        ),
        style: TextStyle(color: MyColors.myGrey, fontSize: 18),
        onChanged: (searchedCharacter) {
          addSearchedItem(searchedCharacter);
        },
      );

  void addSearchedItem(String searchedCharacter) {
    searchedForCharacters = allCharacters
        .where((element) =>
            element.name!.toLowerCase().startsWith(searchedCharacter))
        .toList();
    setState(() {});
  }

  List<Widget> buildAppBarActions() {
    if (isSearching) {
      return [
        IconButton(
          onPressed: () {
            clearSearch();
            Navigator.pop(context);
          },
          icon: Icon(Icons.clear),
          color: MyColors.myGrey,
        ),
      ];
    } else {
      return [
        IconButton(
          onPressed: () {
            startSearch();
          },
          icon: Icon(Icons.search),
          color: MyColors.myGrey,
        )
      ];
    }
  }

  void startSearch() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: stopSearching));
    setState(() {
      isSearching = true;
    });
  }

  void stopSearching() {
    clearSearch();
    setState(() {
      isSearching = false;
    });
  }

  void clearSearch() {
    setState(() {
      textController.clear();
    });
  }

  Widget buildBlocWidget() {
    return BlocBuilder<CharactersCubit, CharactersState>(
      builder: (context, state) {
        if (state is CharactersLoaded) {
          allCharacters = state.characters;
          return buildLoadedListWidgets();
        } else {
          return Center(
            child: CircularProgressIndicator(
              color: MyColors.myYellwo,
            ),
          );
        }
      },
    );
  }

  buildLoadedListWidgets() {
    return SingleChildScrollView(
      child: Container(
        color: MyColors.myGrey,
        child: Column(
          children: [buildCharactersList()],
        ),
      ),
    );
  }

  Widget buildCharactersList() => GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 2 / 3,
            crossAxisSpacing: 1,
            mainAxisSpacing: 1),
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: textController.text.isEmpty
            ? allCharacters.length
            : searchedForCharacters.length,
        itemBuilder: (context, index) => CharacterItem(
          characterModel: textController.text.isEmpty
              ? allCharacters[index]
              : searchedForCharacters[index],
        ),
      );
  Widget buildAppBarTitle() => Text(
        'Characters',
        style: TextStyle(color: MyColors.myGrey),
      );

  Widget internet(
          {required Color color,
          required String text,
          required bool showProgress}) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 30,
            color: color,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(text),
                SizedBox(width: 5),
                SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                    ))
              ],
            ),
          ),
          showProgress ? CircularProgressIndicator() : SizedBox()
        ],
      );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: isSearching ? BackButton(color: MyColors.myGrey) : Container(),
        backgroundColor: MyColors.myYellwo,
        title: isSearching ? buildSearchedField() : buildAppBarTitle(),
        actions: buildAppBarActions(),
      ),
      body: OfflineBuilder(
        connectivityBuilder: (
          BuildContext context,
          ConnectivityResult connectivity,
          Widget child,
        ) {
          final bool connected = connectivity != ConnectivityResult.none;
          if (connected) {
            return buildBlocWidget();
          } else {
            setState(() {});
            return internet(
                text: 'Offline', color: Colors.red, showProgress: true);
          }
        },
        child: Center(
          child: CircularProgressIndicator(),
        ),
        //  Column(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       Text(
        //         'please check your internet',
        //         style: TextStyle(color: Colors.black),
        //       ),
        //       Icon(
        //         Icons.wifi_off_outlined,
        //         size: 20,
        //       )
        //     ],
        //   )),
      ),
    );
  }
}

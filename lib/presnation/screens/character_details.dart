import 'package:character/components/my_colors.dart';
import 'package:character/data/models/character_model.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CharacterDetilasScreen extends StatelessWidget {
  const CharacterDetilasScreen({super.key, required this.characterModel});
  final CharacterModel characterModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.myGrey,
      body: CustomScrollView(
        slivers: [
          buildAppBarSliver(),
          SliverList(
              delegate: SliverChildListDelegate([
            Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.fromLTRB(14, 14, 14, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildInfo(
                      title: 'status : ', subTitle: characterModel.status!),
                  buildDivider(endPoint: 260),
                  const SizedBox(height: 7),
                  buildInfo(
                      title: 'species : ', subTitle: characterModel.species!),
                  buildDivider(endPoint: 250),
                  const SizedBox(height: 7),
                  buildInfo(
                      title: 'gender : ', subTitle: characterModel.gender!),
                  buildDivider(endPoint: 250),
                  const SizedBox(height: 7),
                  buildInfo(
                      title: 'origin : ',
                      subTitle: characterModel.origin!.name),
                  buildDivider(endPoint: 250),
                  const SizedBox(height: 7),
                  buildInfo(
                      title: 'location : ',
                      subTitle: characterModel.location!.name),
                  buildDivider(endPoint: 250),
                  const SizedBox(height: 7),
                  buildInfo(
                      title: 'created : ', subTitle: characterModel.created!),
                  buildDivider(endPoint: 250),
                  SizedBox(
                    height: 60.h,
                  )
                ],
              ),
            )
          ]))
        ],
        // physics: BouncingScrollPhysics(),
      ),
    );
  }

  Widget buildAppBarSliver() {
    return SliverAppBar(
      expandedHeight: 600,
      backgroundColor: MyColors.myGrey,
      pinned: true,
      stretch: true,
      flexibleSpace: FlexibleSpaceBar(
        // centerTitle: true,
        title: Text(
          characterModel.name!,
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
        background: Hero(
          tag: characterModel.id!,
          child: Image.network(
            characterModel.image!,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget buildInfo({required String title, required String subTitle}) =>
      RichText(
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          text: TextSpan(children: [
            TextSpan(
              text: title,
              style: const TextStyle(
                color: MyColors.myWhite,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextSpan(
              text: subTitle,
              style: const TextStyle(
                color: MyColors.myWhite,
                fontSize: 16,
              ),
            ),
          ]));
  Widget buildDivider({
    required double endPoint,
  }) =>
      Divider(
        color: MyColors.myYellwo,
        thickness: 2,
        endIndent: endPoint,
      );
}

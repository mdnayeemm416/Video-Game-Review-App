import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:videogame_review_app/Model/gamedata_model.dart';
import 'package:videogame_review_app/View/Review_Page/review_page.dart';

class HomeCarouselSlider extends StatefulWidget {
  final List<Item> gameData;
  const HomeCarouselSlider({super.key, required this.gameData});

  @override
  State<HomeCarouselSlider> createState() => _HomeCarouselSliderState();
}

class _HomeCarouselSliderState extends State<HomeCarouselSlider> {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
        itemCount: 5,
        itemBuilder: (context, index, realIndex) {
          Item allGameData = widget.gameData[index];
          return GestureDetector(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => ReviewPage(gameData: allGameData))),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      image: NetworkImage(allGameData.gameImage),
                      fit: BoxFit.cover)),
            ),
          );
        },
        options: CarouselOptions(
            // height: AppSize.height(context) * .45,
            autoPlay: true,
            enlargeCenterPage: true,
            viewportFraction: 1,
            enlargeStrategy: CenterPageEnlargeStrategy.height,
            onPageChanged: (index, reason) {
              setState(() {});
            }));
  }
}

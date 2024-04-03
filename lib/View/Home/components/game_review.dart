import 'package:flutter/material.dart';
import 'package:videogame_review_app/App_Constant/app_constant.dart';
import 'package:videogame_review_app/Model/gamedata_model.dart';
import 'package:videogame_review_app/View/Review_Page/review_page.dart';

class GameReview extends StatefulWidget {
  final List<Item> gameData;
  const GameReview({super.key, required this.gameData});

  @override
  State<GameReview> createState() => _GameReviewState();
}

class _GameReviewState extends State<GameReview> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSize.height30(context)),
      child: GridView.builder(
          itemCount: 15,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 15.0,
            mainAxisSpacing: 15.0,
          ),
          itemBuilder: (context, index) {
            Item allGameData = widget.gameData[index + 5];
            return GestureDetector(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => ReviewPage(gameData: allGameData))),
              child: Container(
                height: 150,
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromARGB(255, 171, 169, 169),
                      blurRadius: 1,
                    ),
                    BoxShadow(
                      color: Color.fromARGB(255, 0, 0, 0),
                      blurRadius: 10,
                    )
                  ],
                  gradient: const LinearGradient(colors: [
                    Color.fromARGB(255, 1, 26, 46),
                    Color.fromARGB(255, 5, 54, 95)
                  ]),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          allGameData.gameImage,
                          height: AppSize.height(context) * .13,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        )),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            allGameData.title,
                            maxLines: 1,
                            style: const TextStyle(
                                fontSize: 15, color: Colors.white),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Container(
                              decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 104, 102, 102),
                                  borderRadius: BorderRadius.circular(10)),
                              height: 25,
                              width: 130,
                              child: const Center(
                                child: Text(
                                  "Action/Adventure",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}

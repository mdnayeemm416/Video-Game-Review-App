import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:readmore/readmore.dart';
import 'package:videogame_review_app/App_Constant/app_constant.dart';
import 'package:videogame_review_app/BLoC/Review_Page/review_page_bloc.dart';
import 'package:videogame_review_app/Model/gamedata_model.dart';
import 'package:videogame_review_app/View/Add_Review/add_review.dart';
import 'package:videogame_review_app/View/Review_Page/components/genres.dart';
import 'package:videogame_review_app/View/Review_Page/components/user_review_card.dart';

class ReviewPage extends StatefulWidget {
  final Item gameData;
  const ReviewPage({super.key, required this.gameData});

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  ReviewPageBloc reviewPageBloc = ReviewPageBloc();

  @override
  void initState() {
    reviewPageBloc
        .add(ReviewPageInitialDataFetchEvent(gameId: widget.gameData.id));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: FloatingActionButton.extended(
          backgroundColor: const Color.fromARGB(255, 142, 84, 151),
          extendedPadding:
              EdgeInsets.symmetric(horizontal: AppSize.height100(context)),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => AddReview(
                          gameId: widget.gameData.id.toString(),
                        )));
          },
          label: const Text(
            "Add Review",
            style: TextStyle(
                color: Colors.white, fontSize: 15, fontWeight: FontWeight.w700),
          ),
        ),
      ),
      appBar: AppBar(
        title: const Text(
          "Reviews & Ratings",
          style: wColor,
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 75, 2, 104),
                Color.fromARGB(255, 138, 68, 150)
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: BlocConsumer<ReviewPageBloc, ReviewPageState>(
        bloc: reviewPageBloc,
        listener: (context, state) {},
        builder: (context, state) {
          switch (state.runtimeType) {
            case ReviewPageSuccessState:
              final reviewPageSuccessState = state as ReviewPageSuccessState;
              return SingleChildScrollView(
                child: Container(
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(colors: [
                    Color.fromARGB(255, 75, 2, 104),
                    Color.fromARGB(255, 138, 68, 150)
                  ])),
                  padding: EdgeInsets.symmetric(
                      horizontal: AppSize.height30(context)),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          widget.gameData.gameImage,
                          height: AppSize.height(context) * .3,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(
                        height: AppSize.height20(context),
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GenresWidget(
                              text: "Action", icon: FontAwesomeIcons.burst),
                          GenresWidget(
                              text: "Adventure",
                              icon: FontAwesomeIcons.gamepad),
                          GenresWidget(
                              text: "Top",
                              icon: FontAwesomeIcons.fireFlameCurved)
                        ],
                      ),
                      SizedBox(
                        height: AppSize.height30(context),
                      ),
                      Row(
                        children: [
                          Column(
                            children: [
                              const Text(
                                "4.2",
                                style: TextStyle(
                                    fontSize: 50, color: Colors.white),
                              ),
                              RatingBarIndicator(
                                  itemSize: 18,
                                  rating: 4.2,
                                  itemCount: 5,
                                  itemBuilder: (index, context) {
                                    return const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    );
                                  }),
                            ],
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.gameData.title,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                ReadMoreText(
                                  widget.gameData.descriptions,
                                  style: const TextStyle(color: Colors.white54),
                                  trimLines: 2,
                                  trimMode: TrimMode.Line,
                                  trimExpandedText: "Show Less",
                                  trimCollapsedText: "Show More",
                                  moreStyle: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color:
                                          Color.fromARGB(255, 227, 129, 244)),
                                  lessStyle: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color:
                                          Color.fromARGB(255, 227, 129, 244)),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: AppSize.height20(context),
                      ),
                      UserReviewCard(
                        reviewPageData: reviewPageSuccessState.reviewPageData,
                      ),
                      const SizedBox(
                        height: 100,
                      ),
                    ],
                  ),
                ),
              );

            default:
              return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

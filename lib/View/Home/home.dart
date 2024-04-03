import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:videogame_review_app/App_Constant/app_constant.dart';
import 'package:videogame_review_app/BLoC/Home_BLoC/home_bloc.dart';
import 'package:videogame_review_app/View/Authentication/Auth/firebase_function.dart';
import 'package:videogame_review_app/View/Home/components/carousel_slider.dart';
import 'package:videogame_review_app/View/Home/components/game_review.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeBloc homeBloc = HomeBloc();
  String username = "";
  String email = "";

  @override
  void initState() {
    homeBloc.add(GameDataInitialFetchEvent());
    fetchUserData();
    super.initState();
  }

  Future<void> fetchUserData() async {
    try {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      DocumentSnapshot documentSnapshot =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      setState(() {
        username = documentSnapshot.get('username');
        email = documentSnapshot.get('email');
      });
    } catch (e) {
      print("Error fetching user data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<HomeBloc, HomeState>(
        bloc: homeBloc,
        listenWhen: (previous, current) => current is HomeActionState,
        buildWhen: (previous, current) => current is! HomeActionState,
        listener: (context, state) {},
        builder: (context, state) {
          switch (state.runtimeType) {
            case GameDataSuccessState:
              final successState = state as GameDataSuccessState;
              return Container(
                height: AppSize.height(context),
                width: AppSize.width(context),
                decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: [
                  Color.fromARGB(255, 75, 2, 104),
                  Color.fromARGB(255, 138, 68, 150)
                ])),
                child: Column(
                  children: [
                    SizedBox(
                      height: AppSize.height20(context),
                    ),
                    Padding(
                      padding: EdgeInsets.all(AppSize.height30(context)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const CircleAvatar(
                                    radius: 18,
                                    backgroundImage:
                                        AssetImage("images/avater.png"),
                                  ),
                                  SizedBox(
                                    width: AppSize.height25(context),
                                  ),
                                  Text(
                                    username,
                                    style: smallText,
                                  )
                                ],
                              ),
                              ElevatedButton.icon(
                                  onPressed: () {
                                    signOut();
                                  },
                                  icon: const Icon(
                                    Icons.person,
                                    size: 15,
                                  ),
                                  label: const Text("Sign Out"))
                            ],
                          ),
                          SizedBox(
                            height: AppSize.height15(context),
                          ),
                          const Text(
                            "Gaming Hubs",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 25,
                            ),
                          ),
                        ],
                      ),
                    ),
                    HomeCarouselSlider(gameData: successState.gameData),
                    Padding(
                      padding: EdgeInsets.all(AppSize.height30(context)),
                      child: const Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Game Review",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                      ),
                    ),
                    Expanded(
                        child: GameReview(
                      gameData: successState.gameData,
                    ))
                  ],
                ),
              );

            default:
              return Text("Error");
          }
        },
      ),
    );
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:geolocator/geolocator.dart';

import 'package:videogame_review_app/App_Constant/app_constant.dart';
import 'package:videogame_review_app/BLoC/Add_Review/add_review_bloc.dart';
import 'package:videogame_review_app/View/Home/home.dart';


class AddReview extends StatefulWidget {
  final String gameId;
  const AddReview({
    Key? key,
    required this.gameId,
  }) : super(key: key);

  @override
  State<AddReview> createState() => _AddReviewState();
}

class _AddReviewState extends State<AddReview> {
  AddReviewBloc addReviewBloc = AddReviewBloc();
  final TextEditingController comment = TextEditingController();
  late String ratingValue;
  String username = "";
  String email = "";
  String latitude = "";
  String longitude = "";

  @override
  void initState() {
    fetchUserData();
    getCurrentLocation();
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

  getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      LocationPermission ask = await Geolocator.requestPermission();
    } else {
      Position currentPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);
      setState(() {
        latitude = currentPosition.latitude.toString();
        longitude = currentPosition.longitude.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add Review",
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
      body: SingleChildScrollView(
        child: BlocConsumer<AddReviewBloc, AddReviewState>(
          bloc: addReviewBloc,
          listener: (context, state) {
            if (state is AddReviewDataState) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text(
                  "Your Review Successfully Added",
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.purple,
              ));
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (_) => const HomePage()));
            }
          },
          builder: (context, state) {
            return Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [
                Color.fromARGB(255, 75, 2, 104),
                Color.fromARGB(255, 138, 68, 150)
              ])),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: AppSize.height(context) * .4,
                    width: double.infinity,
                    child: Image.asset(
                      "images/rating.png",
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  const Text(
                    "Give Rating",
                    style: mediumText,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  RatingBar.builder(
                      direction: Axis.horizontal,
                      initialRating: 0,
                      minRating: 1,
                      itemBuilder: (context, index) {
                        return const Icon(
                          Icons.star,
                          color: Colors.amber,
                        );
                      },
                      onRatingUpdate: (rating) {
                        setState(() {
                          ratingValue = rating.toString();
                        });
                        print(ratingValue);
                      }),
                  SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Comment",
                    style: mediumText,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    height: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey)),
                    child: TextFormField(
                      style: TextStyle(color: Colors.white),
                      cursorColor: Colors.white,
                      controller: comment,
                      decoration: const InputDecoration(
                        hintText: "Give your Comments",
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.w300,
                            color: Color.fromARGB(255, 187, 186, 186)),
                        enabledBorder:
                            UnderlineInputBorder(borderSide: BorderSide.none),
                        focusedBorder:
                            UnderlineInputBorder(borderSide: BorderSide.none),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Color.fromARGB(255, 93, 154, 204)),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            padding: MaterialStateProperty.all(
                                EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 80))),
                        onPressed: () {
                          if (comment.text.isEmpty || ratingValue == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'Please fill out both rating and comment fields.'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          } else {
                            addReviewBloc.add(AddReviewDataEvent(
                                username: username,
                                email: email,
                                rating: ratingValue,
                                comments: comment.text,
                                latitude: latitude,
                                longitude: longitude,
                                gameId: widget.gameId));
                            // getCurrentLocation();
                            // print(comment.text);
                            // print(ratingValue);
                            // print(username);
                            // print(email);
                            // print(widget.gameId);
                            // print("Longatude${longitude}");
                            // print("latitude${latitude}");
                          }
                        },
                        child: Text(
                          "Save Review",
                          style: wColor,
                        )),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

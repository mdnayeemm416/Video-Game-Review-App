import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';
import 'package:videogame_review_app/App_Constant/app_constant.dart';
import 'package:readmore/readmore.dart';
import 'package:videogame_review_app/Model/review_model.dart';

class UserReviewCard extends StatefulWidget {
  final List<ReviewModel> reviewPageData;

  const UserReviewCard({
    Key? key,
    required this.reviewPageData,
  }) : super(key: key);

  @override
  State<UserReviewCard> createState() => _UserReviewCardState();
}

class _UserReviewCardState extends State<UserReviewCard> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSize.height(context) * 0.5,
      child: ListView.builder(
        itemCount: widget.reviewPageData.length,
        itemBuilder: (context, index) {
          ReviewModel reviewpagedata = widget.reviewPageData[index];
          String formatDate(String dateString) {
            DateTime dateTime = DateTime.parse(dateString);
            String formattedDate = DateFormat.yMMMMd().format(dateTime);
            return formattedDate;
          }

          String formattedDate =
              formatDate(reviewpagedata.createdOn.toString());

          return FutureBuilder<String>(
            future: getUserLocation(
              double.parse(reviewpagedata.latitude),
              double.parse(reviewpagedata.longitude),
            ),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator(); // Placeholder widget while loading location
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                String location = snapshot.data ?? 'Unknown Location';
                return Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundColor:
                                    const Color.fromARGB(255, 82, 156, 216),
                                child: Text(
                                  reviewpagedata.username.substring(0, 1),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                reviewpagedata.username,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.more_vert,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          RatingBarIndicator(
                            itemSize: 15,
                            rating: reviewpagedata.rating,
                            itemCount: 5,
                            itemBuilder: (index, context) {
                              return const Icon(
                                Icons.star,
                                color: Color.fromARGB(255, 159, 206, 245),
                              );
                            },
                          ),
                          const SizedBox(width: 10),
                          Text(
                            formattedDate,
                            style: wColor,
                          ),
                        ],
                      ),
                      ReadMoreText(
                        reviewpagedata.comments,
                        style: const TextStyle(color: Colors.white54),
                        trimLines: 2,
                        trimMode: TrimMode.Line,
                        trimExpandedText: 'Show Less',
                        trimCollapsedText: 'Show More',
                        moreStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 227, 129, 244),
                        ),
                        lessStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 227, 129, 244),
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.location_pin,
                            color: Colors.blue,
                          ),
                          Text(
                            location,
                            style: TextStyle(color: Colors.white70),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }

  Future<String> getUserLocation(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);
      Placemark place = placemarks[0];
      return "${place.name}, ${place.locality}, ${place.country}";
    } catch (e) {
      print("Error getting location: $e");
      return 'Unknown Location';
    }
  }
}

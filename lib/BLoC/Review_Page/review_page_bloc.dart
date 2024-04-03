import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:videogame_review_app/Model/review_model.dart';

part 'review_page_event.dart';
part 'review_page_state.dart';

class ReviewPageBloc extends Bloc<ReviewPageEvent, ReviewPageState> {
  ReviewPageBloc() : super(ReviewPageInitial()) {
    on<ReviewPageInitialDataFetchEvent>(reviewPageInitialDataFetchEvent);
  }

  Future<FutureOr<void>> reviewPageInitialDataFetchEvent(
      ReviewPageInitialDataFetchEvent event,
      Emitter<ReviewPageState> emit) async {
    var client = http.Client();
    try {
      var response = await client.get(
        Uri.parse(
            'https://gce9f5f8a8b9d3c-w9grokp1k58x32cl.adb.ap-singapore-1.oraclecloudapps.com/ords/oci_practice/GAMES/REVIEW?game_id=${event.gameId}'),
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        List<dynamic> items = jsonResponse['items'];
        List<ReviewModel> reviewPageData =
            items.map((e) => ReviewModel.fromJson(e)).toList();
        emit(ReviewPageSuccessState(reviewPageData: reviewPageData));
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}

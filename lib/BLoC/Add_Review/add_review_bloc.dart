import 'dart:async';


import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

part 'add_review_event.dart';
part 'add_review_state.dart';

class AddReviewBloc extends Bloc<AddReviewEvent, AddReviewState> {
  AddReviewBloc() : super(AddReviewInitial()) {
    on<AddReviewDataEvent>(addReviewDataEvent);
  }
  Future<FutureOr<void>> addReviewDataEvent(
      AddReviewDataEvent event, Emitter<AddReviewState> emit) async {
    var client = http.Client();

    try {
      var response = await client.post(
        Uri.parse(
            'https://gce9f5f8a8b9d3c-w9grokp1k58x32cl.adb.ap-singapore-1.oraclecloudapps.com/ords/oci_practice/GAMES/REVIEW'),
        body: {
          "Username": event.username,
          "Email": event.email,
          "Rating": event.rating,
          "Comments": event.comments,
          "Latitude": event.latitude,
          "Longitude": event.longitude,
          "Game_id": event.gameId
        },
      );
      print(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        emit(AddReviewDataState());
        print("Comment added successfully");
      } else {
        print("Failed to add comment. Status code: ${response.statusCode}");
        print("Response body: ${response.body}");
      }
    } catch (e) {
      print("Error adding comment: $e");
    } finally {
      client.close(); // Close the HTTP client
    }
  }
}

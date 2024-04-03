import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:videogame_review_app/Model/gamedata_model.dart';
import 'package:http/http.dart' as http;

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<GameDataInitialFetchEvent>(gameDataInitialFetchEvent);
  }

  Future<FutureOr<void>> gameDataInitialFetchEvent(
      GameDataInitialFetchEvent event, Emitter<HomeState> emit) async {
    var client = http.Client();

    try {
      var response = await client.get(
        Uri.parse(
            'https://gce9f5f8a8b9d3c-w9grokp1k58x32cl.adb.ap-singapore-1.oraclecloudapps.com/ords/oci_practice/GAMES/API'),
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        List<dynamic> items = jsonResponse['items'];
        List<Item> gameData = items.map((e) => Item.fromJson(e)).toList();

        emit(GameDataSuccessState(gameData: gameData));
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}

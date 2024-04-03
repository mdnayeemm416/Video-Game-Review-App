part of 'home_bloc.dart';

@immutable
sealed class HomeState {}
sealed class HomeActionState extends HomeState{}


final class HomeInitial extends HomeState {}




class GameDataSuccessState extends HomeState {
  final List<Item> gameData;
  GameDataSuccessState({
    required this.gameData,
  });
}

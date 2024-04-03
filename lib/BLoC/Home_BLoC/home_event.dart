part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class GameDataInitialFetchEvent extends HomeEvent{}
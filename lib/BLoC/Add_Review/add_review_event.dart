// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'add_review_bloc.dart';

@immutable
sealed class AddReviewEvent {}

class AddReviewDataEvent extends AddReviewEvent {
  final String username;
  final String email;
  final String rating;
  final String comments;
  final String latitude;
  final String longitude;
  final String gameId;
  AddReviewDataEvent({
    required this.username,
    required this.email,
    required this.rating,
    required this.comments,
    required this.latitude,
    required this.longitude,
    required this.gameId,
  });

 
}

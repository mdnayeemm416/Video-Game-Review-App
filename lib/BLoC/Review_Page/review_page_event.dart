// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'review_page_bloc.dart';

@immutable
sealed class ReviewPageEvent {}

class ReviewPageInitialDataFetchEvent extends ReviewPageEvent {
  final int gameId;
  ReviewPageInitialDataFetchEvent({
    required this.gameId,
  });
}

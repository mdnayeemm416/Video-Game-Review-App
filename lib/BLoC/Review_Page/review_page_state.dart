// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'review_page_bloc.dart';

@immutable
sealed class ReviewPageState {}

sealed class ReviewPageActionState extends ReviewPageState {}

final class ReviewPageInitial extends ReviewPageState {}

class ReviewPageSuccessState extends ReviewPageState {
  final List<ReviewModel> reviewPageData;
  ReviewPageSuccessState({
    required this.reviewPageData,
  });
}

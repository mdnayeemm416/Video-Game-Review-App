part of 'add_review_bloc.dart';

@immutable
sealed class AddReviewState {}

sealed class AddreviewActionState extends AddReviewState{}

final class AddReviewInitial extends AddReviewState {}

class AddReviewDataState extends AddreviewActionState{}

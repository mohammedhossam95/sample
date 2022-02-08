part of 'home_cubit.dart';

abstract class HomeState {}

class PostsInitial extends HomeState {}

class PostsLoadingState extends HomeState {
  final bool isLoading;
  PostsLoadingState(this.isLoading);
}

class FetchPostesSuccessState extends HomeState {
  final List<Posts> posts;

  FetchPostesSuccessState(this.posts);
}

class FailurePostesState extends HomeState {
  final String? message;
  FailurePostesState({this.message});
}

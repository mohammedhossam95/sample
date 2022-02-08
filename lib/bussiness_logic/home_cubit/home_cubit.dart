import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_app/data/model/posts.dart';
import 'package:sample_app/data/repositories/home_repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepositoryImp homeRepository;

  HomeCubit({required this.homeRepository}) : super(PostsInitial());

  bool isLoading = false;
  List<Posts> apiPosts = [];
  List<Posts> myPostsList = [];

  Future<void> getAllPosts() async {
    changeLoadingView();
    apiPosts = await homeRepository.getAllPostes();
    myPostsList = (apiPosts.getRange(0, 10)).toList();
    emit(FetchPostesSuccessState(myPostsList));
  }

  void loadMore() {
    Future.delayed(const Duration(seconds: 1), () {
      if (myPostsList.length < 100) {
        _getNextTenItem(lengthRange: myPostsList.length);
      }
    });
    if (myPostsList.isNotEmpty) {
      emit(FetchPostesSuccessState(myPostsList));
    }
  }

  void _getNextTenItem({required int lengthRange}) {
    final nextTenItems =
        (apiPosts.getRange(lengthRange, lengthRange + 10)).toList();
    myPostsList.addAll(nextTenItems);
  }

  void changeLoadingView() {
    isLoading = !isLoading;
    emit(PostsLoadingState(isLoading));
  }
}

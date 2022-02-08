import 'package:flutter/material.dart';
import 'package:loadmore/loadmore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_app/bussiness_logic/home_cubit/home_cubit.dart';
import 'package:sample_app/ui/home/widgets/error_text.dart';
import 'package:sample_app/ui/home/widgets/post_item.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({Key? key}) : super(key: key);

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is PostsLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is FetchPostesSuccessState) {
          return state.posts.isNotEmpty
              ? LoadMore(
                  isFinish: state.posts.length >= 100,
                  onLoadMore: _loadMore,
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: state.posts.length,
                    itemBuilder: (context, index) {
                      return PostItem(
                        post: state.posts[index],
                        index: index,
                      );
                    },
                  ),
                  whenEmptyLoad: false,
                  delegate: const DefaultLoadMoreDelegate(),
                  textBuilder: DefaultLoadMoreTextBuilder.english,
                )
              : Center(
                  child: ErrorText(
                    text: 'No data found',
                    width: MediaQuery.of(context).size.width,
                    isNetwork: false,
                  ),
                );
        } else if (state is FailurePostesState) {
          return Center(child: Text(state.message ?? ''));
        }
        return Center(child: Text("$state"));
      },
    );
  }

  Future<bool> _loadMore() async {
    await Future.delayed(const Duration(seconds: 0, milliseconds: 2000));
    context.read<HomeCubit>().loadMore();
    return true;
  }
}

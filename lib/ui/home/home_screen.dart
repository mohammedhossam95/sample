import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_app/bussiness_logic/home_cubit/home_cubit.dart';
import 'package:sample_app/ui/home/widgets/posts_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String page = 'posts';

  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeCubit>(context).getAllPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Posts")),
      body: const PostsScreen(),
    );
  }
}

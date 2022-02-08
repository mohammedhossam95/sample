import 'package:flutter/material.dart';
import 'package:sample_app/data/model/posts.dart';

class PostItem extends StatelessWidget {
  final Posts post;
  final int? index;

  const PostItem({
    Key? key,
    required this.post,
    this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.grey[200],
      ),
      child: Column(
        children: [
          Text(
            post.title ?? '',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.lightBlue[700],
                fontWeight: FontWeight.bold,
                fontSize: 15),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(post.body ?? '',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey[700], fontSize: 15)),
        ],
      ),
    );
  }
}

import 'package:blog_app/features/blogs/presentation/pages/add_new_blog_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BlogScreen extends StatelessWidget {
  const BlogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Blogs App')),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context, AddNewBlogScreen.route());
              },
              icon: const Icon(
                CupertinoIcons.add_circled,
                size: 26,
              ))
        ],
      ),
    );
  }
}

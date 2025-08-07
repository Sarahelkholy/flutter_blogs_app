import '../../../../core/common/widgets/loader.dart';
import '../../../../core/theme/app_pallete.dart';
import '../../../../core/utils/show_snackbar.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/pages/login_screen.dart';
import '../bloc/blog_bloc.dart';
import 'add_new_blog_screen.dart';
import '../widgets/blog_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlogScreen extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const BlogScreen());
  const BlogScreen({super.key});

  @override
  State<BlogScreen> createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  @override
  void initState() {
    super.initState();
    context.read<BlogBloc>().add(BlogFetchAllBlogs());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthFailure) {
          showSnackBar(context, state.message);
        } else if (state is AuthInitial) {
          Navigator.pushReplacement(context, LoginScreen.route());
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              context.read<AuthBloc>().add(AuthLogout());
            },
            icon: const Icon(Icons.logout, size: 26),
            tooltip: 'Logout',
          ),
          title: const Text('Blogs App'),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(context, AddNewBlogScreen.route());
              },
              icon: const Icon(CupertinoIcons.add_circled, size: 26),
              tooltip: 'Add Blog',
            ),
          ],
        ),
        body: BlocConsumer<BlogBloc, BlogState>(
          listener: (context, state) {
            if (state is BlogFailure) {
              showSnackBar(context, state.error);
            }
          },
          builder: (context, state) {
            if (state is BlogLoading) return const Loader();

            if (state is BlogDisplaySucess) {
              return ListView.builder(
                itemCount: state.blogs.length,
                itemBuilder: (context, index) {
                  final blog = state.blogs[index];
                  return BlogCard(
                    blog: blog,
                    color: index % 3 == 0
                        ? AppPallete.gradient1
                        : index % 3 == 1
                            ? AppPallete.gradient2
                            : AppPallete.gradient3,
                  );
                },
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}

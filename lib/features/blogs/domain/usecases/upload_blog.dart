import 'dart:io';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/blog.dart';
import '../repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class UploadBlog implements UseCase<Blog, UploadBlogParams> {
  final BlogRepository blogRepository;

  UploadBlog(this.blogRepository);

  @override
  Future<Either<Failures, Blog>> call(UploadBlogParams params) async {
    return await blogRepository.uploadBlog(
      posterId: params.posterId,
      image: params.image,
      title: params.title,
      content: params.content,
      topics: params.topics,
    );
  }
}

class UploadBlogParams {
  final String posterId;
  final File image;
  final String title;
  final String content;
  final List<String> topics;

  UploadBlogParams(
      {required this.posterId,
      required this.image,
      required this.title,
      required this.content,
      required this.topics});
}

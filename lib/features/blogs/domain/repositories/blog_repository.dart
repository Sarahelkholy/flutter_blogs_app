import 'dart:io';

import '../../../../core/error/failures.dart';
import '../entities/blog.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class BlogRepository {
  Future<Either<Failures, Blog>> uploadBlog({
    required String posterId,
    required File image,
    required String title,
    required String content,
    required List<String> topics,
  });

  Future<Either<Failures, List<Blog>>> getAllBlogs();
}

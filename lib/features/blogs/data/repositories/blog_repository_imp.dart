import 'dart:io';

import '../../../../core/constants/constants.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/connection_checker.dart';
import '../datasources/blog_local_data_source.dart';
import '../datasources/blog_remote_data_source.dart';
import '../models/blog_model.dart';
import '../../domain/entities/blog.dart';
import '../../domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

class BlogRepositoryImp implements BlogRepository {
  final BlogRemoteDataSource blogRemoteDataSource;
  final BlogLocalDataSource blogLocalDataSource;
  final ConnectionChecker connectionChecker;

  BlogRepositoryImp(this.blogRemoteDataSource, this.blogLocalDataSource,
      this.connectionChecker);

  @override
  Future<Either<Failures, Blog>> uploadBlog({
    required String posterId,
    required File image,
    required String title,
    required String content,
    required List<String> topics,
  }) async {
    try {
      if (!await (connectionChecker.isConnected)) {
        return left(Failures(Constants.noConnectionErrorMessage));
      }
      BlogModel blogModel = BlogModel(
        id: const Uuid().v1(),
        posterId: posterId,
        title: title,
        content: content,
        imageUrl: '',
        topics: topics,
        updatedAt: DateTime.now(),
      );

      final imageUrl = await blogRemoteDataSource.uploadBlogImage(
          image: image, blog: blogModel);

      blogModel = blogModel.copyWith(imageUrl: imageUrl);

      final uploadedBlog = await blogRemoteDataSource.uploadBlog(blogModel);
      return right(uploadedBlog);
    } on ServerException catch (e) {
      return left(Failures(e.message));
    }
  }

  @override
  Future<Either<Failures, List<Blog>>> getAllBlogs() async {
    try {
      if (!await (connectionChecker.isConnected)) {
        final blogs = blogLocalDataSource.loadBlogs();
        return right(blogs);
      }
      final blogs = await blogRemoteDataSource.getAllBlogs();
      blogLocalDataSource.uploadLocalBlogs(blogs: blogs);
      return right(blogs);
    } on ServerException catch (e) {
      return left(Failures(e.message));
    }
  }
}

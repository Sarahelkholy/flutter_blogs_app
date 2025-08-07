import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/blog.dart';
import '../repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetAllBlogs implements UseCase<List<Blog>, NoParams> {
  final BlogRepository blogRepository;

  GetAllBlogs(this.blogRepository);

  @override
  Future<Either<Failures, List<Blog>>> call(NoParams params) async {
    return await blogRepository.getAllBlogs();
  }
}

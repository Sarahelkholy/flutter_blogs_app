import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserLogout implements UseCase<void, NoParams> {
  final AuthRepository authRepository;

  UserLogout(this.authRepository);

  @override
  Future<Either<Failures, void>> call(NoParams params) {
    return authRepository.logout();
  }
}

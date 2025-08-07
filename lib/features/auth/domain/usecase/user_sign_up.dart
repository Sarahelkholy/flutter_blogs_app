import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/common/entities/user.dart';
import '../repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserSignUp implements UseCase<User, UserSignUpParams> {
  final AuthRepository authRepository;

  UserSignUp(this.authRepository);

  @override
  Future<Either<Failures, User>> call(UserSignUpParams params) async {
    return await authRepository.signUpWithEmailAndPassword(
      email: params.email,
      password: params.password,
      name: params.username,
    );
  }
}

class UserSignUpParams {
  final String email;
  final String password;
  final String username;

  UserSignUpParams({
    required this.email,
    required this.password,
    required this.username,
  });
}

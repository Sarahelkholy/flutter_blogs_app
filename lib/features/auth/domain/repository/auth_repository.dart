import '../../../../core/error/failures.dart';
import '../../../../core/common/entities/user.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  Future<Either<Failures, User>> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  });
  Future<Either<Failures, User>> loginWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<Either<Failures, User>> currentUser();
  Future<Either<Failures, void>> logout();
}

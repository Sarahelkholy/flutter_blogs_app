import 'package:blog_app/core/error/exceptions.dart';
import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:blog_app/core/common/entities/user.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sb;

class AuthRepositoryImp implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImp(this.remoteDataSource);

  @override
  Future<Either<Failures, User>> currentUser() async {
    try {
      final user = await remoteDataSource.getCurrentUserData();
      if (user == null) {
        return left(
          Failures('User not logged in!'),
        );
      }
      return right(user);
    } on ServerException catch (e) {
      return left(Failures(e.message));
    }
  }

  @override
  Future<Either<Failures, User>> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    return _getUser(
        () async => await remoteDataSource.signUpWithEmailAndPassword(
              name: name,
              email: email,
              password: password,
            ));
  }

  @override
  Future<Either<Failures, User>> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return _getUser(
        () async => await remoteDataSource.loginWithEmailAndPassword(
              email: email,
              password: password,
            ));
  }

  Future<Either<Failures, User>> _getUser(
    Future<User> Function() fn,
  ) async {
    try {
      final user = await fn();
      return right(user);
    } on sb.AuthException catch (e) {
      return left(Failures(e.message));
    } on ServerException catch (e) {
      return left(Failures(e.message));
    }
  }
}

import 'package:fpdart/fpdart.dart';

import '../../../../core/common/entities/user.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/connection_checker.dart';
import '../../domain/repository/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';
import '../models/user_model.dart';

class AuthRepositoryImp implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final ConnectionChecker connectionChecker;
  AuthRepositoryImp(this.remoteDataSource, this.connectionChecker);

  @override
  Future<Either<Failures, User>> currentUser() async {
    try {
      if (!await connectionChecker.isConnected) {
        final session = remoteDataSource.currentUserSession;
        if (session == null) {
          return left(
            Failures('User not logged in!'),
          );
        }
        return right(
          UserModel(
              id: session.user.id, email: session.user.email ?? '', name: ''),
        );
      }
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
      if (!await connectionChecker.isConnected) {
        return left(Failures(Constants.noConnectionErrorMessage));
      }
      final user = await fn();
      return right(user);
    } on ServerException catch (e) {
      return left(Failures(e.message));
    }
  }

  @override
  Future<Either<Failures, void>> logout() async {
    try {
      if (!await connectionChecker.isConnected) {
        return left(Failures(Constants.noConnectionErrorMessage));
      }

      await remoteDataSource.logout();
      return right(null);
    } on ServerException catch (e) {
      return left(Failures(e.message));
    }
  }
}

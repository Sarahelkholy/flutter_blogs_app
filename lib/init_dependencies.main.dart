part of 'init_dependencies.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  _initBlog();
  final supabase = await Supabase.initialize(
      url: AppSecrets.supabaseUrl, anonKey: AppSecrets.supabaseAnonKey);
  Hive.defaultDirectory = (await getApplicationDocumentsDirectory()).path;

  serviceLocator.registerLazySingleton(() => Hive.box(name: 'blogs'));

  serviceLocator.registerLazySingleton(() => supabase.client);
  serviceLocator.registerFactory(() => InternetConnection());

// core
  serviceLocator.registerLazySingleton(() => AppUserCubit());
  serviceLocator.registerFactory<ConnectionChecker>(
      () => ConnectionCheckerImp(serviceLocator()));
}

void _initAuth() {
  //Data source
  serviceLocator
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(serviceLocator()),
    )
    //Repository
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImp(serviceLocator(), serviceLocator()),
    )
    // Use Cases
    ..registerFactory(
      () => UserSignUp(serviceLocator()),
    )
    ..registerFactory(
      () => UserLogin(serviceLocator()),
    )
    ..registerFactory(
      () => CurrentUser(serviceLocator()),
    )
    ..registerFactory(
      () => UserLogout(serviceLocator()),
    )
    // Bloc
    ..registerLazySingleton(
      () => AuthBloc(
          userSignUp: serviceLocator(),
          userLoghin: serviceLocator(),
          currentUser: serviceLocator(),
          userLogout: serviceLocator(),
          appUserCubit: serviceLocator()),
    );
}

void _initBlog() {
  //Data source
  serviceLocator
    ..registerFactory<BlogRemoteDataSource>(
      () => BlogRemoteDataSourceImp(serviceLocator()),
    )
    ..registerFactory<BlogLocalDataSource>(
      () => BlogLocalDataSourceImp(
        serviceLocator(),
      ),
    )
    //Repository

    ..registerFactory<BlogRepository>(
      () => BlogRepositoryImp(
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
      ),
    )
    // Use Cases
    ..registerFactory(
      () => UploadBlog(serviceLocator()),
    )
    ..registerFactory(
      () => GetAllBlogs(serviceLocator()),
    )
    // bloc
    ..registerLazySingleton(() => BlogBloc(
          uploadBlog: serviceLocator(),
          getAllBlogs: serviceLocator(),
        ));
}

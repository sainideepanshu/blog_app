import 'package:blog_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog_app/core/secrets/app_secrets.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:blog_app/features/auth/domain/usecases/current_user.dart';
import 'package:blog_app/features/auth/domain/usecases/user_login.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/blog/data/datasources/blog_remote_data_source.dart';
import 'package:blog_app/features/blog/data/repositories/blog_repository_impl.dart';
import 'package:blog_app/features/blog/domain/repositories/blog_repository.dart';
import 'package:blog_app/features/blog/domain/usecases/get_all_blogs.dart';
import 'package:blog_app/features/blog/domain/usecases/upload_blog.dart';
import 'package:blog_app/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'features/auth/data/datasources/auth_remote_data_source.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/usecases/user_sign_up.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  _initBlog();
  final supabase = await Supabase.initialize(
      url: AppSecrets.supabaseUrl, anonKey: AppSecrets.supabaseAnonKey);

  serviceLocator.registerLazySingleton(() => supabase.client);

  serviceLocator.registerLazySingleton(
    () => AppUserCubit(),
  );
}

void _initAuth() {
  serviceLocator
    //Datasource
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(
        serviceLocator(),
      ),
    )
    //Repository
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(
        serviceLocator(),
      ),
    )
    //Use cases
    ..registerFactory(
      () => UserSignUp(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => UserLogin(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => CurrentUser(
        serviceLocator(),
      ),
    )
    //Bloc
    ..registerLazySingleton(
      () => AuthBloc(
        userSignUp: serviceLocator(),
        userLogin: serviceLocator(),
        currentUser: serviceLocator(),
        appUserCubit: serviceLocator(),
      ),
    );
}

void _initBlog() {
  serviceLocator
    // Datasource
    ..registerFactory<BlogRemoteDataSource>(
      () => BlogRemoteDataSourceImpl(
        serviceLocator(),
      ),
    )
    // Repository
    ..registerFactory<BlogRepository>(
      () => BlogRepositoryImpl(
        serviceLocator(),
      ),
    )
    // Use cases
    ..registerFactory(
      () => UploadBlog(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => GetAllBlogs(
        serviceLocator(),
      ),
    )
    // Bloc
    ..registerLazySingleton(
      () => BlogBloc(
        uploadBlog: serviceLocator(),
        getAllBlogs: serviceLocator(),
      ),
    );
}

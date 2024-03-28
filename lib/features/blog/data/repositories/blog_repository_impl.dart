import 'dart:io';

import 'package:blog_app/core/constants/constants.dart';
import 'package:blog_app/core/error/exceptions.dart';
import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/core/network/connection_checker.dart';
import 'package:blog_app/features/blog/data/datasources/blog_local_data_source.dart';
import 'package:blog_app/features/blog/data/datasources/blog_remote_data_source.dart';
import 'package:blog_app/features/blog/data/models/blog_model.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:blog_app/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

class BlogRepositoryImpl implements BlogRepository {
  final BlogRemoteDataSource blogRemoteDataSource;
  final BlogLocalDataSource blogLocalDataSource;
  final ConnectionChecker connectionChecker;

  BlogRepositoryImpl(
    this.blogRemoteDataSource,
    this.blogLocalDataSource,
    this.connectionChecker,
  );

  @override
  Future<Either<Failure, Blog>> uploadBlog({
    required File image,
    required String title,
    required String content,
    required String posterId,
    required List<String> topics,
  }) async {
    try {
      if (!await (connectionChecker.isConnected)) {
        return left(Failure(Constants.noConnectionErrorMessage));
      }

      BlogModel blogModel = BlogModel(
        id: const Uuid()
            .v1(), // this id will be randomly generated , Supabase is not going to do it , we will use Uuid package
        posterId: posterId,
        title: title,
        content: content,
        imageUrl: '',
        topics: topics,
        updatedAt: DateTime.now(),
      );

      //This will give us the image url after uploading the image in supabase and getting the url in response
      //THen we will assign this url to blog model to upload the final blog model
      //We have uploaded this blog image to supabase storage
      final imageUrl = await blogRemoteDataSource.uploadBlogImage(
        image: image,
        blog: blogModel,
      );

      // assigning this url to blog model to upload the final blog model
      // using a copyWith constructor since all the fields in Blog entity are final fields
      blogModel = blogModel.copyWith(
        imageUrl: imageUrl,
      );

      //Now uploading the blog model to supabase database
      final uploadedBlog = await blogRemoteDataSource.uploadBlog(blogModel);

      return right(uploadedBlog);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Blog>>> getAllBlogs() async {
    try {
      if (!await (connectionChecker.isConnected)) {
        final blogs = blogLocalDataSource.loadBlogs();
        return right(blogs);
      }

      final blogs = await blogRemoteDataSource.getAllBlogs();
      blogLocalDataSource.uploadLocalBlogs(blogs: blogs);

      return right(blogs);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}

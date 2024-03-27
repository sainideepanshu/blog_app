import 'dart:io';

import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class BlogRepository {
  //Why I have not created a BlogModel in place of these so many arguments because I will create it in data layer in BlogRepository implementation
  Future<Either<Failure, Blog>> uploadBlog({
    required File image,
    required String title,
    required String content,
    required String posterId, // posterId is the user who posted it
    required List<String> topics,
  });
}

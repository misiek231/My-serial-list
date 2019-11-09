import 'package:meta/meta.dart';
import 'package:my_serial_list/features/film_production/domain/entities/comment.dart';

class CommentModel extends Comment {
  CommentModel({
    @required description,
    @required username,
    @required createAt,
    @required isCurrentUserComment,
  }) : super(
          createAt: createAt,
          description: description,
          isCurrentUserComment: isCurrentUserComment,
          username: username,
        );

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      description: json['description'],
      username: json['username'],
      createAt: json['createAt'],
      isCurrentUserComment: json['isCurrentUserComment'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'description': this.description,
      'username': this.username,
      'createAt': this.createAt,
      'isCurrentUserComment': this.isCurrentUserComment,
    };
  }
}

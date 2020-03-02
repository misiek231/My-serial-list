import 'package:meta/meta.dart';

class Comment {
  final String description;
  final String username;
  final String createAt;
  final bool isCurrentUserComment;

  Comment({
    @required this.description,
    @required this.username,
    @required this.createAt,
    @required this.isCurrentUserComment,
  });
}

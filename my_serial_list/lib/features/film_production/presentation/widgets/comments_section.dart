import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_serial_list/features/film_production/domain/entities/comment.dart';
import 'package:my_serial_list/features/film_production/presentation/bloc/comments/bloc.dart';
import 'package:my_serial_list/injection_container.dart';

class CommentsSection extends StatefulWidget {
  final int filmProductionId;
  const CommentsSection({Key key, @required this.filmProductionId})
      : super(key: key);

  @override
  _CommentsSectionState createState() => _CommentsSectionState();
}

class _CommentsSectionState extends State<CommentsSection> {
  CommentsBloc bloc = sl<CommentsBloc>();

  @override
  void initState() {
    bloc.add(GetMoreComments(widget.filmProductionId));
    super.initState();
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          _buildAddingComment(),
          Divider(),
          BlocBuilder<CommentsBloc, CommentsState>(
            bloc: bloc,
            builder: (context, state) {
              if (state is InitialCommentsState) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (state is Loaded) {
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.comments.length,
                  itemBuilder: (context, index) {
                    return _buildComment(state.comments[index]);
                  },
                );
              } else if (state is Empty) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      'Brak komentarzy',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                );
              } else if (state is Error) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      state.error,
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                );
              }
              return null;
            },
          )
        ],
      ),
    );
  }

  Widget _buildComment(Comment comment) {
    return Card(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CircleAvatar(
            child: Text(comment.username[0]),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          comment.username,
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(comment.createAt),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(comment.description),
                  ],
                )),
          ),
          PopupMenuButton<String>(
            onSelected: (String result) {},
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                child: Text('Usuń'),
              ),
              const PopupMenuItem<String>(
                child: Text('Edytuj'),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildAddingComment() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          CircleAvatar(
            child: Text('M'),
          ),
          SizedBox(width: 20),
          Expanded(
            child: TextField(
              decoration: InputDecoration(hintText: 'Dodaj komentarz...'),
              style: TextStyle(fontSize: 20),
              keyboardType: TextInputType.multiline,
            ),
          ),
          SizedBox(width: 20),
          IconButton(
            icon: Icon(Icons.arrow_forward),
            onPressed: () {},
          )
        ],
      ),
    );
  }
}

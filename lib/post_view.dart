
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:from_cubit_to_bloc/post_bloc.dart';

class PostView extends StatefulWidget {
  const PostView({Key key}) : super(key: key);

  @override
  _PostViewState createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Post'),),
      body: BlocBuilder<PostBloc,PostState>(
        builder: (context, state) {
          if(state is LoadingPostState){
            return Center(child: CircularProgressIndicator(),);
          }
          else if(state is LoadedPostState){
            return RefreshIndicator(
              onRefresh:()async=>BlocProvider.of<PostBloc>(context).add(PullToRefreshEvent()),
              child: ListView.builder(
                  itemCount: state.post.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(title: Text(state.post[index].title),),
                    );
                  }),
            );
          }
          else if(state is FailedPostState){
            return Center(child: Text('Error : ${state.error}'),);

          }
          else{
            return Container();
          }
        },
      ),
    );
  }
}

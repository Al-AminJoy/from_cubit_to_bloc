
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:from_cubit_to_bloc/data_service.dart';
import 'package:from_cubit_to_bloc/post_model.dart';

abstract class PostEvent{}
class LoadPostEvent extends PostEvent{}
class PullToRefreshEvent extends PostEvent{}

abstract class PostState{}
class LoadingPostState extends PostState{}
class LoadedPostState extends PostState{
  List<Post> post;
  LoadedPostState({this.post});
}
class FailedPostState extends PostState{
  Error error;
  FailedPostState({this.error});
}

class PostBloc extends Bloc<PostEvent,PostState>{
  final _dataService=DataService();
  PostBloc():super(LoadingPostState());

  @override
  Stream<PostState> mapEventToState(PostEvent event)async* {
    if(event is LoadPostEvent || event is PullToRefreshEvent){
      yield LoadingPostState();
      try{
        final post = await _dataService.getPosts();
        yield LoadedPostState(post: post);
      }
      catch(e){
        yield FailedPostState(error: e);
      }
    }
  }
  
}


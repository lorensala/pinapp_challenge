import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinapp_challenge/comments/cubit/comments_cubit.dart';
import 'package:pinapp_challenge/posts/posts.dart';
import 'package:posts/posts.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('PinApp'),
      ),
      backgroundColor:
          CupertinoColors.systemGroupedBackground.resolveFrom(context),
      child: BlocBuilder<PostsCubit, PostsState>(
        builder: (context, state) {
          return switch (state) {
            PostsInitial() ||
            PostsLoading() =>
              const Center(child: CupertinoActivityIndicator()),
            PostsSuccess(:final posts, :final hasMore) => SafeArea(
                child: PostList(
                  posts: posts,
                  showMore: hasMore,
                ),
              ),
            PostsFailure(:final failure) =>
              Center(child: Text(failure.message)),
          };
        },
      ),
    );
  }
}

class PostList extends StatefulWidget {
  const PostList({
    required this.posts,
    required this.showMore,
    super.key,
  });

  final List<Post> posts;
  final bool showMore;

  @override
  State<PostList> createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  late final ScrollController _controller;

  @override
  void initState() {
    _controller = ScrollController();
    _controller.addListener(() {
      if (_controller.position.atEdge) {
        context.read<PostsCubit>().showMore();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _controller,
      child: CupertinoScrollbar(
        controller: _controller,
        child: Column(
          children: [
            CupertinoListSection(
              header: const Text('Posts'),
              children: widget.posts
                  .map(
                    (post) => BlocProvider(
                      create: (context) => CommentsCubit(
                        repository: RepositoryProvider.of(context),
                      ),
                      child: Builder(
                        builder: (context) => PostListItem(post),
                      ),
                    ),
                  )
                  .toList(),
            ),
            if (widget.showMore) const CupertinoActivityIndicator(),
          ],
        ),
      ),
    );
  }
}

class PostListItem extends StatelessWidget {
  const PostListItem(
    this.post, {
    super.key,
  });

  final Post post;

  @override
  Widget build(BuildContext context) {
    return CupertinoListTile(
      onTap: () {
        final cubit = context.read<CommentsCubit>()..getPostComments(post.id);

        Navigator.of(context).push(
          PostDetailPage.route(
            post: post,
            cubit: cubit,
          ),
        );
      },
      title: Text(post.title),
      subtitle: Text(post.body),
      trailing: const CupertinoListTileChevron(),
    );
  }
}

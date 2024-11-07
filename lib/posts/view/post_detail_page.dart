import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinapp_challenge/comments/cubit/comments_cubit.dart';
import 'package:posts/posts.dart';

class PostDetailPage extends StatelessWidget {
  const PostDetailPage({required this.post, super.key});

  static Route<dynamic> route({
    required Post post,
    required CommentsCubit cubit,
  }) {
    return CupertinoPageRoute<void>(
      builder: (_) => BlocProvider.value(
        value: cubit,
        child: PostDetailPage(post: post),
      ),
    );
  }

  final Post post;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        previousPageTitle: 'Posts',
      ),
      backgroundColor:
          CupertinoColors.systemGroupedBackground.resolveFrom(context),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PostContent(post: post),
              const PostComments(),
            ],
          ),
        ),
      ),
    );
  }
}

class PostContent extends StatelessWidget {
  const PostContent({
    required this.post,
    super.key,
  });

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            post.title,
            style: CupertinoTheme.of(context).textTheme.navLargeTitleTextStyle,
          ),
          const SizedBox(height: 8),
          Text(post.body),
        ],
      ),
    );
  }
}

class PostComments extends StatelessWidget {
  const PostComments({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommentsCubit, CommentsState>(
      builder: (context, state) {
        return switch (state) {
          CommentsInitial() ||
          CommentsLoading() =>
            const Center(child: CupertinoActivityIndicator()),
          CommentsSuccess(:final comments) => CupertinoListSection(
              header: const Text('Comments'),
              footer: Text('Total: ${comments.length}'),
              children: comments
                  .map(
                    (comment) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                          ),
                          child: Text(
                            comment.email,
                            style: CupertinoTheme.of(context)
                                .textTheme
                                .actionTextStyle,
                          ),
                        ),
                        CupertinoListTile(
                          title: Text(comment.name),
                          subtitle: Text(comment.body),
                        ),
                      ],
                    ),
                  )
                  .toList(),
            ),
          CommentsFailure(:final failure) =>
            Center(child: Text(failure.message)),
        };
      },
    );
  }
}

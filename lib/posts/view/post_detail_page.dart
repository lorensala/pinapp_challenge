import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinapp_challenge/comments/comments.dart';
import 'package:pinapp_challenge/utils/utils.dart';
import 'package:posts/posts.dart';

class PostDetailPage extends StatelessWidget {
  const PostDetailPage({required this.post, super.key});

  final Post post;

  static Route<dynamic> route({
    required Post post,
  }) {
    return CupertinoPageRoute<void>(
      builder: (_) => PostDetailPage(
        post: post,
      ),
    );
  }

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
              PostComments(post: post),
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

class PostComments extends ConsumerWidget {
  const PostComments({
    required this.post,
    super.key,
  });

  final Post post;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posts = ref.watch(commentsNotifierProvider(postId: post.id));

    return posts.when(
      data: (comments) => CommentsList(comments: comments),
      loading: () => const Center(child: CupertinoActivityIndicator()),
      error: (error, _) => Center(child: Text(parseError(error))),
    );
  }
}

class CommentsList extends StatelessWidget {
  const CommentsList({required this.comments, super.key});

  final List<Comment> comments;

  @override
  Widget build(BuildContext context) {
    return CupertinoListSection(
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
                    style: CupertinoTheme.of(context).textTheme.actionTextStyle,
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
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinapp_challenge/posts/posts.dart';
import 'package:pinapp_challenge/utils/parse_error.dart';
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
      child: const PostsBody(),
    );
  }
}

class PostsBody extends ConsumerWidget {
  const PostsBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posts = ref.watch(postNotifierProvider);

    return posts.when(
      data: (posts) => PostList(posts: posts, showMore: true),
      loading: () => const Center(child: CupertinoActivityIndicator()),
      error: (error, _) => Center(child: Text(parseError(error))),
    );
  }
}

class PostList extends ConsumerStatefulWidget {
  const PostList({
    required this.posts,
    required this.showMore,
    super.key,
  });

  final List<Post> posts;
  final bool showMore;

  @override
  ConsumerState<PostList> createState() => _PostListState();
}

class _PostListState extends ConsumerState<PostList> {
  late final ScrollController _controller;

  @override
  void initState() {
    _controller = ScrollController();
    _controller.addListener(() {
      if (_controller.position.atEdge) {
        ref.read(postNotifierProvider.notifier).showMore();
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
              children: widget.posts.map(PostListItem.new).toList(),
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
      onTap: () => Navigator.of(context).push(PostDetailPage.route(post: post)),
      title: Text(post.title),
      subtitle: Text(post.body),
      trailing: const CupertinoListTileChevron(),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinapp_challenge/l10n/l10n.dart';
import 'package:pinapp_challenge/posts/cubit/posts_cubit.dart';
import 'package:pinapp_challenge/posts/view/posts_page.dart';
import 'package:posts/posts.dart';

class App extends StatelessWidget {
  const App({required this.postRepository, super.key});

  final PostRepository postRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: postRepository,
      child: BlocProvider(
        create: (context) => PostsCubit(
          repository: RepositoryProvider.of<PostRepository>(context),
        )..getPosts(),
        child: const CupertinoApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: PostsPage(),
        ),
      ),
    );
  }
}

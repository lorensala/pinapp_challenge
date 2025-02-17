import 'package:flutter/cupertino.dart';
import 'package:pinapp_challenge/l10n/l10n.dart';
import 'package:pinapp_challenge/posts/view/posts_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: PostsPage(),
    );
  }
}

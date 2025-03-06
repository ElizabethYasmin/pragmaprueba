import 'package:go_router/go_router.dart';
//import '../../presentation/screens/cat_screen.dart';
import '../../presentation/screens/cat_screen.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (_, __) => CatScreen(),
    ),
  ],
);

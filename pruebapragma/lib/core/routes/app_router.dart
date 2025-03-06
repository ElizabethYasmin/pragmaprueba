import 'package:go_router/go_router.dart';
import 'package:pruebapragma/presentation/screens/cat_screen.dart';
import '../../presentation/screens/splash_screen.dart';
import '../../presentation/screens/landing_screen.dart';
import '../../presentation/screens/detail_screen.dart';
import '../../presentation/screens/detail_scroll_screen.dart';
import 'package:pruebapragma/data/models/cat_model.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (_, __) => const SplashScreen()),
    GoRoute(path: '/landing', builder: (_, __) => const CatScreen()),
    //GoRoute(path: '/landing', builder: (_, __) => const LandingScreen()),
    GoRoute(path: '/detail', builder: (_, __) => const DetailScreen()),
    GoRoute(
      path: '/detail-scroll',
      builder: (context, state) {
        final cat = state.extra as CatModel; // Aquí casteas el objeto
        return DetailScrollScreen(cat: cat);
      },
    ),

  ],
);
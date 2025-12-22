import 'package:go_router/go_router.dart';
import '../pages/dashboard_screen.dart';
import '../pages/transaction_detail_screen.dart';
import '../pages/add_edit_transaction_screen.dart';
import '../pages/pin_screen.dart';
import '../pages/settings_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => const PinScreen(),
    ),
    GoRoute(
      path: '/dashboard',
      builder: (context, state) => const DashboardScreen(),
    ),
    GoRoute(
      path: '/add',
      builder: (context, state) => const AddEditTransactionScreen(),
    ),
    GoRoute(
      path: '/edit/:id',
      builder: (context, state) => AddEditTransactionScreen(id: state.pathParameters['id']),
    ),
    GoRoute(
      path: '/tx/:id',
      builder: (context, state) => TransactionDetailScreen(id: state.pathParameters['id']!),
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsScreen(),
    ),
  ],
);

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_wallet_lite/presentation/providers/transaction_provider.dart';

part 'connectivity_provider.g.dart';

@riverpod
Stream<List<ConnectivityResult>> connectivityStatus(Ref ref) {
  return Connectivity().onConnectivityChanged;
}

@riverpod
void connectivitySync(Ref ref) {
  final status = ref.watch(connectivityStatusProvider);
  
  status.whenData((results) {
    // If we have any active connection (Wi-Fi, Mobile, etc.)
    final hasConnection = results.any((result) => result != ConnectivityResult.none);
    
    if (hasConnection) {
      // Small delay to ensure network is fully stable before hitting the "server"
      Future.delayed(const Duration(seconds: 2), () {
        ref.read(transactionListProvider.notifier).syncData();
      });
    }
  });
}

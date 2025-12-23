import 'package:flutter/material.dart';
import '../../domain/entities/sync_status.dart';

/// Badge that displays sync status for an item
class SyncStatusBadge extends StatelessWidget {
  final bool isSynced;
  final bool editedLocally;
  final bool compact;

  const SyncStatusBadge({
    super.key,
    required this.isSynced,
    required this.editedLocally,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    // Only show badge if not synced or edited locally
    if (isSynced && !editedLocally) {
      return const SizedBox.shrink();
    }

    final badge = _buildBadge(context);
    
    if (compact) {
      return badge;
    }

    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: badge,
    );
  }

  Widget _buildBadge(BuildContext context) {
    if (editedLocally) {
      return _Badge(
        icon: Icons.edit_outlined,
        label: compact ? null : 'Edited Locally',
        color: Colors.orange,
        tooltip: 'This item has local edits pending sync',
      );
    }

    if (!isSynced) {
      return _Badge(
        icon: Icons.cloud_upload_outlined,
        label: compact ? null : 'Pending Sync',
        color: Colors.blue,
        tooltip: 'This item is waiting to sync',
      );
    }

    return const SizedBox.shrink();
  }
}

class _Badge extends StatelessWidget {
  final IconData icon;
  final String? label;
  final Color color;
  final String tooltip;

  const _Badge({
    required this.icon,
    required this.label,
    required this.color,
    required this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    final Widget badge = Container(
      padding: label != null
          ? const EdgeInsets.symmetric(horizontal: 8, vertical: 4)
          : const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          if (label != null) ...[
            const SizedBox(width: 4),
            Text(
              label!,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ],
      ),
    );

    return Tooltip(
      message: tooltip,
      child: badge,
    );
  }
}

/// Global sync status indicator (for app bar or similar)
class GlobalSyncIndicator extends StatelessWidget {
  final ValueNotifier<SyncStatus> syncStatusNotifier;
  final VoidCallback? onTap;

  const GlobalSyncIndicator({
    super.key,
    required this.syncStatusNotifier,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<SyncStatus>(
      valueListenable: syncStatusNotifier,
      builder: (context, status, _) {
        return InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: _buildStatusIcon(status),
          ),
        );
      },
    );
  }

  Widget _buildStatusIcon(SyncStatus status) {
    switch (status) {
      case SyncStatus.idle:
        return const Icon(Icons.cloud_done, color: Colors.grey);
      
      case SyncStatus.syncing:
        return const SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
          ),
        );
      
      case SyncStatus.success:
        return const Icon(Icons.cloud_done, color: Colors.green);
      
      case SyncStatus.partialFailure:
        return const Icon(Icons.cloud_sync, color: Colors.orange);
      
      case SyncStatus.failed:
        return const Icon(Icons.cloud_off, color: Colors.red);
    }
  }
}


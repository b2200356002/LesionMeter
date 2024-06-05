import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lesion_meter/custom/custom_snackbar.dart';

import '../../core/injections/locator.dart';

class TransferDatasSheet extends StatelessWidget {
  const TransferDatasSheet();

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _Export(),
        Divider(),
        _Import(),
      ],
    );
  }

  Future<void> show(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      showDragHandle: true,
      backgroundColor: Colors.white,
      builder: (context) => this,
    );
  }
}

class _Export extends ConsumerWidget {
  const _Export();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      leading: const Icon(Icons.exit_to_app),
      title: const Text("Export"),
      onTap: () => onTap(context, ref),
    );
  }

  Future<void> onTap(BuildContext context, WidgetRef ref) async {
    final maybePop = context.maybePop;

    final result = await ref.read(fileRepositoryProvider).export();

    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          result.fold(
            (l) => "An error occued: ${l.message}",
            (r) => "Data exported to downloads folder",
          ),
        ),
      ),
    );

    await maybePop();
  }
}

class _Import extends ConsumerWidget {
  const _Import();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      leading: const Icon(Icons.import_export),
      title: const Text("Import"),
      onTap: () => onTap(context, ref),
    );
  }

  Future<void> onTap(BuildContext context, WidgetRef ref) async {
    final maybePop = context.maybePop;

    final result = await ref.read(fileRepositoryProvider).import();

    result.fold(
      (l) => CustomSnackBar(title: "An error occued: ${l.message}").show(context),
      (r) => r.fold(
        () => null,
        (t) => CustomSnackBar(title: "Data imported successfully").show(context),
      ),
    );

    await maybePop();
  }
}

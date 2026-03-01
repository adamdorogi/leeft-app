import 'package:flutter/material.dart';

import 'package:leeft/l10n/app_localizations.dart';
import 'package:leeft/ui/settings/settings_viewmodel.dart';

/// A screen displaying application settings.
class SettingsScreen extends StatelessWidget {
  /// Creates a [SettingsScreen].
  const SettingsScreen({required SettingsViewModel viewModel, super.key})
    : _viewModel = viewModel;

  final SettingsViewModel _viewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context).settings)),
      body: ListenableBuilder(
        listenable: Listenable.merge([
          _viewModel.load,
          _viewModel.setThemeMode,
        ]),
        builder: (_, _) => Column(
          children: [
            DropdownMenu(
              onSelected: _viewModel.setThemeMode.run,
              initialSelection: _viewModel.themeMode,
              dropdownMenuEntries: [
                DropdownMenuEntry(
                  value: ThemeMode.system.name,
                  label: AppLocalizations.of(context).system,
                  leadingIcon: const Icon(Icons.sunny_snowing),
                ),
                DropdownMenuEntry(
                  value: ThemeMode.dark.name,
                  label: AppLocalizations.of(context).dark,
                  leadingIcon: const Icon(Icons.dark_mode),
                ),
                DropdownMenuEntry(
                  value: ThemeMode.light.name,
                  label: AppLocalizations.of(context).light,
                  leadingIcon: const Icon(Icons.light_mode),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

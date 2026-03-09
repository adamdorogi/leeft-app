import 'package:flutter/material.dart';

import 'package:relift/l10n/app_localizations.dart';
import 'package:relift/ui/settings/settings_viewmodel.dart';

/// A screen displaying application settings.
class SettingsScreen extends StatelessWidget {
  /// Creates a [SettingsScreen].
  const SettingsScreen({required SettingsViewModel viewModel, super.key})
    : _viewModel = viewModel;

  final SettingsViewModel _viewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(AppLocalizations.of(context).settings),
          ),
          SliverList.list(
            children: [
              ListTile(
                title: Text(AppLocalizations.of(context).themeMode),
                trailing: ListenableBuilder(
                  listenable: _viewModel.load,
                  builder: (context, _) => DropdownMenu(
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
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

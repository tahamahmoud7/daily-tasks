import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/my_provider.dart';

import '../shared/styles/colors.dart';
import 'language_bottom_sheet.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsTab extends StatefulWidget {
  static const String routName = "Settings";

  const SettingsTab({super.key});

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<MyProvider>(context);

    return Container(
      margin: const EdgeInsets.all(30),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Text(
          AppLocalizations.of(context)!.language,
          style: Theme.of(context)
              .textTheme
              .subtitle1!
              .copyWith(color: colorBlack),
        ),
        const SizedBox(
          height: 10,
        ),
        InkWell(
          onTap: () {
            showLanguageBottomSheet(context);
          },
          child: Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              border: Border.all(
                color: colorBlack,
              ),

            ),
            child: Text(pro.languageCode == "en" ? "English" : "Arabic",
                style: Theme.of(context).textTheme.subtitle1),
          ),
        ),
      ]),
    );
  }

  void showLanguageBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return const LanguageBottomSheet();
      },
    );
  }
}

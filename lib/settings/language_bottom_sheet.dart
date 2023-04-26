import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/my_provider.dart';
import '../shared/styles/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LanguageBottomSheet extends StatelessWidget {
  const LanguageBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return Container(
      margin: const EdgeInsets.all(20),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              provider.ChangeLanuage("en");
              Navigator.pop(context);
            },
            child: Row(
              children: [
                Text(
                  AppLocalizations.of(context)!.english,
                  style: Theme.of(context).textTheme.headline1?.copyWith(
                      color: provider.languageCode == "en"
                          ? pramiryColor
                          : colorBlack),
                ),
                const Spacer(),
                Icon(Icons.done,
                    color: provider.languageCode == "en"
                        ? pramiryColor
                        : colorBlack),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              provider.ChangeLanuage("ar");
              Navigator.pop(context);
            },
            child: Row(
              children: [
                Text(
                  AppLocalizations.of(context)!.arabic,
                  style: Theme.of(context).textTheme.headline1?.copyWith(
                      color: provider.languageCode == "ar"
                          ? pramiryColor
                          : colorBlack),
                ),
                const Spacer(),
                Icon(
                  Icons.done,
                  size: 30,
                  color:
                      provider.languageCode == "ar" ? pramiryColor : colorBlack,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

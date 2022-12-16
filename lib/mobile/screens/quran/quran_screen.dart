import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muslim_app/model/quran_details.dart';
import 'package:muslim_app/model/sura_details.dart';
import 'package:muslim_app/mobile/screens/quran/sura_details_screen.dart';
import 'package:muslim_app/shared/components/my_divider.dart';
import 'package:muslim_app/shared/components/navigator.dart';
import 'package:muslim_app/shared/image_path/image_path.dart';
import 'package:muslim_app/shared/providers/settings_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class QuranScreen extends StatelessWidget {
  static const String routeName = 'QuranScreen';
  const QuranScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    var settingsProvider = Provider.of<SettingsProvider>(context);
    return  Column(
        children: [
          Expanded(
            flex: 2,
            child: Image.asset(
              AssetsPath.quranImage,
            ),
          ),
          const MyDivider(),
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: Text(
              AppLocalizations.of(context)!.sura_name,
              style: GoogleFonts.elMessiri(
                  fontSize: 25, fontWeight: FontWeight.w500,
                color: settingsProvider.isDarkMode() ? Colors.white : Colors.black,),
            ),
          ),
          const MyDivider(),

          Expanded(
            flex: 5,
            child: Stack(
              alignment: Alignment.center,
              children: [
              Container(
                height : double.infinity,
                width: 3.0,
              color: Theme.of(context).accentColor,),
                settingsProvider.currentLanguage == 'ar' ?
                ListView.separated(
                  separatorBuilder: (_, index) {
                    return SuraTitle(QuranDetails.namesArabic[index],QuranDetails.numbersArabic[index],index);
                  },
                  itemCount:QuranDetails.namesArabic.length+1, itemBuilder: (BuildContext context, int index) {
                    return   Container(
                        width: double.infinity,
                        height: 3.0,
                        color: Theme.of(context).accentColor,);
                },
                ) :
                ListView.separated(
                  separatorBuilder: (_, index) {
                    return SuraTitle(QuranDetails.namesEnglish[index],QuranDetails.numbersEnglish[index],index);
                  },
                  itemCount:QuranDetails.namesEnglish.length+1, itemBuilder: (BuildContext context, int index) {
                    return   Container(
                        width: double.infinity,
                        height: 3.0,
                        color: Theme.of(context).accentColor,);
                },
                ),

              ],
            ),
          ),
        ],

    );
  }
}

class SuraTitle extends StatelessWidget {
final String names;
final String numbers;
  final int index;
  const SuraTitle(this.names,this.numbers,this.index, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var settingsProvider = Provider.of<SettingsProvider>(context);

    return InkWell(
      onTap: ()
      {
        navigateTo(context,
            routeName: SuraDetailsScreen.routeName,
            arguments: SuraDetailsArg(names:  names, index: index));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: Container(
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                names,
                textAlign: TextAlign.center,
                style:GoogleFonts.elMessiri(
                  color: settingsProvider.isDarkMode() ? Colors.white : Colors.black,
                  fontSize: 32,
                ),
              ),
              Text(
                numbers,
                textAlign: TextAlign.center,
                style:GoogleFonts.elMessiri(
                  color: settingsProvider.isDarkMode() ? Colors.white : Colors.black,
                  fontSize: 32,
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}


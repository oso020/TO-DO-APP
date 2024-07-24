import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/providers/theme_provider.dart';

import '../../providers/language_provider.dart';
import '../../theme_and_color/color_app.dart';

class EasyDateTimeLinePackage extends StatelessWidget {
  const EasyDateTimeLinePackage({super.key});

  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<LanguageProvider>(context);
    var themeProvider = Provider.of<ThemeProvider>(context);

    return EasyDateTimeLine(
      locale: languageProvider.locale,
      initialDate: DateTime.now(),
      onDateChange: (selectedDate) {
        // `selectedDate` is the new date selected.
      },
      activeColor: ColorApp.whiteColor,
      headerProps: EasyHeaderProps(
        monthPickerType: MonthPickerType.switcher,
        monthStyle: TextStyle(
            color: themeProvider.theme == ThemeMode.light
                ? ColorApp.whiteColor
                : ColorApp.itemsDarkColor),
        selectedDateStyle: TextStyle(
            color: themeProvider.theme == ThemeMode.light
                ? ColorApp.whiteColor
                : ColorApp.itemsDarkColor,
            fontSize: 23,
            fontWeight: FontWeight.w700),
        dateFormatter: DateFormatter.fullDateDMY(),
      ),
      dayProps: EasyDayProps(
        dayStructure: DayStructure.dayStrDayNum,
        disabledDayStyle: DayStyle(
          dayStrStyle: TextStyle(
            color: themeProvider.theme == ThemeMode.light
                ? ColorApp.whiteColor
                : ColorApp.whiteColor,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: themeProvider.theme == ThemeMode.light
                ? ColorApp.whiteColor
                : ColorApp.itemsDarkColor,
          ),
        ),
        activeDayStyle: DayStyle(
          dayStrStyle: TextStyle(
            color: themeProvider.theme == ThemeMode.light
                ? ColorApp.blackColor
                : ColorApp.whiteColor,
          ),
          dayNumStyle: TextStyle(
            color: themeProvider.theme == ThemeMode.light
                ? ColorApp.blackColor
                : ColorApp.whiteColor,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: ColorApp.greenColor,
          ),
        ),
        inactiveDayStyle: DayStyle(
          dayNumStyle: TextStyle(
            color: themeProvider.theme == ThemeMode.light
                ? ColorApp.blackColor
                : ColorApp.whiteColor,
          ),
          dayStrStyle: TextStyle(
            color: themeProvider.theme == ThemeMode.light
                ? ColorApp.blackColor
                : ColorApp.whiteColor,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: themeProvider.theme == ThemeMode.light
                ? ColorApp.whiteColor
                : ColorApp
                    .itemsDarkColor, // Set the color for unselected (inactive) days
          ),
        ),
      ),
    );
  }
}

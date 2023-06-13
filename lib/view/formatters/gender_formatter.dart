
import 'package:easy_stepper/easy_stepper.dart';
import 'package:vaea_mobile/data/enums/gender.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// It provides a UI representation for Gender enum
class GenderFormatter {

  /// It builds a chip that represents the given gender
  static Widget buildGenderChip(BuildContext context, Gender gender) {
    String labelStr = (gender == Gender.male)
      ? AppLocalizations.of(context)!.male
      : AppLocalizations.of(context)!.female;
    Color chipColor = (gender == Gender.male)
      ? Theme.of(context).colorScheme.secondary
      : Theme.of(context).colorScheme.error;
    Icon icon = (gender == Gender.male)
      ? Icon(Icons.male, color: chipColor)
      : Icon(Icons.female, color: chipColor);

    return Chip(
      backgroundColor: chipColor,
      label: Text(
        labelStr,
        style: TextStyle(fontSize: Theme.of(context).textTheme.labelSmall!.fontSize),
      ),
      avatar: CircleAvatar(
        backgroundColor: Theme.of(context).colorScheme.background,
        child: icon,
      ),
    );
  }


  /// It builds an icon that represents the given gender.
  static Widget buildGenderIcon(BuildContext context, Gender gender, double? size) {
    Color genderColor = (gender == Gender.male)
        ? Theme.of(context).colorScheme.secondary
        : Theme.of(context).colorScheme.error;

    Icon icon = (gender == Gender.male)
        ? Icon(Icons.male, color: genderColor, size: size,)
        : Icon(Icons.female, color: genderColor, size: size,);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        icon,
      ],
    );
  }


  /// It provides a text representation that includes the word employee and for.
  static String getForGenderEmployeeStr(BuildContext context, Gender gender) {
    return (gender == Gender.male)
      ? AppLocalizations.of(context)!.forMalesOnly
      : AppLocalizations.of(context)!.forFemalesOnly;
  }


  /// It represents a gender as a color
  static Color getGenderColor(BuildContext context, Gender gender) {
    return (gender == Gender.male)
      ? Theme.of(context).colorScheme.secondary
      : Theme.of(context).colorScheme.error;
  }


}

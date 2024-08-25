import 'package:data_base/config/app_color.dart';
import 'package:flutter/material.dart';

class AppStyle {
  BuildContext context;
  AppStyle(this.context);

  // Constant style
  TextStyle get titleLarge => Theme.of(context).textTheme.titleLarge!;
  TextStyle get titleMedium => Theme.of(context).textTheme.titleMedium!;
  TextStyle get titleSmall => Theme.of(context).textTheme.titleSmall!;
  TextStyle get bodysmall => Theme.of(context).textTheme.bodySmall!;

  TextStyle get splashFont =>
      Theme.of(context).textTheme.headlineSmall!.copyWith(
            fontWeight: FontWeight.w600,
            color: Colors.white,
            fontSize: 32,
          );
  TextStyle get headingLarge =>
      Theme.of(context).textTheme.titleLarge!.copyWith(
            fontSize: 16,
          );
  TextStyle get headingLargeBold =>
      Theme.of(context).textTheme.titleLarge!.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          );
  TextStyle get headingMedium =>
      Theme.of(context).textTheme.titleMedium!.copyWith(
            fontSize: 14,
          );
  TextStyle get headingMediumBold =>
      Theme.of(context).textTheme.titleMedium!.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          );
  TextStyle get headingsmall =>
      Theme.of(context).textTheme.titleSmall!.copyWith(
            fontSize: 12,
            wordSpacing: 1.0,
          );
  TextStyle get headingsmallBold =>
      Theme.of(context).textTheme.titleSmall!.copyWith(
            fontSize: 12,
            fontWeight: FontWeight.bold,
          );
  TextStyle get bodysmallBold =>
      Theme.of(context).textTheme.bodySmall!.copyWith(
            fontWeight: FontWeight.bold,
          );

  TextStyle get hintsmall =>
      Theme.of(context).textTheme.bodySmall!.copyWith(color: AppColor.greyText);
}

import 'package:flutter/material.dart';

/// Centralized size constants for spacing, dimensions and reusable EdgeInsets.
///
/// This file exposes two main classes:
/// - `Sizes` for generic dimensional constants and EdgeInsets presets.
/// - `FontSizes` for text-size related constants.
class Sizes {
  Sizes._();

  // ---------- EdgeInsets presets (used throughout the app) ----------
  static const EdgeInsets paddingAll8 = EdgeInsets.all(8);
  static const EdgeInsets paddingAll12 = EdgeInsets.all(12);
  static const EdgeInsets paddingAll16 = EdgeInsets.all(16);
  static const EdgeInsets paddingAll20 = EdgeInsets.all(20);

  static const EdgeInsets horizontal16 = EdgeInsets.symmetric(horizontal: 16);
  static const EdgeInsets vertical16 = EdgeInsets.symmetric(vertical: 16);
  static const EdgeInsets horizontal8 = EdgeInsets.symmetric(horizontal: 8);
  static const EdgeInsets vertical8 = EdgeInsets.symmetric(vertical: 8);

  static const EdgeInsets onlyTop16 = EdgeInsets.only(top: 16);
  static const EdgeInsets onlyBottom16 = EdgeInsets.only(bottom: 16);
  static const EdgeInsets onlyLeft16 = EdgeInsets.only(left: 16);
  static const EdgeInsets onlyRight16 = EdgeInsets.only(right: 16);

  // Combined presets used in the app (kept from original)
  static const EdgeInsets appPaddingHorizontal16 = EdgeInsets.only(
    left: 16,
    right: 16,
  );
  static const EdgeInsets appPaddingVertical16 = EdgeInsets.only(
    top: 16,
    bottom: 16,
  );
  static const EdgeInsets appPaddingAll16_8 = EdgeInsets.only(
    top: 16,
    bottom: 16,
    left: 8,
    right: 8,
  );
  static const EdgeInsets appPaddingAll12_16 = EdgeInsets.only(
    top: 12,
    bottom: 12,
    left: 16,
    right: 16,
  );
  static const EdgeInsets appPaddingAll20_16 = EdgeInsets.only(
    top: 20,
    bottom: 20,
    left: 16,
    right: 16,
  );

  // ---------- Common UI sizes and semantic names ----------
  static const double iconSize = 26;
  static const double listTileIconSize = 18;
  static const double appBarIconSize = 24;
  static const double fabSize = 56;

  static const double contentGap = 20;
  static const double sectionGap = 8;
  static const double mainSectionGap = 16;

  static const double padding = 16;

  // ---------- Generic named dimensions (dimen_X) ----------
  // Common small values
  static const double dimen_0 = 0;
  static const double dimen_0_5 = 0.5;
  static const double dimen_1 = 1;
  static const double dimen_2 = 2;
  static const double dimen_2p2 = 2.2;
  static const double dimen_2p4 = 2.4;
  static const double dimen_2p5 = 2.5;
  static const double dimen_2p6 = 2.6;
  static const double dimen_2p8 = 2.8;
  static const double dimen_3 = 3;
  static const double dimen_3p5 = 3.5;
  static const double dimen_4 = 4;
  static const double dimen_4p4 = 4.4;
  static const double dimen_5 = 5;
  static const double dimen_5p5 = 5.5;
  static const double dimen_6 = 6;
  static const double dimen_7 = 7;
  static const double dimen_8 = 8;
  static const double dimen_9 = 9;
  static const double dimen_10 = 10;
  static const double dimen_11 = 11;
  static const double dimen_12 = 12;
  static const double dimen_13 = 13;
  static const double dimen_14 = 14;
  static const double dimen_15 = 15;
  static const double dimen_16 = 16;
  static const double dimen_18 = 18;
  static const double dimen_19 = 19;
  static const double dimen_20 = 20;
  static const double dimen_21 = 21;
  static const double dimen_21p5 = 21.5;
  static const double dimen_22 = 22;
  static const double dimen_23 = 23;
  static const double dimen_24 = 24;
  static const double dimen_25 = 25;
  static const double dimen_26 = 26;
  static const double dimen_27 = 27;
  static const double dimen_28 = 28;
  static const double dimen_30 = 30;
  static const double dimen_32 = 32;
  static const double dimen_34 = 34;
  static const double dimen_35 = 35;
  static const double dimen_36 = 36;
  static const double dimen_37 = 37;
  static const double dimen_38 = 38;
  static const double dimen_40 = 40;
  static const double dimen_42 = 42;
  static const double dimen_45 = 45;
  static const double dimen_48 = 48;
  static const double dimen_50 = 50;
  static const double dimen_52 = 52;
  static const double dimen_55 = 55;
  static const double dimen_60 = 60;
  static const double dimen_64 = 64;
  static const double dimen_67 = 67;
  static const double dimen_70 = 70;
  static const double dimen_75 = 75;
  static const double dimen_80 = 80;
  static const double dimen_85 = 85;
  static const double dimen_90 = 90;
  static const double dimen_95 = 95;
  static const double dimen_100 = 100;
  static const double dimen_105 = 105;
  static const double dimen_110 = 110;
  static const double dimen_120 = 120;
  static const double dimen_125 = 125;
  static const double dimen_130 = 130;
  static const double dimen_135 = 135;
  static const double dimen_140 = 140;
  static const double dimen_145 = 145;
  static const double dimen_150 = 150;
  static const double dimen_160 = 160;
  static const double dimen_165 = 165;
  static const double dimen_170 = 170;
  static const double dimen_180 = 180;
  static const double dimen_185 = 185;
  static const double dimen_190 = 190;
  static const double dimen_200 = 200;
  static const double dimen_210 = 210;
  static const double dimen_220 = 220;
  static const double dimen_230 = 230;
  static const double dimen_250 = 250;
  static const double dimen_280 = 280;
  static const double dimen_300 = 300;
  static const double dimen_310 = 310;
  static const double dimen_320 = 320;
  static const double dimen_350 = 350;
  static const double dimen_400 = 400;
  static const double dimen_450 = 450;

  // ---------- Publisher/logo sizes (kept small as in original) ----------
  static const double publisherLogoHeight = 5;
  static const double publisherLogoWidth = 6;

  // ---------- Convenience named sizes used in original project ----------
  static const double loginPageHeading = 36;
  static const double heading = 22;
  static const double subheading = 18;
  static const double title = 20;
  static const double subtitle = 16;
  static const double subtitle2 = 14;
  static const double subtitle3 = 13;
  static const double subtitle4 = 13;
  static const double bodySmallSize = 12;
  static const double bodyMediumSmallSize = 13;

  // Timestamp and other tiny text uses
  static const double timeStampSize = 10;
}

/// Separated font sizes to keep typography concerns isolated from other sizes.
class FontSizes {
  FontSizes._();

  static const double appBar = 18;
  static const double heading = 15; // smaller heading used in lists
  static const double headingLarge = 22; // main screen headings
  static const double headline = 36; // loginPageHeading equivalent
  static const double subtitle = 16;
  static const double subtitleSmall = 14;
  static const double body = 14;
  static const double bodySmall = 12;
  static const double caption = 11;
  static const double small = 10;

  // Points / publisher specific
  static const double pointsLevel = 20;
  static const double publisherName = 13;
  static const double normalText = 13;
  static const double pointsHeading = 14;
  static const double pointsSubtitle = 12;
  static const double pointsLink = 13;
}

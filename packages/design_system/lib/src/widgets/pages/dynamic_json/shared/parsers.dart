import 'package:flutter/material.dart';
import '../../../atoms/button/button_eae.dart';
import '../../../atoms/text/text_eae.dart';
import '../../../atoms/tag/tag_eae.dart';
import '../../../atoms/logo/logo_eae.dart';
import '../../../atoms/icon/icon_eae.dart';
import '../../../../models/brand.dart';

/// Centralized parsers for JSON values

// =============================================================================
// ALIGNMENT PARSERS
// =============================================================================

/// Parse MainAxisAlignment from string
MainAxisAlignment parseMainAxisAlignment(String? value) {
  switch (value?.toLowerCase()) {
    case 'start':
      return MainAxisAlignment.start;
    case 'end':
      return MainAxisAlignment.end;
    case 'center':
      return MainAxisAlignment.center;
    case 'spacebetween':
    case 'space_between':
      return MainAxisAlignment.spaceBetween;
    case 'spacearound':
    case 'space_around':
      return MainAxisAlignment.spaceAround;
    case 'spaceevenly':
    case 'space_evenly':
      return MainAxisAlignment.spaceEvenly;
    default:
      return MainAxisAlignment.start;
  }
}

/// Parse CrossAxisAlignment from string
CrossAxisAlignment parseCrossAxisAlignment(String? value) {
  switch (value?.toLowerCase()) {
    case 'start':
      return CrossAxisAlignment.start;
    case 'end':
      return CrossAxisAlignment.end;
    case 'center':
      return CrossAxisAlignment.center;
    case 'stretch':
      return CrossAxisAlignment.stretch;
    case 'baseline':
      return CrossAxisAlignment.baseline;
    default:
      return CrossAxisAlignment.center;
  }
}

/// Parse TextAlign from string
TextAlign? parseTextAlign(String? value) {
  switch (value?.toLowerCase()) {
    case 'left':
      return TextAlign.left;
    case 'right':
      return TextAlign.right;
    case 'center':
      return TextAlign.center;
    case 'justify':
      return TextAlign.justify;
    case 'start':
      return TextAlign.start;
    case 'end':
      return TextAlign.end;
    default:
      return null;
  }
}

/// Parse EdgeInsets from dynamic value
/// Supports: number (all), or map {left, top, right, bottom}
EdgeInsetsGeometry? parseEdgeInsets(dynamic value) {
  if (value == null) return null;
  if (value is num) {
    return EdgeInsets.all(value.toDouble());
  }
  if (value is Map) {
    return EdgeInsets.only(
      left: (value['left'] as num?)?.toDouble() ?? 0,
      top: (value['top'] as num?)?.toDouble() ?? 0,
      right: (value['right'] as num?)?.toDouble() ?? 0,
      bottom: (value['bottom'] as num?)?.toDouble() ?? 0,
    );
  }
  return null;
}

// =============================================================================
// STYLE PARSERS
// =============================================================================

/// Parse FontWeight from string
FontWeight? parseFontWeight(String? value) {
  switch (value?.toLowerCase()) {
    case 'thin':
      return FontWeight.w100;
    case 'extralight':
      return FontWeight.w200;
    case 'light':
      return FontWeight.w300;
    case 'normal':
      return FontWeight.w400;
    case 'medium':
      return FontWeight.w500;
    case 'semibold':
      return FontWeight.w600;
    case 'bold':
      return FontWeight.w700;
    case 'extrabold':
      return FontWeight.w800;
    case 'black':
      return FontWeight.w900;
    default:
      return null;
  }
}

/// Parse TextOverflow from string
TextOverflow? parseTextOverflow(String? value) {
  switch (value?.toLowerCase()) {
    case 'clip':
      return TextOverflow.clip;
    case 'fade':
      return TextOverflow.fade;
    case 'ellipsis':
      return TextOverflow.ellipsis;
    case 'visible':
      return TextOverflow.visible;
    default:
      return null;
  }
}

/// Parse TextTypeEAE from string
TextTypeEAE parseTextType(String? value) {
  switch (value?.toLowerCase()) {
    case 'displaylarge':
    case 'display_large':
      return TextTypeEAE.displayLarge;
    case 'displaymedium':
    case 'display_medium':
      return TextTypeEAE.displayMedium;
    case 'displaysmall':
    case 'display_small':
      return TextTypeEAE.displaySmall;
    case 'headlinelarge':
    case 'headline_large':
      return TextTypeEAE.headlineLarge;
    case 'headlinemedium':
    case 'headline_medium':
      return TextTypeEAE.headlineMedium;
    case 'headlinesmall':
    case 'headline_small':
      return TextTypeEAE.headlineSmall;
    case 'titlelarge':
    case 'title_large':
      return TextTypeEAE.titleLarge;
    case 'titlemedium':
    case 'title_medium':
      return TextTypeEAE.titleMedium;
    case 'titlesmall':
    case 'title_small':
      return TextTypeEAE.titleSmall;
    case 'bodylarge':
    case 'body_large':
      return TextTypeEAE.bodyLarge;
    case 'bodymedium':
    case 'body_medium':
      return TextTypeEAE.bodyMedium;
    case 'bodysmall':
    case 'body_small':
      return TextTypeEAE.bodySmall;
    case 'labellarge':
    case 'label_large':
      return TextTypeEAE.labelLarge;
    case 'labelmedium':
    case 'label_medium':
      return TextTypeEAE.labelMedium;
    case 'labelsmall':
    case 'label_small':
      return TextTypeEAE.labelSmall;
    default:
      return TextTypeEAE.bodyMedium;
  }
}

// =============================================================================
// ENUM PARSERS
// =============================================================================

/// Parse ButtonEAEVariant from string
ButtonEAEVariant parseButtonVariant(String? value) {
  switch (value?.toLowerCase()) {
    case 'primary':
      return ButtonEAEVariant.primary;
    case 'secondary':
      return ButtonEAEVariant.secondary;
    case 'outline':
      return ButtonEAEVariant.outline;
    default:
      return ButtonEAEVariant.primary;
  }
}

/// Parse ButtonEAESize from string
ButtonEAESize parseButtonSize(String? value) {
  switch (value?.toLowerCase()) {
    case 'small':
      return ButtonEAESize.small;
    case 'medium':
      return ButtonEAESize.medium;
    case 'large':
      return ButtonEAESize.large;
    default:
      return ButtonEAESize.medium;
  }
}

/// Parse TagEAESize from string
TagEAESize parseTagSize(String? value) {
  switch (value?.toLowerCase()) {
    case 'small':
      return TagEAESize.small;
    case 'medium':
      return TagEAESize.medium;
    case 'large':
      return TagEAESize.large;
    default:
      return TagEAESize.medium;
  }
}

/// Parse Brand from string
Brand parseBrand(String? value) {
  switch (value?.toLowerCase()) {
    case 'match':
      return Brand.match;
    case 'meetic':
      return Brand.meetic;
    case 'okc':
    case 'okcupid':
      return Brand.okc;
    case 'pof':
    case 'plentyoffish':
      return Brand.pof;
    default:
      return Brand.match;
  }
}

/// Parse LogoTypeEAE from string
LogoTypeEAE parseLogoType(String? value) {
  switch (value?.toLowerCase()) {
    case 'small':
      return LogoTypeEAE.small;
    case 'ondark':
    case 'on_dark':
      return LogoTypeEAE.onDark;
    case 'onwhite':
    case 'on_white':
      return LogoTypeEAE.onWhite;
    default:
      return LogoTypeEAE.onWhite;
  }
}

/// Parse IconSizeEAE from string
IconSizeEAE parseIconSize(String? value) {
  switch (value?.toLowerCase()) {
    case 'xs':
      return IconSizeEAE.xs;
    case 'sm':
    case 'small':
      return IconSizeEAE.sm;
    case 'md':
    case 'medium':
      return IconSizeEAE.md;
    case 'lg':
    case 'large':
      return IconSizeEAE.lg;
    case 'xl':
    case 'xlarge':
      return IconSizeEAE.xl;
    default:
      return IconSizeEAE.md;
  }
}

/// Parse IconData from string name
IconData? parseIconData(String? value) {
  if (value == null) return null;
  return _iconMap[value.toLowerCase()];
}

/// Map of icon names to IconData
const Map<String, IconData> _iconMap = {
  'add': Icons.add,
  'remove': Icons.remove,
  'check': Icons.check,
  'close': Icons.close,
  'arrow_forward': Icons.arrow_forward,
  'arrow_back': Icons.arrow_back,
  'chevron_left': Icons.chevron_left,
  'chevron_right': Icons.chevron_right,
  'home': Icons.home,
  'settings': Icons.settings,
  'search': Icons.search,
  'favorite': Icons.favorite,
  'star': Icons.star,
  'calendar_today': Icons.calendar_today,
  'person': Icons.person,
  'location_on': Icons.location_on,
  'email': Icons.email,
  'phone': Icons.phone,
  'camera_alt': Icons.camera_alt,
  'edit': Icons.edit,
  'delete': Icons.delete,
  'info': Icons.info,
  'warning': Icons.warning,
  'error': Icons.error,
  'help': Icons.help,
  'visibility': Icons.visibility,
  'visibility_off': Icons.visibility_off,
};

/// Get all available icon names
List<String> get availableIcons => _iconMap.keys.toList();


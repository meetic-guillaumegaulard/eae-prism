import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../theme/brand_theme_extensions.dart';

class LinkedTextEAE extends StatelessWidget {
  final String htmlText;
  final TextAlign textAlign;

  const LinkedTextEAE({
    super.key,
    required this.htmlText,
    this.textAlign = TextAlign.start,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final linkedTextTheme = theme.extension<BrandLinkedTextTheme>();

    // Default text styles
    final normalTextStyle = linkedTextTheme?.normalTextStyle ??
        theme.textTheme.bodyMedium ??
        const TextStyle(fontSize: 14, color: Colors.black87);

    final underlineThickness = linkedTextTheme?.linkUnderlineThickness ?? 1.0;
    final underlineOffset = linkedTextTheme?.linkUnderlineOffset ?? 1.0;

    // Style des liens sans la décoration underline par défaut
    final linkTextStyle = (linkedTextTheme?.linkTextStyle ??
            TextStyle(
              fontSize: 14,
              color: theme.colorScheme.primary,
            ))
        .copyWith(
      decoration: TextDecoration.none, // On enlève la décoration par défaut
    );

    final textSpans = _parseHtml(
      htmlText,
      normalTextStyle,
      linkTextStyle,
      underlineThickness,
      underlineOffset,
    );

    return RichText(
      textAlign: textAlign,
      text: TextSpan(
        children: textSpans,
      ),
    );
  }

  List<InlineSpan> _parseHtml(
    String html,
    TextStyle normalStyle,
    TextStyle linkStyle,
    double underlineThickness,
    double underlineOffset,
  ) {
    final List<InlineSpan> spans = [];
    
    // Regex pour capturer les balises <a href="...">...</a>
    final linkRegex = RegExp(r'<a\s+href=["\x27](.*?)["\x27]\s*>(.*?)</a>');
    
    int lastIndex = 0;
    
    for (final match in linkRegex.allMatches(html)) {
      // Ajouter le texte avant le lien
      if (match.start > lastIndex) {
        final textBefore = html.substring(lastIndex, match.start);
        if (textBefore.isNotEmpty) {
          spans.add(TextSpan(
            text: textBefore,
            style: normalStyle,
          ));
        }
      }
      
      // Extraire l'URL et le texte du lien
      final url = match.group(1) ?? '';
      final linkText = match.group(2) ?? '';
      
      // Ajouter le lien cliquable avec soulignement personnalisé
      spans.add(
        WidgetSpan(
          alignment: PlaceholderAlignment.baseline,
          baseline: TextBaseline.alphabetic,
          child: _UnderlinedLinkText(
            text: linkText,
            style: linkStyle,
            underlineColor: linkStyle.color ?? Colors.blue,
            underlineThickness: underlineThickness,
            underlineOffset: underlineOffset,
            onTap: () => _launchUrl(url),
          ),
        ),
      );
      
      lastIndex = match.end;
    }
    
    // Ajouter le texte restant après le dernier lien
    if (lastIndex < html.length) {
      final textAfter = html.substring(lastIndex);
      if (textAfter.isNotEmpty) {
        spans.add(TextSpan(
          text: textAfter,
          style: normalStyle,
        ));
      }
    }
    
    return spans;
  }

  Future<void> _launchUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      // En cas d'échec, on pourrait logger l'erreur
      debugPrint('Could not launch $urlString');
    }
  }
}

class _UnderlinedLinkText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final Color underlineColor;
  final double underlineThickness;
  final double underlineOffset;
  final VoidCallback onTap;

  const _UnderlinedLinkText({
    required this.text,
    required this.style,
    required this.underlineColor,
    required this.underlineThickness,
    required this.underlineOffset,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CustomPaint(
        painter: _UnderlinePainter(
          color: underlineColor,
          thickness: underlineThickness,
          offset: underlineOffset,
        ),
        child: Text(
          text,
          style: style,
        ),
      ),
    );
  }
}

class _UnderlinePainter extends CustomPainter {
  final Color color;
  final double thickness;
  final double offset;

  _UnderlinePainter({
    required this.color,
    required this.thickness,
    required this.offset,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = thickness
      ..style = PaintingStyle.stroke;

    // Dessiner la ligne en dessous du texte avec l'offset spécifié
    final y = size.height + offset;
    canvas.drawLine(
      Offset(0, y),
      Offset(size.width, y),
      paint,
    );
  }

  @override
  bool shouldRepaint(_UnderlinePainter oldDelegate) {
    return color != oldDelegate.color ||
        thickness != oldDelegate.thickness ||
        offset != oldDelegate.offset;
  }
}


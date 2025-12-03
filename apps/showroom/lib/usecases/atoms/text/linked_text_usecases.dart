import 'package:flutter/material.dart';
import 'package:design_system/design_system.dart';

Widget buildLinkedTextSimple(BuildContext context) {
  return const Center(
    child: Padding(
      padding: EdgeInsets.all(24.0),
      child: LinkedTextEAE(
        htmlText:
            'Ceci est un texte avec <a href="https://www.google.com">un lien</a> dedans.',
      ),
    ),
  );
}

Widget buildLinkedTextMultiple(BuildContext context) {
  return const Center(
    child: Padding(
      padding: EdgeInsets.all(24.0),
      child: LinkedTextEAE(
        htmlText:
            'Vous pouvez visiter <a href="https://www.google.com">Google</a> ou <a href="https://www.flutter.dev">Flutter.dev</a> pour plus d\'informations.',
      ),
    ),
  );
}

Widget buildLinkedTextLong(BuildContext context) {
  return const Center(
    child: Padding(
      padding: EdgeInsets.all(24.0),
      child: LinkedTextEAE(
        textAlign: TextAlign.justify,
        htmlText:
            'En cliquant sur "Accepter", vous acceptez nos <a href="https://example.com/terms">Conditions d\'utilisation</a> et notre <a href="https://example.com/privacy">Politique de confidentialité</a>. Nous utilisons des cookies et des technologies similaires pour améliorer votre expérience. Pour en savoir plus, consultez notre <a href="https://example.com/cookies">Politique relative aux cookies</a>.',
      ),
    ),
  );
}

Widget buildLinkedTextNoLinks(BuildContext context) {
  return const Center(
    child: Padding(
      padding: EdgeInsets.all(24.0),
      child: LinkedTextEAE(
        htmlText: 'Ceci est un texte sans aucun lien.',
      ),
    ),
  );
}

Widget buildLinkedTextCenter(BuildContext context) {
  return const Center(
    child: Padding(
      padding: EdgeInsets.all(24.0),
      child: LinkedTextEAE(
        textAlign: TextAlign.center,
        htmlText:
            'Besoin d\'aide ?\n<a href="https://support.example.com">Contactez-nous</a>',
      ),
    ),
  );
}

Widget buildLinkedTextMeeticConsent(BuildContext context) {
  return const Center(
    child: Padding(
      padding: EdgeInsets.all(24.0),
      child: LinkedTextEAE(
        htmlText:
            'Je consens au traitement de mes <a href="https://www.meetic.fr/pages/misc/privacy">données sensibles</a> et à l\'utilisation de <a href="https://www.meetic.fr/pages/misc/safety">Filtres de messages sécurisés</a> par Meetic à des fins de prestation de services.',
      ),
    ),
  );
}

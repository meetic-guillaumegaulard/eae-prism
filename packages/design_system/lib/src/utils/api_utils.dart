import 'dart:convert';
import 'package:http/http.dart' as http;

/// Utilitaire pour construire les URLs de l'API EAE
/// 
/// Cette classe centralise la configuration de l'API backend et fournit
/// des méthodes pour construire les URLs des différentes ressources.
class ApiUtils {
  /// URL de base de l'API par défaut
  static String _defaultBaseUrl = 'http://localhost:3000/api';

  /// Getter pour l'URL de base
  static String get baseUrl => _defaultBaseUrl;

  /// Permet de configurer l'URL de base de l'API
  static void configure({String? baseUrl}) {
    if (baseUrl != null) {
      _defaultBaseUrl = baseUrl;
    }
  }

  /// Construit l'URL complète à partir d'un endpoint relatif
  static String buildUrl(String endpoint, {String? customBaseUrl}) {
    final base = customBaseUrl ?? _defaultBaseUrl;
    // Supprime les slashes en double
    final cleanEndpoint = endpoint.startsWith('/') ? endpoint : '/$endpoint';
    return '$base$cleanEndpoint';
  }

  /// Effectue un appel POST à l'API avec les données du formulaire
  /// 
  /// [endpoint] L'endpoint relatif (ex: /screens/submit)
  /// [data] Les données à envoyer (sera encodé en JSON)
  /// [customBaseUrl] URL de base optionnelle pour remplacer la valeur par défaut
  /// 
  /// Retourne le JSON décodé de la réponse
  static Future<Map<String, dynamic>> post(
    String endpoint,
    Map<String, dynamic> data, {
    String? customBaseUrl,
  }) async {
    final url = buildUrl(endpoint, customBaseUrl: customBaseUrl);
    
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw ApiException(
        statusCode: response.statusCode,
        message: 'API call failed: ${response.statusCode}',
        body: response.body,
      );
    }
  }

  /// Effectue un appel GET à l'API
  static Future<Map<String, dynamic>> get(
    String endpoint, {
    String? customBaseUrl,
  }) async {
    final url = buildUrl(endpoint, customBaseUrl: customBaseUrl);
    
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Accept': 'application/json',
      },
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw ApiException(
        statusCode: response.statusCode,
        message: 'API call failed: ${response.statusCode}',
        body: response.body,
      );
    }
  }

  /// Construit une URL pour les assets de marque
  /// 
  /// [brandName] Le nom de la marque (match, meetic, okc, pof)
  /// [assetPath] Le chemin de l'asset (ex: logo-small.png)
  static String brandAssetUrl(String brandName, String assetPath) {
    return '$baseUrl/assets/brands/$brandName/$assetPath';
  }

  /// Construit l'URL du logo selon le type
  /// 
  /// [brandName] Le nom de la marque (match, meetic, okc, pof)
  /// [logoType] Le type de logo (small, onDark, onWhite)
  static String logoUrl(String brandName, LogoType logoType) {
    final fileName = switch (logoType) {
      LogoType.small => 'logo-small.png',
      LogoType.onDark => 'logo-ondark.png',
      LogoType.onWhite => 'logo-onwhite.png',
    };
    return brandAssetUrl(brandName, fileName);
  }

  /// Construit l'URL de l'image de fond landing mobile
  /// 
  /// [brandName] Le nom de la marque (match, meetic, okc, pof)
  static String landingMobileBackgroundUrl(String brandName) {
    return brandAssetUrl(brandName, 'landing-mobile.jpg');
  }

  /// Construit l'URL de l'image de fond landing desktop
  /// 
  /// [brandName] Le nom de la marque (match, meetic, okc, pof)
  static String landingDesktopBackgroundUrl(String brandName) {
    return brandAssetUrl(brandName, 'landing-desktop.jpg');
  }
}

/// Types de logos disponibles
enum LogoType {
  /// Logo compact/icône
  small,
  /// Logo pour fond sombre
  onDark,
  /// Logo pour fond clair
  onWhite,
}

/// Exception levée lors d'une erreur API
class ApiException implements Exception {
  final int statusCode;
  final String message;
  final String? body;

  const ApiException({
    required this.statusCode,
    required this.message,
    this.body,
  });

  @override
  String toString() => 'ApiException($statusCode): $message';
}


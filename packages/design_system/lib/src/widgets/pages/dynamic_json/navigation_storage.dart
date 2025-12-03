import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

/// Service de stockage pour la navigation dynamique
/// Permet de persister l'état de navigation et les données du formulaire
class NavigationStorage {
  static const String _keyPrefix = 'dynamic_nav_';
  static const String _historyKey = '${_keyPrefix}history';
  static const String _formDataKey = '${_keyPrefix}form_data';
  static const String _currentPathKey = '${_keyPrefix}current_path';

  final String _storageId;
  SharedPreferences? _prefs;

  /// [storageId] identifiant unique pour isoler les données de différents navigateurs
  NavigationStorage({String storageId = 'default'}) : _storageId = storageId;

  String get _prefixedHistoryKey => '${_historyKey}_$_storageId';
  String get _prefixedFormDataKey => '${_formDataKey}_$_storageId';
  String get _prefixedCurrentPathKey => '${_currentPathKey}_$_storageId';

  /// Initialise le stockage
  Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  /// Sauvegarde les données du formulaire
  Future<void> saveFormData(Map<String, dynamic> data) async {
    await init();
    await _prefs!.setString(_prefixedFormDataKey, jsonEncode(data));
  }

  /// Récupère les données du formulaire
  Future<Map<String, dynamic>> loadFormData() async {
    await init();
    final json = _prefs!.getString(_prefixedFormDataKey);
    if (json == null || json.isEmpty) {
      return {};
    }
    try {
      return jsonDecode(json) as Map<String, dynamic>;
    } catch (_) {
      return {};
    }
  }

  /// Sauvegarde l'historique de navigation (liste des paths)
  Future<void> saveHistory(List<String> paths) async {
    await init();
    await _prefs!.setStringList(_prefixedHistoryKey, paths);
  }

  /// Récupère l'historique de navigation
  Future<List<String>> loadHistory() async {
    await init();
    return _prefs!.getStringList(_prefixedHistoryKey) ?? [];
  }

  /// Sauvegarde le path courant
  Future<void> saveCurrentPath(String? path) async {
    await init();
    if (path == null) {
      await _prefs!.remove(_prefixedCurrentPathKey);
    } else {
      await _prefs!.setString(_prefixedCurrentPathKey, path);
    }
  }

  /// Récupère le path courant
  Future<String?> loadCurrentPath() async {
    await init();
    return _prefs!.getString(_prefixedCurrentPathKey);
  }

  /// Efface toutes les données de navigation
  Future<void> clear() async {
    await init();
    await _prefs!.remove(_prefixedFormDataKey);
    await _prefs!.remove(_prefixedHistoryKey);
    await _prefs!.remove(_prefixedCurrentPathKey);
  }

  /// Sauvegarde l'état complet (formulaire + historique + path courant)
  Future<void> saveState({
    required Map<String, dynamic> formData,
    required List<String> historyPaths,
    String? currentPath,
  }) async {
    await saveFormData(formData);
    await saveHistory(historyPaths);
    await saveCurrentPath(currentPath);
  }
}

/// État de navigation restauré depuis le stockage
class RestoredNavigationState {
  final Map<String, dynamic> formData;
  final List<String> historyPaths;
  final String? currentPath;

  const RestoredNavigationState({
    required this.formData,
    required this.historyPaths,
    this.currentPath,
  });

  bool get isEmpty =>
      formData.isEmpty && historyPaths.isEmpty && currentPath == null;
}

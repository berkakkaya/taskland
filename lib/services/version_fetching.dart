import 'package:package_info_plus/package_info_plus.dart';

class VersionFetchingService {
  static String? _appName;
  static String? _packageName;
  static String? _version;
  static String? _buildNumber;

  static String get appName => _appName!;
  static String get packageName => _packageName!;
  static String get version => _version!;
  static String get buildNumber => _buildNumber!;

  static Future<void> initialize() async {
    final packageInfo = await PackageInfo.fromPlatform();

    _appName = packageInfo.appName;
    _packageName = packageInfo.packageName;
    _version = packageInfo.version;
    _buildNumber = packageInfo.buildNumber;
  }
}

import 'dart:io';

class AdConfig {
  /// 应用ID
  static String get appId {
    if (Platform.isAndroid) {
      return '836543846000';
    }
    return '836791510808';
  }

  /// 应用Key
  static String get appKey {
    if (Platform.isAndroid) {
      return '02d1213c2f12372f';
    }
    return '36f6746399497b45';
  }

  /// 开屏广告
  static String get splashId {
    if (Platform.isAndroid) {
      return '81q547sonhiw';
    }
    return '81q7a9oaq37m';
  }

  /// 插屏广告
  static String get interstitialId {
    if (Platform.isAndroid) {
      return '81q61bh65ujq';
    }
    return '81q7svkjcxxa';
  }

  /// 信息流广告
  static String get feedId {
    if (Platform.isAndroid) {
      return '85ilbeo2labq';
    }
    return '85ikvtui5f5i';
  }
}

import 'package:focial/api/urls.dart';

extension stringExtension on String {
  String getAssetURL() {
    if (this.contains("http") ||
        this.contains("://") ||
        this.contains("www") ||
        this.contains(".co") ||
        this.contains(".co")) {
      return this;
    }
    return (Urls.assetsBase + this);
  }
}

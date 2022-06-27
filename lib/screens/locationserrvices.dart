import 'package:url_launcher/url_launcher.dart';

class LocationService {
  goToMaps(double latitute, double longitude) async {
    String mapLocationUrl =
        "https://www.google.com/maps/search/?api=1&query=$latitute,$longitude";
    final String encodeUrl = Uri.encodeFull(mapLocationUrl);
    if (await canLaunch(encodeUrl)) {
      await launch(encodeUrl);
    } else {
      print('Could not launch $encodeUrl');
      throw 'Could not launch $encodeUrl ';
    }
  }
}

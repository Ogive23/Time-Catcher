import 'package:time_catcher/Models/User.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'Helper.dart';

class DataMapper {
  Helper helper = new Helper();
  getMarkerColor(priority) {
    switch (priority) {
      case '1':
        return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen);
      case '3':
        return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue);
      case '5':
        return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure);
      case '7':
        return BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueOrange);
      case '10':
        return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed);
    }
  }

  List<Marker> getMarkersFromJson(List<Map<String, dynamic>> list) {
//  MarkerIcon markerOption = new MarkerIcon();      ///for custom marker icon
    List<Marker> returnedMarkers = <Marker>[];
    list.forEach((marker) {
      returnedMarkers.add(Marker(
        markerId: new MarkerId(marker['id'].toString()),
        position: LatLng(double.parse(marker['latitude'].toString()),
            double.parse(marker['longitude'].toString())),
//      icon: markerOption.getIcon(),
        icon: getMarkerColor(marker['priority'].toString()),
        infoWindow: InfoWindow(
            title: marker['type'].toString(),
            snippet: marker['description'].toString() +
                ' \nQuantity = ${double.parse(marker['quantity'].toString()).toInt()} bags'),
      ));
    });
    return returnedMarkers;
  }

  User getUserFromJson(String url, Map<String, dynamic> info) {
    return User(
        helper.getAppropriateText(info['user']['id']),
        helper.getAppropriateText(info['user']['name'].toString()),
        helper.getAppropriateText(info['user']['user_name'].toString()),
        helper.getAppropriateText(info['user']['email'].toString()),
        helper.getAppropriateText(info['user']['gender'].toString()),
        helper.getAppropriateText(info['user']['phone_number'].toString()),
        helper.getAppropriateText(info['user']['address'].toString()),
        info['user']['email_verified_at'] != null ? true : false,
        info['profile']['image'] != null
            ? url + info['profile']['image']
            : 'N/A',
        info['profile']['cover'] != null
            ? url + info['profile']['cover']
            : 'N/A',
        helper.getAppropriateText(info['profile']['bio'].toString()));
  }

  getAchievementsFromJson(Map<String,dynamic> data) {}
}

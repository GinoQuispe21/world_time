import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location; //location name for the UI
  String time; //time in that location
  String flag; //url to an asset flag icon
  String url; //location url for API endpoint
  bool isDaytime; //true or false if daytime or not

  WorldTime({this.location, this.flag, this.url});

  Future<void> getTime() async {
    try {
      //make request
      var urlapi = Uri.parse('http://worldtimeapi.org/api/timezone/$url');
      var response = await http.get(urlapi);
      var data = jsonDecode(response.body);
      //print(data);

      //get properties from data
      String dateTime = data['datetime'];
      String offset = data['utc_offset'].substring(1, 3);
      //print(dateTime);
      //print(offset);

      //create DateTime object
      DateTime now = DateTime.parse(dateTime);
      now = now.add(Duration(hours: int.parse(offset)));
      //print(now);
      //time = now.toString();

      // set the tiem property
      isDaytime = now.hour > 6 && now.hour < 17 ? true : false;
      time = DateFormat.jm().format(now);
    } catch (e) {
      print('caught error: $e');
      time = 'could not get time data';
    }
  }
}

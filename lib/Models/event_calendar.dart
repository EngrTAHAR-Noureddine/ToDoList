import 'dart:developer';

import 'package:flutter/material.dart';
import "package:googleapis_auth/auth_io.dart";
import 'package:googleapis/calendar/v3.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:googleapis_auth/googleapis_auth.dart';

class EventCalendar {
  static final EventCalendar _singleton = EventCalendar._internal();
  factory EventCalendar() {
    return _singleton;
  }
  EventCalendar._internal();
  BuildContext context;
  setContext(context){
    this.context = context;
  }
  static final _scopes = [CalendarApi.calendarScope];

  insert(title, startTime, endTime,description) {
    var _clientID = new ClientId("Client ID", "");
    clientViaUserConsent(_clientID, _scopes, prompt).then((AuthClient client) {
      var calendar = CalendarApi(client);
      calendar.calendarList.list().then((value) => print("VAL________$value"));

      String calendarId = "primary";
      Event event = Event(); // Create object of event

      event.summary = title;
      event.description = description;

      EventDateTime start = new EventDateTime();
      start.dateTime = startTime;
      start.timeZone = "GMT+1";
      event.start = start;

      EventDateTime end = new EventDateTime();
      end.timeZone = "GMT+1";
      end.dateTime = endTime;
      event.end = end;
      try {
        calendar.events.insert(event, calendarId).then((value) {
          print("ADDEDDD_________________${value.status}");
          if (value.status == "confirmed") {
            log('Event added in google calendar');
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('New Task added in google Calendar')));
          } else {
            log("Unable to add event in google calendar");
          }
        });
      } catch (e) {
        log('Error creating event $e');
      }
    });
  }

  void prompt(String url) async {
    print("Please go to the following URL and grant access:");
    print("  => $url");
    print("");

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
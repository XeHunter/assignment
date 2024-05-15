import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/event_model.dart';
import '../models/database_helper.dart';

class EventProvider with ChangeNotifier {
  List<EventModel> _events = [];
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  List<EventModel> get events => _events;

  Future<void> fetchEvents() async {
    try {
      final response =
      await http.get(Uri.parse('https://post-api-omega.vercel.app/api/posts?page=1'));

      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        _events = jsonData.map((json) => EventModel.fromJson(json)).toList();
        await _saveEventsToDatabase(_events);
        notifyListeners();
      } else {
        throw Exception('Failed to fetch events');
      }
    } catch (e) {
      print('Error fetching events: $e');
      await _loadEventsFromDatabase();
    }
  }

  Future<void> _saveEventsToDatabase(List<EventModel> events) async {
    await _databaseHelper.clearEvents();
    for (var event in events) {
      await _databaseHelper.insertEvent(event);
    }
  }

  Future<void> _loadEventsFromDatabase() async {
    _events = await _databaseHelper.getEvents();
    notifyListeners();
  }
}
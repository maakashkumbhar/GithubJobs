import 'dart:convert';

import 'package:githubjobs/constants/strings.dart';
import 'package:githubjobs/models/jobs_model.dart';
import 'package:http/http.dart' as http;

class Api_manager {
  static final _client = http.Client();
  List<Jobs> _jobs = null;
  Future<List<Jobs>> getJobs() async {
    try {
      var response = await _client.get(Uri.parse(Strings().githubApi));
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = jsonDecode(jsonString);
        return JobsFromJson(jsonString);
      }
    } catch (e) {
      print(e);
    }
    return _jobs;
  }
}

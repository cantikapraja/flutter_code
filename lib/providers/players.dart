import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../models/player.dart';

class Players with ChangeNotifier {
  List<Player> _allPlayer = [];

  List<Player> get allPlayer => _allPlayer;

  int get jumlahPlayer => _allPlayer.length;

  Player selectById(String id) =>
      _allPlayer.firstWhere((element) => element.id == id);

  Future<void> addPlayer(String name, String position, String image) {
    DateTime datetimeNow = DateTime.now();

    Uri url = Uri.parse(
      "https://http-new-74586-default-rtdb.firebaseio.com/players.json",
    );
    return http
        .post(
          url,
          body: json.encode({
            "name": name,
            "position": position,
            "imageUrl": image,
            "createdAt": datetimeNow.toString(),
          }),
        )
        .then((response) {
          print("THEN FUNCTION");
          _allPlayer.add(
            Player(
              id: json.decode(response.body)["name"].toString(),
              name: name,
              position: position,
              imageUrl: image,
              createdAt: datetimeNow,
            ),
          );

          notifyListeners();
        });
  }

  Future<void> editPlayer(
    String id,
    String name,
    String position,
    String image,
  ) {
    Uri url = Uri.parse(
      "https://http-new-74586-default-rtdb.firebaseio.com/players/$id.json",
    );
    return http
        .put(
          url,
          body: json.encode({
            "name": name,
            "position": position,
            "imageUrl": image,
          }),
        )
        .then((response) {
          Player selectPlayer = _allPlayer.firstWhere(
            (element) => element.id == id,
          );
          selectPlayer.name = name;
          selectPlayer.position = position;
          selectPlayer.imageUrl = image;
          notifyListeners();
        });
  }

  Future<void> deletePlayer(String id) {
    Uri url = Uri.parse(
      "https://http-new-74586-default-rtdb.firebaseio.com/players/$id.json",
    );
    return http.delete(url).then((response) {
      _allPlayer.removeWhere((element) => element.id == id);
      notifyListeners();
    });
  }

  initialData() {
    Uri url = Uri.parse(
      "https://http-new-74586-default-rtdb.firebaseio.com/players.json",
    );

    http.get(url).then((value) {
      var dataResponse = json.decode(value.body) as Map<String, dynamic>;

      dataResponse.forEach((key, value) {
        DateTime dateTimeParse = DateFormat(
          "yyyy-MM-dd HH:mm:ss",
        ).parse(value["createdAt"]);

        print(dateTimeParse);
        _allPlayer.add(
          Player(
            id: key,
            createdAt: dateTimeParse,
            imageUrl: value["imageUrl"],
            name: value["name"],
            position: value["position"],
          ),
        );
      });
      print("Berhasil masukan data list");
    });
    notifyListeners();
  }
}

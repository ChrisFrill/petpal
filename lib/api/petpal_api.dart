import 'dart:math';

import 'package:PetPal/api/tokenhandler.dart';
import 'package:PetPal/models/animal/animal.dart';
import 'package:PetPal/models/animal/liked_animals_list.dart';
import 'package:PetPal/models/chat/chat.dart';
import 'package:PetPal/models/chat/chat_list.dart';
import 'package:PetPal/models/login.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';

import 'package:http/http.dart' as http;

class PetPalApi {
  static const String baseUrl = '10.27.99.28:8080';
  //final _httpClient =  HttpClient();

  requestRegisterAPI(BuildContext context, Map<String, dynamic> body) async {
    final url = Uri.http(baseUrl, "/register/user");

    final response = await http.post(url,
        body: utf8.encode(json.encode(body)),
        headers: {HttpHeaders.contentTypeHeader: "application/json"});

    if (response.statusCode == 200) {
      print("reached this");
      Navigator.of(context).pushReplacementNamed('/authentication');
    } else {
      print("reached that");

      showDialogSingleButton(
          context,
          "Unable to Register",
          "You may have supplied an invalid 'Username' / 'Password' combination. Please try again or contact your support representative.",
          "OK");
      return null;
    }
  }

  Future<LoginModel> requestLoginAPI(
      BuildContext context, Map<String, dynamic> body) async {
    final url = Uri.http(baseUrl, "/login/user");

    final response = await http.post(url,
        body: utf8.encode(json.encode(body)),
        headers: {HttpHeaders.contentTypeHeader: "application/json"});
    print(response.statusCode);

    if (response.statusCode == 200) {
      final Map responseJson = json.decode(response.body);
      TokenHandler().setMobileToken(responseJson["token"]);
      String username = TokenHandler().parseJwt(responseJson["token"])["sub"];
      TokenHandler().setUserName(username);

      print(username);
      Navigator.of(context).pushReplacementNamed('/petfinder');

      return LoginModel.fromJson(body);
    } else {
      showDialogSingleButton(
          context,
          "Unable to Login",
          "You may have supplied an invalid 'Username' / 'Password' combination. Please try again or contact your support representative.",
          "OK");
      return null;
    }
  }

  void uploadFile(BuildContext context, String path, String filename) async {
    final url = Uri.http(baseUrl, "/uploadFile");
    Dio dio = Dio();

    FormData formData = FormData.from({
      "file": UploadFileInfo(
          File(path.substring(7, path.length - 1)), filename)
    });

    final response = await dio.post(url.toString(),
        data: formData,
        options: Options(headers: {
          HttpHeaders.authorizationHeader:
              "Bearer: " + await TokenHandler().getMobileToken(),
        }));

    // var body = {"file": fileName};
    //  response = await http.post(url,
    //     headers: {
    //       HttpHeaders.authorizationHeader:
    //           "Bearer: " + await TokenHandler().getMobileToken(),
    //       HttpHeaders.contentTypeHeader: "multipart/form-data",
    //     },
    //     body: body,
    //     encoding: Encoding.getByName("utf-8"));

    if (response.statusCode == 200) {
      print("Uploaded!");
      print(response);
    } else {
      showDialogSingleButton(
          context,
          "Unable to Login",
          "You may have supplied an invalid 'Username' / 'Password' combination. Please try again or contact your support representative.",
          "OK");
      return null;
    }
  }

  addPet(BuildContext context, Map<String, dynamic> body) async {
    final url = Uri.http(baseUrl, "/uploadPet");

    final response = await http.post(
      url,
      body: utf8.encode(json.encode(body)),
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader:
            "Bearer: " + await TokenHandler().getMobileToken(),
      },
    );

    if (response.statusCode == 200) {
      Navigator.of(context).pushReplacementNamed('/pets');
    } else {
      print(response.statusCode);
      showDialogSingleButton(
          context, "Unable to post pet", "Something went wrong.", "OK");
      return null;
    }
  }

  Future<List<Animal>> getPets() async {
    final url = Uri.http(baseUrl, "/home/pets");

    final response = await http.get(
      url,
      headers: {
        HttpHeaders.authorizationHeader:
            "Bearer: " + await TokenHandler().getMobileToken(),
      },
    );

    final List<dynamic> responseJson = json.decode(response.body);
    if (response.statusCode == 200) {
      print(responseJson);
    } else {
      print(response.statusCode);
    }
    print(LikedAnimalsList.fromJSON(responseJson).toString());
    return LikedAnimalsList.fromJSON(responseJson).animals;
  }

  Future<List<Animal>> getLikedPets() async {
    final url = Uri.http(baseUrl, "/pets/liked");

    final response = await http.get(
      url,
      headers: {
        HttpHeaders.authorizationHeader:
            "Bearer: " + await TokenHandler().getMobileToken(),
      },
    );

    final List<dynamic> responseJson = json.decode(response.body);
    if (response.statusCode == 200) {
      print(responseJson);
    } else {
      print(response.statusCode);
    }
    print(LikedAnimalsList.fromJSON(responseJson).toString());
    return LikedAnimalsList.fromJSON(responseJson).animals;
  }

  Future<List<Animal>> getPetsToAdopt() async {
    final url = Uri.http(baseUrl, "/pets/underadoption");

    final response = await http.get(
      url,
      headers: {
        HttpHeaders.authorizationHeader:
            "Bearer: " + await TokenHandler().getMobileToken(),
      },
    );

    final List<dynamic> responseJson = json.decode(response.body);
    if (response.statusCode == 200) {
      print(responseJson);
    } else {
      print(response.statusCode);
    }
    print(LikedAnimalsList.fromJSON(responseJson).toString());
    return LikedAnimalsList.fromJSON(responseJson).animals;
  }

  Future<List<Chat>> getUserChats() async {
    final url = Uri.http(baseUrl, "/chats");

    final response = await http.get(
      url,
      headers: {
        HttpHeaders.authorizationHeader:
            "Bearer: " + await TokenHandler().getMobileToken(),
      },
    );

    final List<dynamic> responseJson = json.decode(response.body);
    if (response.statusCode == 200) {
      print(response.toString());
    } else {
      print(response.statusCode);
    }
    return ChatList.fromJSON(responseJson).chats;
  }

  Future<Chat> getUserChat(int id) async {
    print(id);
    final url = Uri.http(baseUrl, "/chats/$id");

    final response = await http.get(
      url,
      headers: {
        HttpHeaders.authorizationHeader:
            "Bearer: " + await TokenHandler().getMobileToken(),
      },
    );

    final Map<String, dynamic> responseJson = json.decode(response.body);
    if (response.statusCode == 200) {
      print(response.toString());
    } else {
      print(response.statusCode);
    }
    return Chat.fromJSON(responseJson);
  }

  addMessage(BuildContext context, Map<String, dynamic> body, int id) async {
    final url = Uri.http(baseUrl, "/chats/$id");
    print(body.toString());
    final response = await http.post(
      url,
      body: utf8.encode(json.encode(body)),
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader:
            "Bearer: " + await TokenHandler().getMobileToken(),
      },
    );

    if (response.statusCode == 200) {
      print(response.statusCode);
    } else {
      print(response.statusCode);
      showDialogSingleButton(
          context, "Unable to post message", "Something went wrong.", "OK");
      return null;
    }
  }

  likeAnimal(BuildContext context, int id) async {
    final url = Uri.http(baseUrl, "/pet/$id/like");

    final response = await http.post(url, headers: {
      HttpHeaders.authorizationHeader:
          "Bearer: " + await TokenHandler().getMobileToken(),
    });

    if (response.statusCode == 200) {
    } else {
      showDialogSingleButton(
          context,
          "Unable to like",
          "You may have supplied an invalid 'Username' / 'Password' combination. Please try again or contact your support representative.",
          "OK");
      return null;
    }
  }

  wantToAdoptAnimal(BuildContext context, int id) async {
    final url = Uri.http(baseUrl, "/pet/$id/toAdopt");

    final response = await http.post(url, headers: {
      HttpHeaders.authorizationHeader:
          "Bearer: " + await TokenHandler().getMobileToken(),
    });

    if (response.statusCode == 200) {
    } else {
      showDialogSingleButton(
          context,
          "Unable to adopt",
          "You may have supplied an invalid 'Username' / 'Password' combination. Please try again or contact your support representative.",
          "OK");
      return null;
    }
  }

  void showDialogSingleButton(
      BuildContext context, String title, String message, String buttonLabel) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            FlatButton(
              child: Text(buttonLabel),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

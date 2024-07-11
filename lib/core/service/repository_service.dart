import 'package:http/http.dart' as http;

class RepositoryService{

  const RepositoryService();

  static const String galaxyFoodAPI = "https://";

  Future<http.Response> fetch(dynamic object, String request) async {
    var endpointURL = Uri.parse(galaxyFoodAPI+request);

    var response = await http.post(
        endpointURL,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: object.toJson()
    );
    return response;
  }

}

import 'package:http/http.dart' as http;
import 'package:movienight/models/cep_data.dart';

class ApiCEP {
  static get({required String cep}) async {
    final response = await http.get(Uri.parse('https://viacep.com.br/ws/$cep/json/'));
    if (response.statusCode == 200) {
      print(response.body);
      return ResultCep.fromJson(response.body);
    } else {
      throw Exception('Requisição inválida!');
    }
  }
}


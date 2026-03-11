import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:command_runner/command_runner.dart';

const version = "1.1.1";
void main(List<String> arguments) async {
  var runner = CommandRunner();
  await runner.run(arguments);
}

void printUserInformation() {
  print(
    "The following commands are valid: 'help', 'version', 'search <ARTICLE-TITLE>'",
  );
}

void searchWikipedia(List<String>? arguments) async {
  final String articleTitle;

  if (arguments == null || arguments.isEmpty) {
    print("Please provide titles:");
    articleTitle = stdin.readLineSync() ?? "";
    if (articleTitle.isEmpty) {
      print("You must provide article title, exiting funciton");
      return;
    }
  } else {
    articleTitle = arguments.join(" ");
  }

  print('Looking up articles about "$articleTitle". Please wait.');

  var articleContent = await getWikipediaArticle(articleTitle);
  print(articleContent);
}

Future<String> getWikipediaArticle(String articleTitle) async {
  final url = Uri.https(
    'en.wikipedia.org',
    '/api/rest_v1/page/summary/$articleTitle',
  );

  final response = await http.get(url);
  if (response.statusCode == 200) {
    return response.body;
  }
  return 'Error: Failed to fetch article, Status code: ${response.statusCode}';
}

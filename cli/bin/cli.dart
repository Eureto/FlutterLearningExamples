import 'dart:io';

const version = "1.1.1";
void main(List<String> arguments) {

  if(arguments.isEmpty || arguments.first == "help"){
    printUserInformation();
  }else if(arguments.first == "--version" || arguments.first == "-V"){
    print("Version: $version");
  }else if(arguments.first == "search")
  {
    final inputList = arguments.length > 1 ? arguments.sublist(1): null;
    searchWikipedia(inputList);
  }else{
    printUserInformation();
  }
}

void printUserInformation(){
  print("this is test program");
}

void searchWikipedia(List<String>? arguments){
  
  if(arguments.isEmpty || arguments == null){
    print("Please provide titles:");
    var articles = stdin.readLineSync() ?? "";
  }
  print("Searching for $arguments");
}
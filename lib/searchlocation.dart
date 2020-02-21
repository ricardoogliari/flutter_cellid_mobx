import 'package:flutter/services.dart';
import 'package:mobx/mobx.dart';

part 'searchlocation.g.dart';

class SearchLocation = SearchLocationBase with _$SearchLocation;

abstract class SearchLocationBase with Store {
  static const platform = const MethodChannel('flutter.dev/geolocation');

  @observable
  String currentLocation;

  @action
  void startSearch(){
    try {
      platform.invokeMethod('getLocation').then((result){
        currentLocation = result;
      });
    } on PlatformException catch (e) {
      print("recebeu erro ${e.message}'.");
    }
  }
}
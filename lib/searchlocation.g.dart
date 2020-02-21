// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'searchlocation.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SearchLocation on SearchLocationBase, Store {
  final _$currentLocationAtom =
      Atom(name: 'SearchLocationBase.currentLocation');

  @override
  String get currentLocation {
    _$currentLocationAtom.context.enforceReadPolicy(_$currentLocationAtom);
    _$currentLocationAtom.reportObserved();
    return super.currentLocation;
  }

  @override
  set currentLocation(String value) {
    _$currentLocationAtom.context.conditionallyRunInAction(() {
      super.currentLocation = value;
      _$currentLocationAtom.reportChanged();
    }, _$currentLocationAtom, name: '${_$currentLocationAtom.name}_set');
  }

  final _$SearchLocationBaseActionController =
      ActionController(name: 'SearchLocationBase');

  @override
  void startSearch() {
    final _$actionInfo = _$SearchLocationBaseActionController.startAction();
    try {
      return super.startSearch();
    } finally {
      _$SearchLocationBaseActionController.endAction(_$actionInfo);
    }
  }
}

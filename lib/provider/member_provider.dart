import 'package:flutter/material.dart';
import 'package:flutter_example/models/member/member_model.dart';

class MemberProvider extends ChangeNotifier {
  MemberModel _user = const MemberModel();

  String get name => _user.name ?? "";
  String get sex => _user.sex ?? "";
  double get age => _user.age ?? 0;
  double get height => _user.height ?? 0;
  double get weight => _user.weight ?? 0;
  void set(MemberModel? user) {
    _user = user ?? const MemberModel(name: "");
    notifyListeners();
  }
}

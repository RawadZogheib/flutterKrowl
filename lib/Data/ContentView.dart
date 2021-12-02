import 'package:flutter/material.dart';
import 'package:flutter_app_backend/widgets/TabBar/CustomTab.dart';

class ContentView{
  ContentView({required this.tab, required this.content});
  final CustomTab tab;
  final Widget content;
}
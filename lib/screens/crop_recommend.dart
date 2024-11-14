import 'package:flutter/material.dart';
import 'package:v4/screens/common/drawer.dart';

class CropRecommendPage extends StatefulWidget {
  const CropRecommendPage({super.key});

  @override
  State<CropRecommendPage> createState() => _CropRecommendPageState();
}

class _CropRecommendPageState extends State<CropRecommendPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("작물추천"),
        backgroundColor: Colors.orangeAccent,
      ),
      drawer: CustomDrawer(),
      body: Center(
        child: Text(
          "작황추천 페이지",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
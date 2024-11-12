import 'package:flutter/material.dart';
import 'package:v4/screens/common/style/text_styles.dart';

class SignUpStepTwo extends StatefulWidget {
  @override
  _SignUpStepTwoState createState() => _SignUpStepTwoState();
}

class _SignUpStepTwoState extends State<SignUpStepTwo> {
  String? _selectedCrop;
  String? _selectedInterestCrop;
  String? _mainCrop;
  List<String> _selectedCrops = [];
  List<String> _interestCrops = [];

  final List<String> _cropOptions = ['들깨', '메밀', '콩', '감자']; // 드롭다운 리스트에 사용할 농작물 리스트

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFF339B75),
        elevation: 0,
        centerTitle: true,
        title: Image.asset(
          'assets/png/bgood_bi_w.png',
          height: 40,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    '회원가입',
                    style: AppTextStyle.semibold18,
                  ),
                ),
              ),

              // 진행률 막대
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 50.0, vertical: 16),
                child: LinearProgressIndicator(
                  value: 0.5,
                  backgroundColor: Color(0xFF339B75),
                  valueColor: AlwaysStoppedAnimation(Colors.grey[300]),
                ),
              ),
              SizedBox(height: 20),
            Text('농작물 관리', style: AppTextStyle.regular16),

            // 농작물 드롭다운
            DropdownButton<String>(
              hint: Text('농작물 선택'),
              value: _selectedCrop,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedCrop = newValue;
                  if (!_selectedCrops.contains(newValue)) {
                    _selectedCrops.add(newValue!);
                  }
                });
              },
              items: _cropOptions.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),

            // 메인 작물 지정과 선택된 작물 목록
            SizedBox(height: 10),
            _buildCropList(),

            SizedBox(height: 20),

            Text('관심 농작물(선택)', style: AppTextStyle.regular16),

            // 관심 농작물 드롭다운
            DropdownButton<String>(
              hint: Text('관심 농작물 선택'),
              value: _selectedInterestCrop,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedInterestCrop = newValue;
                  if (!_interestCrops.contains(newValue)) {
                    _interestCrops.add(newValue!);
                  }
                });
              },
              items: _cropOptions.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),

            // 선택된 관심 농작물 목록
            SizedBox(height: 10),
            _buildInterestCropList(),

            Spacer(),

            // 다음 버튼
            ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  "가입",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            SizedBox(height: 30,)
          ],
        ),
      ),
    );
  }

  // 선택된 작물 목록을 보여주는 위젯
  Widget _buildCropList() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('메인 작물 지정'),
            Text('선택 작물'),
            SizedBox(width: 60), // 삭제 버튼 위치 확보
          ],
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: _selectedCrops.length,
          itemBuilder: (context, index) {
            String crop = _selectedCrops[index];
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Radio<String>(
                  value: crop,
                  groupValue: _mainCrop,
                  onChanged: (String? value) {
                    setState(() {
                      _mainCrop = value;
                    });
                  },
                ),
                Text(crop),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.black),
                  onPressed: () {
                    setState(() {
                      _selectedCrops.remove(crop);
                      if (_mainCrop == crop) {
                        _mainCrop = null;
                      }
                    });
                  },
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  // 선택된 관심 농작물 목록을 보여주는 위젯
  Widget _buildInterestCropList() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('선택 작물'),
            SizedBox(width: 60), // 삭제 버튼 위치 확보
          ],
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: _interestCrops.length,
          itemBuilder: (context, index) {
            String crop = _interestCrops[index];
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(crop),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.black),
                  onPressed: () {
                    setState(() {
                      _interestCrops.remove(crop);
                    });
                  },
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  String _selectedLanguage = '한국어'; 

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 언어 선택 드롭다운
              Align(
                alignment: Alignment.topRight,
                child: DropdownButton<String>(
                  value: _selectedLanguage,
                  items: <String>['English', '한국어'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: const TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedLanguage = newValue!;
                    });
                  },
                  icon: const Icon(Icons.keyboard_arrow_down, color: Colors.black),
                  underline: Container(),
                ),
              ),
              const Spacer(),
              // 로고
              Image.asset(
                'assets/png/bgood_bi.png', // 로고 이미지 경로 설정 필요
                height: 50,
              ),
              const SizedBox(height: 60),
              // 이메일 입력 필드
              TextField(
                focusNode: _emailFocusNode,
                decoration: InputDecoration(
                  labelText: _selectedLanguage == 'English' ? 'Email' : '이메일',
                  labelStyle: TextStyle(
                    color: _emailFocusNode.hasFocus ? Colors.black : Colors.grey,
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2.0),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1.0),
                  ),
                  prefixIcon: const Icon(Icons.email, color: Colors.grey),
                ),
                keyboardType: TextInputType.emailAddress,
                onTap: () {
                  setState(() {});
                },
              ),
              const SizedBox(height: 16),
              // 비밀번호 입력 필드
              TextField(
                obscureText: true,
                focusNode: _passwordFocusNode,
                decoration: InputDecoration(
                  labelText: _selectedLanguage == 'English' ? 'Password' : '비밀번호',
                  labelStyle: TextStyle(
                    color: _passwordFocusNode.hasFocus ? Colors.black : Colors.grey,
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2.0),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1.0),
                  ),
                  prefixIcon: Icon(Icons.lock, color: Colors.grey),
                  suffixIcon: Icon(Icons.visibility, color: Colors.grey),
                ),
                onTap: () {
                  setState(() {});
                },
              ),
              const SizedBox(height: 16),
              // 로그인 버튼
              ElevatedButton(
                onPressed: () {
                  // 로그인 로직 처리
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  _selectedLanguage == 'English' ? "CONTINUE" : "로그인",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              // 회원가입 텍스트
              GestureDetector(
                onTap: () {
                  // 회원가입 페이지 이동 처리
                },
                child: RichText(
                  text: TextSpan(
                    text: _selectedLanguage == 'English' ? 'New User?  ' : '새 사용자입니까?  ',
                    style: TextStyle(color: Colors.black),
                    children: [
                      TextSpan(
                        text: _selectedLanguage == 'English' ? 'SIGN UP HERE' : '여기서 가입',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

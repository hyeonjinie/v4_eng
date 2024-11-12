import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:v4/screens/common/style/text_styles.dart'; // For file attachment

class SignUpStepOne extends StatefulWidget {
  @override
  _SignUpStepOneState createState() => _SignUpStepOneState();
}

class _SignUpStepOneState extends State<SignUpStepOne> {
  final _formKey = GlobalKey<FormState>();
  bool _allFieldsFilled = false;
  bool _passwordsMatch = true;
  String? _fileName;

  String _selectedLanguage = '한국어';

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _confirmPasswordFocusNode = FocusNode();
  final FocusNode _companyNameFocusNode = FocusNode();
  final FocusNode _businessNumberFocusNode = FocusNode();
  final FocusNode _representativeNameFocusNode = FocusNode();
  final FocusNode _countryFocusNode = FocusNode();
  final FocusNode _businessAddressFocusNode = FocusNode();
  final FocusNode _managerNameFocusNode = FocusNode();
  final FocusNode _managerContactFocusNode = FocusNode();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _businessNumberController =
      TextEditingController();
  final TextEditingController _representativeNameController =
      TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _businessAddressController =
      TextEditingController();
  final TextEditingController _managerNameController = TextEditingController();
  final TextEditingController _managerContactController =
      TextEditingController();

  void _checkIfAllFieldsFilled() {
    setState(() {
      _allFieldsFilled = _emailController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty &&
          _confirmPasswordController.text.isNotEmpty &&
          _companyNameController.text.isNotEmpty &&
          _businessNumberController.text.isNotEmpty &&
          _representativeNameController.text.isNotEmpty &&
          _countryController.text.isNotEmpty &&
          _businessAddressController.text.isNotEmpty &&
          _managerNameController.text.isNotEmpty &&
          _managerContactController.text.isNotEmpty &&
          _fileName != null;

      // 비밀번호와 확인 비밀번호가 일치하는지 확인
      _passwordsMatch =
          _passwordController.text == _confirmPasswordController.text;
    });
  }

  // Function to pick a file for the business registration certificate
  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        _fileName = result.files.single.name;
        _checkIfAllFieldsFilled();
      });
    }
  }

  @override
  void initState() {
    super.initState();

    // Adding listeners to form fields to check if all fields are filled
    _emailController.addListener(_checkIfAllFieldsFilled);
    _passwordController.addListener(_checkIfAllFieldsFilled);
    _confirmPasswordController.addListener(_checkIfAllFieldsFilled);
    _companyNameController.addListener(_checkIfAllFieldsFilled);
    _businessNumberController.addListener(_checkIfAllFieldsFilled);
    _representativeNameController.addListener(_checkIfAllFieldsFilled);
    _countryController.addListener(_checkIfAllFieldsFilled);
    _businessAddressController.addListener(_checkIfAllFieldsFilled);
    _managerNameController.addListener(_checkIfAllFieldsFilled);
    _managerContactController.addListener(_checkIfAllFieldsFilled);
  }

  @override
  void dispose() {
    // Dispose controllers and focus nodes to avoid memory leaks
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _companyNameController.dispose();
    _businessNumberController.dispose();
    _representativeNameController.dispose();
    _countryController.dispose();
    _businessAddressController.dispose();
    _managerNameController.dispose();
    _managerContactController.dispose();

    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    _companyNameFocusNode.dispose();
    _businessNumberFocusNode.dispose();
    _representativeNameFocusNode.dispose();
    _countryFocusNode.dispose();
    _businessAddressFocusNode.dispose();
    _managerNameFocusNode.dispose();
    _managerContactFocusNode.dispose();

    super.dispose();
  }

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
        child: Form(
          key: _formKey,
          child: ListView(
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
                  backgroundColor: Colors.grey[300],
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF339B75)),
                ),
              ),
              SizedBox(height: 20),

              // Email Field
              _buildTextField(
                controller: _emailController,
                focusNode: _emailFocusNode,
                labelText: _selectedLanguage == 'English' ? 'Email' : '이메일',
                icon: Icons.email,
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 10),

              // Password Field
              _buildTextField(
                controller: _passwordController,
                focusNode: _passwordFocusNode,
                labelText: _selectedLanguage == 'English' ? 'Password' : '비밀번호',
                icon: Icons.lock,
                obscureText: true,
              ),
              SizedBox(height: 10),

              // Confirm Password Field
              _buildTextField(
                controller: _confirmPasswordController,
                focusNode: _confirmPasswordFocusNode,
                labelText: _selectedLanguage == 'English'
                    ? 'Confirm Password'
                    : '비밀번호 확인',
                icon: Icons.lock,
                obscureText: true,
              ),
              SizedBox(height: 10),

              // Company Name Field
              _buildTextField(
                controller: _companyNameController,
                focusNode: _companyNameFocusNode,
                labelText:
                    _selectedLanguage == 'English' ? 'Company Name' : '회사명',
                icon: Icons.business,
              ),
              SizedBox(height: 10),

              // Business Number Field
              _buildTextField(
                controller: _businessNumberController,
                focusNode: _businessNumberFocusNode,
                labelText: _selectedLanguage == 'English'
                    ? 'Business Number'
                    : '사업자번호',
                icon: Icons.confirmation_number,
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 10),

              // Representative Name Field
              _buildTextField(
                controller: _representativeNameController,
                focusNode: _representativeNameFocusNode,
                labelText: _selectedLanguage == 'English'
                    ? 'Representative Name'
                    : '대표명',
                icon: Icons.person,
              ),
              SizedBox(height: 10),

              // Country Field
              _buildTextField(
                controller: _countryController,
                focusNode: _countryFocusNode,
                labelText: _selectedLanguage == 'English' ? 'Country' : '국가',
                icon: Icons.flag,
              ),
              SizedBox(height: 10),

              // Business Address Field
              _buildTextField(
                controller: _businessAddressController,
                focusNode: _businessAddressFocusNode,
                labelText: _selectedLanguage == 'English'
                    ? 'Business Address'
                    : '사업장주소',
                icon: Icons.location_on,
              ),
              SizedBox(height: 10),

              // Manager Name Field
              _buildTextField(
                controller: _managerNameController,
                focusNode: _managerNameFocusNode,
                labelText:
                    _selectedLanguage == 'English' ? 'Manager Name' : '담당자명',
                icon: Icons.person,
              ),
              SizedBox(height: 10),

              // Manager Contact Field
              _buildTextField(
                controller: _managerContactController,
                focusNode: _managerContactFocusNode,
                labelText: _selectedLanguage == 'English'
                    ? 'Manager Contact'
                    : '담당자연락처',
                icon: Icons.phone,
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 10),

              // Business Registration Certificate (File Picker)
              ElevatedButton(
                onPressed: _pickFile,
                child: Text(_fileName != null
                    ? _fileName!
                    : 'Attach Business Registration Certificate'),
              ),
              SizedBox(height: 20),

              // 필수값 입력되지 않은 경우 경고 메시지
              if (!_allFieldsFilled)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(
                    '필수값을 모두 입력해주세요',
                    style: TextStyle(color: Color(0xFF0084FF), fontSize: 14),
                  ),
                ),
              if (_allFieldsFilled && !_passwordsMatch)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(
                    '설정한 비밀번호가 서로 일치하지 않습니다.',
                    style: TextStyle(color: Color(0xFF0084FF), fontSize: 14),
                  ),
                ),

              ElevatedButton(
                onPressed: _allFieldsFilled
                    ? () {
                        // Next step logic goes here
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  _selectedLanguage == 'English' ? "CONTINUE" : "다음",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // TextFormField
  Widget _buildTextField({
    required TextEditingController controller,
    required FocusNode focusNode,
    required String labelText,
    required IconData icon,
    TextInputType? keyboardType,
    bool obscureText = false,
  }) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(
          color: focusNode.hasFocus ? Colors.black : Colors.grey,
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 2.0),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 1.0),
        ),
        prefixIcon: Icon(icon, color: Colors.grey),
      ),
      keyboardType: keyboardType,
      obscureText: obscureText,
      onTap: () {
        setState(() {});
      },
    );
  }
}

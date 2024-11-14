import 'package:flutter/material.dart';
import 'package:v4/data/mock/crop_mock.dart';
import 'package:v4/screens/common/style/text_styles.dart';

class CustomHeader extends StatelessWidget {
  final List<Color> gradientColors;
  final String selectedProduct;
  final String title;
  final ValueChanged<String?> onProductChanged;

  const CustomHeader({
    Key? key,
    required this.gradientColors,
    required this.selectedProduct,
    required this.title,
    required this.onProductChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Column(
        children: [
          const SizedBox(height: 110),
          Row(
            children: [
              _buildProductDropdown(),
              const SizedBox(width: 16),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              const Spacer(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProductDropdown() {
    List<String> cropNames =  ['들깨'];//cropMockupData['selectedCrops'].keys.toList();
    return Container(
      width: 134,
      height: 42,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: Colors.white),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: DropdownButton<String>(
          value: selectedProduct,
          items: cropNames.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value == '들깨' ? 'Perilla' : value,
                  style: AppTextStyle.regular16),
            );
          }).toList(),
          onChanged: onProductChanged,
          dropdownColor: Colors.white,
          icon: Image.asset('assets/icon/arrow_down.png', width: 20, height: 20),
          style: const TextStyle(color: Color(0xFF363B45)),
          underline: const SizedBox(),
          isExpanded: true,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:v4/screens/common/appbar.dart';
import 'package:v4/screens/common/drawer.dart';
import 'package:v4/screens/common/footer.dart';
import 'package:v4/screens/common/header.dart';
import 'package:v4/screens/common/style/text_styles.dart';
import 'package:v4/screens/common/widget/current_chart.dart';
import 'package:v4/screens/common/widget/grade_btn.dart';
import 'package:v4/screens/common/widget/info_text.dart';
import 'package:v4/screens/common/widget/pred_curr_chart.dart';
import 'package:v4/screens/price_info/widget/price_table.dart';
import 'package:v4/screens/common/widget/year_btn.dart';
import 'package:v4/screens/price_info/widget/seasonal_bar.dart';
import 'package:v4/screens/utils/format/number_format.dart';
import 'package:v4/screens/utils/format/plus_minus.dart';
import 'package:v4/services/price_service.dart';

class PriceInfoPage extends StatefulWidget {
  @override
  _PriceInfoPageState createState() => _PriceInfoPageState();
}

class _PriceInfoPageState extends State<PriceInfoPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  //공통
  Future<void>? _priceInfoFuture;
  final PriceService _priceService = PriceService();
  Map<String, dynamic> priceMockupData = {};
  String selectedProduct = "들깨";
  String selectedPriceType = "해외";
  String priceCategory = "수출가격";
  bool isContinuousView = false; //그래프 이어서 보기
  final List<Color> buttonColors = [
    Color(0xFFEB5C5C),
    Color(0xFFFF9500),
    Color(0xFFF8D32D),
    Color(0xFF9568EE),
    Color(0xFFEE68C4),
    Color(0xFF0084FF),
  ];

  // 분석
  Map<String, dynamic> cropData = {}; // 선택된 작물 및 옵션의 실제가격 데이터
  Map<String, List<double>> currentProductionData = {}; //선택한 년도에 대한 분석데이터
  List<double> seasonalIndex = []; //선택한 년도에 대한 계절데이터
  Map<String, Color> yearColorMap = {}; //생성된 년도에 따른 컬러 매핑
  List<String> availableYears = []; // 생성해야 하는 연도 버튼
  List<String> selectedYears = [];
  List<String> availableGrades = [];
  List<String> selectedGrades = [];
  Map<String, Color> gradeColorMap = {}; //생성된 등급에 따른 컬러 매핑

  // 예측
  Map<String, dynamic> cropPredData = {};
  List<double> predCurrProductionData = [];
  List<double> predProductionData = [];
  List<String> date = [];
  List<double> seasonalPredIndex = [];
  List<String> availablePredYears = [];
  List<String> selectedPredYears = [];
  Map<String, Color> yearPredColorMap = {};
  List<String> availablePredGrades = [];
  String selectedPredGrades = '해당없음';

  @override
  void initState() {
    super.initState();
    loadPriceInfo();
  }

  Future<void> loadPriceInfo() async {
    final data = await _priceService.fetchPriceInfo();
    if (mounted) {
      setState(() {
        priceMockupData = data;
      });
      _updateYearColorMap();
      _updateGradeColorMap();
      _updateChartData();
    }
  }

  // chart data 추출
  void _updateChartData() {
    // 선택된 연도 리스트에서 'Avg.'를 '평년'으로 대체
    List<String> modifiedSelectedYears = [
      for (var year in selectedYears) year == 'Avg.' ? '평년' : year
    ];
    List<String> modifiedSelectedPredYears = [
      for (var year in selectedPredYears) year == 'Avg.' ? '평년' : year
    ];

    // 선택된 작물 및 옵션의 실제가격 데이터 가져오기
    cropData = priceMockupData['selectedCrops'][selectedProduct]['prices']
        [selectedPriceType][priceCategory]['실제가격'];
    cropPredData = priceMockupData['selectedCrops'][selectedProduct]['prices']
        [selectedPriceType][priceCategory]['예측가격'];

    // 선택된 연도들의 데이터 가져오기
    currentProductionData = {
      for (var grade in selectedGrades)
        grade: [
          for (var year in (selectedYears..sort()))
            if (year != '평년')
              ...List<double>.from((cropData[year][grade] ?? [])
                  .where((data) => data != null)
                  .map((data) => data!.toDouble()))
        ]
    };
    predProductionData = [
      for (var year in selectedPredYears..sort())
        ...List<double>.from((cropPredData[year][selectedPredGrades] ?? [])
            .where((data) => data != null)
            .map((data) => data!.toDouble()))
    ];
    predCurrProductionData = [
      for (var year in selectedPredYears..sort())
        if (year != '평년')
          ...List<double>.from((cropData[year][selectedPredGrades] ?? [])
              .where((data) => data != null)
              .map((data) => data!.toDouble()))
    ];

    int yearIndex = 0;
    int month = 1;
    date.clear();

    for (int i = 0; i < predProductionData.length; i++) {
      date.add(
          '${modifiedSelectedPredYears[yearIndex].substring(2)}.${month.toString().padLeft(2, '0')}');
      month++;
      if (month > 12) {
        month = 1;
        yearIndex++;
        if (yearIndex >= modifiedSelectedPredYears.length) {
          yearIndex = 0;
        }
      }
    }

    date.sort((a, b) {
      int yearA = int.parse(a.split('.')[0]);
      int monthA = int.parse(a.split('.')[1]);
      int yearB = int.parse(b.split('.')[0]);
      int monthB = int.parse(b.split('.')[1]);

      if (yearA == yearB) {
        return monthA.compareTo(monthB);
      } else {
        return yearA.compareTo(yearB);
      }
    });

    // 계절지수 설정하기
    seasonalIndex = [
      for (var year in selectedYears..sort())
        if (year != '평년')
          ...List<double>.from((cropData['monthly_seasonal_index'][year] ?? [])
              .where((data) => data != null)
              .map((data) => data!.toDouble()))
    ];
    seasonalPredIndex = [
      for (var year in selectedPredYears..sort())
        ...List<double>.from(
            (cropPredData['monthly_seasonal_index'][year] ?? [])
                .where((data) => data != null)
                .map((data) => data!.toDouble()))
    ];

    setState(() {});
  }

  // 연도 버튼 컬러 매핑
  void _updateYearColorMap() {
    yearColorMap.clear(); // 기존 맵 초기화
    availableYears = priceMockupData['selectedCrops'][selectedProduct]['prices']
            [selectedPriceType][priceCategory]['실제가격']
        .keys
        .where((year) =>
            year != 'act_analysis' &&
            year != '평년' &&
            year != 'monthly_seasonal_index')
        .toList();
    availableYears.sort((a, b) => int.parse(b).compareTo(int.parse(a)));
    availableYears.add('Avg.');
    selectedYears = [availableYears[0]];

    for (int i = 0; i < availableYears.length; i++) {
      String year = availableYears[i];
      if (year == 'Avg.') {
        yearColorMap[year] = Color(0xFF78B060);
      } else {
        yearColorMap[year] = Color(0xFF0084FF);
      }
    }

    availablePredYears = priceMockupData['selectedCrops'][selectedProduct]
            ['prices'][selectedPriceType][priceCategory]['예측가격']
        .keys
        .where((year) =>
            year != 'pred_analysis' && year != 'monthly_seasonal_index')
        .toList();
    availablePredYears.sort((a, b) => int.parse(b).compareTo(int.parse(a)));
    selectedPredYears = [availablePredYears[0]];

    for (int i = 0; i < availablePredYears.length; i++) {
      String year = availablePredYears[i];
      if (year == '평년') {
        yearPredColorMap[year] = Color(0xFF78B060);
      } else {
        yearPredColorMap[year] = Color(0xFF0084FF);
      }
    }
  }

  // 등급 버튼 컬러 매핑
  void _updateGradeColorMap() {
    gradeColorMap.clear(); // 기존 맵 초기화
    availableGrades = priceMockupData['selectedCrops'][selectedProduct]
                ['prices'][selectedPriceType][priceCategory]['실제가격']
            [availableYears[0]]
        .keys
        .toList();
    selectedGrades = ['해당없음'];
    for (String grade in availableGrades) {
      switch (grade) {
        case '특':
          gradeColorMap[grade] = Color(0xFFEB5C5C); // 특
          break;
        case '상':
          gradeColorMap[grade] = Color(0xFFFF9500); // 상
          break;
        case '중':
          gradeColorMap[grade] = Color(0xFFF8D32D); // 중
          break;
        case '하':
          gradeColorMap[grade] = Color(0xFF9568EE); // 하
          break;
        case '등급외':
          gradeColorMap[grade] = Color(0xFFEE68C4); // 등급외
          break;
        case '해당없음':
          gradeColorMap[grade] = Color(0xFF0084FF); // 해당없음
          break;
        default:
          gradeColorMap[grade] = Colors.grey; // 지정되지 않은 경우 기본 색상
      }
    }
    availablePredGrades = priceMockupData['selectedCrops'][selectedProduct]
                ['prices'][selectedPriceType][priceCategory]['예측가격']
            [availableYears[0]]
        .keys
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      appBar: CustomAppBar(
        color1: Color(0xFF054F90),
        color2: Color(0xFF020202),
        onMenuPressed: () {
          _scaffoldKey.currentState?.openDrawer();
        },
      ),
      extendBodyBehindAppBar: true,
      drawer: CustomDrawer(),
      body: FutureBuilder(
        future: _priceInfoFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('데이터를 불러오는 중 오류가 발생했습니다.'));
          } else {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    color: Color(0xFFF8F8F8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomHeader(
                          gradientColors: const [
                            Color(0xFF04579D),
                            Color(0xFF022F54),
                            Color(0xFF020202)
                          ],
                          selectedProduct: selectedProduct,
                          title: 'PRICE INFO',
                          onProductChanged: (value) {
                            setState(() {
                              // 데이터 초기화
                              selectedProduct = value ?? '들깨';
                              selectedPriceType = "해외";
                              priceCategory = "수출가격";
                              _updateYearColorMap();
                              _updateChartData();
                            });
                          },
                        ),
                        const SizedBox(height: 30),
                        _buildPriceTypeDropdown(),
                        const SizedBox(height: 16),
                        _buildToggleButtons(),
                        const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 20),
                          child: Text(
                            'Analysis',
                            style: AppTextStyle.medium18,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(16.0),
                          color: Colors.white,
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              PriceTableWidget(
                                dataRows: cropData['act_analysis'] != null
                                    ? [
                                        [
                                          'Current(${cropData['act_analysis']['date']})',
                                          '${cropData['act_analysis']['currency_unit']}${formatCurrency(cropData['act_analysis']['this_value'])}',
                                          ' (${cropData['act_analysis']['weight_unit']})',
                                          'Previous',
                                          formatPositiveValue(
                                              cropData['act_analysis']
                                                  ['rate_compared_last_value'])
                                        ],
                                        [
                                          'Vs. Last Year',
                                          formatCurrency(
                                              cropData['act_analysis']
                                                  ['value_compared_last_year']),
                                          '${formatArrowIndicator(cropData['act_analysis']['diff_compared_last_value_year'])}(${formatPositiveValue(cropData['act_analysis']['rate_compared_last_year'])})'
                                        ],
                                        [
                                          'Vs. Avg. Year',
                                          formatCurrency(cropData[
                                                  'act_analysis']
                                              ['value_compared_common_3years']),
                                          '${formatArrowIndicator(cropData['act_analysis']['diff_value_compared_common_3years'])}(${formatPositiveValue(cropData['act_analysis']['rate_compared_common_3years'])})'
                                        ],
                                        [
                                          '1-Year Avg.',
                                          formatCurrency(
                                              cropData['act_analysis']
                                                  ['year_average_value'])
                                        ],
                                        [
                                          '1-Year Volatility',
                                          '${cropData['act_analysis']['year_change_value']}'
                                        ],
                                        [
                                          'Seasonal Index',
                                          '${cropData['act_analysis']['seasonal_index']}'
                                        ],
                                        [
                                          'Supply Stability Index',
                                          '${cropData['act_analysis']['supply_stability_index']}'
                                        ],
                                      ]
                                    : [
                                        ['Current()', '', '', 'Previous', ''],
                                        ['Vs. Last Year', '', ''],
                                        ['Vs. Avg. Year', '', ''],
                                        ['1-Year Avg.', ''],
                                        ['1-Year Volatility', ''],
                                        ['Seasonal Index', ''],
                                        ['Supply Stability Index', ''],
                                      ],
                              ),
                              YearButtonWidget(
                                availableYears: availableYears,
                                selectedYears: selectedYears,
                                onYearsChanged: (updatedSelectedYears) {
                                  setState(() {
                                    selectedYears = updatedSelectedYears;
                                    _updateChartData();
                                  });
                                },
                                yearColorMap: yearColorMap,
                                isContinuousView: false,
                              ),
                              YearButtonWidget(
                                availableYears: availableGrades,
                                selectedYears: selectedGrades,
                                onYearsChanged: (updatedSelectedYears) {
                                  setState(() {
                                    selectedGrades = updatedSelectedYears;
                                    _updateChartData();
                                  });
                                },
                                yearColorMap: gradeColorMap,
                                isContinuousView: false,
                              ),
                              const SizedBox(height: 16),
                              CurrentChart(
                                selectedGrades: selectedGrades,
                                selectedYears: selectedYears,
                                currentProductionData: currentProductionData,
                                onToggleView: (bool newValue) {
                                  setState(() {
                                    isContinuousView = newValue;
                                  });
                                },
                                gradeColorMap: gradeColorMap,
                                unit: cropData['act_analysis'] != null
                                    ? '(${cropData['act_analysis']['currency_unit']})'
                                    : '',
                                hoverText: 'point.x: point.y',
                              ),
                              SeasonalBarWidget(
                                seasonalIndex: seasonalIndex,
                                selectedYears: selectedYears,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 20),
                          child: Text(
                            'Forecast',
                            style: AppTextStyle.medium18,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(16.0),
                          color: Colors.white,
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              PriceTableWidget(
                                dataRows: cropPredData['pred_analysis'] != null
                                    ? [
                                        [
                                          'Predicted(${cropPredData['pred_analysis']['date']})',
                                          '${cropPredData['pred_analysis']['currency_unit']}${formatCurrency(cropPredData['pred_analysis']['predicted_price'])}',
                                          ' (${cropPredData['pred_analysis']['weight_unit']})',
                                          'Current',
                                          formatPositiveValue(
                                              cropPredData['pred_analysis']
                                                  ['rate_compared_last_value'])
                                        ],
                                        [
                                          'Range',
                                          '${formatCurrency(cropPredData['pred_analysis']['range'][0])} ~ ${formatCurrency(cropPredData['pred_analysis']['range'][1])}'
                                        ],
                                        [
                                          'Out-of-Range Probability',
                                          '${cropPredData['pred_analysis']['out_of_range_probability']}%'
                                        ],
                                        [
                                          'Stability Probability',
                                          '${cropPredData['pred_analysis']['stability_section_probability']}%'
                                        ],
                                        [
                                          'Consistency Index',
                                          '${cropPredData['pred_analysis']['consistency_index']}'
                                        ],
                                        [
                                          'Seasonal Adjusted Price',
                                          formatCurrency(
                                              cropPredData['pred_analysis']
                                                  ['seasonally_adjusted_price'])
                                        ],
                                        [
                                          'Signal Index',
                                          '${cropPredData['pred_analysis']['signal_index']}'
                                        ],
                                      ]
                                    : [
                                        ['Predicted()', '', '', 'Current', ''],
                                        ['Range', ''],
                                        ['Out-of-Range Probability', ''],
                                        ['Stability Probability', ''],
                                        ['Consistency Index', ''],
                                        ['Seasonal Adjusted Price', ''],
                                        ['Signal Index', ''],
                                      ],
                              ),
                              YearButtonWidget(
                                availableYears: availablePredYears,
                                selectedYears: selectedPredYears,
                                onYearsChanged: (updatedSelectedYears) {
                                  setState(() {
                                    selectedPredYears = updatedSelectedYears;
                                    _updateChartData();
                                  });
                                },
                                yearColorMap: yearPredColorMap,
                                isContinuousView: false,
                              ),
                              GradeButtonWidget(
                                onGradeChanged: (newSelectedForecast) {
                                  setState(() {
                                    selectedPredGrades = newSelectedForecast;
                                    _updateChartData();
                                  });
                                },
                                btnNames: availablePredGrades,
                                selectedBtn: selectedPredGrades,
                              ),
                              TrendChart(
                                latestPred: predProductionData,
                                latestActual: predCurrProductionData,
                                date: date,
                                actualName: 'Current',
                                predictedName: 'Predicted',
                                unit: '',
                              ),
                              SeasonalBarWidget(
                                seasonalIndex: seasonalPredIndex,
                                selectedYears: selectedPredYears,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),

                        // const Padding(
                        //   padding:
                        //       EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
                        //   child: Text(
                        //     '예측 성능 지표',
                        //     style: AppTextStyle.medium18,
                        //   ),
                        // ),
                        // Container(
                        //   padding: const EdgeInsets.symmetric(
                        //       horizontal: 16.0, vertical: 20),
                        //   color: Colors.white,
                        //   width: double.infinity,
                        //   child: Column(
                        //     crossAxisAlignment: CrossAxisAlignment.start,
                        //     children: [
                        //       const SizedBox(
                        //         height: 20,
                        //       ),
                        //       Row(
                        //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //         children: [
                        //           // 첫 번째 차트
                        //           Flexible(
                        //             child: HalfDoughnutChart(
                        //               value: performance['highest_accuracy'] ?? 0.0,
                        //               title: '최고 예측 정확도',
                        //             ),
                        //           ),
                        //           // 두 번째 차트
                        //           Flexible(
                        //             child: HalfDoughnutChart(
                        //               value:
                        //                   performance['last_value_accuracy'] ?? 0.0,
                        //               title: '지난달 예측 정확도',
                        //             ),
                        //           ),
                        //         ],
                        //       ),
                        //       PerformanceWidget(info: performance, type: '가격'),
                        //     ],
                        //   ),
                        // ),
                        const SizedBox(
                          height: 50,
                        ),
                      ],
                    ),
                  ),
                  Footer(),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  // 가격 유형 선택 드롭다운
  Widget _buildPriceTypeDropdown() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Container(
            width: 134,
            height: 42,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50),
              border: Border.all(color: Colors.white),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  offset: Offset(0, 2),
                  blurRadius: 4,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: DropdownButton<String>(
                value: selectedPriceType == '해외'
                    ? 'Overseas'
                    : 'Domestic', // 초기 표시 값
                items: <String>['Overseas', 'Domestic'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: const TextStyle(
                        color: Color(0xFF363B45),
                        fontSize: 16,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedPriceType =
                        (value == 'Overseas' ? '해외' : '국내') ?? '해외';
                    // 가격 카테고리 초기화
                    priceCategory = selectedPriceType == '해외' ? '수출가격' : '유통가격';
                    // 업데이트 호출
                    _updateYearColorMap();
                    _updateChartData();
                  });
                },
                dropdownColor: Colors.white,
                icon: Image.asset('assets/icon/arrow_down.png',
                    width: 20, height: 20),
                style: const TextStyle(color: Color(0xFF363B45)),
                underline: SizedBox(),
                isExpanded: true,
              ),
            ),
          ),
          if (selectedPriceType == '해외')
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: InfoTextWidget(text: 'Canada ➔ Korea'),
            ),
        ],
      ),
    );
  }

  // 수출/수입 or 산지/유통 토글 버튼
  Widget _buildToggleButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        height: 42,
        child: ToggleButtons(
          isSelected: selectedPriceType == "해외"
              ? [priceCategory == "수출가격", priceCategory == "수입가격"]
              : [priceCategory == "유통가격", priceCategory == "산지가격"],
          borderRadius: BorderRadius.circular(50),
          selectedBorderColor: Color(0xFF39739D),
          borderColor: Color(0xFFD9D9D9),
          onPressed: (index) {
            String newPriceCategory;

            if (selectedPriceType == "해외") {
              newPriceCategory = index == 0 ? "수출가격" : "수입가격";
            } else {
              newPriceCategory = index == 0 ? "유통가격" : "산지가격";
            }

            // 가격 데이터가 있는지 확인
            bool hasData = checkIfDataExists(newPriceCategory);

            if (hasData) {
              // 데이터가 있으면 카테고리 업데이트
              setState(() {
                priceCategory = newPriceCategory;
                _updateYearColorMap();
                _updateChartData();
              });
            } else {
              // 데이터가 없으면 얼럿 표시
              _showNoDataAlert(context);
            }
          },
          fillColor: Color(0xFF39739D),
          selectedColor: Colors.white,
          color: Color(0xFF9CA1AB),
          constraints: BoxConstraints.expand(width: 130),
          children: selectedPriceType == "해외"
              ? [
                  const Text(
                    'Export',
                    style: AppTextStyle.medium16,
                  ),
                  const Text(
                    'Import',
                    style: AppTextStyle.medium16,
                  )
                ]
              : [
                  const Text(
                    'Market',
                    style: AppTextStyle.medium16,
                  ),
                  const Text(
                    'Auction',
                    style: AppTextStyle.medium16,
                  )
                ],
        ),
      ),
    );
  }

  // 데이터가 있는지 확인하는 함수
  bool checkIfDataExists(String category) {
    if (selectedPriceType == "해외") {
      var data = priceMockupData["selectedCrops"][selectedProduct]["prices"]
          ["해외"][category];
      return data != null && data.isNotEmpty; // null 체크 후 isNotEmpty 호출
    } else {
      var data = priceMockupData["selectedCrops"][selectedProduct]["prices"]
          ["국내"][category];
      return data != null && data.isNotEmpty; // null 체크 후 isNotEmpty 호출
    }
  }

  // 데이터가 없을 때 얼럿 표시
  void _showNoDataAlert(BuildContext context) {
    var snackBar = const SnackBar(
      content: Text(
        '해당 데이터가 없습니다.',
        style: TextStyle(fontSize: 16.0),
      ),
      duration: Duration(seconds: 3),
      behavior: SnackBarBehavior.floating,
    );

    // 스낵바 표시
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

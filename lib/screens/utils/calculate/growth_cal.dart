// 수확일까지 남은 일 수 계산 
int calculateDaysUntilHarvest(String estimatedHarvestDate) {

  DateTime currentDate = DateTime.now();
  DateTime harvestDate = DateTime.parse(estimatedHarvestDate);
  Duration difference = harvestDate.difference(currentDate);

  return difference.inDays;
}

String calculateGrowthStage(double overallProgress, List<dynamic> growthStages) {

  double lastEndMonth = growthStages.last['endMonth'];
  double accumulatedProgress = 0;

  for (var stage in growthStages) {
    double stageProgress = (100 / lastEndMonth) * stage['endMonth'];

    if (overallProgress <= stageProgress) {
      return stage['label'];  
    }
    accumulatedProgress = stageProgress;  
  }

  return growthStages.last['label'];
}

extension on Map<String, dynamic> {
  get last => null;
}



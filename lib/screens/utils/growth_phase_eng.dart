String getGrowthStageInEng(String koreanStage) {
  switch (koreanStage) {
    case '파종 및 유묘기':
      return 'Seeding';
    case '이식기':
      return 'Transplanting';
    case '신장기':
      return 'Vegetative';
    case '개화기':
      return 'Flowering';
    case '성숙기':
      return 'Maturation';
    case '수확':
      return 'Harvest';
    default:
      return koreanStage;
  }
}

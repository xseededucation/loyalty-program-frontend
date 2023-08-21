String getConfettiBasedOnLevel(int indexOfMileStone, int lengthOfMileStone) {
  if (indexOfMileStone == 0) {
    return '';
  } else if (indexOfMileStone == lengthOfMileStone - 1) {
    return 'level_5.png';
  }

  int totalLevels = 3;
  int elementsPerLevel = ((lengthOfMileStone - 2) / totalLevels).ceil();

  if (indexOfMileStone < elementsPerLevel + 1) {
    return 'level_2.png';
  } else if (indexOfMileStone < 2 * elementsPerLevel + 1) {
    return 'level_3.png';
  } else {
    return 'level_4.png';
  }
}

import 'package:flutter_test/flutter_test.dart';
import 'package:loyalty_program_frontend/presentation/utils/helpers/helpers.dart';

void main() {
  group('getConfettiBasedOnLevel test', () {
    test('returns empty string im array has no elements', () {
      int lengthOfArray = 0;
      int indexOfMileStone = 0;
      expect('', getConfettiBasedOnLevel(indexOfMileStone, lengthOfArray));
    });
    test(
        'First element will return level 0 and last element will return level 5',
        () {
      int lengthOfArray = 4;
      int indexOfMileStone = 3;
      expect('level_5.png',
          getConfettiBasedOnLevel(indexOfMileStone, lengthOfArray));
    });
    test('level 2,3 & 4 will be distrubuted equally', () {
      int lengthOfArray = 5;
      int indexOfMileStone = 1;
      expect('level_2.png',
          getConfettiBasedOnLevel(indexOfMileStone, lengthOfArray));
    });
    test('level 2,3 & 4 will be distrubuted equally', () {
      int lengthOfArray = 5;
      int indexOfMileStone = 2;
      expect('level_3.png',
          getConfettiBasedOnLevel(indexOfMileStone, lengthOfArray));
    });

    test('level 2,3 & 4 will be distrubuted equally', () {
      int lengthOfArray = 5;
      int indexOfMileStone = 3;
      expect('level_4.png',
          getConfettiBasedOnLevel(indexOfMileStone, lengthOfArray));
    });
  });
}

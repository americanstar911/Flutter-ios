// void main() {
//   for (int i = 1; i <= 10; i++) {
//     for (int j = 1; j <= 10; j++) {
//       print('$i * $j = ${i * j}');
//     }
//     print(' ');
//   }
// }

// bool isLeapYear(int year) {
//   if (year % 400 == 0) return true;
//   if (year % 100 == 0) return false;
//   if (year % 4 == 0) return true;
//   return false;
// }

// int daysIM(int month, int year) {
//   List<int> days = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
//   if (month == 2 && isLeapYear(year)) {
//     return 29;
//   }
//   return days[month - 1];
// }

// String nextDay(int day, int month, int year) {
//   int Day = day + 1;
//   int Month = month;
//   int Year = year;
//   if (day > 31 || month > 12) {
//     return ('Mistake');
//   }
//   if (Day > daysIM(month, year)) {
//     Day = 1;
//     Month = month + 1;
//     if (Month > 12) {
//       Month = 1;
//       Year = year + 1;
//     }
//   }
//   return ('$Day/$Month/$Year');
// }

// void main() {
//   print(nextDay(28, 2, 2024));
//   print(nextDay(31, 12, 2025));
//   print('--------');
//   print(nextDay(36, 12, 2025));
//   print(nextDay(36, 14, 2025));
// }

// int countVowels(String text) {
//   String vowels = 'aeiou';
//   int count = 0;
//   for (int i = 0; i < text.length; i++) {
//     String letter = text[i].toLowerCase();
//     if (vowels.contains(letter)) {
//       count = count + 1;
//     }
//   }
//   return count;
// }

// void main() {
//   print(countVowels('Hello World'));
//   print(countVowels('Dart Programming'));
//   print(countVowels('Flutter Development'));
// }

void MinMax(List<int> numbers) {
  int min = numbers[0];
  int max = numbers[0];
  for (int i = 0; i < numbers.length; i++) {
    if (numbers[i] > max) {
      max = numbers[i];
    }
    if (numbers[i] < min) {
      min = numbers[i];
    }
  }
  print('Min: $min, Max: $max');
}

void main() {
  MinMax([5, 2, 9, 1, 7]);
}
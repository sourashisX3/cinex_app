import 'package:flutter_test/flutter_test.dart';
import 'package:cinex_app/common/extensions/common_functions.dart';

void main() {
  group('formatDateWithSuffix', () {
    test('returns correct suffixes for typical days', () {
      expect(formatDateWithSuffix(DateTime(2025, 1, 1)), '1st Jan, 2025');
      expect(formatDateWithSuffix(DateTime(2025, 1, 2)), '2nd Jan, 2025');
      expect(formatDateWithSuffix(DateTime(2025, 1, 3)), '3rd Jan, 2025');
      expect(formatDateWithSuffix(DateTime(2025, 1, 4)), '4th Jan, 2025');
    });

    test('handles teen exceptions (11,12,13) as "th"', () {
      expect(formatDateWithSuffix(DateTime(2025, 1, 11)), '11th Jan, 2025');
      expect(formatDateWithSuffix(DateTime(2025, 1, 12)), '12th Jan, 2025');
      expect(formatDateWithSuffix(DateTime(2025, 1, 13)), '13th Jan, 2025');
    });

    test('handles 21,22,23 and 31 correctly', () {
      expect(formatDateWithSuffix(DateTime(2025, 1, 21)), '21st Jan, 2025');
      expect(formatDateWithSuffix(DateTime(2025, 1, 22)), '22nd Jan, 2025');
      expect(formatDateWithSuffix(DateTime(2025, 1, 23)), '23rd Jan, 2025');
      expect(formatDateWithSuffix(DateTime(2025, 1, 31)), '31st Jan, 2025');
    });
  });

  group('formatDateWithSuffixFrom', () {
    test(
      'accepts DateTime and String inputs and returns empty for invalid',
      () {
        expect(
          formatDateWithSuffixFrom(DateTime(2025, 2, 14)),
          '14th Feb, 2025',
        );
        expect(
          formatDateWithSuffixFrom('2025-02-14T00:00:00'),
          '14th Feb, 2025',
        );
        expect(formatDateWithSuffixFrom('invalid-date'), '');
        expect(formatDateWithSuffixFrom(null), '');
      },
    );
  });
}

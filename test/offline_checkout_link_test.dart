import 'package:flutter_test/flutter_test.dart';
import 'package:stylestore_mobile/utils/offline_checkout_link.dart';

void main() {
  group('OfflineCheckoutLink', () {
    final existence = <String, dynamic>{
      'stock_inventario_id': 28,
      'offline_checkout_links': <String, String>{
        '1':
            'https://style-store-frontend-nine.vercel.app/pago-offline/token-1',
        '2':
            'https://style-store-frontend-nine.vercel.app/pago-offline/token-2',
      },
    };

    test('returns the signed link for the exact quantity', () {
      expect(
        OfflineCheckoutLink.forQuantity(existence, 2),
        'https://style-store-frontend-nine.vercel.app/pago-offline/token-2',
      );
    });

    test('does not reuse a link prepared for another quantity', () {
      expect(OfflineCheckoutLink.forQuantity(existence, 3), isNull);
    });

    test('rejects links outside the secure offline checkout route', () {
      expect(
        OfflineCheckoutLink.forQuantity({
          'offline_checkout_links': {'1': 'http://example.test/unsafe'},
        }, 1),
        isNull,
      );
    });
  });
}

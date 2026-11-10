class OfflineCheckoutLink {
  static String? forQuantity(
    Map<String, dynamic>? existence,
    int quantity,
  ) {
    if (existence == null || quantity < 1) return null;

    final rawLinks = existence['offline_checkout_links'];
    if (rawLinks is! Map) return null;

    final rawLink = rawLinks[quantity.toString()];
    if (rawLink is! String) return null;

    final link = rawLink.trim();
    final uri = Uri.tryParse(link);
    if (uri == null ||
        uri.scheme != 'https' ||
        uri.host.isEmpty ||
        !uri.path.contains('/pago-offline/')) {
      return null;
    }
    return link;
  }
}

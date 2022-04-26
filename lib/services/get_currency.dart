String getCurrency(String currency) {
  switch (currency) {
    case 'JPY':
      return '¥';
    case 'EUR':
      return '€';
    case 'USD':
      return '\$';
    case 'GBP':
      return '£';
    default:
      return '€';
  }
}

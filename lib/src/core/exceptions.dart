class UnrecognizedType implements Exception {
  UnrecognizedType(this.fromApi, this.expected)
      : message = 'Unrecognized type that came from api: "$fromApi" '
            'does not conform with any option of $expected.';

  final String fromApi;
  final Type expected;
  final String message;
}

class NameValueObject {
  final String value;

  const NameValueObject({required this.value});

  String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Insira o nome';
    }
    return null;
  }
}

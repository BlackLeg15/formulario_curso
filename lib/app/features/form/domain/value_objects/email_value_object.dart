class EmailValueObject {
  final String value;

  const EmailValueObject({required this.value});

  String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Digite um e-mail';
    }
    return null;
  }
}

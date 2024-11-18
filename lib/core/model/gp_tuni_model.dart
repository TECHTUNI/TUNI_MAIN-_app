class GPTuniModel {
  final String text;
  final bool isSentByMe;
  final List<String>? options;
  final String? imageUrl;

  GPTuniModel(
      {required this.text,
      required this.isSentByMe,
      this.options,
      this.imageUrl});
}

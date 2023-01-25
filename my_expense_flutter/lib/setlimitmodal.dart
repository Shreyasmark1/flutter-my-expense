class SetLimitModal {
  String? response;

  SetLimitModal({required this.response});

  factory SetLimitModal.fromJson(Map<String, dynamic> json) =>
      SetLimitModal(response: json["response"]);
}

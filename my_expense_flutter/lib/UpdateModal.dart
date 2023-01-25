class UpdateModal {
  String note;
  String response;
  UpdateModal({required this.note,required this.response});


  factory UpdateModal.fromJson(Map<String, dynamic> json) => UpdateModal(
    note: json["note"],
    response: json["response"]
  );



}
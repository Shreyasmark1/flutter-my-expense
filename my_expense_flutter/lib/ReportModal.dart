class ReportModal{
  int amount;
  String category;
  ReportModal(this.category,this.amount);

  factory ReportModal.fromJson(Map<String,dynamic> json) =>ReportModal(
    json["category"],
    json["amount"],

  );

}
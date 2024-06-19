class StringTableData
{
  int? id;
  String? kor;

  StringTableData({
    this.id,
    this.kor,
  });

  factory StringTableData.fromJson(Map<String, dynamic> json) => StringTableData
  (
    id: int.parse(json["id"]),
    kor: json["kor"],
  );
}
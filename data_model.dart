class DataModel{
    String name1;
    int count1;



    DataModel({
      required this.name1,
      required this.count1,
    });

    factory DataModel.fromJson(Map<String, dynamic>json) => DataModel(
      name1: json["name"],
      count1: int.parse(json["count"]),
      );
}



List<DataModel> dataModelFromJson1(List data) => List<DataModel>.from(
  data.map((e) => DataModel.fromJson(e))
);

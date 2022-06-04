class VehicleModel {
  final int vehicleId;
  final String vehicleType;
  final List<dynamic> image;
  final String title;
  final String yearModel;
  final String ownerNo;
  final String kmDriven;
  final String fuelType;
  final String descriptionText;
  final double sellAmount;
  final String itemBy;
  String? dbId;
  final String itemByName;
  final int postNo;
  final String brand;
  final String vehicle;

  VehicleModel({
    required this.vehicleId,
    required this.vehicleType,
    required this.image,
    required this.title,
    required this.yearModel,
    required this.ownerNo,
    required this.kmDriven,
    required this.fuelType,
    required this.descriptionText,
    required this.sellAmount,
    required this.itemBy,
    this.dbId,
    required this.itemByName,
    required this.postNo,
    required this.brand,
    required this.vehicle,
  });
}

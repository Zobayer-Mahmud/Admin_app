class Order {
  Order({
    required this.id,
    required this.quantity,
    required this.price,
    this.discount,
    this.vat,
    required this.orderDateAndTime,
    required this.user,
    this.shippingAddress,
    required this.orderFoodItems,
    required this.payment,
    required this.orderStatus,
  });

  int? id;
  int? quantity;
  int? price;
  dynamic discount;
  dynamic vat;
  DateTime? orderDateAndTime;
  User? user;
  IngAddress? shippingAddress;
  List<OrderFoodItem> orderFoodItems;
  Payment? payment;
  OrderStatus? orderStatus;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"] != null ? json['id'] as int : 0,
        quantity: json["quantity"] != null ? json['quantity'] as int : 0,
        price: json["price"] != null ? json['price'] as int : 0,
        discount: json["discount"] != null ? json['discount'] as int : 0,
        vat: json["VAT"] != null ? json['VAT'] as int : 0,
        orderDateAndTime: DateTime.parse(json["order_date_and_time"]),
        user: User.fromJson(json["user"]),
        shippingAddress: json["shipping_address"] != null
            ? IngAddress.fromJson(json["shipping_address"])
            : null,
        orderFoodItems: json["order_food_items"] != null
            ? List<OrderFoodItem>.from(
                json["order_food_items"].map((x) => OrderFoodItem.fromJson(x)))
            : [],
        payment: Payment.fromJson(json["payment"]),
        orderStatus: OrderStatus.fromJson(json["order_status"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "quantity": quantity,
        "price": price,
        "discount": discount,
        "VAT": vat,
        "order_date_and_time": orderDateAndTime?.toIso8601String(),
        "user": user?.toJson(),
        "shipping_address": shippingAddress?.toJson(),
        "order_food_items":
            List<dynamic>.from(orderFoodItems.map((x) => x.toJson())),
        "payment": payment?.toJson(),
        "order_status": orderStatus?.toJson(),
      };
}

class OrderFoodItem {
  OrderFoodItem({
    required this.id,
    required this.name,
    required this.pivot,
    required this.price,
  });

  int id;
  String name;
  Pivot pivot;
  List<Price> price;

  factory OrderFoodItem.fromJson(Map<String, dynamic> json) => OrderFoodItem(
        id: json["id"] != null ? json['id'] as int : 0,
        name: json["name"] != null ? json['name'] as String : "",
        pivot: Pivot.fromJson(json["pivot"]),
        price: json['price'] != null
            ? List<Price>.from(json["price"].map((x) => Price.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "pivot": pivot.toJson(),
        "price": List<dynamic>.from(price.map((x) => x.toJson())),
      };
}

class Pivot {
  Pivot({
    required this.orderId,
    required this.foodItemId,
    required this.foodItemPriceId,
    required this.quantity,
    required this.createdAt,
    required this.updatedAt,
  });

  int orderId;
  int foodItemId;
  int foodItemPriceId;
  int quantity;
  DateTime createdAt;
  DateTime updatedAt;

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
        orderId: json["order_id"] != null ? json['order_id'] as int : 0,
        foodItemId:
            json["food_item_id"] != null ? json['food_item_id'] as int : 0,
        foodItemPriceId: json["food_item_price_id"] != null
            ? json['food_item_price_id'] as int
            : 0,
        quantity: json["quantity"] != null ? json['quantity'] as int : 0,
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "order_id": orderId,
        "food_item_id": foodItemId,
        "food_item_price_id": foodItemPriceId,
        "quantity": quantity,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class Price {
  Price({
    required this.originalPrice,
    required this.discountedPrice,
  });

  int originalPrice;
  int discountedPrice;

  factory Price.fromJson(Map<String, dynamic> json) => Price(
        originalPrice:
            json["original_price"] != null ? json['original_price'] as int : 0,
        discountedPrice: json["discounted_price"] != null
            ? json['discounted_price'] as int
            : 0,
      );

  Map<String, dynamic> toJson() => {
        "original_price": originalPrice,
        "discounted_price": discountedPrice,
      };
}

class OrderStatus {
  OrderStatus({
    required this.orderStatusCategory,
  });

  OrderStatusCategory orderStatusCategory;

  factory OrderStatus.fromJson(Map<String, dynamic> json) => OrderStatus(
        orderStatusCategory:
            OrderStatusCategory.fromJson(json["order_status_category"]),
      );

  Map<String, dynamic> toJson() => {
        "order_status_category": orderStatusCategory.toJson(),
      };
}

class OrderStatusCategory {
  OrderStatusCategory({
    required this.id,
    required this.name,
  });

  int id;
  String name;

  factory OrderStatusCategory.fromJson(Map<String, dynamic> json) =>
      OrderStatusCategory(
        id: json["id"] != null ? json['id'] as int : 0,
        name: json["name"] != null ? json["name"] as String : "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class Payment {
  Payment({
    required this.paymentStatus,
  });

  int paymentStatus;

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        paymentStatus:
            json["payment_status"] != null ? json['payment_status'] as int : 0,
      );

  Map<String, dynamic> toJson() => {
        "payment_status": paymentStatus,
      };
}

class IngAddress {
  IngAddress({
    required this.area,
    required this.appartment,
    required this.house,
    required this.road,
    required this.city,
    required this.district,
    required this.zipCode,
    required this.contact,
  });

  String area;
  String appartment;
  String house;
  String road;
  String city;
  String district;
  String zipCode;
  String contact;

  factory IngAddress.fromJson(Map<String, dynamic> json) => IngAddress(
        area: json["area"] != null ? json["area"] as String : "",
        appartment:
            json["appartment"] != null ? json["appartment"] as String : "",
        house: json["house"] != null ? json["house"] as String : "",
        road: json["road"] != null ? json["road"] as String : "",
        city: json["city"] != null ? json["city"] as String : "",
        district: json["district"] != null ? json["district"] as String : "",
        zipCode: json["zip_code"] != null ? json["zip_code"] as String : "",
        contact: json["contact"] != null ? json["contact"] as String : "",
      );

  Map<String, dynamic> toJson() => {
        "area": area,
        "appartment": appartment,
        "house": house,
        "road": road,
        "city": city,
        "district": district,
        "zip_code": zipCode,
        "contact": contact,
      };
}

class User {
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.contact,
    required this.image,
  });

  int id;
  String name;
  String email;
  String contact;
  String image;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"] != null ? json["id"] as int : 0,
        name: json["name"] != null ? json["name"] as String : "",
        email: json["email"] != null ? json["email"] as String : "",
        contact: json["contact"] != null ? json["contact"] as String : "",
        image: json["image"] != null ? json["image"] as String : "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "contact": contact,
        "image": image,
      };
}

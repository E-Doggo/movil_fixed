class RestaurantEvent {
  RestaurantEvent();
}

class RestaurantFetchedData extends RestaurantEvent {
  final Map<String, dynamic> resInfo;

  RestaurantFetchedData({required this.resInfo});

  List<Object> get props => [resInfo];
}

class RestaurantAddReview extends RestaurantEvent {}

class RestaurantAddFavorite extends RestaurantEvent {}

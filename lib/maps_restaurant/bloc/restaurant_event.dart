class RestaurantEvent {
  RestaurantEvent();
}

class RestaurantFetchedData extends RestaurantEvent {
  final String parameter_id;

  RestaurantFetchedData({required this.parameter_id});

  List<Object> get props => [parameter_id];
}

class RestaurantAddReview extends RestaurantEvent {}

class RestaurantAddFavorite extends RestaurantEvent {}

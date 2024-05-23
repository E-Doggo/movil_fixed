class RestaurantState {
  RestaurantState();
}

class RestaurantLoading extends RestaurantState {}

class RestaurantLoaded extends RestaurantState {
  final String id_restaurant;
  final bool favorite;
  final int stars;

  RestaurantLoaded(
      {required this.id_restaurant,
      required this.favorite,
      required this.stars});

  List<Object> get props => [id_restaurant];
}

class RestaurantLoadingFailed extends RestaurantState {}

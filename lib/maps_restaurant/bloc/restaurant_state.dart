class RestaurantState {
  RestaurantState();
}

class RestaurantLoading extends RestaurantState {}

class RestaurantLoaded extends RestaurantState {
  final Map<String, dynamic> restaruantInfo;
  final bool restaurantFavorite;

  RestaurantLoaded(
      {required this.restaruantInfo, required this.restaurantFavorite});

  List<Object> get props => [restaruantInfo, restaurantFavorite];
}

class RestaurantLoadingFailed extends RestaurantState {}

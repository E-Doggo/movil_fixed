class RestaurantEvent {}

class RestaurantReview extends RestaurantEvent {}

class RestaurantFavorite extends RestaurantEvent {
  final String id_restaurant;

  RestaurantFavorite({required this.id_restaurant});

  List<Object> get props => [id_restaurant];
}

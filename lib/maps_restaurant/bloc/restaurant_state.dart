class RestaurantState {}

class RestaurantLoading extends RestaurantState {}

class RestaurantLoaded extends RestaurantState {
  final String id_restaurant;

  RestaurantLoaded({required this.id_restaurant});

  List<Object> get props => [id_restaurant];
}

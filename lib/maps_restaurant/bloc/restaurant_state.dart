class RestaurantState {
  RestaurantState();
}

class RestaurantLoading extends RestaurantState {}

class RestaurantLoaded extends RestaurantState {
  final Map<String, dynamic> restaruantInfo;

  RestaurantLoaded({required this.restaruantInfo});

  List<Object> get props => [restaruantInfo];
}

class RestaurantLoadingFailed extends RestaurantState {}

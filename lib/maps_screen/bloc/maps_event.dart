class MapEvents {
  MapEvents();
}

class MapLoadedData extends MapEvents {}

class MapRestaurantSelected extends MapEvents {
  final String id_restaurant;

  MapRestaurantSelected({required this.id_restaurant});

  List<Object> get props => [id_restaurant];
}

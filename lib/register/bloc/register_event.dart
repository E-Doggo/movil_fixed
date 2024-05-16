class RegisterEvent {
  RegisterEvent();
}

class RegisterSave extends RegisterEvent {
  final String email;
  final String password;
  final String passwordValidation;
  final String username;

  RegisterSave(
      {required this.email,
      required this.password,
      required this.passwordValidation,
      required this.username});

  @override
  List<Object> get props => [email, password, passwordValidation, username];
}

class RegisterChange extends RegisterEvent {
  final int type;
  RegisterChange({required this.type});
  @override
  List<Object> get props => [type];
}

class RegisterRestaurant extends RegisterEvent {
  final String email;
  final String password;
  final String passwordValidation;
  final String restaurantName;
  final String streetName;
  final String description;

  RegisterRestaurant(
      {required this.email,
      required this.password,
      required this.passwordValidation,
      required this.restaurantName,
      required this.description,
      required this.streetName});

  @override
  List<Object> get props => [
        email,
        password,
        passwordValidation,
        restaurantName,
        description,
        streetName
      ];
}

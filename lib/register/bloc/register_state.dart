class RegisterState {
  RegisterState();
}

class RegisterWaiting extends RegisterState {}

class RegisterWaitingRestaurant extends RegisterState {}

class RegisterSuccesful extends RegisterState {
  // Aqui poner el firstTime = false
}

class RegisterFailure extends RegisterState {}

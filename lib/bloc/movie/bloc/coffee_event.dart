part of 'coffee_bloc.dart';

sealed class CoffeeEvent extends Equatable {
  const CoffeeEvent();

  @override
  List<Object> get props => [];
}

class FetchCoffeeEvent extends CoffeeEvent {
  const FetchCoffeeEvent();
}

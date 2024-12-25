import 'package:coffeeshopapp/bloc/movie/bloc/barrel.dart';
import 'package:coffeeshopapp/repository/coffee_db_reposiotry.dart';
part 'coffee_event.dart';
part 'coffee_state.dart';

class CoffeeBloc extends Bloc<CoffeeEvent, CoffeeState> {
  ProductModelDbReposiotry productModelDbReposiotry =
      ProductModelDbReposiotry();
  CoffeeBloc() : super(CoffeeState()) {
    on<FetchCoffeeEvent>(_fetchCoffee);
  }

  void _fetchCoffee(FetchCoffeeEvent event, Emitter<CoffeeState> emit) async {
    emit(state.copyWith(
      status: Status.loading,
    ));
    await productModelDbReposiotry.getProductModels().then((val) {
      emit(state.copyWith(
        products: val,
        status: Status.success,
      ));
    }).catchError((error) {
      emit(state.copyWith(
        message: error.toString(),
        status: Status.error,
      ));
    });
  }
}

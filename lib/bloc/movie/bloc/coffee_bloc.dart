import 'package:coffeeshopapp/bloc/movie/bloc/barrel.dart';
import 'package:coffeeshopapp/repository/coffee_db_reposiotry.dart';
part 'coffee_event.dart';
part 'coffee_state.dart';

class CoffeeBloc extends Bloc<CoffeeEvent, CoffeeState> {
  ProductModelDbReposiotry productModelDbReposiotry =
      ProductModelDbReposiotry();
  late List<ProductModel> products;
  CoffeeBloc() : super(const CoffeeState()) {
    on<FetchCoffeeEvent>(_fetchCoffee);
    on<AddnewProductEvent>(_addNewProduct);
  }

  void _fetchCoffee(FetchCoffeeEvent event, Emitter<CoffeeState> emit) async {
    emit(state.copyWith(
      status: Status.loading,
    ));
    await productModelDbReposiotry.getProductModels().then((val) {
      products = val ?? const [];
      emit(state.copyWith(
        products: products,
        status: Status.success,
      ));
    }).catchError((error) {
      emit(state.copyWith(
        message: error.toString(),
        status: Status.error,
      ));
    });
  }

  void _addNewProduct(
      AddnewProductEvent event, Emitter<CoffeeState> emit) async {
    emit(state.copyWith(
      status: Status.loading,
    ));
    products = [...state.products, event.productModel];
    await productModelDbReposiotry
        .addProductModel(event.productModel)
        .then((_) {
      emit(state.copyWith(
        status: Status.success,
        products: products,
      ));
    }).catchError((error) {
      emit(state.copyWith(
        message: error.toString(),
        status: Status.error,
      ));
    });
  }
}

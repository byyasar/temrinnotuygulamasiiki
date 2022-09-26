import 'package:bloc/bloc.dart';
import 'package:temrinnotuygulamasiiki/features/temrin/cubit/temrin_state.dart';
import 'package:temrinnotuygulamasiiki/features/temrin/model/temrin_model.dart';
import 'package:temrinnotuygulamasiiki/features/temrin/service/temrin_database_provider.dart';

class TemrinCubit extends Cubit<TemrinState> {
  TemrinCubit({required TemrinDatabaseProvider databaseProvider})
      : _databaseProvider = databaseProvider,
        super(const TemrinState()) {
    temrinleriGetir();
  }

  final TemrinDatabaseProvider _databaseProvider;

  Future<void> temrinleriGetir() async {
    emit(state.copyWith(isLoading: true));
    final temrinList = await _databaseProvider.getList();
    emit(state.copyWith(
        temrinModel: temrinList, isLoading: false, isCompleted: true));
  }

  Future<void> filtrelenmisTemrinleriGetir(int dersId) async {
    emit(state.copyWith(isLoading: true));
    final temrinList = await _databaseProvider.getFilterList(dersId);
    emit(state.copyWith(
        temrinModel: temrinList, isLoading: false, isCompleted: true));
  }

  Future<void> temrinKaydet({int? id, required TemrinModel temrinModel}) async {
    emit(state.copyWith(isLoading: true));

    if (id == null) {
      await _databaseProvider.insertItem(temrinModel);
    } else {
      await _databaseProvider.updateItem(id, temrinModel);
    }
    final temrinList = await _databaseProvider.getList();
    emit(state.copyWith(
        temrinModel: temrinList, isLoading: false, isCompleted: true));
  }

  Future<void> temrinSil({required int id}) async {
    emit(state.copyWith(isLoading: true));
    await _databaseProvider.removeItem(id);
    final temrinList = await _databaseProvider.getList();
    emit(state.copyWith(
        temrinModel: temrinList, isLoading: false, isCompleted: true));
  }
}

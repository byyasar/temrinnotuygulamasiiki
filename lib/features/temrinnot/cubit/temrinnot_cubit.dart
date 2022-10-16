import 'package:bloc/bloc.dart';
import 'package:temrinnotuygulamasiiki/features/temrinnot/cubit/temrinnot_state.dart';
import 'package:temrinnotuygulamasiiki/features/temrinnot/model/temrinnot_model.dart';
import 'package:temrinnotuygulamasiiki/features/temrinnot/service/temrinnot_database_provider.dart';

class TemrinNotCubit extends Cubit<TemrinNotState> {
  TemrinNotCubit({required TemrinNotDatabaseProvider databaseProvider, int? ogrenciId})
      : _databaseProvider = databaseProvider,
        _ogrenciId = ogrenciId ?? -1,
        super(const TemrinNotState()) {
    temrinnotleriGetir(_ogrenciId);
  }

  final TemrinNotDatabaseProvider _databaseProvider;
  final int _ogrenciId;

  Future<void> temrinnotleriGetir(int? ogrenciId) async {
    emit(state.copyWith(isLoading: true));
    if (ogrenciId == -1) {
      final temrinnotList = await _databaseProvider.getList();
      emit(state.copyWith(temrinNotModel: temrinnotList, isLoading: false, isCompleted: true));
    } else {
      final temrinnotList = await _databaseProvider.getFilterListItemOgrenciParameter(ogrenciId: ogrenciId);
      emit(state.copyWith(temrinNotModel: temrinnotList, isLoading: false, isCompleted: true));
    }
  }

  Future<List<TemrinNotModel>> filtrelenmisTemrinNotleriGetir(int dersId) async {
    emit(state.copyWith(isLoading: true));
    final temrinnotList = await _databaseProvider.getFilterList(dersId);
    emit(state.copyWith(temrinNotModel: temrinnotList, isLoading: false, isCompleted: true));
    return temrinnotList;
  }

  Future<void> temrinnotKaydet({int? id, required TemrinNotModel temrinnotModel}) async {
    emit(state.copyWith(isLoading: true));

    if (id == null) {
      await _databaseProvider.insertItem(temrinnotModel);
    } else {
      await _databaseProvider.updateItem(id, temrinnotModel);
    }
    final temrinnotList = await _databaseProvider.getList();
    emit(state.copyWith(temrinNotModel: temrinnotList, isLoading: false, isCompleted: true));
  }

  Future<void> temrinnotSil({required int id}) async {
    emit(state.copyWith(isLoading: true));
    await _databaseProvider.removeItem(id);
    final temrinnotList = await _databaseProvider.getList();
    emit(state.copyWith(temrinNotModel: temrinnotList, isLoading: false, isCompleted: true));
  }
}

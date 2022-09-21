import 'package:bloc/bloc.dart';
import 'package:temrinnotuygulamasiiki/features/ogrenci/cubit/ogrenci_state.dart';
import 'package:temrinnotuygulamasiiki/features/ogrenci/model/ogrenci_model.dart';
import 'package:temrinnotuygulamasiiki/features/ogrenci/service/ogrenci_database_provider.dart';

class OgrenciCubit extends Cubit<OgrenciState> {
  OgrenciCubit({required OgrenciDatabaseProvider databaseProvider})
      : _databaseProvider = databaseProvider,
        super(const OgrenciState()) {
    ogrencileriGetir();
  }

  final OgrenciDatabaseProvider _databaseProvider;

  Future<void> ogrencileriGetir() async {
    emit(state.copyWith(isLoading: true));
    final ogrenciList = await _databaseProvider.getList();
    emit(state.copyWith(ogrenciModel: ogrenciList, isLoading: false, isCompleted: true));
   }
    
  Future<void> ogrenciKaydet({int? id, required OgrenciModel ogrenciModel}) async {
     emit(state.copyWith(isLoading: true));
   
      if (id == null) {
        await _databaseProvider.insertItem(ogrenciModel);
      } else {
        await _databaseProvider.updateItem(id, ogrenciModel);
      }
      final ogrenciList = await _databaseProvider.getList();
     emit(state.copyWith(ogrenciModel: ogrenciList, isLoading: false, isCompleted: true));
  }

  Future<void> ogrenciSil({required int id}) async {
    emit(state.copyWith(isLoading: true));
      await _databaseProvider.removeItem(id);
      final ogrenciList = await _databaseProvider.getList();
     emit(state.copyWith(ogrenciModel: ogrenciList, isLoading: false, isCompleted: true));
  }
}

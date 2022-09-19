import 'package:bloc/bloc.dart';
import 'package:temrinnotuygulamasiiki/features/sinif/cubit/sinif_state.dart';
import 'package:temrinnotuygulamasiiki/features/sinif/model/sinif_model.dart';
import 'package:temrinnotuygulamasiiki/features/sinif/service/sinif_database_provider.dart';

class SinifCubit extends Cubit<SinifState> {
  SinifCubit({required SinifDatabaseProvider databaseProvider})
      : _databaseProvider = databaseProvider,
        super(const SinifState()) {
    sinifleriGetir();
  }

  final SinifDatabaseProvider _databaseProvider;

  Future<void> sinifleriGetir() async {
    emit(state.copyWith(isLoading: true));
    final sinifList = await _databaseProvider.getList();
    emit(state.copyWith(sinifModel: sinifList, isLoading: false, isCompleted: true));
   }
    
  Future<void> sinifKaydet({int? id, required SinifModel sinifModel}) async {
     emit(state.copyWith(isLoading: true));
   
      if (id == null) {
        await _databaseProvider.insertItem(sinifModel);
      } else {
        await _databaseProvider.updateItem(id, sinifModel);
      }
      final sinifList = await _databaseProvider.getList();
     emit(state.copyWith(sinifModel: sinifList, isLoading: false, isCompleted: true));
  }

  Future<void> sinifSil({required int id}) async {
    emit(state.copyWith(isLoading: true));
      await _databaseProvider.removeItem(id);
      final sinifList = await _databaseProvider.getList();
     emit(state.copyWith(sinifModel: sinifList, isLoading: false, isCompleted: true));
  }
}

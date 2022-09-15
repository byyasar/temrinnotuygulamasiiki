import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temrinnotuygulamasiiki/cubit/ders_cubit.dart';
import 'package:temrinnotuygulamasiiki/cubit/ders_state.dart';
import 'package:temrinnotuygulamasiiki/models/ders/ders_database_provider.dart';
import 'package:temrinnotuygulamasiiki/models/ders/ders_model.dart';
import 'package:temrinnotuygulamasiiki/widget/loading_center_widget.dart';

class AnapencereView extends StatefulWidget {
  const AnapencereView({Key? key}) : super(key: key);

  @override
  State<AnapencereView> createState() => _AnapencereViewState();
}

class _AnapencereViewState extends State<AnapencereView> {
  List<dynamic> ogrenciList = [];
  List<DersModel> durum = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DersCubit(databaseProvider: DersDatabaseProvider()),
      child:BlocBuilder<DersCubit, DersState>(
              builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              leading: state.isLoading? const LoadingCenter():const SizedBox(),
            ),
            floatingActionButton: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                  child: const Icon(Icons.all_inbox),
                  onPressed: () async {
                   // context.read<DersCubit>().dersleriGetir();
                  },
                ),
              
               
                FloatingActionButton(
                  child: const Icon(Icons.remove),
                  onPressed: () async {
                    context.read<DersCubit>().dersSil(id: 3);
                  },
                ),
                FloatingActionButton(
                  child: const Icon(Icons.add),
                  onPressed: () async {
                    DersModel dersModel = DersModel();
                    dersModel.dersAd = "pc";
                    dersModel.sinifId = 2;
                    context.read<DersCubit>().dersKaydet(dersModel: dersModel);
                  },
                ),
                FloatingActionButton(
                  child: const Icon(Icons.list),
                  onPressed: () async {
                    DersModel dersModel = DersModel();
                    dersModel.dersAd = "web tasarım";
                    dersModel.sinifId = 2;
                    dersModel.id = 1;
                    context.read<DersCubit>().dersKaydet(dersModel: dersModel);
                    // context.read<DersCubit>().dersKaydet(id: 5, dersModel: dersModel);
                  },
                ),
              ],
            ),
            body: BlocBuilder<DersCubit, DersState>(
              builder: (context, state) {
                // if (state is DersLoaded) {
                //   List<DersModel> list = [];
                //   list = state.ders ?? [];
                //   return ListView.builder(
                //     itemCount: list.length,
                //     itemBuilder: (BuildContext context, int index) {
                //       return Text(list[index].toString());
                //     },
                //   );
                // } else if (state is DersLoading) {
                //   return const Center(child: CircularProgressIndicator());
                // } else if (state is DersFailure) {
                //   return Text('$state hata oluştu');
                if (state.isCompleted) {
                  List<DersModel> list = [];
                  list = state.dersModel ?? [];
                  return ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Text(list[index].toString());
                    },
                  );
                } else {
                  return const SizedBox(height: 1);
                }
              },
            ),
          );
        }
      ),
    );
  }
}

// class PageView extends StatelessWidget {
//   const PageView({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return 
//   }
// }


/*


Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            child: const Icon(Icons.all_inbox),
            onPressed: () async {
              verileriGetir();
              setState(() {});
            },
          ),
          FloatingActionButton(
            child: const Icon(Icons.update),
            onPressed: () async {
              //DersDatabaseProvider dersDatabaseProvider = DersDatabaseProvider();
              await dersDatabaseProvider.open();
              DersModel dersModel = DersModel();
              dersModel.dersAd = "yaşar ders";
              dersModel.sinifId = 2;
              dersModel.id = 8;
              DersModel derslist;
              bool durum = await dersDatabaseProvider.updateItem(8, dersModel);
            },
          ),
          FloatingActionButton(
            child: const Icon(Icons.remove),
            onPressed: () async {
              //DersDatabaseProvider dersDatabaseProvider = DersDatabaseProvider();
              await dersDatabaseProvider.open();
              bool durum = await dersDatabaseProvider.removeItem(6);
            },
          ),
          FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () async {
              //DersDatabaseProvider dersDatabaseProvider = DersDatabaseProvider();
              await dersDatabaseProvider.open();
              DersModel dersModel = DersModel();
              dersModel.dersAd = "pc";
              dersModel.sinifId = 2;
              DersModel derslist;
              bool durum = await dersDatabaseProvider.insertItem(dersModel);
              inspect(durum);
            },
          ),
          FloatingActionButton(
            child: const Icon(Icons.list),
            onPressed: () async {
              await dersDatabaseProvider.open();
              DersModel dersModel;
              int id = 5;
              dersModel = await dersDatabaseProvider.getItem(id);
              inspect(dersModel);
            },
          ),
        ],
      ),
      body: Container(
        //color: Colors.amber,
        child: ListView.builder(
          itemCount: durum.length,
          itemBuilder: (BuildContext context, int index) {
            return Text(
                '${durum[index].id.toString()} - ${durum[index].dersAd ?? ""} - ${durum[index].sinifId.toString()}');
          },
        ),
      ),
    );
 */

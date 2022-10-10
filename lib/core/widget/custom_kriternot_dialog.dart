import 'package:flutter/material.dart';
import 'package:temrinnotuygulamasiiki/constans/icon_constans.dart';
import 'package:temrinnotuygulamasiiki/core/base/base_state.dart';
import 'package:temrinnotuygulamasiiki/core/widget/cancel_button.dart';
import 'package:temrinnotuygulamasiiki/core/widget/custom_menu_button.dart';
import 'package:temrinnotuygulamasiiki/features/temrinnot/model/temrinnot_model.dart';
import 'package:temrinnotuygulamasiiki/features/temrinnot/service/temrinnot_database_provider.dart';

class CustomKriterDialog extends StatefulWidget {
  final TemrinNotModel transaction;
  final int? ogrenciId;
  final int? index;
  //final List<int>? parametreler;
  final List<int>? kriterler;

  //final Function() onClickedDone;

  const CustomKriterDialog({
    Key? key,
    required this.transaction,
    // required this.onClickedDone,
    required this.ogrenciId,
    // required this.parametreler,
    required this.kriterler,
    required this.index,
  }) : super(key: key);

  @override
  _CustomKriterDialogState createState() => _CustomKriterDialogState();
}

class _CustomKriterDialogState extends BaseState<CustomKriterDialog> {
  final formKey = GlobalKey<FormState>();
  //late TemrinnotStore viewModel;
  final TemrinNotModel viewModel = TemrinNotModel();

  final _aciklamaController = TextEditingController();
  final _kriter1Controller = TextEditingController();
  final _kriter2Controller = TextEditingController();
  final _kriter3Controller = TextEditingController();
  final _kriter4Controller = TextEditingController();
  final _kriter5Controller = TextEditingController();
  int _toplam = 0;

  @override
  void initState() {
    super.initState();
    _aciklamaController.text = widget.transaction.aciklama ?? "";
    _kriter1Controller.text = widget.kriterler![0].toString();
    _kriter2Controller.text = widget.kriterler![1].toString();
    _kriter3Controller.text = widget.kriterler![2].toString();
    _kriter4Controller.text = widget.kriterler![3].toString();
    _kriter5Controller.text = widget.kriterler![4].toString();
    _toplam = int.tryParse(_kriter1Controller.text.isEmpty ? '0' : _kriter1Controller.text)! +
        int.tryParse(_kriter2Controller.text.isEmpty ? '0' : _kriter2Controller.text)! +
        int.tryParse(_kriter3Controller.text.isEmpty ? '0' : _kriter3Controller.text)! +
        int.tryParse(_kriter4Controller.text.isEmpty ? '0' : _kriter4Controller.text)! +
        int.tryParse(_kriter5Controller.text.isEmpty ? '0' : _kriter5Controller.text)!;
    ////_viewModel.setKriterler(widget.kriterler!);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: EdgeInsets.fromLTRB(0, 10, 0, 0),
      title: const Center(child: Text('Değerlendirme Kriterleri')),
      content: Column(
        children: [
          Row(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              myCustomMenuButton(context, () {
                toplamHesapla();
                _buildAllOkButtononPressed;
              }, const Text('Tam'), IconsConstans.fullokIcon, Colors.blueAccent),
              const SizedBox(width: 10),
              myCustomMenuButton(context, () {
                _buildOkButtononPressed(false);
              }, const Text('Gelmedi'), IconsConstans.gelmediIcon, Colors.red),
            ],
          ),
          Form(
            key: formKey,
            child: Expanded(
              child: SingleChildScrollView(
                child: SizedBox(
                  width: dyanmicWidth(.90),
                  child: Column(
                    children: <Widget>[
                      const Divider(height: 10),
                      /* Observer(builder: (_) {
                          _toplam = //_viewModel.toplam;
                          return Text('TOPLAM =$_toplam');
                        }), */

                      //"buildTemrin(context, transactionsTemrin),

                      Text('TOPLAM =${_toplam < 0 ? 'G' : _toplam}'),
                      TextFormField(
                        style: const TextStyle(fontSize: 24),
                        decoration: const InputDecoration(
                            labelText: '1-Bilgi -20P', focusColor: Colors.blue, labelStyle: TextStyle(fontSize: 18)),
                        controller: _kriter1Controller,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        onChanged: (value) {
                          int puan = int.tryParse(value.isEmpty ? '0' : value)!;
                          if (puan >= 0 && puan <= 20) {
                            widget.kriterler![0] = int.tryParse(value.isEmpty ? '0' : value)!;
                            //_viewModel.setKriterler(widget.kriterler!);
                            toplamHesapla();
                          } else {
                            _kriter1Controller.text = '';
                          }
                        },
                      ),
                      TextFormField(
                        style: const TextStyle(fontSize: 24),
                        decoration: const InputDecoration(
                            labelText: '2-Çözümü anlama ve aktarma -30P',
                            focusColor: Colors.blue,
                            labelStyle: TextStyle(fontSize: 18)),
                        controller: _kriter2Controller,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        onChanged: (value) {
                          int puan = int.tryParse(value.isEmpty ? '0' : value)!;
                          if (puan >= 0 && puan <= 30) {
                            widget.kriterler![1] = int.tryParse(value.isEmpty ? '0' : value)!;
                            toplamHesapla();
                            //_viewModel.setKriterler(widget.kriterler!);
                          } else {
                            _kriter2Controller.text = '';
                          }
                        },
                      ),
                      TextFormField(
                        style: const TextStyle(fontSize: 24),
                        decoration: const InputDecoration(
                            labelText: '3-Doğru şekilde çalıştırma -30P',
                            focusColor: Colors.blue,
                            labelStyle: TextStyle(fontSize: 18)),
                        controller: _kriter3Controller,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        onChanged: (value) {
                          int puan = int.tryParse(value.isEmpty ? '0' : value)!;
                          if (puan >= 0 && puan <= 30) {
                            widget.kriterler![2] = int.tryParse(value.isEmpty ? '0' : value)!;
                            toplamHesapla();
                            //_viewModel.setKriterler(widget.kriterler!);
                          } else {
                            _kriter3Controller.text = '';
                          }
                        },
                      ),
                      TextFormField(
                        style: const TextStyle(fontSize: 24),
                        decoration: const InputDecoration(
                            labelText: '4-Tasarım -10P', focusColor: Colors.blue, labelStyle: TextStyle(fontSize: 18)),
                        controller: _kriter4Controller,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        onChanged: (value) {
                          int puan = int.tryParse(value.isEmpty ? '0' : value)!;
                          if (puan >= 0 && puan <= 10) {
                            widget.kriterler![3] = int.tryParse(value.isEmpty ? '0' : value)!;
                            toplamHesapla();
                            //_viewModel.setKriterler(widget.kriterler!);
                          } else {
                            _kriter4Controller.text = '';
                          }
                        },
                      ),
                      TextFormField(
                        style: const TextStyle(fontSize: 24),
                        decoration: const InputDecoration(
                            labelText: '5-Süre -10P', focusColor: Colors.blue, labelStyle: TextStyle(fontSize: 18)),
                        controller: _kriter5Controller,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        onChanged: (value) {
                          int puan = int.tryParse(value.isEmpty ? '0' : value)!;
                          if (puan >= 0 && puan <= 10) {
                            widget.kriterler![4] = int.tryParse(value.isEmpty ? '0' : value)!;
                            toplamHesapla();
                            //_viewModel.setKriterler(widget.kriterler!);
                          } else {
                            _kriter5Controller.text = '';
                          }
                        },
                      ),

                      TextFormField(
                        decoration: const InputDecoration(labelText: 'Açıklama', focusColor: Colors.blue),
                        controller: _aciklamaController,
                        onChanged: (value) {
                          //_viewModel.setAciklama(value);
                          viewModel.aciklama = value;
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildCancelButton(context),
            const SizedBox(width: 10),
            myCustomMenuButton(context, () {
              _buildOkButtononPressed(true);
            }, const Text('Kaydet'), IconsConstans.okIcon, Colors.green)
            // buildOkButton(context, buildOkButtononPressed),
          ],
        ),
      ],
    );
  }

  void toplamHesapla() {
    setState(() {
      _toplam = (_kriter1Controller.text.isEmpty ? 0 : int.tryParse(_kriter1Controller.text)!) +
          (_kriter2Controller.text.isEmpty ? 0 : int.tryParse(_kriter2Controller.text)!) +
          (_kriter3Controller.text.isEmpty ? 0 : int.tryParse(_kriter3Controller.text)!) +
          (_kriter4Controller.text.isEmpty ? 0 : int.tryParse(_kriter4Controller.text)!) +
          (_kriter5Controller.text.isEmpty ? 0 : int.tryParse(_kriter5Controller.text)!);
    });
  }

  void get _buildAllOkButtononPressed {
    _kriter1Controller.text = '20';
    _kriter2Controller.text = '30';
    _kriter3Controller.text = '30';
    _kriter4Controller.text = '10';
    _kriter5Controller.text = '10';
    _aciklamaController.text = '';
    /*  widget.kriterler![0] = 20;
    widget.kriterler![1] = 30;
    widget.kriterler![2] = 30;
    widget.kriterler![3] = 10;
    widget.kriterler![4] = 10; */
    //_viewModel.setKriterler(widget.kriterler!);
    toplamHesapla;
  }

  Future<void> _buildOkButtononPressed(bool geldi) async {
    viewModel.aciklama = _aciklamaController.text;
    viewModel.ogrenciId = widget.ogrenciId;
    viewModel.temrinId = widget.transaction.temrinId;
    viewModel.notTarih = "";
    viewModel.id = widget.transaction.id;

    if (geldi) {
      viewModel.puanBir = int.tryParse(_kriter1Controller.text);
      viewModel.puanIki = int.tryParse(_kriter2Controller.text);
      viewModel.puanUc = int.tryParse(_kriter3Controller.text);
      viewModel.puanDort = int.tryParse(_kriter4Controller.text);
      viewModel.puanBes = int.tryParse(_kriter5Controller.text);
    } else {
      viewModel.puanBir = -1;
      viewModel.puanIki = -1;
      viewModel.puanUc = -1;
      viewModel.puanDort = -1;
      viewModel.puanBes = -1;
    }
    if (viewModel.id == null) {
      await TemrinNotDatabaseProvider().insertItem(viewModel);
    } else {
      await TemrinNotDatabaseProvider().updateItem(viewModel.id!, viewModel);
    }
    /*  String key =
        "${widget.parametreler![0]}-${widget.parametreler![1]}-${widget.parametreler![2]}-${widget.ogrenciId!}";
    if (geldi) {
      _addTransactionTemrinnot(key, widget.index!, widget.parametreler![2], widget.ogrenciId!, //_viewModel.toplam,
          _aciklamaController.text, //_viewModel.kriterler);
    } else {
      widget.kriterler![0] = 0;
      widget.kriterler![1] = 0;
      widget.kriterler![2] = 0;
      widget.kriterler![3] = 0;
      widget.kriterler![4] = 0;
      //_viewModel.setKriterler(widget.kriterler!);
      //_viewModel.setToplam(-1);
      //_addTransactionTemrinnot(   key, widget.index!, widget.parametreler![2], widget.ogrenciId!, -1, "Gelmedi", widget.kriterler!);
    } */
    //Navigator.of(context).pop(//_viewModel);
    //
  }

  String _getTransactionAciklama() {
    /*   String key =
        "${widget.parametreler![0]}-${widget.parametreler![1]}-${widget.parametreler![2]}-${widget.ogrenciId!}";
    final _box = TemrinnotBoxes.getTransactions();
    return TemrinnotListesiHelper(ApplicationConstants.boxTemrinNot).getItem(key, _box) != null
        ? TemrinnotListesiHelper(ApplicationConstants.boxTemrinNot).getItem(key, _box)!.notlar
        : ""; */
    return "";
  }

/*   Future _addTransactionTemrinnot(
      String key, int id, int temrinId, int ogrenciId, int puan, String notlar, List<int> kriterler) async {
    final transaction = TemrinNotModel(
        id: id,
        temrinId: temrinId,
        ogrenciId: ogrenciId,
        puan: puan,
        notlar: notlar,
        gelmedi: false,
        kriterler: kriterler);
    final box = TemrinnotBoxes.getTransactions();
    box.put(key, transaction);
  }*/
}

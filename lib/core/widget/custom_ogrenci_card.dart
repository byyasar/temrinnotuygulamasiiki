// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:temrinnotuygulamasiiki/features/ogrenci/model/ogrenci_model.dart';

class CustomOgrenciCard extends StatefulWidget {
  final OgrenciModel transaction;
  final int index;
  final int temrinId;
  final String? puan;
  //final TextEditingController? puanController;

//  final List<int>? parametreler;
//  final List<int>? kriterler;

  //final TemrinnotModel? temrinnotModel;

  const CustomOgrenciCard(
      {Key? key,
      //required this.puanController,
      required this.transaction,
      required this.index,
      required this.temrinId,
      this.puan = ""})
      : super(key: key);

  @override
  State<CustomOgrenciCard> createState() => _CustomOgrenciCardState();
}

class _CustomOgrenciCardState extends State<CustomOgrenciCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          Expanded(
            flex: 9,
            child: ListTile(
              title: Row(
                children: [
                  Expanded(
                    flex: 10,
                    child: Text(
                      (widget.index + 1).toString() + " - " + widget.transaction.ogrenciAdSoyad.toString(),
                      maxLines: 2,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                  Expanded(
                      flex: 3,
                      child: CircleAvatar(
                        child: Text(widget.puan!.toString()),
                        // child: Text("Y"),
                      )

                      /* TextFormField(
                        onTap: () => widget.puanController!.clear(),
                        controller: widget.puanController,
                        textAlign: TextAlign.center,
                        maxLength: 3,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(fontSize: 28),
                      )*/
                      ),
                ],
              ),
              onLongPress: () {
                debugPrint('uzun basıldı ${widget.transaction.ogrenciAdSoyad}');
                // _viewModelOgrenci.setFiltreOgrenciId(widget.transaction.id);
                // _viewModelTemrin.setFiltretemrinId(widget.temrinId);
                /*   showDialog(
                    context: context,
                    builder: (context) => CustomKriterDialog(
                          //onClickedDone: addTransaction,
                          ogrenciId: widget.transaction.id,
                          parametreler: widget.parametreler,
                          kriterler: widget.kriterler,
                          index:widget.index,
                          
                        )).then((value) {
                 if (value!=null) {
                    setState(() {
                    widget.puanController!.text =value.puan==-1?'G': value.puan.toString();
                  });
                 } 
                 
                }); */
              },
              subtitle: Text("Nu: ${widget.transaction.ogrenciNu} Sınıf: ${widget.transaction.sinifId}"),
            ),
          ),
          /*   Expanded(
            flex: 1,
            child: IconButton(
                onPressed: () {
                  setState(() {
                    widget.puanController!.text = "G";
                  });
                },
                icon: IconsConstans.gelmediIcon),
          ), */
        ],
      ),
    );
  }
}

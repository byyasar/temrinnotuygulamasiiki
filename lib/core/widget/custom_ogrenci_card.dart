import 'package:flutter/material.dart';
import 'package:temrinnotuygulamasiiki/features/ogrenci/model/ogrenci_model.dart';

class CustomOgrenciCard extends StatefulWidget {
  final OgrenciModel transaction;
  final int index;
  final int temrinId;
  //final TextEditingController? puanController;

//  final List<int>? parametreler;
//  final List<int>? kriterler;

  //final TemrinnotModel? temrinnotModel;

  const CustomOgrenciCard({
    Key? key,
    required this.transaction,
    required this.index,
    //required this.puanController,
    required this.temrinId,

    // required this.temrinnotModel,
  }) : super(key: key);

  @override
  State<CustomOgrenciCard> createState() => _CustomOgrenciCardState();
}

class _CustomOgrenciCardState extends State<CustomOgrenciCard> {
  //final _viewModelTemrin = TemrinStore();
  @override
  Widget build(BuildContext context) {
    //final _viewModelTemrin = TemrinStore();

    // SinifListesiHelper _sinifListesiHelper = SinifListesiHelper(ApplicationConstants.boxSinif);

    return Card(
      //color: Colors.white60,
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
                      (widget.index + 1).toString() +
                          " - " +
                          widget.transaction.ogrenciAdSoyad.toString(),
                      maxLines: 2,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                  Expanded(
                      flex: 3,
                      child: CircleAvatar(
                        //child: Text(widget.puanController!.text),
                        child: Text("Y"),
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
                debugPrint('uzun basıldı ${widget.index}');
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
              subtitle: Text(
                  "Nu: ${widget.transaction.ogrenciNu} Sınıf: ${widget.transaction.sinifId}"),
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

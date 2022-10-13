import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:temrinnotuygulamasiiki/constans/icon_constans.dart';
import 'package:temrinnotuygulamasiiki/screen/ders_page_view.dart';
import 'package:temrinnotuygulamasiiki/screen/ogrenci_page_view.dart';
import 'package:temrinnotuygulamasiiki/screen/sinif_page_view.dart';
import 'package:temrinnotuygulamasiiki/screen/temrin_page_view.dart';
import 'package:temrinnotuygulamasiiki/screen/temrinnot_listeleme_page_view.dart';
import 'package:temrinnotuygulamasiiki/screen/temrinnot_secim_view.dart';
import 'package:temrinnotuygulamasiiki/screen/verilericek_paege_view.dart';

Drawer buildDrawer(BuildContext context) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        const DrawerHeader(
          decoration: BoxDecoration(
            //image: AssetImage(ImageConstants.logo),
            color: Colors.transparent,
          ),
          child: Center(
            child: Text(
              'Temrin Not Sistemi v1',
              style: TextStyle(fontSize: 22, color: Colors.black, backgroundColor: Colors.white),
            ),
          ),
        ),
        ListTile(
          title: Row(children: const [IconsConstans.sinifIcon, SizedBox(width: 5), Text('Sınıflar', style: TextStyle(fontSize: 20))]),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SinifPageView()));
          },
        ),
        const Divider(color: Colors.black, height: 2.0),
        ListTile(
          title: Row(
            children: const [
              IconsConstans.dersIcon,
              SizedBox(width: 5),
              Text('Dersler', style: TextStyle(fontSize: 20)),
            ],
          ),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const DersPageView()));
          },
        ),
        const Divider(color: Colors.black, height: 2.0),
        ListTile(
          title: Row(
            children: const [
              IconsConstans.ogrenciIcon,
              SizedBox(width: 5),
              Text('Öğrenciler', style: TextStyle(fontSize: 20)),
            ],
          ),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const OgrenciPageView()));
          },
        ),
        const Divider(color: Colors.black, height: 2.0),
        ListTile(
          title: Row(
            children: const [
              IconsConstans.temrinIcon,
              SizedBox(width: 5),
              Text('Temrinler', style: TextStyle(fontSize: 20)),
            ],
          ),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const TemrinPageView()));
          },
        ),
        const Divider(color: Colors.black, height: 2.0),
        ListTile(
          title: Row(
            children: const [
              IconsConstans.temrinnotIcon,
              SizedBox(width: 5),
              Text('Temrin Not Girişi', style: TextStyle(fontSize: 20)),
            ],
          ),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const TemrinNotSecimPageView()));
          },
        ),
        const Divider(color: Colors.black, height: 2.0),
        ListTile(
          title: Row(
            children: const [
              IconsConstans.puanlarIcon,
              SizedBox(width: 5),
              Text('Öğrenci Not Listeleme', style: TextStyle(fontSize: 20)),
            ],
          ),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => TemrinNotListelemePageView()));
          },
        ),
        const Divider(color: Colors.black, height: 2.0),
        ListTile(
          title: Row(
            children: const [
              IconsConstans.databaseIcon,
              SizedBox(width: 5),
              Text('Db İşlemleri', style: TextStyle(fontSize: 20)),
            ],
          ),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => VerilericekPageView()));
          },
        ),
        const Divider(color: Colors.black, height: 2.0),
        ListTile(
          title: Row(
            children: const [
              IconsConstans.exitIcon,
              SizedBox(width: 5),
              Text('Çıkış', style: TextStyle(fontSize: 20)),
            ],
          ),
          onTap: () {
            SystemNavigator.pop();
            exit(0);
            //exitAppDialog(context);
          },
        ),
        const Divider(color: Colors.black, height: 2.0),
      ],
    ),
  );
}

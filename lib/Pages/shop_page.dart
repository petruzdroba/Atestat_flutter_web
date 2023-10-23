import 'package:flutter/material.dart';
import 'package:flutter_club_blaga/Class/Product.dart';
import 'package:flutter_club_blaga/Widgets/box_image_product_hover.dart';
import 'package:flutter_club_blaga/Widgets/navigation_bar.dart';

import '../Class/MenuOption.dart';

List<Product> shopProductList = [
  Product(
      'name',
      0,
      'https://img.olympics.com/images/image/private/t_s_pog_staticContent_hero_md_2x/f_auto/primary/ngdjbafv3twathukjbq2',
      ['a']),
  Product(
      'name',
      0,
      'https://img.olympics.com/images/image/private/t_s_pog_staticContent_hero_md_2x/f_auto/primary/ngdjbafv3twathukjbq2',
      ['a']),
  Product(
      'name',
      0,
      'https://img.olympics.com/images/image/private/t_s_pog_staticContent_hero_xl/f_auto/primary/ydk9vatpnihwfquy6zq3',
      ['a']),
  Product(
      'name',
      0,
      'https://img.olympics.com/images/image/private/t_s_pog_staticContent_hero_md_2x/f_auto/primary/ngdjbafv3twathukjbq2',
      ['a']),
  Product(
      'name',
      0,
      'https://img.olympics.com/images/image/private/t_s_pog_staticContent_hero_md_2x/f_auto/primary/ngdjbafv3twathukjbq2',
      ['a']),
  Product(
      'name',
      0,
      'https://img.olympics.com/images/image/private/t_s_pog_staticContent_hero_md_2x/f_auto/primary/ngdjbafv3twathukjbq2',
      ['a']),
  Product(
      'name',
      0,
      'https://img.olympics.com/images/image/private/t_s_pog_staticContent_hero_xl/f_auto/primary/ydk9vatpnihwfquy6zq3',
      ['a']),
  Product(
      'name',
      0,
      'https://img.olympics.com/images/image/private/t_s_pog_staticContent_hero_md_2x/f_auto/primary/ngdjbafv3twathukjbq2',
      ['a']),
  Product(
      'name',
      0,
      'https://img.olympics.com/images/image/private/t_s_pog_staticContent_hero_md_2x/f_auto/primary/ngdjbafv3twathukjbq2',
      ['a']),
  Product(
      'name',
      0,
      'https://img.olympics.com/images/image/private/t_s_pog_staticContent_hero_md_2x/f_auto/primary/ngdjbafv3twathukjbq2',
      ['a']),
  Product(
      'name',
      0,
      'https://img.olympics.com/images/image/private/t_s_pog_staticContent_hero_xl/f_auto/primary/ydk9vatpnihwfquy6zq3',
      ['a']),
  Product(
      'name',
      0,
      'https://img.olympics.com/images/image/private/t_s_pog_staticContent_hero_md_2x/f_auto/primary/ngdjbafv3twathukjbq2',
      ['a']),
  Product(
      'name',
      0,
      'https://img.olympics.com/images/image/private/t_s_pog_staticContent_hero_md_2x/f_auto/primary/ngdjbafv3twathukjbq2',
      ['a']),
  Product(
      'name',
      0,
      'https://img.olympics.com/images/image/private/t_s_pog_staticContent_hero_md_2x/f_auto/primary/ngdjbafv3twathukjbq2',
      ['a']),
  Product(
      'name',
      0,
      'https://img.olympics.com/images/image/private/t_s_pog_staticContent_hero_xl/f_auto/primary/ydk9vatpnihwfquy6zq3',
      ['a']),
  Product(
      'name',
      0,
      'https://img.olympics.com/images/image/private/t_s_pog_staticContent_hero_md_2x/f_auto/primary/ngdjbafv3twathukjbq2',
      ['a']),
];

class ShopPage extends StatefulWidget {
  List<MenuOption> _menuOptions = options;

  ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.black87,
        child: Row(
          children: [
            SideNavigationBar(widget._menuOptions, '/shop'),
            Expanded(
              flex: 9,
              child: Padding(
                padding: const EdgeInsets.all(50.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Wrap(
                    direction: Axis.horizontal,
                    alignment: WrapAlignment.start,
                    spacing: 16.0,
                    runSpacing: 20.0,
                    children: shopProductList.map((product){
                      return BoxImageProductHover(product);
                    }).toList()
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

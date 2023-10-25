import 'package:flutter/material.dart';
import 'package:flutter_club_blaga/Class/Product.dart';
import 'package:flutter_club_blaga/Widgets/box_image_product_hover.dart';
import 'package:flutter_club_blaga/Widgets/loading_bar_cube.dart';
import 'package:flutter_club_blaga/Widgets/navigation_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../Class/MenuOption.dart';
import '../Widgets/Style/colors_style.dart';

class ShopPage extends StatefulWidget {
  final List<MenuOption> _menuOptions = options;
  final List<Product> shopProductList;

  ShopPage(this.shopProductList, {super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  int currentPage = 0;
  int itemsPerPage = 18; // Adjust the number of items per page as needed
  final ScrollController _scrollController = ScrollController();
  List<Product> visibleProducts = [];
  bool isLoadingMore = false; // Add this flag

  @override
  void initState() {
    super.initState();
    _loadNextPage();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadNextPage() async {
    if (isLoadingMore) return; // Prevent multiple requests

    final start = currentPage * itemsPerPage;
    final end = (currentPage + 1) * itemsPerPage;

    if (start < widget.shopProductList.length) {
      final nextProducts = widget.shopProductList.sublist(start, end);
      setState(() {
        isLoadingMore = false;
        visibleProducts.addAll(nextProducts);
        currentPage++;
      });
    }
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _loadNextPage();
    }
  }

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
                  controller: _scrollController,
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      Wrap(
                        direction: Axis.horizontal,
                        alignment: WrapAlignment.start,
                        spacing: 16.0,
                        runSpacing: 20.0,
                        children: visibleProducts.map((product) {
                          return BoxImageProductHover(product);
                        }).toList(),
                      ),
                      if (isLoadingMore)
                        const LoadingBarCube(10.0, 400),
                    ],
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

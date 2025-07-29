import 'package:flutter/material.dart';
import 'package:flutter_club_blaga/Class/Product.dart';
import 'package:flutter_club_blaga/Widgets/box_image_product_hover.dart';
import 'package:flutter_club_blaga/Widgets/loading_bar_cube.dart';
import 'package:flutter_club_blaga/Widgets/navigation_bar.dart';

import '../Class/MenuOption.dart';

class ShopPage extends StatefulWidget {
  final List<MenuOption> _menuOptions = options;
  final List<Product> shopProductList;

  ShopPage(this.shopProductList, {super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  int currentPage = 0;
  int itemsPerPage = 18;
  final ScrollController _scrollController = ScrollController();
  List<Product> visibleProducts = [];
  bool isLoadingMore = false;

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
      setState(() {
        isLoadingMore = true;

        // Calculate the actual end index, ensuring it doesn't exceed the list length
        final actualEnd = end > widget.shopProductList.length
            ? widget.shopProductList.length
            : end;

        // Load the next items
        visibleProducts.addAll(widget.shopProductList.sublist(start, actualEnd));

        // Increment the page if there are more items to load
        currentPage++;

        // Adjust itemsPerPage if the number of products is less than 18
        itemsPerPage = widget.shopProductList.length < 18
            ? widget.shopProductList.length
            : 18;

        // Set isLoadingMore to false if we've reached the end of the list
        isLoadingMore = actualEnd >= widget.shopProductList.length;
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
        color: Theme.of(context).colorScheme.background,
        child: Row(
          children: [
            SideNavigationBar(widget._menuOptions, '/shop'),
            Expanded(
              flex: 9,
              child: Padding(
                padding: const EdgeInsets.only(top: 35, right: 50,left:50),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    scrollDirection: Axis.vertical,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Shop',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 75,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline
                          ),
                        ),
                        const SizedBox(height: 25,),
                        Center(
                          child: Wrap(
                            direction: Axis.horizontal,
                            alignment: WrapAlignment.start,
                            spacing: 16.0,
                            runSpacing: 20.0,
                            children: visibleProducts.map((product) {
                              return BoxImageProductHover(product);
                            }).toList(),
                          ),
                        ),
                        if (isLoadingMore)
                          const Column(
                            children: [
                              SizedBox(height: 15,),
                              LoadingBarCube(10.0, 400),
                            ],
                          ),
                      ],
                    ),
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

import 'package:flutter/material.dart';

import 'main.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double _page = 0;

  int get _firstItemIndex => _page.toInt();

  final _controller = PageController(
    viewportFraction: 0.5,
  );

  late final _itemWidth =
      MediaQuery.of(context).size.width * _controller.viewportFraction;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => setState(() {
          _page = _controller.page!;
        }));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("LV Scroll"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Positioned.fill(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: SizedBox(
                    width: _itemWidth,
                    child: FractionallySizedBox(
                      child: PageViewItem(
                        index: _firstItemIndex,
                        width: _itemWidth,
                        url: model[_firstItemIndex],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 250,
                child: PageView.builder(
                  padEnds: false,
                  controller: _controller,
                  itemBuilder: (context, index) {
                    return Opacity(
                      opacity: index <= _firstItemIndex ? 0 : 1,
                      child: PageViewItem(
                        index: index,
                        width: _itemWidth,
                        url: model[index],
                      ),
                    );
                  },
                  itemCount: model.length,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class PageViewItem extends StatelessWidget {
  final int index;
  final String url;
  final double width;
  static const String name = '';
  static const String price = '';

  const PageViewItem({
    Key? key,
    required this.index,
    required this.width,
    required this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => print(index),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(1.0),
        ),
        child: Image.network(
          url,
          fit: BoxFit.cover,
          width: width,
        ),
      ),
    );
  }
}

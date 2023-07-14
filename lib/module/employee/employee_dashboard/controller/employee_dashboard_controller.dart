import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:absensi_online/state_util.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../view/employee_dashboard_view.dart';

class EmployeeDashboardController extends State<EmployeeDashboardView>
    implements MvcController {
  static late EmployeeDashboardController instance;
  late EmployeeDashboardView view;

  @override
  void initState() {
    instance = this;
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);

  int currentIndex = 0;
  final CarouselController carouselController = CarouselController();

  List dashboardMenuItems = [
    {
      "label": "Explorer",
      "icon": Icons.explore_rounded,
      "page": Container(),
    },
    {
      "label": "Appointment",
      "icon": Icons.date_range,
      "page": Container(),
    },
    {
      "label": "Shop",
      "icon": MdiIcons.shopping,
      "page": Container(),
    },
    {
      "label": "More",
      "icon": MdiIcons.apps,
      "page": Container(),
    }
  ];
  List products = [
    {
      "id": 1,
      "photo":
          "https://images.unsplash.com/photo-1533481405265-e9ce0c044abb?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8bWFsbHxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=500&q=60",
      "product_name": "Mall Lippo Cikarang",
      "price": 25,
      "category": "Food",
      "description":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
    },
    {
      "id": 2,
      "photo":
          "https://images.unsplash.com/photo-1559171667-74fe3499b5ba?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTB8fG1hbGx8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=500&q=60",
      "product_name": "Mall Grand City",
      "price": 22,
      "category": "Food",
      "description":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
    },
    {
      "id": 3,
      "photo":
          "https://images.unsplash.com/photo-1619335680642-964b9c259d5e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTR8fG1hbGx8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=500&q=60",
      "product_name": "Mall Pakuwon",
      "price": 33,
      "category": "Drink",
      "description":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
    },
    {
      "id": 4,
      "photo":
          "https://images.unsplash.com/photo-1586366775916-7018ef19ff34?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTV8fG1hbGx8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=500&q=60",
      "product_name": "Mall Tunjungan Plaza",
      "price": 31,
      "category": "Food",
      "description":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
    },
    {
      "id": 5,
      "photo":
          "https://images.unsplash.com/photo-1580793241553-e9f1cce181af?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8bWFsbHxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=500&q=60",
      "product_name": "Mall Grand Indonesia",
      "price": 32,
      "category": "Drink",
      "description":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
    },
    {
      "id": 6,
      "photo":
          "https://images.unsplash.com/photo-1567958451986-2de427a4a0be?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OXx8bWFsbHxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=500&q=60",
      "product_name": "Sunrise Mall",
      "price": 49,
      "category": "Food",
      "description":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
    },
  ];
}

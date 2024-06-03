import 'package:flutter/material.dart';
import 'package:vietmap_map/Screens/auth/Auth.dart';

class Locationacess extends StatelessWidget {
  const Locationacess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/z5498055623606_196a0e8d1bf13823eb7a17bf90d19f84-removebg-preview.png',
                      height: 300,
                      color: Color(0xFFFF2B85),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    const Text(
                      'Phân tích thiết kế và xây dựng hệ thống thông tin quản lý mạng lưới giao thông đường bộ của một tỉnh/thành phố trực thuộc Trung ương trên nền GIS',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFFFF2B85).withOpacity(0.15),
                          ),
                          child: Icon(
                            Icons.delivery_dining_outlined,
                            color: Color(0xFFFF2B85),
                            size: 30,
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: Text(
                            'Tìm tuyến đường tốt nhất cho bạn',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black.withOpacity(0.6),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    Row(children: [
                      Container(
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFFFF2B85).withOpacity(0.15),
                        ),
                        child: Icon(
                          Icons.delivery_dining_outlined,
                          color: Color(0xFFFF2B85),
                          size: 30,
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: Text(
                          'Cung cấp thông tin cho bạn',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black.withOpacity(0.6),
                          ),
                        ),
                      ),
                    ]),
                    const SizedBox(
                      height: 32,
                    ),
                    Row(children: [
                      Container(
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFFFF2B85).withOpacity(0.15),
                        ),
                        child: Icon(
                          Icons.delivery_dining_outlined,
                          color: Color(0xFFFF2B85),
                          size: 30,
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: Text(
                          'Giao diện thân thiện dễ sử dụng',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black.withOpacity(0.6),
                          ),
                        ),
                      ),
                    ]),
                  ],
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Auth(),
                        ));
                  },
                  child: Center(
                    child: Text(
                      'continue',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFE21A70),
                    padding: EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

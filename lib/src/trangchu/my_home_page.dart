import 'package:flutter/material.dart';
import 'package:thikthp/src/Bookmark/bookmark.dart';
import 'package:thikthp/src/chitietsach/book_info.dart';
import 'package:thikthp/src/Read/GioiThieu.dart';
import 'package:thikthp/src/chitietsach/khuyen_doc.dart';
import 'package:thikthp/src/chitietsach/moi_ra.dart';
import 'package:thikthp/src/setting/setting.dart';
import 'package:thikthp/src/theloai/category.dart';
import 'package:thikthp/src/trangchu/Ring.dart';
import 'package:thikthp/src/trangchu/search.dart';
import 'package:thikthp/src/GiaoLuu/GiaoLuuScreen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  static List<BookInfo> allBooks = [
    BookInfo('2 vạn dặm dưới đáy biển', 'Jules Verne', '2vd.png', 'Tiểu thuyết', 'Trong năm 1866, tàu của một số quốc gia phát hiện ra một con quái vật biển bí ẩn, mà một số cho thấy là một con cá voi khổng lồ. Chính phủ Hoa Kỳ khởi động một cuộc thám hiểm trên biển để tìm và tiêu diệt con quái vật. Giáo sư Pierre Aronnax, nhà sinh học biển và người kể chuyện của người Pháp, người đang ở New York vào thời điểm đó, nhận được lời mời đến phút cuối cùng tham gia cuộc thám hiểm mà ông chấp nhận. Thợ săn cá voi của Canada - Ned Land và hộ tống trung thành của Aronnax - Conseil cũng được đưa lên tàu.', '2vd.pdf'),
    BookInfo('5cm/s', 'Shinkai Makoto', '5cms.jpg', 'Tiểu thuyết', 'Vào một hôm, khi đi trên đường, Takaki đi ngang qua một phụ nữ. Anh có linh tính đó là Akari và quay lại gặp thì bị xe lửa che mất tầm nhìn. Lúc này, những ký ức của hai người ùa về. Anh đứng chờ đến khi xe lửa chạy qua. Lúc này, người phụ nữ kia cũng đã đi mất. Takaki khẽ mỉm cười vì đã trút được gánh nặng bấy lâu nay và lấy lại được sự tự tin để bước tiếp trên đường đời.', '5cms.pdf'),
    BookInfo('Dế mèn phiêu lưu ký', 'Tô Hoài', 'dmplk.jpg', 'Tiểu thuyết', 'Truyện gồm 10 chương, kể về những cuộc phiêu lưu của Dế Mèn qua thế giới muôn màu muôn vẻ của những loài vật nhỏ bé.', 'dmplk.pdf'),
    BookInfo('Gió qua rặng liễu', 'Kenneth Grahame', 'gqrl.jpg', 'Tiểu thuyết', 'Kenneth Grahame bắt đầu kể những mẩu truyện kì thú về lão Cóc (Mr. Toad) cùng các bạn Chuột Chũi, Chuột Cống, Lửng và Rái Cá. Để rồi về sau, tác giả gộp các thủ bản này dưới nhan đề Gió qua rặng liễu[3].', 'gqrl.pdf'),
    BookInfo('Thám tử Conan', 'Gosho Aoyama', 'conan.jpg', 'Truyện tranh', 'Kudo Shinichi, 17 tuổi, là một thám tử học sinh trung học phổ thông rất nổi tiếng, thường xuyên giúp cảnh sát phá các vụ án khó khăn.[2] Trong một lần khi đang theo dõi một vụ tống tiền, đã bị thành viên của Tổ chức Áo đen bí ẩn phát hiện. Chúng đánh gục Kudo Shinichi, làm cậu bất tỉnh và ép cậu uống loại thuốc độc APTX - 4869 mà Tổ chức vừa điều chế nhằm bịt đầu mối "thân phận". Tuy vậy, thứ thuốc đó không giết chết mà lại gây ra tác dụng phụ khiến Shinichi bị teo nhỏ thành một đứa trẻ khoảng 6-7 tuổi', 'conan.pdf'),
    BookInfo('Đạo đức kinh', 'Lão Tử', 'ddk.jpg', 'Triết học','Đạo Đức Kinh (tiếng Trung: 道德經; phát âm tiếng Trung: ngheⓘ) là quyển sách do triết gia Lão Tử viết ra vào khoảng năm 600 TCN[cần dẫn nguồn]. Theo truyền thuyết thì Lão Tử vì chán chường thế sự nên cưỡi trâu xanh đi ở ẩn. Ông Doãn Hỷ đang làm quan giữ ải Hàm Cốc níu lại "nếu ngài quyết đi ẩn cư xin vì tôi để lại một bộ sách!", Lão Tử bèn ở lại cửa ải Hàm Cốc viết bộ "Đạo Đức Kinh" dặn Doãn Hỷ cứ tu theo đó thì đắc đạo. Do đó, Đạo Đức Kinh còn được gọi là sách Lão Tử.', 'ddk.pdf'),
    BookInfo('Kinh tế học vĩ mô', 'Nguyễn Như Ý', 'kthvm.jpg', 'Kinh tế','Kinh tế học vi mô hay là kinh tế tầm nhỏ (Tiếng Anh: microeconomics), là một phân ngành của kinh tế học chuyên nghiên cứu về đặc điểm, cấu trúc và hành vi của cả một nền kinh tế nói chung. Kinh tế học vĩ mô và kinh tế học vi mô là hai lĩnh vực chung nhất của kinh tế học. Trong khi kinh tế học vi mô chủ yếu nghiên cứu về hành vi của các cá thể đơn lẻ, như công ty và cá nhân người tiêu dùng, kinh tế học vĩ mô lại nghiên cứu các chỉ tiêu cộng hưởng như GDP, tỉ lệ thất nghiệp, và các chỉ số giá cả để hiểu cách hoạt động của cả nền kinh tế.','kthvm.pdf'),
    BookInfo('Lược sử loài người', 'Yuval Noah Harari', 'lsln.jpg', 'Lịch sử',' Cuốn sách nói bao quát về lịch sử tiến hóa của loài người từ thời cổ xưa trong thời kỳ đồ đá cho đến thế kỷ XXI, tập trung vào loài Homo sapiens (Người Tinh Khôn). Được ghi chép lại với khuôn khổ được cung cấp bởi các ngành khoa học tự nhiên, đặc biệt là sinh học tiến hóa.','lsln.pdf'),
    BookInfo('Truyện Kiều', 'Nguyễn Du', 'tk.jpg', 'Thơ','Đoạn trường tân thanh (chữ Hán: 斷腸新聲), thường được biết đến với cái tên đơn giản là Truyện Kiều (chữ Nôm: 傳翹), là một truyện thơ của đại thi hào Nguyễn Du. Đây được xem là truyện thơ nổi tiếng nhất và xét vào hàng kinh điển trong văn học Việt Nam, tác phẩm được viết bằng chữ Nôm, theo thể lục bát, gồm 3.254 câu.', 'tk.pdf'),
    BookInfo('Góc sân và khoảng trời', 'Trần Đăng Khoa', 'gskt.jpg', 'Thơ','Góc sân và khoảng trời là tập thơ của Trần Đăng Khoa[1] được xuất bản lần đầu tiên năm 1968[2] khi tác giả mới 10 tuổi. Tập thơ mới đầu có tên là Từ góc sân nhà em, sau nhiều lần tái bản và chỉnh sửa, nay tập thơ tên là Góc sân và khoảng trời. Tập thơ như là những trang ký ức, nhật ký của tác giả thời thơ ấu. Tập thơ gồm có 107 bài thơ và Trường ca đánh Thần Hạn có 4 chương.','gskt.pdf'),
    BookInfo('Nguồn gốc các loài', 'Charles Darwin', 'ngcl.jpg', 'Khoa học','Cuốn sách giới thiệu giả thuyết cho rằng quần thể các loài tiến hóa qua các thế hệ thông qua một quá trình chọn lọc tự nhiên. Điều này gây tranh cãi vì nó mâu thuẫn với các niềm tin tôn giáo lúc đó đặt bên dưới các giả thuyết về sinh vật học. Quyển sách của Darwin đã là tột đỉnh của bằng chứng mà ông đã tích lũy trước đó trong chuyến đi của Beagle vào thập niên 1830 và được mở rộng ra thông qua các cuộc điều tra và thí nghiệm kể từ khi ông quay về','ngcl.pdf'),
    BookInfo('Design Pattern', 'Alexsander Shvets', 'dp.png', 'Khoa học','Design Patterns: Elements of Reusable Object-Oriented Software (1994) là một cuốn sách kỹ thuật phần mềm mô tả các mẫu thiết kế phần mềm. ', 'dp.pdf'),
  ];

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Category> bookCategories = [
    Category('Tiểu thuyết'),
    Category('Khoa học'),
    Category('Lịch sử'),
    Category('Thơ'),
    Category('Kinh tế'),
    Category('Tâm lý'),
    Category('Truyện tranh'),
    Category('Triết học'),
  ];

  TextEditingController searchController = TextEditingController();
  bool isSearchBarVisible = false;
  List<BookInfo> currentBooks = [];
  List<BookInfo> recommendedBooks = [];
  Category? selectedCategory;
  bool homeButtonPressed = false;

  @override
  void initState() {
    super.initState();
    currentBooks = List.from(MyHomePage.allBooks);
    recommendedBooks = KhuyenDoc.getRecommendedBooks();
  }

  void _handleCategorySelection(Category selectedCategory) {
    if (this.selectedCategory == selectedCategory) {
      setState(() {
        this.selectedCategory = null;
        currentBooks = List.from(recommendedBooks);
      });
    } else {
      List<BookInfo> selectedCategoryBooks =
      MyHomePage.allBooks.where((book) => book.category == selectedCategory.name).toList();

      setState(() {
        this.selectedCategory = selectedCategory;
        currentBooks = selectedCategoryBooks;
      });
    }
  }

  void _updateBooks() {
    if (homeButtonPressed) {
      setState(() {
        currentBooks = List.from(recommendedBooks);
      });
    }
  }

  Widget _buildBookList(List<BookInfo> books) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: books.isEmpty
          ? Container(
        height: 30,
        alignment: Alignment.center,
        child: Text(
          selectedCategory != null
              ? 'Không tìm thấy sách thuộc thể loại ${selectedCategory!.name}'
              : 'Không có sách',
          style: TextStyle(fontWeight: FontWeight.w300),
        ),
      )
          : Row(
        children: books.map((book) {
          return GestureDetector(
            onTap: () {
              _onBookTapped(book);
            },
            child: Container(
              margin: EdgeInsets.only(right: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      'assets/images/${book.cover}',
                      width: 130,
                      height: 180,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 8),
                  Flexible(
                    child: Text(
                      book.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    '${book.author}',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildCategoryList() {
    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: bookCategories.map((category) {
        bool isSelected = category == selectedCategory;

        return GestureDetector(
          onTap: () {
            _handleCategorySelection(category);
          },
          child: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isSelected ? Colors.green : Colors.blue,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              category.name,
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      }).toList(),
    );
  }


  void _onBookTapped(BookInfo book) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GioiThieuScreen(book: book),
      ),
    );
  }
  void _onSearch(String keyword) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SearchScreen(keyword: keyword),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _updateBooks();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFFF2E6),
        title: Row(
          children: [
            CircleAvatar(
              radius: 40.0,
              backgroundImage: AssetImage('assets/logo/logo1.jpg'), // Đường dẫn đến ảnh của bạn
            ),
            const SizedBox(width: 8),
            isSearchBarVisible
                ? Expanded(
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Nhập từ khoá...',
                ),
                autofocus: true,
                onSubmitted: (value) {
                  _onSearch(value);
                },
              ),
            )
                : Container(),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              setState(() {
                isSearchBarVisible = !isSearchBarVisible;
              });
            },
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              Ring(message: "").navigateToRingForm(context);
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingScreen()),
              );
            },
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildCategoryList(),
              if (selectedCategory != null) ...[
                SizedBox(height: 16),
                Text(
                  'Theo thể loại',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Container(
                  height: currentBooks.isEmpty ? 30 : 250,
                  child: _buildBookList(currentBooks),
                ),
              ],
              SizedBox(height: 16),
              Text(
                'Khuyên đọc',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Container(
                height: 250,
                child: _buildBookList(recommendedBooks),
              ),
              SizedBox(height: 16),
              Text(
                'Mới ra',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Container(
                height: 250,
                child: _buildBookList(MoiRa.books),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Trang chủ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Đánh dấu',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Giao lưu',
          ),
        ],
        onTap: (index) {
          if (index == 0) {
            setState(() {
              homeButtonPressed = true;
            });

            _updateBooks();

            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => MyHomePage(title: 'Trang chủ'),
              ),
            );
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BookmarkScreen(),
              ),
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => GiaoLuuScreen(),
              ),
            );
          }
        },
      ),

    );
  }
}

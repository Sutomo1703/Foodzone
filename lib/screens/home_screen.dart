import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_foodzone/model/menuModel.dart';
import 'package:flutter_foodzone/model/order_model.dart';
import 'package:flutter_foodzone/screens/order_page.dart';
import 'package:flutter_foodzone/screens/orderhistory.dart';
import 'package:flutter_foodzone/screens/profile_page.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'category_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<MenuModel> menus = <MenuModel>[];
  List<OrderModel> cartList = <OrderModel>[];

  var isLoaded = false;

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 1) {
      Navigator.of(context).pushReplacement(new MaterialPageRoute(
          builder: (context) => new OrderHistory(
                title: toString(),
              )));
    } else if (index == 2) {
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new AccountPage()));
    }
  }

  @override
  void initState() {
    super.initState();
    populateMenu();
  }

  final uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List of Our Menu'),
        backgroundColor: Color(0xFF89dad0),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 16.0, top: 8.0),
            child: GestureDetector(
              child: Stack(
                alignment: Alignment.topCenter,
                children: <Widget>[
                  Icon(
                    Icons.shopping_cart,
                    size: 36.0,
                  ),
                  if (cartList.length > 0)
                    Padding(
                      padding: const EdgeInsets.only(left: 2.0),
                      child: CircleAvatar(
                        radius: 8.0,
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        child: Text(
                          cartList.length.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              onTap: () {
                if (cartList.isNotEmpty) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => OrderPage(cart: cartList),
                    ),
                  );
                }
              },
            ),
          )
        ],
      ),
      body: Column(
        children: [
          const categoryList(),
          Expanded(
              child: Visibility(
            visible: isLoaded,
            child: _buildGridView(),
            replacement: const Center(
              child: CircularProgressIndicator(),
            ),
          )),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Order History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }

  ListView _buildListView() {
    return ListView.builder(
      itemCount: menus.length,
      itemBuilder: (context, index) {
        var item = menus[index];
        OrderModel x = OrderModel(
            uid: uid,
            orderName: item.name,
            orderPrice: item.price,
            orderQty: 1);
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 2.0,
          ),
          child: Card(
            elevation: 4.0,
            child: ListTile(
              // leading: Icon(
              //   item.icon,
              //   color: item.color,
              // ),
              leading: Image.network(item.url),
              title: Text(item.name),
              trailing: GestureDetector(
                child: (!cartList.contains(x))
                    // ? Icon(
                    //     Icons.add_circle,
                    //     color: Colors.green,
                    //   )
                    ? ElevatedButton(
                        onPressed: () {}, child: Text('Add to Cart'))
                    // : Icon(
                    //     Icons.remove_circle,
                    //     color: Colors.red,
                    //   ),
                    : ElevatedButton(
                        onPressed: () {}, child: Text('Remove from Cart')),
                onTap: () {
                  setState(() {
                    if (!cartList.contains(x)) {
                      cartList.add(x);
                    } else {
                      cartList.remove(x);
                    }
                  });
                },
              ),
            ),
          ),
        );
      },
    );
  }

  GridView _buildGridView() {
    return GridView.builder(
        scrollDirection: categoryListState.scrollDirection,
        controller: categoryListState.controller,
        shrinkWrap: true,
        // padding: const EdgeInsets.all(4.0),
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: menus.length,
        itemBuilder: (context, index) {
          var item = menus[index];
          OrderModel x = OrderModel(
              uid: uid,
              orderName: item.name,
              orderPrice: item.price,
              orderQty: 1);
          return AutoScrollTag(
            key: ValueKey(index),
            controller: categoryListState.controller,
            index: index,
            child: Expanded(
              child: Card(
                elevation: 4.0,
                child: Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // Icon(
                      //   item.icon,
                      //   color: (cartList.contains(item))
                      //       ? Colors.grey
                      //       : item.color,
                      //   size: 100.0,
                      // ),
                      Container(
                        height: 100,
                        width: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.grey[300],
                        ),
                        child: Image.network(item.url, fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.amber,
                            alignment: Alignment.center,
                            child: const Text(
                              'Whoops!',
                              style: TextStyle(fontSize: 18),
                            ),
                          );
                        }),
                      ),
                      Text(
                        item.name,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        // style: Theme.of(context).textTheme.subhead,
                      ),
                      Text(
                        'Rp${item.price.toString()},-',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          right: 8.0,
                          bottom: 8.0,
                        ),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: GestureDetector(
                            child: (!cartList.contains(x))
                                ? Icon(
                                    Icons.add_circle,
                                    color: Colors.green,
                                  )
                                : Icon(
                                    Icons.remove_circle,
                                    color: Colors.red,
                                  ),
                            onTap: () {
                              setState(() {
                                if (!cartList.contains(x)) {
                                  cartList.add(x);
                                } else {
                                  cartList.remove(x);
                                }
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  void populateMenu() {
    var menuList = <MenuModel>[
      MenuModel(
          "Soto Ayam",
          30000,
          "https://sweetrip.id/wp-content/uploads/2021/01/106220990_192214052228039_3832608672111737167_n.jpg",
          1),
      MenuModel(
          "Bakso Sapi + Mie",
          25000,
          "https://img-global.cpcdn.com/recipes/62bc0149e02866d8/1200x630cq70/photo.jpg",
          1),
      MenuModel(
          "Gado-gado",
          20000,
          "https://upload.wikimedia.org/wikipedia/commons/2/26/Gado_gado_jakarta.jpg",
          1),
      MenuModel(
          "Nasi Rawon",
          35000,
          "https://www.masakapahariini.com/wp-content/uploads/2018/04/resep-rawon-daging.jpg",
          1),
      MenuModel(
          "Nasi Pecel Lele",
          17000,
          "https://asset.kompas.com/crops/QT6V0LoKz42gr5uezLBcGZyBBLw=/0x0:1000x667/750x500/data/photo/2021/03/21/60569b33a2b3d.jpeg",
          1),
      MenuModel(
          "Nasi Kuning",
          15000,
          "https://i.gojekapi.com/darkroom/gofood-indonesia/v2/images/uploads/b4a73082-619b-43c5-a4d0-c09b93941e46_Go-Biz_20211006_094409.jpeg?h=302&w=302&fit=crop&auto=compress",
          1),
      MenuModel(
          "Nasi Gudeg",
          35000,
          "https://awsimages.detik.net.id/community/media/visual/2021/05/06/sedep-mlekoh-5-nasi-gudeg-khas-jogja-dengan-lauk-lengkap-3.jpeg?w=700&q=90",
          1),
      MenuModel(
          "Nasi Uduk Ayam Goreng",
          23000,
          "https://images.tokopedia.net/img/cache/500-square/VqbcmM/2020/8/7/42d03620-b705-4aae-8b48-6f8943adee90.png",
          1),
      MenuModel(
          "Nasi Goreng Jawa",
          20000,
          "https://blue.kumparan.com/image/upload/c_lpad,b_white,f_jpg,h_900,q_auto,w_1200/g_south,l_og_user_zprw89/co_rgb:ffffff,g_south_west,l_text:Heebo_20_bold:Konten%20dari%20Pengguna%0DResep%20Masakan,x_140,y_26/vd7zarfscnh8hv9lszew.jpg",
          1),
      MenuModel(
          "Mie Goreng Jawa",
          20000,
          "https://cdn.yummy.co.id/content-images/images/20200718/DEk4BKmpX1qRFIF1T84P5Jm54DF2pm4b-31353935303532373535d41d8cd98f00b204e9800998ecf8427e_800x800.jpg",
          1),
      MenuModel(
          "Nasi Goreng Hong Kong",
          22500,
          "https://awsimages.detik.net.id/community/media/visual/2020/06/23/nasi-goreng-hong-kong-1_43.jpeg?w=700&q=90",
          1),
      MenuModel(
          "Mie Goreng Hong Kong",
          25000,
          "https://www.tiktak.id/wp-content/uploads/2020/10/Resep-Mi-Goreng-ala-Hong-Kong-Praktis-untuk-Sarapan.jpg",
          1),
      MenuModel(
          "Kwetiau Goreng Seafood",
          26000,
          "https://www.masakapahariini.com/wp-content/uploads/2020/09/kwetiau-goreng-seafood-780x440.jpg",
          1),
      MenuModel(
          "Bihun Goreng Spesial",
          24000,
          "https://theplaceboston.com/wp-content/uploads/2020/09/cara-membuat-bihun-goreng.jpg",
          1),
      MenuModel("Bihun Kuah", 21000,
          "https://i.ytimg.com/vi/p9H6rIETNck/sddefault.jpg", 1),
      MenuModel(
          "Dumpling Ayam (6 pcs)",
          24000,
          "https://cdn.yummy.co.id/content-images/images/20200419/1vl8pZ5PPSLiiKq8PveGmHSUpSPm5sVA-31353837323736393236d41d8cd98f00b204e9800998ecf8427e_800x800.jpg",
          1),
      MenuModel("Siomay Udang (4 pcs)", 24000,
          "https://cf.shopee.co.id/file/09f5b389e1f461e20fc4580f836a47e2", 1),
      MenuModel(
          "Bakpao isi Ayam Jamur (3 pcs)",
          21000,
          "https://selerasa.com/wp-content/uploads/2016/09/images_bakpao-ayam-jamur.jpg",
          1),
      MenuModel(
          "Sup Perut Ikan",
          150000,
          "https://images.tokopedia.net/img/cache/700/VqbcmM/2021/2/28/396c07d8-9a9d-4d43-95c2-52a66ed967be.jpg",
          1),
      MenuModel("Sapo Tahu Seafood", 28000,
          "https://i.ytimg.com/vi/bqnQkW1TguE/maxresdefault.jpg", 1),
      MenuModel(
          "Tamago Sushi (3 pcs)",
          12000,
          "https://cdn1-production-images-kly.akamaized.net/llXjr-ROlRMW3OVwdDZrhvmaAZ0=/0x0:1000x563/469x260/filters:quality(75):strip_icc():format(webp)/kly-media-production/medias/3342515/original/004291600_1609995158-2021-01-06.jpg",
          1),
      MenuModel(
          "Aburi Salmon Sushi (8 pcs)",
          32000,
          "https://awsimages.detik.net.id/community/media/visual/2020/11/25/review-sushi-mahal-vs-sushi-murah-1_43.jpeg?w=700&q=90",
          1),
      MenuModel("Unagi Sushi (2 pcs)", 20000,
          "https://pbs.twimg.com/media/Dt1DQLpU0AAN-So.jpg", 1),
      MenuModel(
          "Mentai Sushi Roll (4 pcs)",
          32000,
          "https://pict.sindonews.net/dyn/850/pena/news/2020/10/20/185/201830/mentai-sushi-roll-makanan-khas-jepang-yang-bisa-dibuat-sendiri-ryo.jpg",
          1),
      MenuModel("Chicken Karaage Miso Ramen", 65000,
          "https://dev.ibisnis.com/images/images/5e8aa34dd07ca.webp", 1),
      MenuModel(
          "Chicken Katsu Miso Ramen",
          65000,
          "https://www.honestfoodtalks.com/wp-content/uploads/2021/12/katsu-ramen-recipe-served-with-sweetcorn-and-pak-choi-1.jpg",
          1),
      MenuModel(
          "Shoyu Ramen",
          68000,
          "https://media-cdn.tripadvisor.com/media/photo-s/1c/a6/36/97/ramen-shoyu-classic.jpg",
          1),
      MenuModel(
          "Japanese Curry Rice",
          35000,
          "https://upload.wikimedia.org/wikipedia/commons/3/3b/Beef_curry_rice_003.jpg",
          1),
      MenuModel(
          "Oyakodon",
          38000,
          "https://www.justonecookbook.com/wp-content/uploads/2011/02/Oyakodon-w600-500x375.jpg",
          1),
      MenuModel(
          "Gyoza",
          24000,
          "https://s.yimg.com/ny/api/res/1.2/IME.yFnv_HIpjOKf3DTWfw--/YXBwaWQ9aGlnaGxhbmRlcjt3PTY0MA--/https://media.zenfs.com/ID/fimela_hosted_871/aa25b130ad9141f8de321730613af196",
          1),
      MenuModel(
          "Kimbap (8 pcs)",
          56000,
          "https://www.beyondkimchee.com/wp-content/uploads/2021/03/thumb.jpg",
          1),
      MenuModel(
          "Tteokbokki",
          30000,
          "https://awsimages.detik.net.id/community/media/visual/2020/10/19/tteokbokki_43.jpeg?w=700&q=90",
          1),
      MenuModel(
          "Shin Ramyun",
          34000,
          "https://upload.wikimedia.org/wikipedia/commons/f/fb/Ramyun_cooking_image.png",
          1),
      MenuModel(
          "Kimchi Ramyun",
          36000,
          "https://media-cdn.tripadvisor.com/media/photo-s/1c/0f/3a/f6/kimchi-ramyun.jpg",
          1),
      MenuModel(
          "Bibimbap",
          40000,
          "https://cdn0-production-images-kly.akamaized.net/8MsufSZxcK3z7KPubZPO2BZZlVo=/1x61:1000x624/1200x675/filters:quality(75):strip_icc():format(webp)/kly-media-production/medias/3548108/original/016406500_1629692444-shutterstock_1185115657.jpg",
          1),
      MenuModel("Yangnyeom Chicken", 70000,
          "https://i.ytimg.com/vi/XnLWBoZn710/maxresdefault.jpg", 1),
      MenuModel(
          "Jjajangmyeon",
          35000,
          "https://www.maangchi.com/wp-content/uploads/2007/07/jjajangmyeon-plate.jpg",
          1),
      MenuModel(
          "Bulgogi",
          78000,
          "https://asset.kompas.com/crops/U4lI1_JCpkm6b-QsBOR5D7PUwT8=/0x0:0x0/780x390/data/photo/2020/12/23/5fe2c9413a6ce.jpg",
          1),
      MenuModel(
          "Mandu Guk",
          38000,
          "https://www.simplyrecipes.com/thmb/Eye8QPp1L5gFAYxpN8RGQ_scOdc=/4477x2985/filters:no_upscale():max_bytes(150000):strip_icc()/Simply-Recipes-Mandu-Guk-LEAD-08-b05bc837df6f4437aa31b21f6dd98326.jpg",
          1),
      MenuModel(
          "Japchae",
          33000,
          "https://www.tiktak.id/wp-content/uploads/2020/12/Resep-Japchae-Bihun-yang-Dimakan-Keluarga-Nam-Do-San-di-Start-Up.jpg",
          1),
      MenuModel(
          "Cheeseburger",
          28000,
          "https://upload.wikimedia.org/wikipedia/commons/thumb/4/4d/Cheeseburger.jpg/1200px-Cheeseburger.jpg",
          1),
      MenuModel(
          "Chicken Burger",
          30000,
          "https://gofry.com.fj/wp-content/uploads/2019/04/Chicken_Burger-scaled-e1624614963511.jpg",
          1),
      MenuModel(
          "Hot Dog",
          24000,
          "https://s2.bukalapak.com/img/233907047/large/Mesin_Sosis_Hot_Dog_GRL_ER27.jpg.webp",
          1),
      MenuModel(
          "Fish & Chips",
          45000,
          "https://asset.kompas.com/crops/bjX_qY4_G0iQxfJUKwAgGFfZ7mE=/0x0:1000x667/750x500/data/photo/2021/11/24/619da72fb06e6.jpeg",
          1),
      MenuModel(
          "Crispy Chicken Steak",
          65000,
          "https://rocketchicken.co.id/storage/posts/September2019/NC3ilzxcbE9JfqUrc9jO.jpg",
          1),
      MenuModel(
          "Tenderloin Steak",
          150000,
          "https://boncafe.co.id/admin/web/upload_images/kategori_makanan/20210215032457026078.jpeg",
          1),
      MenuModel(
          "Grilled Sirloin Steak",
          150000,
          "https://boncafe.co.id/admin/web/upload_images/kategori_makanan/20210215033100236985.jpeg",
          1),
      MenuModel(
          "Mozarella Beef Roll",
          180000,
          "https://boncafe.co.id/admin/web/upload_images/kategori_makanan/20201124035511601300.jpg",
          1),
      MenuModel(
          "Chicken Roulade",
          98000,
          "https://boncafe.co.id/admin/web/upload_images/kategori_makanan/20201124040257970380.jpg",
          1),
      MenuModel(
          "French Fries",
          18000,
          "https://www.corriecooks.com/wp-content/uploads/2021/05/french-fries-instant-pot.jpg",
          1),
      MenuModel(
          "Melon Juice",
          25000,
          "https://cdn.istyle.im/images/product/web/27/35/98/00/0/000000983527_01_800.JPG",
          1),
      MenuModel(
          "Strawberry Juice",
          25000,
          "https://teacoffeeanddrinks.com/wp-content/uploads/2021/05/strawberry-juice-recipe-without-milk-with-lemon-juice-f.jpg",
          1),
      MenuModel(
          "Guava Juice",
          25000,
          "https://ihanow.com/uploads/items/009c5581c969fd9ea4f13f8fe21e0f90.jpg",
          1),
      MenuModel(
          "Orange Juice",
          25000,
          "https://img.freepik.com/free-photo/fresh-orange-juice_144627-18386.jpg?w=2000",
          1),
      MenuModel(
          "Avocado Juice",
          26000,
          "https://i0.wp.com/www.angsarap.net/wp-content/uploads/2014/09/Jus-Alpukat-Indonesian-Avocado-Shake.jpg?ssl=1",
          1),
      MenuModel(
          "Carrot Juice",
          23000,
          "https://www.alphafoodie.com/wp-content/uploads/2020/11/Carrot-Juice-1-of-1.jpeg",
          1),
      MenuModel(
          "Hot Tea",
          5000,
          "https://cdn.istyle.im/images/product/web/14/35/98/00/0/000000983514_01_800.jpg",
          1),
      MenuModel(
          "Ice Tea",
          5000,
          "https://cdn.istyle.im/images/product/web/17/35/98/00/0/000000983517_01_800.jpg",
          1),
      MenuModel(
          "Iced Lemon Tea",
          13000,
          "https://cdn.shopify.com/s/files/1/0581/6988/4846/products/RaffelsShopifyProduct-IceLemonTea_1024x.png?v=1626117552",
          1),
      MenuModel(
          "Ice Apple Tea",
          12000,
          "https://cdn.yummy.co.id/content-images/images/20200613/92PwuxHvOiOmud2XAn9difUX4zrbIbIW-31353932303432333631d41d8cd98f00b204e9800998ecf8427e_800x800.jpg",
          1),
      MenuModel(
          "Strawberry Milkshake",
          17000,
          "https://www.sharmispassions.com/wp-content/uploads/2012/02/StrawberryMilkshake4-500x500.jpg",
          1),
      MenuModel(
          "Chocolate Milkshake",
          17000,
          "https://media-cdn.tripadvisor.com/media/photo-m/1280/1a/2c/c8/81/chocolate-milkshake.jpg",
          1),
      MenuModel(
          "Vanilla Milkshake",
          17000,
          "https://www.orchidsandsweettea.com/wp-content/uploads/2021/06/Vanilla-Milkshake-4-of-7.jpg",
          1),
      MenuModel(
          "Thai Tea",
          11000,
          "https://assets.pikiran-rakyat.com/crop/0x0:0x0/750x500/photo/2020/09/12/3918509625.jpg",
          1),
      MenuModel(
          "Green Tea",
          11000,
          "https://www.rumahmesin.com/wp-content/uploads/2019/10/Jual-Bubuk-Minuman-di-Bekasi.png",
          1),
      MenuModel(
          "Taro Milk Tea",
          11000,
          "https://recipemarker.com/wp-content/uploads/2020/12/Taro-Milk-Tea-Recipe.jpg",
          1)
    ];

    setState(() {
      isLoaded = true;
      menus = menuList;
    });
  }
}

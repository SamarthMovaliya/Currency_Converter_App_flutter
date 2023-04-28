import 'dart:math';

import 'package:currency_converter_app_api/Controller/Helper_Class/Currency_Helper.dart';
import 'package:currency_converter_app_api/Controller/Helper_Class/ExchangeRateHelper.dart';
import 'package:currency_converter_app_api/Controller/Providers/FromProvider.dart';
import 'package:currency_converter_app_api/Controller/Providers/ThemeProvider.dart';
import 'package:currency_converter_app_api/Modals/Glpbals/CurrencyGlobal.dart';
import 'package:currency_converter_app_api/Modals/Glpbals/ExchangeRateGlobal.dart';
import 'package:currency_converter_app_api/Views/Components/DropDown_List_Item.dart';
import 'package:currency_converter_app_api/Views/Components/DropDown_List_item@.dart';
import 'package:currency_converter_app_api/Views/Screens/CurrentRateScreen.dart';
import 'package:currency_converter_app_api/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool mood = false;
  late PageController pgcontrol = PageController(initialPage: 0);
  TextEditingController controller = TextEditingController();
  int currentIndex = 0;
  late Future data;
  late Future rateData;

  @override
  void initState() {
    print(allCountry.length.toString());
    rateData = ExchangeRateHelper.exchangeRateHelper.fetchAllData();
    data = apiHelper.api.fetchCurrencyData(To: to, From: from);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
        centerTitle: false,
        actions: [
          IconButton(
              onPressed: () {
                Provider.of<ThemeProvider>(context, listen: false)
                    .changeTheme();
              },
              icon: Icon(Icons.sunny)),
          const SizedBox(
            width: 10,
          ),
        ],
        leading: const Icon(
          Icons.menu_rounded,
          size: 30,
        ),
        title: Text(
          'Currency Converter',
          style: GoogleFonts.k2d(
            fontSize: 35,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      body: PageView(
        controller: pgcontrol,
        children: [
          Column(
            children: [
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Card(
                          elevation: 5,
                          borderOnForeground: true,
                          child: SizedBox(
                            height: double.infinity,
                            width: double.infinity,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0, vertical: 8),
                                  child: Row(
                                    children: [
                                      Text(
                                        'From',
                                        style: GoogleFonts.alata(
                                          fontSize: 40,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                      const Spacer(),
                                      const Icon(
                                        Icons.trending_down_rounded,
                                        size: 30,
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0, vertical: 8),
                                  child: Row(
                                    children: [
                                      const Text(
                                        'Select Country',
                                        style: TextStyle(
                                          fontSize: 25,
                                        ),
                                      ),
                                      const Spacer(),
                                      Consumer<FromProvider>(
                                        builder: (context, value, child) {
                                          String to2 = value.fromtoModal.from;
                                          return Text(
                                            to2,
                                            style: const TextStyle(
                                              fontSize: 25,
                                              color: Colors.grey,
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                StatefulBuilder(
                                  builder: (context, setState) {
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          to;
                                        });
                                      },
                                      child: Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.blueGrey.shade300,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 20.0,
                                                vertical: 10,
                                              ),
                                              child: DropdownButton(
                                                  dropdownColor:
                                                      Colors.blueGrey.shade300,
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  icon: const Icon(
                                                    Icons.list,
                                                    color: Colors.white,
                                                    size: 25,
                                                  ),
                                                  isExpanded: true,
                                                  underline: Container(),
                                                  value: from,
                                                  items: allcountry
                                                      .map(
                                                        (e) => DropdownMenuItem(
                                                          value: e[
                                                              'currency_code'],
                                                          child: Text(
                                                            e['country'],
                                                            style:
                                                                const TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 25,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                      .toList(),
                                                  onChanged: (val) {
                                                    Provider.of<FromProvider>(
                                                            context,
                                                            listen: false)
                                                        .changeFrom(
                                                            from:
                                                                val.toString());
                                                    setState(() {
                                                      from = val;
                                                    });
                                                  }),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        )),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Card(
                        elevation: 5,
                        borderOnForeground: true,
                        child: SizedBox(
                          height: 400,
                          width: 500,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0, vertical: 8),
                                child: Row(
                                  children: [
                                    Text(
                                      'Amount',
                                      style: GoogleFonts.alata(
                                        fontSize: 30,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                    const Spacer(),
                                    const Icon(
                                      Icons.monetization_on_rounded,
                                      size: 30,
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextField(
                                  onChanged: (val) {
                                    setState(
                                      () {
                                        amt = double.parse(val);
                                      },
                                    );
                                  },
                                  controller: controller,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                  cursorColor: Colors.grey,
                                  decoration: InputDecoration(
                                    suffixIcon: Icon(
                                      Icons.currency_rupee,
                                      color: Colors.grey.shade400,
                                    ),
                                    labelText: 'Money',
                                    labelStyle:
                                        const TextStyle(color: Colors.grey),
                                    hintText: 'Amount',
                                    hintStyle: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(100),
                                      borderSide: const BorderSide(
                                        width: 2,
                                        color: Colors.grey,
                                        style: BorderStyle.solid,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(100),
                                      borderSide: const BorderSide(
                                          width: 2,
                                          color: Colors.grey,
                                          style: BorderStyle.solid),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(100),
                                      borderSide: const BorderSide(
                                        width: 2,
                                        color: Colors.white70,
                                        style: BorderStyle.solid,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Card(
                          elevation: 5,
                          borderOnForeground: true,
                          child: SizedBox(
                            height: double.infinity,
                            width: double.infinity,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0, vertical: 8),
                                  child: Row(
                                    children: [
                                      Text('To',
                                          style: GoogleFonts.alata(
                                            fontSize: 40,
                                            fontWeight: FontWeight.w900,
                                          )),
                                      const Spacer(),
                                      const Icon(
                                        Icons.trending_up_rounded,
                                        size: 30,
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0, vertical: 8),
                                  child: Row(
                                    children: [
                                      const Text(
                                        'Select Country',
                                        style: TextStyle(
                                          fontSize: 25,
                                        ),
                                      ),
                                      const Spacer(),
                                      Consumer<FromProvider>(
                                        builder: (context, value, child) {
                                          String to1 = value.fromtoModal.to;
                                          return Text(
                                            to1,
                                            style: const TextStyle(
                                              fontSize: 25,
                                              color: Colors.grey,
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                StatefulBuilder(
                                  builder: (context, setState) {
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          to;
                                        });
                                      },
                                      child: Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.blueGrey.shade300,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20.0,
                                                      vertical: 10.0),
                                              child: DropdownButton(
                                                  dropdownColor:
                                                      Colors.blueGrey.shade300,
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 20,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  icon: const Icon(
                                                    Icons.more,
                                                    color: Colors.white,
                                                    size: 25,
                                                  ),
                                                  isExpanded: true,
                                                  underline: Container(),
                                                  value: to,
                                                  items: allcountry
                                                      .map(
                                                        (e) => DropdownMenuItem(
                                                          value: e[
                                                              'currency_code'],
                                                          child: Text(
                                                            e['country'],
                                                            style:
                                                                const TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 25,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                      .toList(),
                                                  onChanged: (val) {
                                                    Provider.of<FromProvider>(
                                                            context,
                                                            listen: false)
                                                        .changeTo(
                                                      to: val.toString(),
                                                    );
                                                    setState(() {
                                                      to = val;
                                                    });
                                                  }),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        )),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        right: 10,
                        left: 10,
                        bottom: 15,
                        top: 5,
                      ),
                      child: SizedBox(
                        height: double.infinity,
                        width: double.infinity,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 4,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.blueGrey.shade500),
                                ),
                                onPressed: () {
                                  setState(() {
                                    data = apiHelper.api.fetchCurrencyData(
                                        From: from, To: to, amount: amt);
                                  });
                                },
                                child: SizedBox(
                                    child: Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Calculate',
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.2,
                                      fontSize: 30,
                                      color: Colors.grey.shade200,
                                    ),
                                  ),
                                )),
                              ),
                            ),
                            Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 20.0),
                                  child: FloatingActionButton(
                                    backgroundColor: Colors.blueGrey,
                                    onPressed: () {
                                      setState(() {
                                        String tempTo = to;
                                        to = from;
                                        from = tempTo;
                                        data = apiHelper.api.fetchCurrencyData(
                                            From: from, To: to, amount: amt);
                                      });
                                    },
                                    child: Transform.rotate(
                                      angle: pi * 0.5,
                                      child: const Icon(
                                        Icons.compare_arrows_rounded,
                                        size: 30,
                                      ),
                                    ),
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Card(
                        elevation: 5,
                        borderOnForeground: true,
                        child: SizedBox(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 10),
                            child: Row(
                              children: [
                                const Spacer(),
                                Center(
                                  child: Align(
                                    alignment: Alignment.topCenter,
                                    child: Text(
                                      'Result :',
                                      style: GoogleFonts.alata(
                                        fontSize: 32,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                FutureBuilder(
                                  future: data,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasError) {
                                      return Center(
                                        child: Text(
                                            'It has error ${snapshot.error}'),
                                      );
                                    } else if (snapshot.hasData) {
                                      global allDatas = snapshot.data as global;
                                      print(allDatas.result.toString());
                                      return Text(
                                        allDatas.result.toString(),
                                        style: const TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      );
                                    }
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  },
                                ),
                                Spacer(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: [
              Expanded(
                flex: 6,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Card(
                          elevation: 5,
                          borderOnForeground: true,
                          child: SizedBox(
                            height: double.infinity,
                            width: double.infinity,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0, vertical: 8),
                                  child: Row(
                                    children: [
                                      Text(
                                        'Base Rate',
                                        style: GoogleFonts.alata(
                                          fontSize: 40,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                      const Spacer(),
                                      const Icon(
                                        Icons.trending_up_rounded,
                                        size: 30,
                                      ),
                                      const SizedBox(
                                        width: 25,
                                      ),
                                      const Icon(
                                        Icons.currency_exchange_rounded,
                                        size: 30,
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0,
                                    vertical: 0,
                                  ),
                                  child: Row(
                                    children: const [
                                      Text(
                                        'United States',
                                        style: TextStyle(
                                          fontSize: 25,
                                        ),
                                      ),
                                      Spacer(),
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Image(
                                          height: 40,
                                          width: 40,
                                          image:
                                              AssetImage('assets/logo/usd.jpg'),
                                        ),
                                      ),
                                      Text(
                                        'USD',
                                        style: TextStyle(
                                          fontSize: 25,
                                          color: Colors.grey,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 23.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Countries Rate',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 30,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 17,
                child: FutureBuilder(
                  future: rateData,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error Occured :${snapshot.error}');
                    } else if (snapshot.hasData) {
                      ExchangeRate allDatas = snapshot.data;
                      return ListView.builder(
                        itemCount: allcountry.length,
                        itemBuilder: (context, index) {
                          dynamic rateCode = allcountry[index]['currency_code'];
                          return Padding(
                            padding: const EdgeInsets.only(
                                top: 8.0, right: 20, left: 20),
                            child: Card(
                              elevation: 2,
                              child: ListTile(
                                isThreeLine: true,
                                leading: Text(
                                  '${index + 1})',
                                  style: GoogleFonts.alata(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                title: Text(
                                  '${allcountry[index]['country']}',
                                  style: GoogleFonts.k2d(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 25,
                                  ),
                                ),
                                subtitle: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      '${allcountry[index]['currency_code']}',
                                      style: GoogleFonts.alata(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                ),
                                trailing: SizedBox(
                                  height: 50,
                                  width: 100,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        '${allDatas.rates[rateCode.toString()]}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14),
                                      ),
                                      const Spacer(),
                                      (allDatas.rates[rateCode] == null)
                                          ? const Icon(
                                              Icons.trending_flat,
                                              color: Colors.grey,
                                            )
                                          : (allDatas.rates[rateCode] > 1)
                                              ? const Icon(
                                                  Icons.trending_down_rounded,
                                                  color: Colors.red,
                                                  size: 30,
                                                )
                                              : const Icon(
                                                  Icons.trending_up_rounded,
                                                  color: Colors.green,
                                                  size: 30,
                                                ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.currency_exchange_rounded),
            label: 'Rates',
          ),
        ],
        onTap: (value) {
          setState(() {
            currentIndex = value;
            pgcontrol.jumpToPage(
              currentIndex,
            );
          });
        },
      ),
    );
  }
}

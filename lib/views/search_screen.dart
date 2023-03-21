import 'package:coin_data/models/crypto.dart';
import 'package:coin_data/service/api_service.dart';
import 'package:coin_data/utils/constants.dart';
import 'package:coin_data/views_models/crypto_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';


class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();
  final _apiService = ApiService();
  final controller = ScrollController(initialScrollOffset: 50.0);
  final formatCurrency = NumberFormat.simpleCurrency(decimalDigits: 2);
  List _cryptoList = [];
  List _filterList = [];

  bool showCryptoDetails = false;
  bool dataHistoryError = false;
  final formatCurrencyPrice = NumberFormat.simpleCurrency(decimalDigits: 6);

  List<ChartData> _data = [];
  bool showStats = false;
  String duration = "max";
  String description = "";
  var dataHistory = [];
  bool dataHistoryLoading = true;

  Future fetchDataHistory() async {
    try {
      setState(() {
        dataHistoryError = false;
      });
      var result = await _apiService.getCryptoDetails(
          Provider.of<CryptoViewModel>(context, listen: false)
              .selectedCrypto
              ?.id ??
              "");
      setState(() {
        dataHistory = result;
        dataHistoryLoading = false;
      });
      for (var i = 0; i < dataHistory.length; i++) {
        var date = DateTime.fromMillisecondsSinceEpoch(dataHistory[i][0]);
        final DateFormat displayFormatter =
        DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
        final DateFormat serverFormatter =
        duration == "max" ? DateFormat('dd/MM/yyyy') : DateFormat('dd/MM');
        final DateTime displayDate = displayFormatter.parse(date.toString());
        final String formatted = serverFormatter.format(displayDate);
        _data.add(ChartData(formatted, dataHistory[i][1]));
      }
    } catch (err) {

      setState(() {
        dataHistoryError = true;
        dataHistoryLoading = false;
      });
    }
  }

  Future fetchDescription() async {
    try {
      description = await _apiService.getCryptoDescription(
          Provider.of<CryptoViewModel>(context, listen: false)
              .selectedCrypto
              ?.id ??
              "");
      print("description is $description");
    } catch (err) {}
  }


  filter(String name) {
    setState(() {
      _filterList = [];
    });
    for(var i = 0; i < Provider.of<CryptoViewModel>(context, listen: false).cryptoList.length ; i ++) {
      if(Provider.of<CryptoViewModel>(context, listen: false).cryptoList[i].id.toString().trim().contains(name.trim()) || Provider.of<CryptoViewModel>(context, listen: false).cryptoList[i].symbol.toString().trim().contains(name.trim())) {
        setState(() {
          _filterList.add(Provider.of<CryptoViewModel>(context, listen: false).cryptoList[i]);
        });

      }
    }
  }


  showDetails()  {
    setState(() {
      showCryptoDetails = true;
      dataHistory = [];
      _data = [];
      dataHistoryLoading = true;
      dataHistoryError = false;
    });
    Future.wait([
      fetchDataHistory(),
      fetchDescription()
    ]);
  }


  @override
  void initState() {
    super.initState();
    showCryptoDetails = false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: showCryptoDetails
          ? SafeArea(
        child: Scaffold(

          backgroundColor: Colors.white,
          body: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        showCryptoDetails = false;
                        dataHistory = [];
                        _data = [];
                      });
                    },
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: EdgeInsets.only(
                          right: MediaQuery.of(context).size.width * 0.05
                        ),
                        child: Text(
                          "< Back",
                          style: GoogleFonts.poppins(
                              color: Colors.blue
                          ),
                        ),
                      )
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.025),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.05,
                        ),
                        Image.network(
                          Provider.of<CryptoViewModel>(context, listen: false)
                              .selectedCrypto
                              ?.image ??
                              "",
                          width: MediaQuery.of(context).size.width * 0.125,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.025,
                        ),
                        Column(
                          children: [
                            Text(
                              Provider.of<CryptoViewModel>(context, listen: false)
                                  .selectedCrypto
                                  ?.name ??
                                  "",
                              style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                  left: MediaQuery.of(context).size.width * 0.015,
                                  right:
                                  MediaQuery.of(context).size.width * 0.015,
                                  top:
                                  MediaQuery.of(context).size.height * 0.0025,
                                  bottom: MediaQuery.of(context).size.height *
                                      0.0025),
                              decoration: BoxDecoration(
                                  color: const Color(0xFF210080),
                                  borderRadius: BorderRadius.circular(
                                      MediaQuery.of(context).size.width * 0.02)),
                              child: Text(
                                "Rank #${Provider.of<CryptoViewModel>(context, listen: false).selectedCrypto?.marketCapRank}",
                                style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: MediaQuery.of(context).size.width *
                                        0.025),
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Container(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.025,
                              right: MediaQuery.of(context).size.width * 0.025,
                              top: MediaQuery.of(context).size.height * 0.005,
                              bottom: MediaQuery.of(context).size.height * 0.005),
                          decoration: BoxDecoration(
                              color: const Color(0xFF210080),
                              borderRadius: BorderRadius.circular(
                                  MediaQuery.of(context).size.width * 0.02)),
                          child: Text(
                            Provider.of<CryptoViewModel>(context, listen: false)
                                .selectedCrypto
                                ?.symbol
                                ?.toUpperCase() ??
                                "",
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize:
                                MediaQuery.of(context).size.width * 0.035),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.05,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.05,
                        right: MediaQuery.of(context).size.width * 0.05,
                        top: MediaQuery.of(context).size.height * 0.025),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "${Provider.of<CryptoViewModel>(context, listen: false).selectedCrypto?.name} Price ( ${Provider.of<CryptoViewModel>(context, listen: false).selectedCrypto?.symbol.toString().toUpperCase()} )",
                          style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: MediaQuery.of(context).size.width * 0.04),
                        ),
                        Row(
                          children: [
                            Text(
                              double.parse(Provider.of<CryptoViewModel>(context, listen: false).selectedCrypto?.currentPrice.toString() ?? "0") < 0.01 ? formatCurrencyPrice.format(Provider.of<CryptoViewModel>(
                                  context,
                                  listen: false)
                                  .selectedCrypto
                                  ?.currentPrice) :
                              formatCurrency.format(Provider.of<CryptoViewModel>(
                                  context,
                                  listen: false)
                                  .selectedCrypto
                                  ?.currentPrice),
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                  fontSize:
                                  MediaQuery.of(context).size.width * 0.04),
                            ),
                            const Spacer(),
                            Text(
                              Provider.of<CryptoViewModel>(context, listen: false)
                                  .selectedCrypto
                                  ?.marketCapChangePercentage
                                  .toString()
                                  .indexOf('-') ==
                                  0
                                  ? "${formatCurrency.format(Provider.of<CryptoViewModel>(context, listen: false).selectedCrypto?.marketCapChangePercentage).replaceAll('\$', '')} %"
                                  : "+${formatCurrency.format(Provider.of<CryptoViewModel>(context, listen: false).selectedCrypto?.marketCapChangePercentage).replaceAll('\$', '')} %",
                              style: GoogleFonts.poppins(
                                  color: Provider.of<CryptoViewModel>(context,
                                      listen: false)
                                      .selectedCrypto
                                      ?.marketCapChangePercentage
                                      .toString()
                                      .indexOf('-') ==
                                      0
                                      ? Colors.red
                                      : Colors.green,
                                  fontWeight: FontWeight.w700,
                                  fontSize:
                                  MediaQuery.of(context).size.width * 0.04),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.05,
                        right: MediaQuery.of(context).size.width * 0.05,
                        top: MediaQuery.of(context).size.height * 0.025),
                    child: Row(
                      children: <Widget>[
                        Text(
                          "Low 24H : ${ double.parse(Provider.of<CryptoViewModel>(context, listen: false).selectedCrypto?.currentPrice.toString() ?? "0") < 0.01 ? formatCurrencyPrice.format(Provider.of<CryptoViewModel>(context, listen: false).selectedCrypto?.low24h) :formatCurrency.format(Provider.of<CryptoViewModel>(context, listen: false).selectedCrypto?.low24h)}",
                          style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: MediaQuery.of(context).size.width * 0.025,
                              fontWeight: FontWeight.w700),
                        ),
                        const Spacer(),
                        Text(
                          "High 24H : ${double.parse(Provider.of<CryptoViewModel>(context, listen: false).selectedCrypto?.currentPrice.toString() ?? "0") < 0.01 ? formatCurrencyPrice.format(Provider.of<CryptoViewModel>(context, listen: false).selectedCrypto?.high24h) : formatCurrency.format(Provider.of<CryptoViewModel>(context, listen: false).selectedCrypto?.high24h)}",
                          style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: MediaQuery.of(context).size.width * 0.025,
                              fontWeight: FontWeight.w700),
                        )
                      ],
                    ),
                  ),
                  if (!showStats)
                    Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.035),
                      child: Center(
                        child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFF210080),
                              borderRadius: BorderRadius.circular(
                                  MediaQuery.of(context).size.width * 0.025),
                            ),
                            width: MediaQuery.of(context).size.width * 0.8,
                            height: MediaQuery.of(context).size.height * 0.065,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.transparent),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              MediaQuery.of(context).size.width *
                                                  0.02)))),
                              onPressed: () {
                                setState(() {
                                  showStats = true;
                                });
                              },
                              child: Text(
                                "More stats",
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                    letterSpacing: 1,
                                    fontStyle: FontStyle.normal,
                                    fontSize: MediaQuery.of(context).size.height *
                                        0.018),
                              ),
                            )),
                      ),
                    ),
                  if (showStats)
                    Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.05),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                                right: MediaQuery.of(context).size.width * 0.05,
                                left: MediaQuery.of(context).size.width * 0.05),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  "Market Cap",
                                  style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                      fontSize:
                                      MediaQuery.of(context).size.width *
                                          0.035),
                                ),
                                const Spacer(),
                                Text(
                                  Provider.of<CryptoViewModel>(context,
                                      listen: false)
                                      .selectedCrypto
                                      ?.marketCap == null ? "No data" :
                                  formatCurrency.format(
                                      Provider.of<CryptoViewModel>(context,
                                          listen: false)
                                          .selectedCrypto
                                          ?.marketCap),
                                  style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                      fontSize:
                                      MediaQuery.of(context).size.width *
                                          0.035),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.0125,
                          ),
                          Container(
                              margin: EdgeInsets.only(
                                  left: MediaQuery.of(context).size.width * 0.05,
                                  right:
                                  MediaQuery.of(context).size.width * 0.05),
                              child: Divider(
                                color: Colors.grey,
                              )),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.0125,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                right: MediaQuery.of(context).size.width * 0.05,
                                left: MediaQuery.of(context).size.width * 0.05),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  "Fully Diluted\nMarket Cap",
                                  style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                      fontSize:
                                      MediaQuery.of(context).size.width *
                                          0.035),
                                ),
                                const Spacer(),
                                Text(
                                  Provider.of<CryptoViewModel>(context,
                                      listen: false)
                                      .selectedCrypto
                                      ?.fullyDilutedValuation == null ? "No data" :
                                  formatCurrency.format(
                                      Provider.of<CryptoViewModel>(context,
                                          listen: false)
                                          .selectedCrypto
                                          ?.fullyDilutedValuation),
                                  style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                      fontSize:
                                      MediaQuery.of(context).size.width *
                                          0.035),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.0125,
                          ),
                          Container(
                              margin: EdgeInsets.only(
                                  left: MediaQuery.of(context).size.width * 0.05,
                                  right:
                                  MediaQuery.of(context).size.width * 0.05),
                              child: Divider(
                                color: Colors.grey,
                              )),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.0125,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                right: MediaQuery.of(context).size.width * 0.05,
                                left: MediaQuery.of(context).size.width * 0.05),
                            child: Row(
                              children: [
                                Text(
                                  "Circulating\nSupply",
                                  style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                      fontSize:
                                      MediaQuery.of(context).size.width *
                                          0.035),
                                ),
                                const Spacer(),
                                Text(
                                  Provider.of<CryptoViewModel>(context,
                                      listen: false)
                                      .selectedCrypto
                                      ?.circulatingSupply == null ? "No data" :
                                  formatCurrency
                                      .format(Provider.of<CryptoViewModel>(
                                      context,
                                      listen: false)
                                      .selectedCrypto
                                      ?.circulatingSupply)
                                      .replaceAll("\$", ""),
                                  style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                      fontSize:
                                      MediaQuery.of(context).size.width *
                                          0.035),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.0125,
                          ),
                          Container(
                              margin: EdgeInsets.only(
                                  left: MediaQuery.of(context).size.width * 0.05,
                                  right:
                                  MediaQuery.of(context).size.width * 0.05),
                              child: Divider(
                                color: Colors.grey,
                              )),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.0125,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                right: MediaQuery.of(context).size.width * 0.05,
                                left: MediaQuery.of(context).size.width * 0.05),
                            child: Row(
                              children: [
                                Text(
                                  "Max\nSupply",
                                  style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                      fontSize:
                                      MediaQuery.of(context).size.width *
                                          0.035),
                                ),
                                const Spacer(),
                                Text(
                                  Provider.of<CryptoViewModel>(context,
                                      listen: false)
                                      .selectedCrypto
                                      ?.maxSupply == null ? "No data" :
                                  formatCurrency
                                      .format(Provider.of<CryptoViewModel>(
                                      context,
                                      listen: false)
                                      .selectedCrypto
                                      ?.maxSupply)
                                      .replaceAll("\$", ""),
                                  style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                      fontSize:
                                      MediaQuery.of(context).size.width *
                                          0.035),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.035),
                            child: Center(
                              child: Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF210080),
                                    borderRadius: BorderRadius.circular(
                                        MediaQuery.of(context).size.width *
                                            0.025),
                                  ),
                                  width: MediaQuery.of(context).size.width * 0.8,
                                  height:
                                  MediaQuery.of(context).size.height * 0.065,
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                        MaterialStateProperty.all(
                                            Colors.transparent),
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(
                                                    MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                        0.02)))),
                                    onPressed: () {
                                      setState(() {
                                        showStats = false;
                                      });
                                    },
                                    child: Text(
                                      "Less stats",
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                          letterSpacing: 1,
                                          fontStyle: FontStyle.normal,
                                          fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.018),
                                    ),
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  if (dataHistoryLoading)
                    Center(
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.1,
                            bottom: MediaQuery.of(context).size.height * 0.1),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.width * 0.075,
                          width: MediaQuery.of(context).size.width * 0.075,
                          child: const CircularProgressIndicator(
                            color: Color(0xFF210080),
                          ),
                        ),
                      ),
                    ),
                  if (!dataHistoryLoading && dataHistory.length > 1)
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SfCartesianChart(
                          plotAreaBorderWidth: 0,
                          trackballBehavior: TrackballBehavior(
                              enable: true,
                              tooltipSettings: InteractiveTooltip(
                                enable: true,
                              ),
                              builder:
                                  (context, TrackballDetails trackballDetails) {
                                return Container(
                                  height: 30,
                                  width: 100,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                      color: Color(0XFF00CC9E)),
                                  child: Center(
                                    child: Text(
                                      "${trackballDetails.point!.y.toString().substring(0, trackballDetails.point!.y.toString().indexOf('.') + 3)}",
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500,
                                          fontStyle: FontStyle.normal,
                                          fontSize: 10.5,
                                          color: Colors.white),
                                    ),
                                  ),
                                );
                              }),
                          zoomPanBehavior: ZoomPanBehavior(
                              enablePinching: true,
                              zoomMode: ZoomMode.x,
                              enableDoubleTapZooming: true,
                              maximumZoomLevel: 0.1
                            //enablePanning: true,
                          ),
                          primaryXAxis: CategoryAxis(
                            majorGridLines: MajorGridLines(width: 0),
                            axisLine: AxisLine(width: 0),
                          ),
                          primaryYAxis: NumericAxis(
                            majorGridLines: MajorGridLines(width: 0),
                            axisLine: AxisLine(width: 0),
                            isVisible: false,
                            interactiveTooltip: InteractiveTooltip(enable: true),
                          ),
                          crosshairBehavior: CrosshairBehavior(
                              enable: true,
                              activationMode: ActivationMode.singleTap,
                              lineColor: Color(0XFF00CC9E),
                              lineType: CrosshairLineType.horizontal,
                              lineDashArray: <double>[5, 5],
                              lineWidth: 2),
                          series: <ChartSeries>[
                            AreaSeries<ChartData, String>(
                                dataSource: _data,
                                xValueMapper: (ChartData data, _) => data.x,
                                yValueMapper: (ChartData data, _) => data.y,
                                animationDuration: 1000,
                                borderWidth: 3,
                                gradient: const LinearGradient(
                                    colors: <Color>[
                                      Color(0xFF210080),
                                      Color(0xFF210080),
                                    ],
                                    begin: const FractionalOffset(0.0, 0.0),
                                    end: const FractionalOffset(0.0, 1.0),
                                    stops: [0.0, 1.0],
                                    tileMode: TileMode.clamp))
                          ],
                        )
                      ],
                    ),
                  if (!dataHistoryLoading && dataHistory.length == 1)
                    Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.1,
                          bottom: MediaQuery.of(context).size.height * 0.1),
                      child: Center(
                        child: Text(
                          "No data",
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w700,
                              fontSize:
                              MediaQuery.of(context).size.height * 0.0175,
                              color: const Color(0XFF210080)),
                        ),
                      ),
                    ),

                  if(!dataHistoryLoading && dataHistoryError)
                    Padding(
                      padding: EdgeInsets.only(
                        right: MediaQuery.of(context).size.width * 0.1,
                          left: MediaQuery.of(context).size.width * 0.1,
                          top: MediaQuery.of(context).size.height * 0.1,
                          bottom: MediaQuery.of(context).size.height * 0.1),
                      child: Center(
                        child: Text(
                          "Something went wrong, please try again later",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w700,
                              fontSize:
                              MediaQuery.of(context).size.height * 0.0175,
                              color: const Color(0XFF210080)),
                        ),
                      ),
                    ),



                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.05,
                        top: MediaQuery.of(context).size.height * 0.05),
                    child: Text(
                      "About ${Provider.of<CryptoViewModel>(context, listen: false).selectedCrypto?.name ?? ""}",
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w700,
                          fontSize: MediaQuery.of(context).size.height * 0.02),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.05,
                          top: MediaQuery.of(context).size.height * 0.025,
                          right: MediaQuery.of(context).size.width * 0.05),
                      child: Text(
                        description != "" ? description : "No data",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400,
                            fontSize: MediaQuery.of(context).size.height * 0.015),
                      ))
                ],
              ),
            ),
          ),
        ),
      )
          : SafeArea(
        child: Scaffold(

          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.025,
                ),

                Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextFormField(
                      controller: _searchController,
                      onChanged: (value) {
                        if(value.isNotEmpty) {
                          filter(value);
                        } else {
                          setState(() {
                            _filterList = [];
                          });
                        }


                      },
                      style: GoogleFonts.poppins(
                          letterSpacing: 0.9,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          fontSize: MediaQuery.of(context).size.width * 0.03,
                          color:Colors.black
                      ),
                      decoration: InputDecoration(
                        hintText: 'Search token ...',
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.015,
                            bottom: MediaQuery.of(context).size.height * 0.015
                          ),
                          child: SvgPicture.asset(
                            "assets/images/search-icon.svg",
                            color: Colors.black,
                          ),
                        ),
                        hintStyle: GoogleFonts.poppins(
                            letterSpacing: 0.9,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            fontSize: MediaQuery.of(context).size.width * 0.03,
                            color:Colors.black
                        ),
                        isDense: true,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(
                              MediaQuery.of(context).size.width * 0.035)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                              MediaQuery.of(context).size.width * 0.035),
                          borderSide:  const BorderSide(
                            color:  Colors.grey,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                              MediaQuery.of(context).size.width * 0.035),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        fillColor: Colors.white,
                      ),
                    ),

                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.015,
                ),

                if(_searchController.text.isEmpty)
                  Padding(
                    padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.05,
                      right: MediaQuery.of(context).size.width * 0.05,
                    ),
                    child: ListView.builder(
                        itemCount: Provider.of<CryptoViewModel>(context,
                            listen: false)
                            .cryptoList.length,
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: ()  {
                              Provider.of<CryptoViewModel>(context, listen: false).selectedCrypto = Provider.of<CryptoViewModel>(context, listen: false).cryptoList[index];
                               showDetails();
                            },
                            child: Padding(
                              padding: EdgeInsets.only(
                                top: index == 0
                                    ? MediaQuery.of(context).size.height *
                                    0.03
                                    : MediaQuery.of(context).size.height *
                                    0.015,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[

                                  SizedBox(
                                    width: MediaQuery.of(context).size.width * 0.075,
                                    child: CircleAvatar(
                                      backgroundImage: NetworkImage(
                                        Provider.of<CryptoViewModel>(context,
                                            listen: false)
                                            .cryptoList[index]
                                            .image
                                            .toString(),
                                      ),
                                      backgroundColor: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.035,
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width * 0.125,
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            Provider.of<CryptoViewModel>(
                                                context,
                                                listen: false)
                                                .cryptoList[index]
                                                .name
                                                .toString(),
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w700,
                                                letterSpacing: 0.9,
                                                fontStyle: FontStyle.normal,
                                                fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                    0.012,
                                                color: Colors.black)),
                                        Text(
                                            Provider.of<CryptoViewModel>(
                                                context,
                                                listen: false)
                                                .cryptoList[index]
                                                .symbol
                                                .toString()
                                                .toUpperCase(),
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w400,
                                                letterSpacing: 0.9,
                                                fontStyle: FontStyle.normal,
                                                fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                    0.01,
                                                color: Colors.grey)),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.05,
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width * 0.2,
                                    child: Text(
                                        formatCurrency.format(
                                            Provider.of<CryptoViewModel>(
                                                context,
                                                listen: false)
                                                .cryptoList[index]
                                                ?.currentPrice),
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w700,
                                            letterSpacing: 0.9,
                                            fontStyle: FontStyle.normal,
                                            fontSize: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.012,
                                            color: Colors.black)),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.035,
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.2,
                                    child: Text(
                                      double.parse(Provider.of<CryptoViewModel>(
                                          context,
                                          listen: false)
                                          .cryptoList[index]
                                          .marketCapChangePercentage
                                          .toString()) >
                                          0
                                          ? "+${Provider.of<CryptoViewModel>(context, listen: false).cryptoList[index].marketCapChangePercentage.toString().substring(0, Provider.of<CryptoViewModel>(context, listen: false).cryptoList[index].marketCapChangePercentage.toString().indexOf('.') + 3)} %"
                                          : "${Provider.of<CryptoViewModel>(context, listen: false).cryptoList[index].marketCapChangePercentage.toString().substring(0, Provider.of<CryptoViewModel>(context, listen: false).cryptoList[index].marketCapChangePercentage.toString().indexOf('.') + 3)} %",
                                      style: GoogleFonts.poppins(
                                          color: double.parse(Provider.of<
                                              CryptoViewModel>(
                                              context,
                                              listen: false)
                                              .cryptoList[index]
                                              .marketCapChangePercentage
                                              .toString()) <
                                              0
                                              ? Colors.red
                                              : Colors.green,
                                          fontSize: MediaQuery.of(context)
                                              .size
                                              .width *
                                              0.0275,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.025,
                                  ),
                                  Text(
                                      Provider.of<CryptoViewModel>(context,
                                          listen: false)
                                          .cryptoList[index]
                                          .marketCapRank ==
                                          null
                                          ? "Rank # --"
                                          : "Rank #${Provider.of<CryptoViewModel>(context, listen: false).cryptoList[index].marketCapRank}",
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w400,
                                          letterSpacing: 0.9,
                                          fontStyle: FontStyle.normal,
                                          fontSize: MediaQuery.of(context)
                                              .size
                                              .height *
                                              0.01,
                                          color: Colors.grey)),
                                ],
                              ),
                            ),
                          );
                        }),
                  ),


                if(_searchController.text.isNotEmpty && _filterList.isNotEmpty)
                  Padding(
                    padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.05,
                      right: MediaQuery.of(context).size.width * 0.05,
                    ),
                    child: ListView.builder(
                        itemCount: _filterList.length,
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Provider.of<CryptoViewModel>(context, listen: false).selectedCrypto = _filterList[index];
                              showDetails();
                            },
                            child: Padding(
                              padding: EdgeInsets.only(
                                top: index == 0
                                    ? MediaQuery.of(context).size.height *
                                    0.03
                                    : MediaQuery.of(context).size.height *
                                    0.015,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[

                                  SizedBox(
                                    width: MediaQuery.of(context).size.width * 0.075,
                                    child: CircleAvatar(
                                      backgroundImage: NetworkImage(
                                        _filterList[index]
                                            .image
                                            .toString(),
                                      ),
                                      backgroundColor: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.035,
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width * 0.125,
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            _filterList[index]
                                                .name
                                                .toString(),
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w700,
                                                letterSpacing: 0.9,
                                                fontStyle: FontStyle.normal,
                                                fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                    0.012,
                                                color: Colors.black)),
                                        Text(
                                            _filterList[index]
                                                .symbol
                                                .toString()
                                                .toUpperCase(),
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w400,
                                                letterSpacing: 0.9,
                                                fontStyle: FontStyle.normal,
                                                fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                    0.01,
                                                color: Colors.grey)),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.05,
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width * 0.2,
                                    child: Text(
                                        formatCurrency.format(
                                            _filterList[index]
                                                ?.currentPrice),
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w700,
                                            letterSpacing: 0.9,
                                            fontStyle: FontStyle.normal,
                                            fontSize: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.012,
                                            color: Colors.black)),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.035,
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.2,
                                    child: Text(
                                      double.parse(_filterList[index]
                                          .marketCapChangePercentage
                                          .toString()) >
                                          0
                                          ? "+${_filterList[index].marketCapChangePercentage.toString().substring(0, _filterList[index].marketCapChangePercentage.toString().indexOf('.') + 3)} %"
                                          : "${_filterList[index].marketCapChangePercentage.toString().substring(0, _filterList[index].marketCapChangePercentage.toString().indexOf('.') + 3)} %",
                                      style: GoogleFonts.poppins(
                                          color: double.parse(_filterList[index]
                                              .marketCapChangePercentage
                                              .toString()) <
                                              0
                                              ? Colors.red
                                              : Colors.green,
                                          fontSize: MediaQuery.of(context)
                                              .size
                                              .width *
                                              0.0275,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.025,
                                  ),
                                  Text(
                                      _filterList[index]
                                          .marketCapRank ==
                                          null
                                          ? "Rank # --"
                                          : "Rank #${_filterList[index].marketCapRank}",
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w400,
                                          letterSpacing: 0.9,
                                          fontStyle: FontStyle.normal,
                                          fontSize: MediaQuery.of(context)
                                              .size
                                              .height *
                                              0.01,
                                          color: Colors.grey)),
                                ],
                              ),
                            ),
                          );
                        }),
                  ),

                if(_searchController.text.isNotEmpty && _filterList.isEmpty)
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: MediaQuery.of(context).size.height * 0.075,),
                        Image.asset("assets/images/error-404.png", color: Colors.black, width: MediaQuery.of(context).size.width * 0.3,),


                        Padding(
                          padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.15,
                            right: MediaQuery.of(context).size.width * 0.15,
                            top: MediaQuery.of(context).size.height * 0.075,
                          ),
                          child: Text(
                              "Opssss ... No crypto match with this name",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                                fontSize: MediaQuery.of(context)
                                    .size
                                    .width *
                                    0.0325,
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.9),
                          ),
                        ),
                      ],
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}



class ChartData {
  ChartData(this.x, this.y);
  final String? x;
  final double? y;
}

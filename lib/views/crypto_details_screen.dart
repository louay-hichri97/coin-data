import 'package:coin_data/service/api_service.dart';
import 'package:coin_data/views_models/crypto_view_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CryptoDetailsScreen extends StatefulWidget {
  const CryptoDetailsScreen({Key? key}) : super(key: key);

  @override
  _CryptoDetailsScreenState createState() => _CryptoDetailsScreenState();
}

class _CryptoDetailsScreenState extends State<CryptoDetailsScreen> {
  final formatCurrency = NumberFormat.simpleCurrency(decimalDigits: 2);
  final formatCurrencyPrice = NumberFormat.simpleCurrency(decimalDigits: 6);
  ApiService _apiService = ApiService();
  List<ChartData> _data = [];
  bool showStats = false;
  String duration = "max";
  String description = "";
  var dataHistory = [];
  bool dataHistoryLoading = true;

  fetchDataHistory() async {
    try {
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
    } catch (err) {}
  }

  fetchDescription() async {
    try {
      description = await _apiService.getCryptoDescription(
          Provider.of<CryptoViewModel>(context, listen: false)
                  .selectedCrypto
                  ?.id ??
              "");
      print("description is $description");
    } catch (err) {}
  }

  @override
  void initState() {
    super.initState();
    showStats = false;
    dataHistoryLoading = true;

    fetchDataHistory();
    fetchDescription();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          title: Text(
            "coinData",
            style: TextStyle(
                fontFamily: 'Climate',
                color: const Color(0xFF210080),
                fontSize: MediaQuery.of(context).size.height * 0.025,
                fontWeight: FontWeight.w400),
          ),
        ),
        backgroundColor: Colors.white,
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
    );
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final String? x;
  final double? y;
}

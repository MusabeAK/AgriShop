import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:agri_shop/farm_screens/home2/Weather/weather_item.dart';
import 'package:agri_shop/farm_screens/home2/Weather/constants.dart';
import 'package:intl/intl.dart';

class DetailPage extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final dailyForecastWeather;

  const DetailPage({Key? key, this.dailyForecastWeather}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final Constants _constants = Constants();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var weatherData = widget.dailyForecastWeather;

    //function to get weather
    Map getForecastWeather(int index) {
      int maxWindSpeed = weatherData[index]["day"]["maxwind_kph"].toInt();
      int avgHumidity = weatherData[index]["day"]["avghumidity"].toInt();
      int chanceOfRain =
          weatherData[index]["day"]["daily_chance_of_rain"].toInt();

      var parsedDate = DateTime.parse(weatherData[index]["date"]);
      var forecastDate = DateFormat('EEEE, d MMMM').format(parsedDate);

      String weatherName = weatherData[index]["day"]["condition"]["text"];
      String weatherIcon =
          "${weatherName.replaceAll(' ', '').toLowerCase()}.png";

      int minTemperature = weatherData[index]["day"]["mintemp_c"].toInt();
      int maxTemperature = weatherData[index]["day"]["maxtemp_c"].toInt();

      var forecastData = {
        'maxWindSpeed': maxWindSpeed,
        'avgHumidity': avgHumidity,
        'chanceOfRain': chanceOfRain,
        'forecastDate': forecastDate,
        'weatherName': weatherName,
        'weatherIcon': weatherIcon,
        'minTemperature': minTemperature,
        'maxTemperature': maxTemperature
      };
      return forecastData;
    }

    return Scaffold(
      backgroundColor: const Color(0xFFEEF0EE),
      appBar: AppBar(
        title: const Text('Forecasts'),
        centerTitle: true,
        backgroundColor: const Color(0xFFEEF0EE),
        elevation: 0.0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
                onPressed: () {
                  print("Settings Tapped!");
                },
                icon: const Icon(Icons.settings)),
          )
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              height: size.height * .75,
              width: size.width,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    top: -50,
                    right: 20,
                    left: 20,
                    child: Container(
                      height: 300,
                      width: size.width * .7,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.center,
                            colors: [
                              Color(0xFFF4FAF4),
                              Color(0xFFE7FCE7),
                            ]),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0xFFEEF0EE),
                            offset: Offset(10, 10),
                            blurRadius: 3,
                            spreadRadius: -5,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Positioned(
                            // ignore: prefer_interpolation_to_compose_strings
                            width: 150,
                            // ignore: prefer_interpolation_to_compose_strings
                            child: Image.asset("assets/images/" +
                                getForecastWeather(0)["weatherIcon"]),
                          ),
                          Positioned(
                            top: 150,
                            left: 30,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: Text(
                                getForecastWeather(0)["weatherName"],
                                style: const TextStyle(
                                    color: Colors.black87, fontSize: 20),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 20,
                            left: 20,
                            child: Container(
                              width: size.width * .8,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  WeatherItem(
                                    value:
                                        getForecastWeather(0)["maxWindSpeed"],
                                    unit: "km/h",
                                    imageUrl: "assets/images/windspeed.png",
                                  ),
                                  WeatherItem(
                                    value: getForecastWeather(0)["avgHumidity"],
                                    unit: "%",
                                    imageUrl: "assets/images/humidity.png",
                                  ),
                                  WeatherItem(
                                    value:
                                        getForecastWeather(0)["chanceOfRain"],
                                    unit: "%",
                                    imageUrl: "assets/images/lightrain.png",
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            top: 20,
                            right: 20,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  getForecastWeather(0)["maxTemperature"]
                                      .toString(),
                                  style: TextStyle(
                                    fontSize: 80,
                                    fontWeight: FontWeight.bold,
                                    foreground: Paint()
                                      ..shader = _constants.shader,
                                  ),
                                ),
                                Text(
                                  'o',
                                  style: TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                    foreground: Paint()
                                      ..shader = _constants.shader,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            top: 320,
                            left: 0,
                            child: SizedBox(
                              height: 400,
                              width: size.width * .9,
                              child: ListView(
                                physics: const BouncingScrollPhysics(),
                                children: [
                                  Card(
                                    elevation: 3.0,
                                    color: const Color(0xFFE7FCE7),
                                    surfaceTintColor: Colors.green,
                                    margin: const EdgeInsets.only(bottom: 20),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                getForecastWeather(
                                                    0)["forecastDate"],
                                                style: const TextStyle(
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        getForecastWeather(0)[
                                                                "minTemperature"]
                                                            .toString(),
                                                        style: const TextStyle(
                                                          color: Colors.black26,
                                                          fontSize: 30,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                      const Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                bottom: 15.0),
                                                        child: Text(
                                                          'o',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black26,
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontFeatures: [
                                                                FontFeature
                                                                    .enable(
                                                                        'sups'),
                                                              ]),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        getForecastWeather(0)[
                                                                "maxTemperature"]
                                                            .toString(),
                                                        style: const TextStyle(
                                                          color: Colors.black87,
                                                          fontSize: 30,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                      const Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                bottom: 15.0),
                                                        child: Text(
                                                          'o',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black87,
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontFeatures: [
                                                                FontFeature
                                                                    .enable(
                                                                        'sups'),
                                                              ]),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Image.asset(
                                                    // ignore: prefer_interpolation_to_compose_strings
                                                    'assets/images/' +
                                                        getForecastWeather(
                                                            0)["weatherIcon"],
                                                    width: 30,
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    getForecastWeather(
                                                        0)["weatherName"],
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.black45,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "${getForecastWeather(0)["chanceOfRain"]}%",
                                                    style: const TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.black45,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Image.asset(
                                                    'assets/images/lightrain.png',
                                                    width: 30,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Card(
                                    elevation: 3.0,
                                    shadowColor: Colors.green,
                                    surfaceTintColor: Colors.green,
                                    color: const Color(0xFFE7FCE7),
                                    margin: const EdgeInsets.only(bottom: 20),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                getForecastWeather(
                                                    1)["forecastDate"],
                                                style: const TextStyle(
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        getForecastWeather(1)[
                                                                "minTemperature"]
                                                            .toString(),
                                                        style: const TextStyle(
                                                          color: Colors.black26,
                                                          fontSize: 30,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                      const Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                bottom: 15.0),
                                                        child: Text(
                                                          'o',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black26,
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontFeatures: [
                                                                FontFeature
                                                                    .enable(
                                                                        'sups'),
                                                              ]),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        getForecastWeather(1)[
                                                                "maxTemperature"]
                                                            .toString(),
                                                        style: const TextStyle(
                                                          color: Colors.black87,
                                                          fontSize: 30,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                      const Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                bottom: 15),
                                                        child: Text(
                                                          'o',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black87,
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontFeatures: [
                                                                FontFeature
                                                                    .enable(
                                                                        'sups'),
                                                              ]),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Image.asset(
                                                    // ignore: prefer_interpolation_to_compose_strings
                                                    'assets/images/' +
                                                        getForecastWeather(
                                                            1)["weatherIcon"],
                                                    width: 30,
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    getForecastWeather(
                                                        0)["weatherName"],
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.black45,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "${getForecastWeather(1)["chanceOfRain"]}%",
                                                    style: const TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.black45,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Image.asset(
                                                    'assets/images/lightrain.png',
                                                    width: 30,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Card(
                                    elevation: 3.0,
                                    color: const Color(0xFFE7FCE7),
                                    surfaceTintColor: Colors.green,
                                    margin: const EdgeInsets.only(bottom: 20),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                getForecastWeather(
                                                    2)["forecastDate"],
                                                style: const TextStyle(
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        getForecastWeather(2)[
                                                                "minTemperature"]
                                                            .toString(),
                                                        style: const TextStyle(
                                                          color: Colors.black26,
                                                          fontSize: 30,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                      const Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                bottom: 15),
                                                        child: Text(
                                                          'o',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black26,
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontFeatures: [
                                                                FontFeature
                                                                    .enable(
                                                                        'sups'),
                                                              ]),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        getForecastWeather(2)[
                                                                "maxTemperature"]
                                                            .toString(),
                                                        style: const TextStyle(
                                                          color: Colors.black87,
                                                          fontSize: 30,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                      const Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                bottom: 15),
                                                        child: Text(
                                                          'o',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black87,
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontFeatures: [
                                                                FontFeature
                                                                    .enable(
                                                                        'sups'),
                                                              ]),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Image.asset(
                                                    'assets/images/' +
                                                        getForecastWeather(
                                                            2)["weatherIcon"],
                                                    width: 30,
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    getForecastWeather(
                                                        2)["weatherName"],
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.black45,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "${getForecastWeather(2)["chanceOfRain"]}%",
                                                    style: const TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.black45,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Image.asset(
                                                    'assets/images/lightrain.png',
                                                    width: 30,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

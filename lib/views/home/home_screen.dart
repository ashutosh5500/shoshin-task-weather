import 'package:flutter/material.dart';
import 'package:weather_app_shoshin/controller/weather_controller.dart';
import 'package:weather_app_shoshin/model/weather_model.dart';
import 'package:weather_app_shoshin/network/weather_repository.dart';
import 'package:get/get.dart';
import 'package:weather_app_shoshin/utils.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    weatherRepo.fetchWeather().then((value) {
      isLoaded.value = true;
    }).catchError((onError) => Utils.showSnackBar(context, '$onError'));
  }

  final weatherController = Get.put(WeatherController());
  final weatherRepo = WeatherRepository();
  RxBool isLoaded = false.obs;

  @override
  Widget build(BuildContext context) {
    const homeBackground =
        'assets/images/janko-ferlic-oe_ozu4ouZk-unsplash.jpg';
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Weather App"),
          centerTitle: true,
        ),
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(homeBackground),
                    fit: BoxFit.cover,
                    opacity: 0.3),
              ),
            ),
            Obx(() {
              var weatherModel = weatherController.weatherModel;
              if (isLoaded.isTrue) {
                return Container(
                  margin: const EdgeInsets.all(16.0),
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${weatherModel?.current?.temperature2m}${weatherModel?.currentUnits?.temperature2m}',
                                  style:
                                      Theme.of(context).textTheme.displayMedium,
                                ),
                                const Icon(
                                  Icons.sunny_snowing,
                                  size: 32,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                            Text(
                              weatherController.weatherDesc(
                                  weatherModel!.daily!.weathercode!.last),
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text('Next three days'),
                      IntrinsicHeight(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            for (int i = 0;
                                i < weatherModel.daily!.time!.length;
                                i++)
                              ForecastCard(
                                weatherModel: weatherModel,
                                i: i,
                                weatherController: weatherController,
                              )
                          ],
                        ),
                      )
                    ],
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            isLoaded.value = false;
            await weatherRepo.fetchWeather().then((value) {
              isLoaded.value = true;
            }).catchError((onError) => Utils.showSnackBar(context, '$onError'));
          },
          child: const Icon(Icons.refresh),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}

class ForecastCard extends StatelessWidget {
  const ForecastCard({
    super.key,
    required this.weatherModel,
    required this.i,
    required this.weatherController,
  });

  final WeatherModel weatherModel;
  final int i;
  final WeatherController weatherController;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(
            Icons.cloud,
            color: Colors.white,
          ),
          Text(
            '${(weatherModel.daily!.temperature2mMin![i])}${(weatherModel.dailyUnits!.temperature2mMin)} - ${(weatherModel.daily!.temperature2mMax![i])}${(weatherModel.dailyUnits!.temperature2mMin)}',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            '${weatherController.weatherDesc(weatherModel.daily!.weathercode![i])}.',
            textAlign: TextAlign.center,
          ),
         Spacer(),
          Text(weatherModel.daily!.time![i], textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

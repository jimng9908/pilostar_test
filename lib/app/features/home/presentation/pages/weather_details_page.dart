import 'package:flutter/material.dart';
import 'package:rockstardata_apk/app/core/core.dart';
import 'package:rockstardata_apk/app/features/home/presentation/widgets/weather/aemet_footer.dart';
import 'package:rockstardata_apk/app/features/home/presentation/widgets/weather/forecast_card.dart';
import 'package:rockstardata_apk/app/features/home/presentation/widgets/weather/sunrise_sunset_card.dart';
import 'package:rockstardata_apk/app/features/home/presentation/widgets/weather/weather_header.dart';

class WeatherDetailsPage extends StatelessWidget {
  const WeatherDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const WeatherHeader(),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
              child: Column(
                children: [
                  const SunriseSunsetCard(),
                  const SizedBox(height: 20),
                  ForecastCard(
                    period: "Mañana",
                    time: "06:00 - 12:00",
                    temp: 14,
                    st: 13,
                    condition: "Despejado con algunas nubes",
                    icon: Icons.wb_sunny_outlined,
                    color: AppColor.darkPink,
                    precipitation: "5%",
                    humidity: "65%",
                    wind: "12 km/h NE",
                  ),
                  const SizedBox(height: 20),
                  ForecastCard(
                    period: "Mediodía",
                    time: "12:00 - 15:00",
                    temp: 21,
                    st: 20,
                    condition: "Soleado",
                    icon: Icons.wb_sunny_outlined,
                    color: AppColor.darkPink,
                    precipitation: "10%",
                    humidity: "55%",
                    wind: "15 km/h E",
                  ),
                  const SizedBox(height: 20),
                  ForecastCard(
                    period: "Tarde",
                    time: "15:00 - 20:00",
                    temp: 18,
                    st: 17,
                    condition: "Parcialmente nublado",
                    icon: Icons.cloud_outlined,
                    color: AppColor.ligthGreen,
                    precipitation: "15%",
                    humidity: "60%",
                    wind: "10 km/h SE",
                  ),
                  const SizedBox(height: 20),
                  ForecastCard(
                    period: "Noche",
                    time: "20:00 - 06:00",
                    temp: 12,
                    st: 11,
                    condition: "Nublado",
                    icon: Icons.cloud_outlined,
                    color: AppColor.ligthGreen,
                    precipitation: "20%",
                    humidity: "70%",
                    wind: "8 km/h S",
                  ),
                  const SizedBox(height: 30),
                  const AemetFooter(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

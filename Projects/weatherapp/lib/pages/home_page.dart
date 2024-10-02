import 'package:flutter/material.dart';
import 'package:weather/weather.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp/pages/consts.dart'; // Assuming this contains OPENWEATHER_API_KEY

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final WeatherFactory _wf = WeatherFactory(OPENWEATHER_API_KEY);
  Weather? _weather;
  final TextEditingController _cityController = TextEditingController(); // Controller for the TextField

  @override
  void initState() {
    super.initState();
    _fetchWeather("Philadelphia"); // Default city
  }

  // Fetch weather for the specified city
  void _fetchWeather(String city) {
    _wf.currentWeatherByCityName(city).then((w) {
      setState(() {
        _weather = w;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
        backgroundColor: Colors.blueAccent, // Gentle color for AppBar
      ),
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    if (_weather == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return SingleChildScrollView( // Make the entire UI scrollable
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _locationHeader(),
              const SizedBox(height: 16),
              _dateTimeInfo(),
              const SizedBox(height: 16),
              _weatherIcon(),
              const SizedBox(height: 16),
              _currentTemp(),
              const SizedBox(height: 16),
              _extraInfo(),
              const SizedBox(height: 16),
              _cityInput(), // City input field
            ],
          ),
        ),
      ),
    );
  }

  // Method to display the location header
  Widget _locationHeader() {
    String city = _weather?.areaName ?? "Unknown Location";
    String country = _weather?.country ?? "Unknown Country"; // Add country info
    return Text(
      "$city, $country", // Display both city and country
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: Colors.deepPurple, // Gentle color for location text
      ),
    );
  }

  Widget _dateTimeInfo() {
    DateTime now = _weather?.date ?? DateTime.now();
    return Column(
      children: [
        Text(
          DateFormat("h:mm a").format(now),
          style: const TextStyle(
            fontSize: 30,
            color: Colors.blueAccent, // Gentle color for time
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              DateFormat("EEEE").format(now),
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w700,
                color: Colors.blueAccent, // Gentle color for day
              ),
            ),
            const SizedBox(width: 10),
            Text(
              "${DateFormat("d.M.y").format(now)}",
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                color: Colors.blueAccent, // Gentle color for date
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _weatherIcon() {
    String? iconUrl = _weather?.weatherIcon != null
        ? "http://openweathermap.org/img/wn/${_weather?.weatherIcon}@4x.png"
        : null;

    return iconUrl != null
        ? Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.network(
          iconUrl,
          width: 100,
          height: 100,
        ),
      ],
    )
        : const SizedBox();
  }

  Widget _currentTemp() {
    return Text(
      "${_weather?.temperature?.celsius?.toStringAsFixed(0)}°C",
      style: const TextStyle(
        color: Colors.black,
        fontSize: 90,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _extraInfo() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.deepPurpleAccent,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Text(
            "Temperature Info",
            style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  const Text(
                    "Min Temp",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  Text(
                    "${_weather?.tempMin?.celsius?.toStringAsFixed(0)}°C",
                    style: const TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ],
              ),
              Column(
                children: [
                  const Text(
                    "Max Temp",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  Text(
                    "${_weather?.tempMax?.celsius?.toStringAsFixed(0)}°C",
                    style: const TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Method for city input
  Widget _cityInput() {
    return Column(
      children: [
        TextField(
          controller: _cityController,
          decoration: InputDecoration(
            labelText: 'Enter City',
            hintText: 'e.g. New York',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.blueAccent),
            ),
            filled: true,
            fillColor: Colors.lightBlue.shade50, // Gentle background color for the input field
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            String city = _cityController.text.trim();
            if (city.isNotEmpty) {
              _fetchWeather(city); // Fetch weather for entered city
              _cityController.clear(); // Clear the input field
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent, // Background color for the button
            foregroundColor: Colors.white, // Text color for the button
          ),
          child: const Text('Get Weather'),
        ),
      ],
    );
  }
}

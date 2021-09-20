import 'dart:convert';

class WeatherData {
  String? weather_state_name;
  String? applicable_date;
  double? min_temp;
  double? max_temp;
  double? the_temp;
  double? wind_speed;
  double? air_pressure;
  int? humidity;
  double? visibility;
  WeatherData({
    this.weather_state_name,
    this.applicable_date,
    this.min_temp,
    this.max_temp,
    this.the_temp,
    this.wind_speed,
    this.air_pressure,
    this.humidity,
    this.visibility,
  });

  WeatherData copyWith({
    String? weather_state_name,
    String? applicable_date,
    double? min_temp,
    double? max_temp,
    double? the_temp,
    double? wind_speed,
    double? air_pressure,
    int? humidity,
    double? visibility,
  }) {
    return WeatherData(
      weather_state_name: weather_state_name ?? this.weather_state_name,
      applicable_date: applicable_date ?? this.applicable_date,
      min_temp: min_temp ?? this.min_temp,
      max_temp: max_temp ?? this.max_temp,
      the_temp: the_temp ?? this.the_temp,
      wind_speed: wind_speed ?? this.wind_speed,
      air_pressure: air_pressure ?? this.air_pressure,
      humidity: humidity ?? this.humidity,
      visibility: visibility ?? this.visibility,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'weather_state_name': weather_state_name,
      'applicable_date': applicable_date,
      'min_temp': min_temp,
      'max_temp': max_temp,
      'the_temp': the_temp,
      'wind_speed': wind_speed,
      'air_pressure': air_pressure,
      'humidity': humidity,
      'visibility': visibility,
    };
  }

  factory WeatherData.fromMap(Map<String, dynamic> map) {
    return WeatherData(
      weather_state_name: map['weather_state_name'],
      applicable_date: map['applicable_date'],
      min_temp: map['min_temp'],
      max_temp: map['max_temp'],
      the_temp: map['the_temp'],
      wind_speed: map['wind_speed'],
      air_pressure: map['air_pressure'],
      humidity: map['humidity'],
      visibility: map['visibility'],
    );
  }

  String toJson() => json.encode(toMap());

  factory WeatherData.fromJson(String source) =>
      WeatherData.fromMap(json.decode(source));

  @override
  String toString() {
    return 'WeatherData(weather_state_name: $weather_state_name, applicable_date: $applicable_date, min_temp: $min_temp, max_temp: $max_temp, the_temp: $the_temp, wind_speed: $wind_speed, air_pressure: $air_pressure, humidity: $humidity, visibility: $visibility)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WeatherData &&
        other.weather_state_name == weather_state_name &&
        other.applicable_date == applicable_date &&
        other.min_temp == min_temp &&
        other.max_temp == max_temp &&
        other.the_temp == the_temp &&
        other.wind_speed == wind_speed &&
        other.air_pressure == air_pressure &&
        other.humidity == humidity &&
        other.visibility == visibility;
  }

  @override
  int get hashCode {
    return weather_state_name.hashCode ^
        applicable_date.hashCode ^
        min_temp.hashCode ^
        max_temp.hashCode ^
        the_temp.hashCode ^
        wind_speed.hashCode ^
        air_pressure.hashCode ^
        humidity.hashCode ^
        visibility.hashCode;
  }
}

class Constants {
  static const String API_URL = "http://192.168.8.154:5000/api";
  static final Constants instance = Constants.internal();
  factory Constants() => instance;
  static const double _padding = 10;
  //http://192.168.8.154:5000
  //https://apicarmiles.hstappstore.com
  Constants.internal();

  get padding => _padding;

}

ApiResponseStatus currentStatus = ApiResponseStatus.noDefinations;

enum ApiResponseStatus { noDefinations, loading, succesfull, error,qrLoading}

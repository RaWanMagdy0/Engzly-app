
class ServiceChargeCalculator {
  static const double baseCharge = 50.0;
  static const double pricePerKm = 2.0;
  static const double freeDistanceKm = 5.0;

  static double calculateFromMeters(double distanceInMeters) {
    double distanceInKm = distanceInMeters / 1000;
    
    if (distanceInKm <= freeDistanceKm) {
      return baseCharge;
    }

    double additionalDistance = distanceInKm - freeDistanceKm;
    double totalCharge = baseCharge + (additionalDistance * pricePerKm);

    return totalCharge;
  }

  static double calculateByZonesFromMeters(double distanceInMeters) {
    double distanceInKm = distanceInMeters / 1000;

    if (distanceInKm <= 5) {
      return 50.0;
    } else if (distanceInKm <= 10) {
      return 70.0;
    } else if (distanceInKm <= 20) {
      return 100.0;
    } else if (distanceInKm <= 30) {
      return 130.0;
    } else {
      return 150.0 + ((distanceInKm - 30) * 3);
    }
  }
}



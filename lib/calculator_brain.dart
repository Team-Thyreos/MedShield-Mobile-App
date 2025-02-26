class HealthMonitor {
  double oxygenLevel;
  double temperature;
  int heartRate;
  int age;

  HealthMonitor(
      {required this.oxygenLevel,
      required this.temperature,
      required this.heartRate,
      required this.age});

  Map<String, String> analyzeHealth() {
    String condition = "";
    String remedy = "";

    // Oxygen Level Analysis
    if (oxygenLevel < 90) {
      condition +=
          "Low oxygen saturation (hypoxemia), which may indicate respiratory issues or infection.\n";
      remedy +=
          "Try deep breathing, rest, and seek medical attention if oxygen levels remain low.\n";
    } else {
      condition += "Oxygen level is normal.\n";
    }

    // Temperature Analysis
    if (temperature > 38) {
      if (age < 5) {
        condition +=
            "Fever detected, possibly due to an infection in a young child.\n";
        remedy +=
            "Ensure hydration, monitor closely, and consult a pediatrician if needed.\n";
      } else if (age >= 65) {
        condition += "Fever detected, which can be serious in older adults.\n";
        remedy +=
            "Monitor temperature, stay hydrated, and seek medical advice if persistent.\n";
      } else {
        condition += "Fever detected, possibly due to an infection.\n";
        remedy += "Take fever reducers, rest, and stay hydrated.\n";
      }
    } else {
      condition += "Temperature is within normal range.\n";
    }

    // Heart Rate Analysis
    if (heartRate > 100) {
      if (age >= 65) {
        condition +=
            "Elevated heart rate (tachycardia), which may indicate dehydration, stress, or cardiac issues.\n";
        remedy +=
            "Ensure adequate hydration, rest, and consult a doctor if persistent.\n";
      } else {
        condition +=
            "Elevated heart rate, possibly due to exertion, dehydration, or anxiety.\n";
        remedy += "Stay hydrated, relax, and monitor your heart rate.\n";
      }
    } else if (heartRate < 60) {
      if (age >= 65) {
        condition +=
            "Low heart rate (bradycardia), which could indicate heart conduction issues.\n";
        remedy +=
            "Seek medical attention if experiencing dizziness or fatigue.\n";
      } else {
        condition +=
            "Low heart rate, which may be normal in athletes but unusual otherwise.\n";
        remedy += "Monitor for dizziness and consult a doctor if concerned.\n";
      }
    } else {
      condition += "Heart rate is within normal range.\n";
    }

    return {
      "Health Assessment": condition ?? "No assessment available",
      "Recommended Actions": remedy ?? "No recommendation available",
    };
  }
}

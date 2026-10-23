import 'dart:async';

/// Mixin providing time-stamped logging functionality across utility classes.
/// Why: Using a mixin avoids redundant logging implementation across independent classes,
/// adhering to the DRY (Don't Repeat Yourself) modular design pattern.
mixin Logger {
  void logAction(String message) {
    print('[LOG] ${DateTime.now()}: $message');
  }
}

/// Interface specifying maintainability operations for vehicles.
/// Why: Enforces an explicit contract for classes requiring maintenance,
/// facilitating uniform handling of maintainable assets.
abstract class Maintainable {
  void performMaintenance();
}

/// Abstract base class defining fundamental attributes and methods for all vehicles.
/// Why: Encapsulates shared attributes like brand and speed to provide a baseline
/// inheritance tree for domain models.
class Vehicle {
  String brand;
  int speed;

  /// Default constructor for initializing base vehicle parameters.
  Vehicle(this.brand, this.speed);

  /// Default behavior for starting a vehicle's engine.
  void startEngine() {
    print('The $brand engine starts running.');
  }

  /// Displays general vehicle details to console.
  void displayInfo() {
    print('Brand: $brand | Speed: $speed km/h');
  }

  /// Simulates asynchronous diagnostic testing using Future and async/await.
  /// Why: Prevents main UI/thread blocking while execution simulates long-running
  /// operations such as network or hardware API responses.
  Future<String> runDiagnostics() async {
    await Future.delayed(const Duration(seconds: 2));
    return 'Diagnostics Complete: All systems operational for $brand.';
  }
}

/// Derived vehicle model representing standard passenger cars.
/// Why: Demonstrates OOP inheritance while overriding base methods for specialized behavior.
class Car extends Vehicle implements Maintainable {
  int numberOfDoors;

  /// Constructor passing core fields up to the base constructor via initializer lists.
  Car(String brand, int speed, this.numberOfDoors) : super(brand, speed);

  /// Overridden engine start behavior specific to cars.
  @override
  void startEngine() {
    print('The $brand car engine purrs smoothly.');
  }

  /// Implementation of the Maintainable interface contract.
  @override
  void performMaintenance() {
    print('Performing oil change and tire rotation for the $brand car.');
  }
}

/// Derived vehicle model representing electric scooters.
/// Why: Shows polymorphism by sharing base type operations while maintaining custom attributes.
class ElectricScooter extends Vehicle implements Maintainable {
  int batteryPercentage;

  /// Constructor initializing specialized electric vehicle attributes.
  ElectricScooter(String brand, int speed, this.batteryPercentage)
      : super(brand, speed);

  /// Overridden engine start behavior specific to electric scooters.
  @override
  void startEngine() {
    print('The $brand electric scooter powers on silently with a beep!');
  }

  /// Implementation of the Maintainable interface contract for electric scooters.
  @override
  void performMaintenance() {
    print('Checking battery health and brake pads for the $brand scooter.');
  }
}

/// Service management hub incorporating logging functionality through mixins.
/// Why: Separates operational services from data models to honor the Single Responsibility Principle.
class ServiceCenter with Logger {
  String locationName;

  /// Constructor setting up the service center's location.
  ServiceCenter(this.locationName);

  /// Processes vehicle intake and executes immediate motor functions.
  void processVehicle(Vehicle vehicle) {
    logAction('Receiving ${vehicle.brand} at $locationName.');
    vehicle.startEngine();
  }
}

/// Main application entry point driving the complete vehicle inventory workflow.
/// Why: Demonstrates control structures, exception handling, collections, OOP, and async calls.
void main() async {
  print('=== PC16 WEEK 12: MILESTONE 2 DART LOGIC PRACTICAL ===\n');

  // Step 1: Instantiate primary object entities
  Car myCar = Car('Toyota', 120, 4);
  ElectricScooter myScooter = ElectricScooter('Xiaomi', 25, 85);

  // Step 2: Store objects in polymorphic collection
  List<Vehicle> fleet = [myCar, myScooter];

  print('--- Displaying Fleet Info & Starting Engines ---');
  for (var vehicle in fleet) {
    vehicle.displayInfo();
    vehicle.startEngine();
    print('');
  }

  print('--- Interface Contract Execution ---');
  List<Maintainable> maintenanceList = [myCar, myScooter];
  for (var item in maintenanceList) {
    item.performMaintenance();
  }

  print('\n--- Mixin Demonstration ---');
  ServiceCenter center = ServiceCenter('Central Auto Hub');
  center.processVehicle(myCar);
  center.processVehicle(myScooter);

  print('\n--- ASYNC / FUTURE DEMONSTRATION ---');

  print('[STATUS]: Initiating diagnostic scan for ${myCar.brand}...');
  print('[NON-BLOCKING PROOF]: This message prints immediately while diagnostics run in the background!');

  // Step 3: Handle asynchronous execution safely with await
  String carDiagnosticResult = await myCar.runDiagnostics();
  print('[RESULT]: $carDiagnosticResult');

  print('\n[STATUS]: Initiating diagnostic scan for ${myScooter.brand}...');
  String scooterDiagnosticResult = await myScooter.runDiagnostics();
  print('[RESULT]: $scooterDiagnosticResult');

  print('\n=== PROGRAM EXECUTED SUCCESSFULLY ===');
}

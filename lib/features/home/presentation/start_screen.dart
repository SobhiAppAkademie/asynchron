import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../domain/car.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  final List<Car> cars = [];

  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadAllData();
  }

  void simulateData() async {
    print("Hole Daten vom Server google.com");
    print("Frage nach Benutzer an...");
    await Future.delayed(const Duration(seconds: 2));
    print("Benutzer gefunden! Hallo Max01");
    print("Füge Standort hinzu...");
    await Future.delayed(const Duration(seconds: 4));
    print("Sie sind eingeloggt!");
  }

  void loadAllData() async {
    print("Getting VW Cars");
    List<Car> vwCars = await getVWCars();
    setState(() {
      loading = false;
      cars.addAll(vwCars);
    });

    print("Getting Audi Cars");
    List<Car> audiCars = await getAudiCars();
    setState(() {
      cars.addAll(audiCars);
    });

    print("Getting BMW Cars");
    List<Car> bmwCars = await getBMWCars();

    setState(() {
      cars.addAll(bmwCars);
    });
    print("Setted Cars");
  }

  Future<List<Car>> getBMWCars() async {
    await Future.delayed(const Duration(seconds: 3));
    return [Car(model: "BMW", name: "M4", ps: "500PS")];
  }

  Future<List<Car>> getAudiCars() async {
    return Future.delayed(const Duration(seconds: 5),
        () => [Car(model: "Audi", name: "R8", ps: "500PS")]);
  }

  Future<List<Car>> getVWCars() async {
    List<Car> sportCars = await getVWSportCars();
    List<Car> normalCars = await getVWNormalCars();
    return [...sportCars, ...normalCars];
  }

  // Simulieren API Request
  Future<List<Car>> getVWSportCars() async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      Car(model: "VW", name: "GOLF R", ps: "300PS"),
      Car(model: "VW", name: "GOLF GTI", ps: "250PS"),
    ];
  }

  // Simulieren API Request
  Future<List<Car>> getVWNormalCars() async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      Car(model: "VW", name: "GOLF 7", ps: "150PS"),
      Car(model: "VW", name: "GOLF 8", ps: "150PS"),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Dein Profil",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: loading
            ? const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Daten werden geladen...",
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 10),
                    CupertinoActivityIndicator(),
                  ],
                ),
              )
            : ListView.separated(
                separatorBuilder: (_, __) => const SizedBox(height: 15),
                itemCount: cars.length,
                itemBuilder: (context, index) {
                  final car = cars[index];
                  return Card(
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      leading: Icon(Icons.directions_car,
                          color: Theme.of(context).primaryColor),
                      title: Text(
                        car.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      subtitle: Text(
                        car.model,
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      trailing: Text(
                        car.ps,
                        style: const TextStyle(
                            fontSize: 15,
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}

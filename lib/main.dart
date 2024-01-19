import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class Clothes {
  String name;
  int price;

  Clothes(this.name, this.price);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Clothes'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Clothes> clothesList = [Clothes("T-shirt", 200), Clothes("Pants", 150)];
  int _counter = 0;
  final nameController = TextEditingController();
  final priceController = TextEditingController();

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _addClothes(name, price) {
    setState(() {
      clothesList.add(Clothes(name, price));
    });
  }

  void _deleteClothes(index) {
    setState(() {
      clothesList.removeAt(index);
    });
  }

  void _editClothes(index, name, price) {
    setState(() {
      Clothes clothes = clothesList[index];
      clothes.name = name;
      clothes.price = price;
    });
  }

  void setControllers(name, price) {
    nameController.text = name;
    priceController.text = price;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: ListView.builder(
          itemCount: clothesList.length,
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.all(10),
              child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        "${clothesList[index].name} - ${clothesList[index].price}"),
                    Container(
                      child: Row(children: [
                        Container(
                          margin: const EdgeInsets.only(right: 10),
                          child: ElevatedButton(
                            onPressed: () => {
                              setControllers(clothesList[index].name,
                                  clothesList[index].price.toString()),
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Dialog(
                                      child: Container(
                                        padding: EdgeInsets.all(20),
                                        height: 400,
                                        width: 300,
                                        child: Column(children: [
                                          Text(
                                              "Enter name and price to edit a clothes"),
                                          Container(
                                              margin: EdgeInsets.symmetric(
                                                  vertical: 20),
                                              child: Column(
                                                children: [
                                                  Text("Name"),
                                                  TextField(
                                                      controller:
                                                          nameController)
                                                ],
                                              )),
                                          Container(
                                              margin: EdgeInsets.symmetric(
                                                  vertical: 20),
                                              child: Column(
                                                children: [
                                                  Text("Price"),
                                                  TextField(
                                                      controller:
                                                          priceController)
                                                ],
                                              )),
                                          ElevatedButton(
                                              onPressed: () => _editClothes(
                                                  index,
                                                  nameController.text,
                                                  int.parse(
                                                      priceController.text)),
                                              child: Text("Save"))
                                        ]),
                                      ),
                                    );
                                  })
                            },
                            child: const Text("Edit"),
                            style: const ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll(Colors.green),
                                foregroundColor:
                                    MaterialStatePropertyAll(Colors.red)),
                          ),
                        ),
                        Container(
                            child: ElevatedButton(
                                onPressed: () => _deleteClothes(index),
                                style: const ButtonStyle(
                                    backgroundColor:
                                        MaterialStatePropertyAll(Colors.green),
                                    foregroundColor:
                                        MaterialStatePropertyAll(Colors.red)),
                                child: const Text("Delete")))
                      ]),
                    )
                  ]),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog(
            context: context,
            builder: (BuildContext context) {
              return Dialog(
                child: Container(
                  padding: EdgeInsets.all(20),
                  height: 400,
                  width: 300,
                  child: Column(children: [
                    Text("Enter name and price to add a new clothes"),
                    Container(
                        margin: EdgeInsets.symmetric(vertical: 20),
                        child: Column(
                          children: [
                            Text("Name"),
                            TextField(controller: nameController)
                          ],
                        )),
                    Container(
                        margin: EdgeInsets.symmetric(vertical: 20),
                        child: Column(
                          children: [
                            Text("Price"),
                            TextField(controller: priceController)
                          ],
                        )),
                    ElevatedButton(
                        onPressed: () => _addClothes(nameController.text,
                            int.parse(priceController.text)),
                        child: Text("Add"))
                  ]),
                ),
              );
            }),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

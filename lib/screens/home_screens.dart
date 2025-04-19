import 'package:flutter/material.dart';

class Car {
  final String id;
  final String marca;
  final String modelo;
  final int year;
  final double precio;
  final int kilometraje;
  final String tipoMotor;
  final String garantia;
  final String imageUrl;

  Car({
    required this.id,
    required this.marca,
    required this.modelo,
    required this.year,
    required this.precio,
    required this.kilometraje,
    required this.tipoMotor,
    required this.garantia,
    required this.imageUrl,
  });
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Car> _cars = [
    Car(
      id: '1',
      marca: 'Toyota',
      modelo: 'Corolla',
      year: 2022,
      precio: 280000,
      kilometraje: 15000,
      tipoMotor: '2.0L 4 cilindros',
      garantia: '3 years/100,000 km',
      imageUrl:
          'https://s3.amazonaws.com/di-enrollment-api/toyota/models/2020/Corolla/colors/barcelona_red_metallic.png',
    ),
    Car(
      id: '2',
      marca: 'Honda',
      modelo: 'Civic',
      year: 2021,
      precio: 250000,
      kilometraje: 20000,
      tipoMotor: '1.5L Turbo',
      garantia: '3 years/100,000 km',
      imageUrl:
          'https://acnews.blob.core.windows.net/imgnews/medium/NAZ_b896903ed5984615b7cc4712755f3cdc.jpg',
    ),
    Car(
      id: '3',
      marca: 'Ford',
      modelo: 'Focus',
      year: 2021,
      precio: 220000,
      kilometraje: 10000,
      tipoMotor: 'Hybrid',
      garantia: '5 years/100,000 km',
      imageUrl:
          'https://cdn.wheel-size.com/thumbs/61/46/6146c8f25ef7af778100e318f7ee1f5c.jpg',
    ),
    Car(
      id: '4',
      marca: 'Chevrolet',
      modelo: 'Malibu',
      year: 2018,
      precio: 170000,
      kilometraje: 30000,
      tipoMotor: 'Petrol',
      garantia: '3 years/60,000 km',
      imageUrl:'https://file.kelleybluebookimages.com/kbb/base/evox/CP/10952/2018-Chevrolet-Malibu-front_10952_032_1820x750_GAN_cropped.png',
    ),
    Car(
      id: '5',
      marca: 'Nissan',
      modelo: 'Altima',
      year: 2022,
      precio: 250000,
      kilometraje: 5000,
      tipoMotor: 'Electric',
      garantia: '8 years/100,000 km',
      imageUrl:'https://di-sitebuilder-assets.dealerinspire.com/Nissan/MLP/Altima/2022/Colors/Vehicles/Sunset+Drift+ChromaFlair.png',
    ),
  ];

  void _addNewCar(Car newCar) {
    setState(() {
      _cars.add(newCar);
    });
  }

  void _navigateToCarDetail(BuildContext context, Car car) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CarDetailScreen(car: car),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Autos Seminuevos', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.orange,
      ),
      body: ListView.builder(
        itemCount: _cars.length,
        itemBuilder: (context, index) => _buildCarCard(_cars[index]),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () => _showAddCarForm(context),
      ),
    );
  }

  Widget _buildCarCard(Car car) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: InkWell(
        onTap: () => _navigateToCarDetail(context, car),
        borderRadius: BorderRadius.circular(15),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: SizedBox(
            height: 140,
            child: Row(
              children: [
                Container(
                  width: 120,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                    ),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(car.imageUrl),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${car.marca} ${car.modelo}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          height: 2,
                          width: 50,
                          color: Colors.orange,
                        ),
                        const SizedBox(height: 12),
                        Text('year: ${car.year} | ${car.kilometraje} km'),
                        Text(
                          '\$${car.precio.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showAddCarForm(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          height: 650,
          color: Colors.white,
          child: CarForm(onSubmit: _addNewCar),
        ),
      ),
    );
  }
}

class CarForm extends StatefulWidget {
  final Function(Car) onSubmit;

  const CarForm({super.key, required this.onSubmit});

  @override
  State<CarForm> createState() => _CarFormState();
}

class _CarFormState extends State<CarForm> {
  final _formKey = GlobalKey<FormState>();
  final _marcaController = TextEditingController();
  final _modeloController = TextEditingController();
  final _yearController = TextEditingController();
  final _precioController = TextEditingController();
  final _kmController = TextEditingController();
  final _motorController = TextEditingController();
  final _garantiaController = TextEditingController();
  final _imageUrlController = TextEditingController();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final newCar = Car(
        id: DateTime.now().toString(),
        marca: _marcaController.text,
        modelo: _modeloController.text,
        year: int.parse(_yearController.text),
        precio: double.parse(_precioController.text),
        kilometraje: int.parse(_kmController.text),
        tipoMotor: _motorController.text,
        garantia: _garantiaController.text,
        imageUrl: _imageUrlController.text,
      );

      widget.onSubmit(newCar);
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _marcaController.dispose();
    _modeloController.dispose();
    _yearController.dispose();
    _precioController.dispose();
    _kmController.dispose();
    _motorController.dispose();
    _garantiaController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                controller: _marcaController,
                decoration: const InputDecoration(labelText: 'Marca'),
                validator: (value) =>
                    value!.isEmpty ? 'Ingrese la marca' : null,
              ),
              TextFormField(
                controller: _modeloController,
                decoration: const InputDecoration(labelText: 'Modelo'),
                validator: (value) =>
                    value!.isEmpty ? 'Ingrese el modelo' : null,
              ),
              TextFormField(
                controller: _yearController,
                decoration: const InputDecoration(labelText: 'year'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) return 'Ingrese el year';
                  if (int.tryParse(value) == null) return 'year inválido';
                  return null;
                },
              ),
              TextFormField(
                controller: _precioController,
                decoration: const InputDecoration(labelText: 'Precio'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) return 'Ingrese el precio';
                  if (double.tryParse(value) == null) return 'Precio inválido';
                  return null;
                },
              ),
              TextFormField(
                controller: _kmController,
                decoration: const InputDecoration(labelText: 'Kilometraje'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) return 'Ingrese el kilometraje';
                  if (int.tryParse(value) == null) return 'Valor inválido';
                  return null;
                },
              ),
              TextFormField(
                controller: _motorController,
                decoration: const InputDecoration(labelText: 'Tipo de Motor'),
                validator: (value) =>
                    value!.isEmpty ? 'Ingrese el tipo de motor' : null,
              ),
              TextFormField(
                controller: _garantiaController,
                decoration: const InputDecoration(labelText: 'Garantía'),
                validator: (value) =>
                    value!.isEmpty ? 'Ingrese la garantía' : null,
              ),
              TextFormField(
                controller: _imageUrlController,
                decoration: const InputDecoration(labelText: 'URL de la Imagen'),
                validator: (value) =>
                    value!.isEmpty ? 'Ingrese la URL de la imagen' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text('Guardar Auto'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CarDetailScreen extends StatelessWidget {
  final Car car;

  const CarDetailScreen({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${car.marca} ${car.modelo}'),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(car.imageUrl),
                ),
              ),
            ),
            const SizedBox(height: 20),
            _buildDetailCard(
              title: 'Información Básica',
              items: [
                _buildDetailItem('Marca', car.marca),
                _buildDetailItem('Modelo', car.modelo),
                _buildDetailItem('year', car.year.toString()),
                _buildDetailItem('Precio', '\$${car.precio.toStringAsFixed(2)}'),
              ],
            ),
            const SizedBox(height: 16),
            _buildDetailCard(
              title: 'Especificaciones Técnicas',
              items: [
                _buildDetailItem('Kilometraje', '${car.kilometraje} km'),
                _buildDetailItem('Tipo de Motor', car.tipoMotor),
                _buildDetailItem('Garantía', car.garantia),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Contactar Vendedor'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailCard({required String title, required List<Widget> items}) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.orange,
              ),
            ),
            const SizedBox(height: 10),
            ...items,
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
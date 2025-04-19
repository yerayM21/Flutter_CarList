import 'package:flutter/material.dart';
import '../models/car.dart';

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagen principal
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
            
            // Sección de información básica
            _buildInfoSection(
              title: 'Información Básica',
              items: [
                _buildInfoItem('Marca', car.marca),
                _buildInfoItem('Modelo', car.modelo),
                _buildInfoItem('Año', car.year.toString()),
                _buildInfoItem('Precio', '\$${car.precio.toStringAsFixed(2)}'),
              ],
            ),
            
            const SizedBox(height: 20),
            
            // Sección de especificaciones técnicas
            _buildInfoSection(
              title: 'Especificaciones Técnicas',
              items: [
                _buildInfoItem('Kilometraje', '${car.kilometraje} km'),
                _buildInfoItem('Tipo de Motor', car.tipoMotor),
                _buildInfoItem('Garantía', car.garantia),
              ],
            ),
            
            const SizedBox(height: 20),
            
            // Botón de contacto
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Acción para contactar al vendedor
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
                child: const Text('Contactar Vendedor', style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoSection({required String title, required List<Widget> items}) {
    return Column(
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
        Card(
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(children: items),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoItem(String label, String value) {
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
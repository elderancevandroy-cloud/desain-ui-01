import 'package:flutter/material.dart';
import '../models/service_model.dart';

class ServiceGrid extends StatelessWidget {
  final List<ServiceModel> services;

  const ServiceGrid({super.key, required this.services});

  IconData _getIcon(String iconName) {
    switch (iconName) {
      case 'microscope':
        return Icons.biotech;
      case 'test_tube':
      case 'test_tube2':
        return Icons.science;
      case 'iv_bag':
        return Icons.local_hospital;
      case 'calendar':
        return Icons.calendar_today;
      case 'chat':
        return Icons.chat_bubble;
      case 'book':
        return Icons.menu_book;
      case 'grid':
        return Icons.grid_view;
      default:
        return Icons.medical_services;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 8,
        mainAxisSpacing: 12,
        childAspectRatio: 0.8,
      ),
      itemCount: services.length,
      itemBuilder: (context, index) {
        final service = services[index];
        return GestureDetector(
          onTap: () => Navigator.pushNamed(context, service.route, arguments: service),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: const Color(0xFF0077B6),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  _getIcon(service.icon),
                  color: Colors.white,
                  size: 28,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                service.name,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 10, height: 1.2),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        );
      },
    );
  }
}

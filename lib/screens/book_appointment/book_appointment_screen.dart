import 'package:flutter/material.dart';
import '../../data/mock_data.dart';
import '../../models/service_model.dart';
import 'booking_confirmation_screen.dart';

class BookAppointmentScreen extends StatefulWidget {
  final VoidCallback? onBookingConfirmed;

  const BookAppointmentScreen({super.key, this.onBookingConfirmed});

  @override
  State<BookAppointmentScreen> createState() => _BookAppointmentScreenState();
}

class _BookAppointmentScreenState extends State<BookAppointmentScreen> {
  int _currentStep = 0;
  List<ServiceModel> _services = [];
  List<String> _slots = [];

  ServiceModel? _selectedService;
  DateTime? _selectedDate;
  String? _selectedSlot;
  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final services = await MockData.loadServices();
    final slots = await MockData.loadAppointmentSlots();
    if (mounted) {
      setState(() {
        _services = services
            .where((s) => s.route.startsWith('/service/'))
            .toList();
        _slots = slots;
      });
    }
  }

  bool get _canProceed {
    switch (_currentStep) {
      case 0:
        return _selectedService != null;
      case 1:
        return _selectedDate != null;
      case 2:
        return _selectedSlot != null;
      case 3:
        return _nameController.text.trim().isNotEmpty;
      default:
        return false;
    }
  }

  void _next() {
    if (_currentStep < 3) {
      setState(() => _currentStep++);
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => BookingConfirmationScreen(
            serviceName: _selectedService!.name.replaceAll('\n', ' '),
            date:
                '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
            timeSlot: _selectedSlot!,
            userName: _nameController.text.trim(),
            onBookingConfirmed: widget.onBookingConfirmed,
          ),
        ),
      );
    }
  }

  void _resetForm() {
    setState(() {
      _currentStep = 0;
      _selectedService = null;
      _selectedDate = null;
      _selectedSlot = null;
      _nameController.clear();
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Appointment'),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF0077B6),
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          _StepIndicator(currentStep: _currentStep),
          Expanded(
            child: IndexedStack(
              index: _currentStep,
              children: [
                _Step1Services(
                  services: _services,
                  selected: _selectedService,
                  onSelect: (s) => setState(() => _selectedService = s),
                ),
                _Step2Date(
                  selected: _selectedDate ?? DateTime.now(),
                  onSelect: (d) => setState(() => _selectedDate = d),
                ),
                _Step3Slots(
                  slots: _slots,
                  selected: _selectedSlot,
                  onSelect: (s) => setState(() => _selectedSlot = s),
                ),
                _Step4Name(
                  controller: _nameController,
                  onChanged: () => setState(() {}),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                if (_currentStep > 0)
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => setState(() => _currentStep--),
                      child: const Text('Kembali'),
                    ),
                  ),
                if (_currentStep > 0) const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _canProceed ? _next : null,
                    child: Text(
                        _currentStep == 3 ? 'Lihat Ringkasan' : 'Lanjut'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Step Indicator ───────────────────────────────────────────────────────────

class _StepIndicator extends StatelessWidget {
  final int currentStep;
  const _StepIndicator({required this.currentStep});

  @override
  Widget build(BuildContext context) {
    final steps = ['Layanan', 'Tanggal', 'Waktu', 'Nama'];
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Row(
        children: List.generate(steps.length, (i) {
          final isActive = i == currentStep;
          final isDone = i < currentStep;
          return Expanded(
            child: Row(
              children: [
                Column(
                  children: [
                    CircleAvatar(
                      radius: 14,
                      backgroundColor: isDone || isActive
                          ? const Color(0xFF0077B6)
                          : Colors.grey.shade300,
                      child: isDone
                          ? const Icon(Icons.check,
                              color: Colors.white, size: 14)
                          : Text(
                              '${i + 1}',
                              style: TextStyle(
                                color: isActive ? Colors.white : Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      steps[i],
                      style: TextStyle(
                        fontSize: 10,
                        color: isActive
                            ? const Color(0xFF0077B6)
                            : Colors.grey,
                        fontWeight: isActive
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
                if (i < steps.length - 1)
                  Expanded(
                    child: Container(
                      height: 2,
                      margin: const EdgeInsets.only(bottom: 20),
                      color: isDone
                          ? const Color(0xFF0077B6)
                          : Colors.grey.shade300,
                    ),
                  ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

// ─── Step 1: Pilih Layanan ────────────────────────────────────────────────────

class _Step1Services extends StatelessWidget {
  final List<ServiceModel> services;
  final ServiceModel? selected;
  final ValueChanged<ServiceModel> onSelect;

  const _Step1Services({
    required this.services,
    required this.selected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    if (services.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: services.length,
      itemBuilder: (context, index) {
        final s = services[index];
        final isSelected = selected?.id == s.id;
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(
              color: isSelected
                  ? const Color(0xFF0077B6)
                  : Colors.transparent,
              width: 2,
            ),
          ),
          child: ListTile(
            onTap: () => onSelect(s),
            leading: CircleAvatar(
              backgroundColor: isSelected
                  ? const Color(0xFF0077B6)
                  : Colors.grey.shade200,
              child: Icon(
                Icons.medical_services,
                color: isSelected ? Colors.white : Colors.grey,
              ),
            ),
            title: Text(s.name.replaceAll('\n', ' ')),
            subtitle: s.price.isNotEmpty ? Text(s.price) : null,
            trailing: isSelected
                ? const Icon(Icons.check_circle,
                    color: Color(0xFF0077B6))
                : null,
          ),
        );
      },
    );
  }
}

// ─── Step 2: Pilih Tanggal ────────────────────────────────────────────────────

class _Step2Date extends StatelessWidget {
  final DateTime selected;
  final ValueChanged<DateTime> onSelect;

  const _Step2Date({required this.selected, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: CalendarDatePicker(
        initialDate: selected,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 90)),
        onDateChanged: onSelect,
      ),
    );
  }
}

// ─── Step 3: Pilih Slot Waktu ─────────────────────────────────────────────────

class _Step3Slots extends StatelessWidget {
  final List<String> slots;
  final String? selected;
  final ValueChanged<String> onSelect;

  const _Step3Slots({
    required this.slots,
    required this.selected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Pilih Slot Waktu',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: slots.map((slot) {
              final isSelected = selected == slot;
              return GestureDetector(
                onTap: () => onSelect(slot),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xFF0077B6)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isSelected
                          ? const Color(0xFF0077B6)
                          : Colors.grey.shade300,
                    ),
                  ),
                  child: Text(
                    slot,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black87,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

// ─── Step 4: Isi Nama ─────────────────────────────────────────────────────────

class _Step4Name extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onChanged;

  const _Step4Name({required this.controller, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Nama Lengkap',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: controller,
            onChanged: (_) => onChanged(),
            decoration: InputDecoration(
              hintText: 'Masukkan nama lengkap Anda',
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8)),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide:
                    const BorderSide(color: Color(0xFF0077B6)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

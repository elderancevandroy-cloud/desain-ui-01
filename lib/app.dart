import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/appointment_provider.dart';
import 'providers/chat_provider.dart';
import 'screens/home/home_screen.dart';
import 'screens/messages/messages_screen.dart';
import 'screens/book_appointment/book_appointment_screen.dart';
import 'screens/health/health_screen.dart';
import 'screens/service_detail/service_detail_screen.dart';
import 'screens/chat/chat_screen.dart';

class BSIHealthApp extends StatelessWidget {
  const BSIHealthApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppointmentProvider()),
        ChangeNotifierProvider(create: (_) => ChatProvider()),
      ],
      child: MaterialApp(
        title: 'BSI Health App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: const Color(0xFF0077B6),
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF0077B6),
            primary: const Color(0xFF0077B6),
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            foregroundColor: Color(0xFF0077B6),
            elevation: 0,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0077B6),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
        home: const MainScaffold(),
        onGenerateRoute: (settings) {
          // Handle /service/:id routes
          if (settings.name != null && settings.name!.startsWith('/service/')) {
            return MaterialPageRoute(
              settings: settings,
              builder: (_) => const ServiceDetailScreen(),
            );
          }
          return null;
        },
        routes: {
          '/home': (context) => const MainScaffold(),
          '/book-appointment': (context) => const BookAppointmentScreen(),
          '/chat': (context) => const ChatScreen(),
        },
      ),
    );
  }
}

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _currentIndex = 0;

  late final List<Widget> _screens = [
    const HomeScreen(),
    const MessagesScreen(),
    BookAppointmentScreen(
      onBookingConfirmed: () => setState(() => _currentIndex = 3),
    ),
    const HealthScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF0077B6),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Messages'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Appointments'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Health'),
        ],
      ),
    );
  }
}

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tuni/bloc/auth_bloc/auth_repository.dart';
import 'package:tuni/bloc/favorite_bloc/favorite_bloc.dart';
import 'package:tuni/bloc/home_bloc/size_bloc.dart';
import 'package:tuni/bloc/personal_details_bloc/personal_detail_bloc.dart';
import 'package:tuni/bloc/produtbloc/bloc/product_bloc_bloc.dart';
import 'package:tuni/bloc/user_profile_bloc/user_profile_bloc.dart';
import 'package:tuni/firebase_options.dart';
import 'package:tuni/provider/category_provider.dart';
import 'package:tuni/provider/product_provider.dart';
import 'package:tuni/screens/bottom_nav/bottom_navigation_bar/routes/generated_routes.dart';
import 'package:tuni/screens/splash_screen/splash_screen.dart';

import 'bloc/address_bloc/address_bloc.dart';
import 'bloc/auth_bloc/auth_bloc.dart';
import 'bloc/bnb_bloc/bottom_nav_bloc.dart';
import 'bloc/cart_bloc/cart_bloc.dart';
import 'bloc/home_bloc/home_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        ChangeNotifierProvider<ProdcuctProvider>(
          create: (_) => ProdcuctProvider(),
        ),
        BlocProvider<AuthBloc>(
          create: (_) => AuthBloc(),
        ),
        BlocProvider<BottomNavBloc>(
          create: (_) => BottomNavBloc(),
        ),
        BlocProvider<HomeBloc>(
          create: (_) => HomeBloc(),
        ),
        BlocProvider<CartBloc>(
          create: (_) => CartBloc(),
        ),
        BlocProvider<AddressBloc>(
          create: (_) => AddressBloc(),
        ),
        BlocProvider<FavoriteBloc>(
          create: (_) => FavoriteBloc(),
        ),
        BlocProvider<PersonalDetailBloc>(
          create: (_) => PersonalDetailBloc(),
        ),
        BlocProvider<UserProfileBloc>(
          create: (_) => UserProfileBloc(),
        ),
        BlocProvider<SizeBloc>(
          create: (_) => SizeBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'TUNI',
        theme: ThemeData(
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(
                Colors.white,
              ), // Text color
              backgroundColor: MaterialStateProperty.all<Color>(
                Colors.blue,
              ), // Button background color
              // Add more button styles as needed
            ),
          ),
          primaryColor: Colors.blue,
          appBarTheme: const AppBarTheme(
            titleTextStyle: TextStyle(
              color: Colors.black,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
            centerTitle: true,
            color: Colors.white,
            elevation: 0,
          ),
          scaffoldBackgroundColor: Colors.white,
        ),
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
        initialRoute: '/',
        onGenerateRoute: RouteGenerator().generateRoute,
      ),
    );
    // );
  }
}

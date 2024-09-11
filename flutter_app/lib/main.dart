import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logistics/features/common/repositories/api_repository.dart';
import 'package:logistics/features/inventory/repository/inventory_repository.dart';
import 'package:logistics/features/user/bloc/user/user_bloc.dart';
import 'package:logistics/features/user/bloc/user/user_event.dart';
import 'package:logistics/features/user/repository/role_repository.dart';
import 'package:logistics/features/user/repository/user_repository.dart';
import 'package:logistics/features/user/screens/user_form_screen.dart';
import 'package:logistics/features/user/screens/user_list_screen.dart';
import 'package:logistics/screen/login_screen.dart';
import 'package:logistics/screen/splash_screen.dart';
// inventory
import 'package:logistics/features/inventory/bloc/inventory_bloc.dart';
import 'package:logistics/features/inventory/bloc/inventory_event.dart';
import 'package:logistics/features/inventory/screens/inventory_list_screen.dart';
import 'package:logistics/features/inventory/screens/inventory_record_screen.dart';

// receive_order
import 'package:logistics/features/receive_order/bloc/receive_order_bloc.dart';
import 'package:logistics/features/receive_order/bloc/receive_order_event.dart';
import 'package:logistics/features/receive_order/screens/receive_order_list_screen.dart';
import 'package:logistics/features/receive_order/repository/receive_order_repository.dart';
// supplier
import 'package:logistics/features/supplier/bloc/supplier_bloc.dart';
import 'package:logistics/features/supplier/bloc/supplier_event.dart';
import 'package:logistics/features/supplier/screens/supplier_form_screen.dart';
import 'package:logistics/features/supplier/screens/supplier_list_screen.dart';
import 'package:logistics/features/supplier/repository/supplier_repository.dart';


Future<void> main() async {
  try {
    await dotenv.load(fileName: '.env');
  } catch (e) {
    print(e);
  }
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ApiRepository>(create: (_) => ApiRepository()),
        Provider<UserRepository>(
          create: (context) => UserRepository(apiRepository: context.read<ApiRepository>()),
        ),
        Provider<RoleRepository>(
          create: (context) => RoleRepository(apiRepository: context.read<ApiRepository>()),
        ),
        Provider<SupplierRepository>(
          create: (context) => SupplierRepository(apiRepository: context.read<ApiRepository>()),
        ),
        Provider<ReceiveOrderRepository>(
          create: (context) => ReceiveOrderRepository(apiRepository: context.read<ApiRepository>()),
        ),
        Provider<InventoryRepository>(
          create: (context) => InventoryRepository(apiRepository: context.read<ApiRepository>()),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: '/splash',
        routes: {
          '/' : (context) => MyHomePage(),
          '/login' : (context) => LoginScreen(),
          '/splash' : (context) => SplashScreen(),
        },
      ),
    );
  }
    
}

class MyHomePage extends StatelessWidget  {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SupplierBloc(context.read<SupplierRepository>())..add(LoadSuppliers()),
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
              title: Text('受発注システム'),
          ),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  child: Text('一覧'),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                ),
                ListTile(
                  title: Text('受注一覧'),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) =>BlocProvider(
                        create: (context) => ReceiveOrderBloc(context.read<ReceiveOrderRepository>())..add(LoadReceiveOrder()),
                        child: ReceiveOrderListScreen(receiveOrderRepository: context.read<ReceiveOrderRepository>()),
                        ) ,
                    ));
                  },
                ),
                ListTile(
                  title: Text('在庫一覧'),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) =>BlocProvider(
                        create: (context) => InventoryBloc(context.read<InventoryRepository>())..add(LoadInventory()),
                        child: InventoryListScreen(inventoryRepository:context.read<InventoryRepository>()),
                        ) ,
                    ));
                  },
                ),
                ListTile(
                  title: Text('入出庫記録管理画面'),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) =>BlocProvider(
                        create: (context) => InventoryBloc(context.read<InventoryRepository>())..add(LoadInventory()),
                        child: InventoryRecordScreen(),
                        ) ,
                    ));
                  },
                ),
                ListTile(
                  title: Text('サプライヤ一覧'),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) =>BlocProvider(
                        create: (context) => SupplierBloc(context.read<SupplierRepository>())..add(LoadSuppliers()),
                        child: SupplierListScreen(),
                        ) ,
                    ));
                  },
                ),
                ListTile(
                  title: Text('サプライヤ登録'),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) =>BlocProvider(
                        create: (context) => SupplierBloc(context.read<SupplierRepository>())..add(LoadSuppliers()),
                        child: SupplierFormScreen(),
                        ) ,
                    ));
                  },
                ),
                ListTile(
                  title: Text('ユーザー管理システム'),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) =>BlocProvider(
                        create: (context) => UserBloc(userRepository:context.read<UserRepository>())..add(LoadUsers()),
                        child: UserFormScreen(),
                        ) ,
                    ));
                  },
                ),
                ListTile(
                  title: Text('ユーザー一覧'),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) =>BlocProvider(
                        create: (context) => UserBloc(userRepository:context.read<UserRepository>())..add(LoadUsers()),
                        child: UserListScreen(),
                        ) ,
                    ));
                  },
                ),                
              ],
            ),
          ),
          body: Center(
            child: Text('Main Content Area'),
          ),
        ),
      )
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pet_project/application/general/theme_cubit.dart';
import 'package:pet_project/presentation/theme/my_theme.dart';
import 'package:pet_project/presentation/tristate_checkbox.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isSwitchActive = true;
  TristateEnum _isTristateCheckActive = TristateEnum.chosen;
  bool _isCheckActive = true;
  int? _radioGroupValue = 1;
  int _selectedDestination = 0;

  ThemeData get _theme => Theme.of(context);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: PlatformLayoutWrapper(
        appBar: _buildAppBar(),
        drawer: _buildDrawer(),
        body: _buildBody(),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {},
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Text('Main page'),
      actions: [
        BlocBuilder<ThemeCubit, MyTheme>(
          builder: (context, snapshot) {
            final themeCubit = BlocProvider.of<ThemeCubit>(context);
            return Switch(
              value: snapshot.isDark,
              onChanged: (_) => themeCubit.setTheme(),
            );
          },
        ),
      ],
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            height: 256.0,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 16.0),
            child: Text(
              'Header',
              style: _theme.textTheme.headline6,
            ),
          ),
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text('Item 1'),
            selected: _selectedDestination == 0,
            onTap: () => _selectDestination(0),
          ),
          ListTile(
            leading: Icon(Icons.delete),
            title: Text('Item 2'),
            selected: _selectedDestination == 1,
            onTap: () => _selectDestination(1),
          ),
          ListTile(
            leading: Icon(Icons.label),
            title: Text('Item 3'),
            selected: _selectedDestination == 2,
            onTap: () => _selectDestination(2),
          ),
        ],
      ),
    );
  }

  void _selectDestination(int index) {
    setState(() {
      _selectedDestination = index;
    });
    Navigator.pop(context);
  }

  Widget _buildBody() {
    return IndexedStack(
      index: _selectedDestination,
      children: [
        _buildContent(),
        Center(child: Text('second')),
        Center(child: Text('third')),
      ],
    );
  }

  Widget _buildContent() {
    final textTheme = _theme.textTheme;
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        Text('hl 1', style: textTheme.headline1),
        Text('hl 2', style: textTheme.headline2),
        Text('hl 3', style: textTheme.headline3),
        Text('hl 4', style: textTheme.headline4),
        Text('hl 5', style: textTheme.headline5),
        Text('hl 6', style: textTheme.headline6),
        Text('subtitle 1', style: textTheme.subtitle1),
        Text('bodyText 1', style: textTheme.bodyText1),
        Text('bodyText 2', style: textTheme.bodyText2),
        Text('caption', style: textTheme.caption),
        Text('button', style: textTheme.button),
        Text('subtitle 2', style: textTheme.subtitle2),
        Text('overline', style: textTheme.overline),
        Divider(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(hintText: 'Text'),
              ),
            ],
          ),
        ),
        Divider(),
        Row(
          children: [
            Switch(
              value: _isSwitchActive,
              onChanged: (value) => setState(() => _isSwitchActive = value),
            ),
            TristateCheckbox(
              value: _isTristateCheckActive,
              onChanged: (value) => setState(() => _isTristateCheckActive = value),
            ),
          ],
        ),
        Row(
          children: [
            Radio(
              value: 1,
              groupValue: _radioGroupValue,
              onChanged: (dynamic value) =>
                  setState(() => _radioGroupValue = value),
            ),
            Radio(
              value: 2,
              groupValue: _radioGroupValue,
              onChanged: (dynamic value) =>
                  setState(() => _radioGroupValue = value),
            ),
            Radio(
              value: 3,
              groupValue: _radioGroupValue,
              onChanged: (dynamic value) =>
                  setState(() => _radioGroupValue = value),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(child: Text('Txt btn : active'), onPressed: () {}),
            TextButton(child: Text('Txt btn : inactive'), onPressed: null),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              child: Text('El btn : active'),
              onPressed: () {},
            ),
            ElevatedButton(
              child: Text('El btn : inactive'),
              onPressed: null,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            OutlinedButton(
              child: Text('Out btn '),
              onPressed: () {},
            ),
            OutlinedButton(
              child: Text('Out btn'),
              onPressed: null,
            ),
          ],
        ),
        Center(
          child: TextButton(
            child: Text('Timer Picker'),
            onPressed: () async {
              await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              );
            },
          ),
        ),
        Center(
          child: TextButton(
            child: Text('Date Picker'),
            onPressed: () async {
              await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2017, 1),
                lastDate: DateTime(2022, 7),
              );
            },
          ),
        ),
        SizedBox(height: 80.0),
      ],
    );
  }
}

class PlatformLayoutWrapper extends StatelessWidget {
  final PreferredSizeWidget appBar;
  final Widget drawer;
  final Widget body;
  final Widget floatingActionButton;

  const PlatformLayoutWrapper({
    Key? key,
    required this.appBar,
    required this.drawer,
    required this.body,
    required this.floatingActionButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).size.width < 600.0) {
      return Scaffold(
        appBar: appBar,
        drawer: drawer,
        body: body,
        floatingActionButton: floatingActionButton,
      );
    } else {
      return Row(
        children: [
          drawer,
          VerticalDivider(width: 1),
          Expanded(
            child: Scaffold(
              appBar: appBar,
              body: body,
              floatingActionButton: floatingActionButton,
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.startTop,
            ),
          ),
        ],
      );
    }
  }
}

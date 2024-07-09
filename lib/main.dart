import 'package:flutter/material.dart';
import 'package:galaxy_food/features/widgets/image_picker.dart';
import 'package:galaxy_food/galaxy_theme.dart';

main(){
  runApp(const App());
}

class App extends StatefulWidget{

  const App({super.key});

  @override
  State<StatefulWidget> createState() => AppState();
}

class AppState extends State<App>{

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.dark,
      theme: GalaxyFoodTheme.normal,
      home: HomePage(),
    );
  }

}

class HomePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage>{

  Image? _image;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          if (_image != null) _image!,

          FilledButton(
            child: const Text("pick Image"),
            onPressed: ()async {
              var image = await ImagePicker.getImage(ImagePickerSource.gallery);
              if (image == null) return;
              setState(() {
                _image = Image.memory(image);
              });
            },
          )

        ],
      ),
    );
  }

}

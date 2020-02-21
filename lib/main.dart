import 'package:flutter/material.dart';
import 'package:hello_lbs_flutter/city.dart';
import 'package:hello_lbs_flutter/map.dart';
void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ), home: MyHomePage(title: 'Capitais do Brasil'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<City> entries = <City>[
    City("Rio Branco", "Acre", -9.971000, -67.822947),
    City("Maceió", "Alagoas", -9.663054, -35.730784),
    City("Macapá", "Amapá", 0.035397, -51.070566),
    City("Manaus", "Amazonas", -3.118918, -60.021657),
    City("Salvador", "Bahia", -12.977329, -38.502403),
    City("Fortaleza", "Ceará", -3.732841, -38.526846),
    City("Vitória", "Espírito Santo", -20.297243, -40.295552),
    City("Goiânia", "Goiás", -16.686204, -49.265162),
    City("São Luís", "Maranhão", -2.529674, -44.257093),
    City("Cuiabá", "Mato Grosso", -15.600882, -56.096740),
    City("Campo Grande", "Mato Grosso do Sul", -20.469699, -54.620173),
    City("Belo Horizonte", "Minas Gerais", -19.919291, -43.938638),
    City("Belém", "Pará", -1.455561, -48.491746),
    City("João Pessoa", "Paraíba", -7.119660, -34.845203),
    City("Curitiba", "Paraná", -25.428565, -49.268209),
    City("Recife", "Pernambuco", -8.057756, -34.883049),
    City("Teresina", "Piauí", -5.044621, -42.766486),
    City("Rio de Janeiro", "Rio de Janeiro", -22.907022, -43.173036),
    City("Natal", "Rio Grande do Norte", -5.779286, -35.200957),
    City("Porto Alegre", "Rio Grande do Sul", -30.034577, -51.221215),
    City("Porto Velho", "Rondônia", -8.760991, -63.901194),
    City("Boa Vista", "Roraima", 2.821854, -60.673535),
    City("Florianópolis", "Santa Catarina", -27.598735, -48.516352),
    City("São Paulo", "São Paulo", -23.552552, -46.632491),
    City("Aracaju", "Sergipe", -10.947256, -37.073109),
    City("Palmas", "Tocantins", -10.249059, -48.324734),
    City("Brasília", "Distrito Federal", -15.793949, -47.882917)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.navigate_next),
            onPressed: () {
              Navigator.push(
                  context,
                    MaterialPageRoute(builder: (context) =>
                      MapScreen(entries.where((city){
                            return city.checked;
                          }
                        ).toList()
                      )
                    )
              );
            },
          ),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: entries.length,
        itemBuilder: (BuildContext context, int index) {
          return CheckboxListTile(
            title: Text('${entries[index].name} (${entries[index].state})'),
            value: entries[index].checked,
            onChanged: (bool value) {
              setState(()
                {
                  entries[index].checked = value;
                }
              );
            }, secondary: const Icon(Icons.add_location),
          );

        },
        separatorBuilder: (BuildContext context, int index) => Divider(),
      ),
    );
  }
}

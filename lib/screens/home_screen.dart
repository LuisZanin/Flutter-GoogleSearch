import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:googlenav/controllers/appController.dart';
import 'package:url_launcher/url_launcher_string.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {
  final BuscaController _buscaController = BuscaController();
  List<dynamic> _resultados = [];
  String _ultimaBusca = '';
  final ScrollController _scrollController = ScrollController();
  bool _isLoadingMore = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _createAppBar(),
      body: _createBody(),
    );
  }

  AppBar _createAppBar() {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('./images/atkicon.png',
            fit: BoxFit.contain,
            height: 70,
            width: 30
          ),
          const SizedBox(width: 10,),
          const Text(
            'Atak Searcher',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold
            ),
          ),
        ],
      ),
      backgroundColor: Colors.redAccent
    );
  }

  Widget _createBody() {
    return Column(
      children: [
        _createBuscaContainer(),
        _createResultsContainer()
      ],
    );
  }
  Container _createBuscaContainer() {
    return Container(
      margin: const EdgeInsets.only(
          top: 40,
          left: 20,
          right: 20),
      decoration: _createBoxDecoration(),
      child: _createCampoBusca()
    );
  }

  BoxDecoration _createBoxDecoration() {
    return BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.11),
          blurRadius: 40,
          spreadRadius: 0.0,
        ),
      ],
    );
  }

  TextField _createCampoBusca() {
    return TextField(
      controller: _buscaController.textController,
      onChanged: (text) {
        setState(() {});
      },
      onSubmitted: (text) async {
        _ultimaBusca = text;
        _resultados = await _buscaController.performSearch(text);
        setState(() {});
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.all(15),
        hintText: 'Insira sua Busca',
        hintStyle: TextStyle(
          color: Colors.black.withOpacity(0.3),
          fontSize: 16,
        ),
        prefixIcon: InkWell(
          onTap: () async {
            _ultimaBusca = _buscaController.textController.text;
            _resultados = await _buscaController.performSearch(_buscaController.textController.text);
            setState(() {});
          },
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: SvgPicture.asset('./icons/Search.svg'),
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
      ),
      keyboardType: TextInputType.text,
    );
  }

  Widget _createResultsContainer() {
    return Expanded(
      child: ListView.builder(
        controller: _scrollController,
        itemCount: _resultados.length + 1,
        itemBuilder: (context, index) {
          if (index < _resultados.length) {
            return _createCampoResultado(index);
          } else {
            return _isLoadingMore ? _createIndicadorLoading() : Container();
          }
        },
      ),
    );
  }

  Widget _createIndicadorLoading() {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(
          top: 20,
          bottom: 20),
        child: const CircularProgressIndicator(
          color: Colors.black,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  _scrollListener() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      _loadMoreResults();
    }
  }

  _loadMoreResults() async {
    setState(() {
      _isLoadingMore = true;
    });
    var moreResults = await _buscaController.performSearch(_ultimaBusca, true);
    setState(() {
      _resultados.addAll(moreResults);
      _isLoadingMore = false;
    });
  }

  Widget _createCampoResultado(int index) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.all(
            Radius.circular(15)),
      ),
      margin: const EdgeInsets.only(
          top: 10,
          left: 20,
          right: 20),
      child: ListTile(
        title: Text(_resultados[index]['titulo']),
        subtitle: _createCamposLinks(index),
      ),
    );
  }

  InkWell _createCamposLinks(int index) {
    return InkWell(
      child: Text(
        _resultados[index]['link'],
        style: const TextStyle(color: Colors.blue),
      ),
      onTap: () async {
        String url = _resultados[index]['link'];
        if (await canLaunchUrlString(url)) {
          await launchUrlString(url);
        } else {
          throw 'Não foi possível Iniciar o link: $url';
        }
      },
    );
  }
}
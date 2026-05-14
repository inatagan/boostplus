import 'package:flutter/material.dart';

void main() => runApp(
  const MaterialApp(
    home: CurvedLandingPage(),
    debugShowCheckedModeBanner: false,
  ),
);

class CurvedLandingPage extends StatelessWidget {
  const CurvedLandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Fundo vermelho para a parte de baixo
      backgroundColor: Colors.red,
      body: Stack(
        children: [
          // Parte de cima Branca com o recorte curvo
          ClipPath(
            clipper: MyClipper(),
            child: Container(
              color: Colors.white,
              height: MediaQuery.of(context).size.height * 0.5, // 50% da tela
              width: double.infinity,
              child: const Center(
                child: Text(
                  "Boost+",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),

          // Conteúdo da parte de baixo (opcional)
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              child: Center(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.red,
                    elevation: 10,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 15,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    "Iniciar",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// A "mágica" acontece aqui
class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    // Começa desenhando um retângulo quase completo
    path.lineTo(0, size.height - 50); // Ponto inicial da curva à esquerda

    // Cria a curva
    // controlPoint: Onde a curva "tenta" chegar (o ápice do arco)
    // endPoint: Onde a curva efetivamente termina (canto inferior direito)
    var controlPoint = Offset(size.width / 2, size.height + 50);
    var endPoint = Offset(size.width, size.height - 50);

    path.quadraticBezierTo(
      controlPoint.dx,
      controlPoint.dy,
      endPoint.dx,
      endPoint.dy,
    );

    path.lineTo(size.width, 0); // Sobe até o topo direito
    path.close(); // Fecha o caminho de volta ao início (0,0)

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

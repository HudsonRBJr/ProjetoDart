import 'package:flutter/material.dart';
import 'screens/transferencia/lista.dart';

void main() => runApp(BankApp());

class BankApp extends StatelessWidget {
  const BankApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //theme: ThemeData.dark(), // tema padronizado do flutter
      home: ListaTransferencias(),
      
      // Configuração de tema do app
      theme: ThemeData(
        // Ativa o estilo Material 3, mais atual e com suporte aos widgets modernos
        useMaterial3: true,

        // Define uma paleta de cores a partir de uma cor base (verde, nesse caso)
        // O Flutter gera automaticamente variações coerentes (primary, secondary, etc.)
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green, // Cor principal do app
        ),

        // Define a cor principal do aplicativo para widgets que ainda usam essa propriedade
        primaryColor: Colors.green.shade900,

        // Tema para a AppBar
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.green.shade900, // Fundo da AppBar
          foregroundColor: Colors.white,          // Texto e ícones na AppBar
          titleTextStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),

        // Tema para botões elevados (substitui o antigo buttonTheme)
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green.shade700, // Cor de fundo do botão
            foregroundColor: Colors.white,          // Cor do texto/ícones no botão
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),

        // Tema para o FloatingActionButton (FAB)
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.green.shade700, // Cor do botão flutuante
          foregroundColor: Colors.white,          // Cor do ícone
        ),

        // Tema para campos de texto (TextField, por exemplo)
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(), // Define borda padrão
        ),
      ),     
    );
  }
} // main
import 'package:flutter/material.dart';

class TermoUso extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Cor do fundo
      backgroundColor: Colors.white,
      appBar: AppBar(
        //title: TextStyle(color: Colors.blue)
        title: Text(
          "Termos e Responsabilidade",
          style: TextStyle(color: Colors.white, fontSize: 23.0),
        ),
        //Cor app bar
        backgroundColor: Colors.green[400],
        centerTitle: true,
      ),
      body: Container(

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
             padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
//              child: Text("Termos de uso e Politica de privacidade",
//                style: TextStyle(
//                  fontSize: 20.0,
//                  color: Colors.grey[400],
//                  fontWeight: FontWeight.w600,
//                ),
//              ),
            ),
            Expanded(
              flex: 1,
              child: SingleChildScrollView(
                child: Text('''
                
TERMOS DE USO

1. ACEITAÇÃO
    Este é um contrato de Termos de uso firmado entre você, de agora em diante denominado como usuário,  pessoa física, dentro do Brasil e o Aplicativo Anote Tudo, de agora em diante denominado Anote Tudo. O Anote Tudo foi Desenvolvido para dispositivos móveis (iOS e Android) O usuário que não concordar com estes termos, recomenda-se o não uso do Anote Tudo.
    Ao acessar e usar o Anote Tudo, o usuário reconhece que analisou e aceitou os seus Termos de Uso.  Devido a este fato, o usuário deve reler periodicamente as versões mais atualizadas do Termos de Uso, para garantir sua concordância como os Termos de Uso mais atuais.
2. LICENÇA LIMITADA
    Sujeito ao cumprimento destes Termos de Uso, o usuário recebe uma licença limitada, não transferível, não exclusiva, não passível de sublicença, livre de royalties, para baixar, instalar, executar e utilizar o Anote Tudo no dispositivo do usuário. A venda, transferência, modificação, engenharia reversa ou distribuição, bem como a cópia de textos, imagens ou quaisquer partes contidas no Anote Tudo é expressamente proibida.
3. ALTERAÇÕES, MODIFICAÇÕES, RESCISÕES E RESTRIÇÕES
     O Anote Tudo reserva-se no direito de, a qualquer tempo, modificar os Termos de Uso, seja incluindo, removendo ou alterando quaisquer de suas cláusulas. Tais modificações terão efeito imediato. Após publicadas tais alterações, ao continuar com o uso do aplicativo, o usuário terá aceito e concordado com os Termos de Uso atualizados.
     O Anote Tudo pode, de tempos em tempos, modificar ou descontinuar (temporária ou permanentemente) a distribuição e/ou a atualização deste aplicativo.
     O Anote Tudo não é obrigado a fornecer nenhum serviço de suporte.
    O usuário não poderá responsabilizar os programadores do Anote Tudo por quaisquer modificações, suspensões ou descontinuidade do Anote Tudo.
4. CONSENTIMENTO PARA COLETA E USO DE DADOS
    O Anote Tudo não coleta informações de seus usuários.
5. ISENÇÃO DE GARANTIAS E LIMITAÇÕES DE RESPONSABILIDADE
    O Anote Tudo estará em contínuo desenvolvimento e pode conter erros. O uso é fornecido no estado em que se encontra e sua utilização sob risco do usuário final. Na extensão máxima permitida pela legislação aplicável ao Anote Tudo e seus desenvolvedores, estes isentam-se de quaisquer garantias e condições explícitas  ou implícitas, incluindo sem limitação, garantias de comercialização, adequação a um propósito diferente do Anote Tudo, titularidade e não violação no que diz respeito a qualquer um dos componentes do Anote Tudo. A prestação de serviços de suporte é vedada ao usuário. O Anote Tudo não garante que a operação deste aplicativo seja contínua e sem defeitos.
    Exceto pelo estabelecido neste documento, não há outras garantias, condições ou promessas do aplicativo, explícitas ou implícitas. Promessas podem ser excluídas de acordo com o que é permitido por lei sem prejuízo ao Anote Tudo e seus desenvolvedores.
    I. O Anote Tudo não garante, declara ou assegura que o uso deste aplicativo será ininterrupto ou livre de erros.  O usuário concorda que o Anote Tudo poderá, por períodos indefinidos, cancelar o Anote Tudo e seu uso a qualquer momento sem que o usuário seja avisado ou julgado conveniente.
    II. O Anote Tudo não garante, declara nem assegura que estará sempre livre de perda de dados, interrupção, ataque de vírus, pirataria ou outra invasão de segurança. O Anote Tudo isenta-se de qualquer responsabilidade em relação às  questões retro citadas. O usuário é responsável pelo aplicativo em seu próprio dispositivo.
    III. Em hipótese alguma, o Anote Tudo, bem como seus programadores, podem ser responsabilizados por perdas de dados ou danos causados pelo uso do Anote Tudo.
POLITICA DE PRIVACIDADE
Tipos de dados coletados
    Nenhum dado é coletado do usuário do Anote Tudo.
Ultima atualização 27 de julho de 2019 



 ''',                 style: TextStyle(fontSize: 16.0, color: Colors.grey[900],
                  ),
                ),
              ),
            )
          ],
        ),
        padding: EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 0.0),
      ),
     );
  }
}

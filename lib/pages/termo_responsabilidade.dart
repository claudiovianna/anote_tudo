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
        backgroundColor: Colors.amber[600],
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

1. ACEITAÇÃOTer

    Este é um contrato de Termos de uso firmado entre você, de agora em diante denominado como usuário, portanto, uma pessoa física, dentro do Brasil e o Aplicativo Anote Tudo Desenvolvido para dispositivos móveis (Android) Se você não concordar com estes termos recomenda-se o não uso deste aplicativo.
    Ao acessar e usar, Você reconhece que analisou e aceitou os termos.  Devido a este fato você deve reler periodicamente as versões mais atualizadas para garantir que está de acordo.

2. LICENÇA LIMITADA

    Sujeito ao cumprimento destes termos, você recebeu uma licença limitada, não transferível, não exclusiva, não passível de sublicença, livre de royalties e revogável para baixar, instalar, executar e utilizar este aplicativo no seu dispositivo. O aplicativo deverá ser utilizado por você, na condição de usuário. A venda, transferência, modificação, engenharia reversa ou distribuição bem como a cópia de textos, imagens ou quaisquer partes nele contido é expressamente proibida.

3. ALTERAÇÕES, MODIFICAÇÕES, RESCISÕES E RESTRIÇÕES

     O Anote Tudo reserva-se no direito de, a qualquer tempo, modificar estes termos seja incluindo, removendo ou alterando quaisquer de suas cláusulas. Tais modificações terão efeito imediato. Após publicadas tais alterações, ao continuar com o uso do aplicativo você terá aceitado e concordado em cumprir os termos modificados.
     O Anote Tudo pode, de tempos em tempos, modificar ou descontinuar (temporária ou permanentemente) a distribuição ou a atualização deste aplicativo.
     O Anote Tudo não é obrigada a fornecer nenhum serviço de suporte para este aplicativo.
    O usuário não poderá responsabilizar seu programador, por quaisquer modificações, suspensões ou descontinuidade do aplicativo.

4. CONSENTIMENTO PARA COLETA E USO DE DADOS

    O Anote Tudo não coleta informações de seus usuário pois se tratando de aplicativo pessoal e sem acesso a internet, funcionando unicamente em seu aparelho sem nenhuma comunicação externa.

5. ISENÇÃO DE GARANTIAS E LIMITAÇÕES DE RESPONSABILIDADE

    Este aplicativo estará em contínuo desenvolvimento e pode conter erros e, o uso é fornecido " no estado em que se encontra" é sob risco do usuário final. Na extensão máxima permitida pela legislação aplicável ao Anote Tudo e seu desenvolvedor isentam-se de quaisquer garantias e condições expressas ou implícitas incluindo, sem limitação, garantias de comercialização, adequação a um propósito específico, titularidade e não violação no que diz respeito ao aplicativo e qualquer um de seus componentes ou ainda à prestação, ou não de serviços de suporte. O Anote Tudo não garante que a operação deste aplicativo seja contínua e sem defeitos.
    Exceto pelo estabelecido neste documento não há outras garantias, condições ou promessas aos aplicativos, expressas ou implícitas, e todas essas garantias, condições e promessas podem ser excluídas de acordo com o que é permitido por lei sem prejuízo ao Anote Tudo e seu desenvolvedor.
    I. O Anote Tudo não garante, declara ou assegura que o uso deste aplicativo será ininterrupto, ou livre de erros e você concorda que  o Anote Tudo poderá remover por períodos indefinidos, ou cancelar este aplicativo, ou o seu uso a qualquer momento sem que você seja avisado se julgado conveniente.
    II. O Anote Tudo não garante, declara nem assegura que este aplicativo esteja livre de perda de dados, interrupção, ataque de vírus,  pirataria ou outra invasão de segurança e isenta-se de qualquer responsabilidade em relação à essas questões. Você é responsável pelo aplicativo em seu próprio dispositivo.
    III. Em hipótese alguma, o Anote Tudo, bem como seus programadores, responsabilizar-se-ão por perdas de dados, ou danos causados pelo uso do aplicativo.

POLITICA DE PRIVACIDADE

Tipos de dados coletados
        Nenhum dados é coletado do usuário do aplicativo  Anote Tudo, aplicativo funciona sem utilização da internet.
 
Última atualização: 02 de junho de 2019


''',
                  style: TextStyle(fontSize: 16.0, color: Colors.grey[900],
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

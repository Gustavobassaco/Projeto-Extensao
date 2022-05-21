import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shop/utils/constants.dart';

class MunicipioRepository extends ChangeNotifier {
  final List<List<String>> _municipios = [];
  late List<dynamic> _data = [];
  int indexSelected0 = 0;
  int indexSelected1 = 0;

  void setIndex0(int i) {
    indexSelected0 = i;
    setInfos0();
    notifyListeners();
  }

  void setIndex1(int i) {
    indexSelected1 = i;
    setInfos1();
    notifyListeners();
  }

  Map<dynamic, List<Map<String, List<dynamic>>>> get infos0 => _infos0;
  Map<dynamic, List<Map<String, List<dynamic>>>> get infos1 => _infos1;
  List<List<String>> get municipios => _municipios;
  List<dynamic> get data => _data;
  bool _carregando = true;
  bool get carregando => _carregando;

  MunicipioRepository() {
    _initData();
  }

  void _initData() async {
    final response = await http.get(Uri.parse('${Constants.urlData}.json'));
    final resp = await jsonDecode(response.body);
    _data = resp;

    for (dynamic objeto in resp) {
      _municipios.add([objeto['data']['nome'], objeto['id']]);
    }
    setInfos0(); // iniciar
    _carregando = false;
    notifyListeners();
  }

  late Map<dynamic, List<Map<String, List<dynamic>>>> _infos0 = {};
  late Map<dynamic, List<Map<String, List<dynamic>>>> _infos1 = {};

  setInfos0() {
    _infos0 = {
      data[indexSelected0]['data']['nome']: [
        {
          'População': [
            data[indexSelected0]['data']['populacao'] + ' hab',
            'null',
          ],
        },
        {
          'Área': [
            data[indexSelected0]['data']['areaMunicipio']['area'] + ' km^2',
            'null',
          ],
        },
        {
          'Densidade Demográfica': [
            data[indexSelected0]['data']['areaMunicipio']['densidade'] +
                ' hab/Km^2',
            'null',
          ],
        },
      ],
      'Economia': [
        {
          'Perdas históricas por desastres como porcentagem do produto da cidade':
              [
            'null',
            'Perdas econômicas diretas por desastre(s) na cidade somadas ao longo de um período de cinco anos (numerador) divididos pela soma total do produto da cidade ao longo do mesmo período (denominador)',
            'Perdas históricas por desastres como porcentagem do produto da cidade devem ser calculadas como perdas econômicas diretas por desastre(s) na cidade somadas ao longo de um período de cinco anos (numerador) divididos pela soma total do produto da cidade ao longo do mesmo período (denominador). O resultado deve ser multiplicado por 100 e expresso como perdas históricas por desastres como porcentagem de produto da cidade. O produto urbano pode ser obtido da ISO 37120:2018, 5.9.3. Perdas históricas por desastres devem se referir a perdas (em termos monetários) que resultam de desastres. Estas perdas são associadas a danos ou destruição de infraestrutura física, social e crítica dentro dos limites administrativos da cidade (mesmo se não estiverem sob a jurisdição da cidade). A infraestrutura física se refere às estruturas de construção, sistemas e ativos necessários para a economia de uma cidade funcionar, incluindo as redes de transporte, serviços de telecomunicações, redes de energia, sistemas de esgoto e eliminação de resíduos, abastecimento de água, edifícios e instalações da cidade e moradias. A infraestrutura social é um subconjunto importante da estrutura física e inclui as estruturas que acomodam os serviços sociais, como escolas, universidades, hospitais e prisões. A infraestrutura crítica se refere aos sistemas, serviços ou ativos (físicos ou virtuais) vitais para o bem-estar da sociedade',
          ],
        },
        {
          'Perda anual média por desastres como porcentagem do produto da cidade':
              [
            'null',
            'Perda econômica média resultante diretamente de desastre(s), estimada por cenários de modelagem de catástrofe em toda a cidade (numerador) pelo produto total da cidade (denominador)',
            'A perda anual média por desastres como porcentagem de produto da cidade deve ser calculada como a perda econômica média resultante diretamente de desastre(s), estimada por cenários de modelagem de catástrofe em toda a cidade (numerador), dividida pelo produto total da cidade (denominador). O resultado deve ser multiplicado por 100 e expresso como perda anual média por desastres como porcentagem do produto da cidade. O termo perdas econômicas diretas deve se referir a perdas (em termos monetários) que resultam de desastres. Estas perdas são associadas a danos ou destruição de infraestrutura física, social e crítica dentro dos limites administrativos da cidade (mesmo se não estiverem sob a jurisdição da cidade). A infraestrutura física se refere às estruturas de construção, sistemas e ativos necessários para a economia de uma cidade funcionar, incluindo as redes de transporte, serviços de telecomunicações, redes de energia, sistemas de esgoto e eliminação de resíduos, abastecimento de água, edifícios e instalações da cidade e moradias. A infraestrutura social é um subconjunto importante da estrutura física e inclui as estruturas que acomodam os serviços sociais, como escolas, universidades, hospitais e prisões. A infraestrutura crítica se refere aos sistemas, serviços ou ativos (físicos ou virtuais) vitais para o bem-estar da sociedade',
          ],
        },
        {
          'Porcentagem de propriedades com cobertura de seguro para ameaças de alto risco':
              [
            'null',
            'Número total de propriedades (residenciais e não residenciais) da cidade com cobertura de seguro para as ameaças de alto risco que afetam a cidade (numerador) dividido pelo número total de propriedades (domicílios e empresas) na cidade (denominador)',
            'A porcentagem de propriedades com cobertura de seguro para ameaças de alto risco deve ser calculada como o número total de propriedades (residenciais e não residenciais) da cidade com cobertura de seguro para as ameaças de alto risco que afetam a cidade (numerador) dividido pelo número total de propriedades (domicílios e empresas) na cidade (denominador). O resultado deve ser multiplicado por 100 e expresso como a porcentagem de propriedades com cobertura de seguro para ameaças de alto risco. Propriedades residenciais devem se referir a habitações (ou estruturas) classifcadas para uso residencial. Convém que exemplos de propriedades residenciais incluam, mas não se limitem a, habitações unifamiliares, habitações móveis, habitações geminadas, casas geminadas, condomínios e edifícios de apartamentos. Propriedades não residenciais devem se referir a estruturas classifcadas para uso não residencial. Convém que exemplos de propriedades não residenciais incluam, mas não se limitem a, edifícios de escritórios/edifícios comerciais privados, hotéis, restaurantes, edifícios do governo, edifícios institucionais (por exemplo, instalações educacionais e de saúde), fábricas e outras propriedades especiais isentas (por exemplo, espaços recreativos não comerciais, locais de culto, funerárias e cemitérios). Quando possível, convém reportar os dados de cobertura de seguro de cada setor (isto é, residencial e não residencial) e as ameaças cobertas, e listá-los em tabelas. Para os fns deste indicador, ameaças de alto risco devem se referir às ameaças para as quais exista uma probabilidade de evento(s) extremo(s) com base em mapas de ameaças gerados pela cidade que possa(m) afetar signifcativamente muitas propriedades na cidade e/ou ter um grande impacto na cidade. Este indicador abrange seguro patrimonial e exclui cobertura pessoal ou de vida. O seguro pode vir de vários prestadores públicos ou privados',
          ],
        },
        {
          'Porcentagem do valor total segurado em relação ao valor total em risco dentro da cidade':
              [
            'null',
            'O valor total segurado de todas as propriedades residenciais e não residenciais dentro da cidade (numerador) pelo valor total de todas as propriedades residenciais e não residenciais na cidade (denominador)',
            'A porcentagem do valor total segurado em relação ao valor total em risco dentro da cidade deve ser calculada como o valor total segurado de todas as propriedades residenciais e não residenciais dentro da cidade (numerador) dividido pelo valor total de todas as propriedades residenciais e não residenciais na cidade (denominador). O resultado deve ser multiplicado por 100 e expresso como a porcentagem do valor total segurado em relação ao valor total em risco dentro da cidade. Propriedades residenciais devem se referir a habitações (ou estruturas) classifcadas para uso residencial. Convém que exemplos de propriedades residenciais incluam, mas não se limitem a, habitações unifamiliares, habitações móveis, habitações geminadas, casas geminadas, condomínios e edifícios de apartamentos. Propriedades não residenciais devem se referir a estruturas classifcadas para uso não residencial. Convém que exemplos de propriedades não residenciais incluam, mas não se limitem a, edifícios de escritórios/edifícios comerciais privados, hotéis, restaurantes, edifícios do governo, edifícios institucionais (por exemplo, instalações educacionais e de saúde), fábricas e outras propriedades especiais isentas (por exemplo, espaços recreativos não comerciais, locais de culto, funerárias e cemitérios). Quando possível, convém reportar os dados de cobertura de seguro de cada setor (isto é, residencial e não residencial) e as ameaças cobertas, e listá-los em tabelas.',
          ],
        },
        {
          'Concentração de empregos': [
            (100 *
                        int.parse(
                            data[indexSelected0]['data']['popEmpregada']) /
                        int.parse(data[indexSelected0]['data']['popEconAtiva']))
                    .toStringAsFixed(2) +
                '%',
            'Número de pessoas na cidade empregadas nos três maiores setores da economia local (conforme medido pelo emprego total) (numerador)  (OBS: total de trabalhadores ) dividido pela força de trabalho total da cidade (denominador)',
            'A concentração de empregos deve ser calculada como o número de pessoas na cidade empregadas nos três maiores setores da economia local (conforme medido pelo emprego total) (numerador) dividido pela força de trabalho total da cidade (denominador). O resultado deve ser multiplicado por 100 e expresso como uma porcentagem. A força de trabalho deve se referir à soma do total de pessoas empregadas e desempregadas legalmente aptas para trabalhar e que são residentes na cidade. Normalmente, isto engloba todos os adultos economicamente ativos entre 15 e 64 anos, mas a idade específca varia de país para país. Os setores utilizados para o cálculo deste indicador devem ser defnidos conforme a Classifcação Internacional Normalizada Industrial de Todas as Atividades Econômicas, Rev. 4 [8] ou uma classifcação equivalente.',
          ],
        },
        {
          'Porcentagem da força de trabalho em empregos informais': [
            ((int.parse(data[indexSelected0]['data']['popInformal'][0]) +
                        int.parse(
                            data[indexSelected0]['data']['popInformal'][1])) /
                    int.parse(data[indexSelected0]['data']['popEconAtiva']))
                .toStringAsFixed(2),
            'Número de pessoas que trabalham em empregos informais (numerador) dividido pela força de trabalho total da cidade (denominador)',
            'A porcentagem da força de trabalho em empregos informais deve ser calculada como o número de pessoas que trabalham em empregos informais (numerador) dividido pela força de trabalho total da cidade (denominador). Este resultado deve ser multiplicado por 100 e expresso como a porcentagem da força de trabalho em empregos informais. O emprego informal deve se referir ao emprego em que a relação de trabalho não esteja, por lei ou na prática, sujeita à legislação trabalhista nacional, imposto de renda, proteção social ou direito a certos benefícios trabalhistas (por exemplo, aviso prévio de dispensa, pagamento de verbas rescisórias, férias anuais pagas ou licença médica). Os motivos podem ser a não declaração dos empregos ou dos funcionários; trabalhos temporários ou trabalhos de curta duração; empregos com horas de trabalho ou salários abaixo de um patamar especifcado (por exemplo, para contribuições de previdência social); emprego por empresas não registradas ou por pessoas em domicílios; empregos em que o local de trabalho do funcionário esteja fora das instalações da empresa do empregador (por exemplo, trabalhadores externos sem contrato de trabalho); ou trabalhos aos quais a legislação trabalhista não se aplica, não é aplicada ou não é cumprida por qualquer outro motivo. Os critérios operacionais para defnição de trabalhos informais de funcionários devem ser determinados de acordo com circunstâncias nacionais e disponibilidade de dados [10]. Convém que emprego informal inclua trabalhadores autônomos empregados em suas próprias empresas do setor informal, empregadores empregados em suas próprias empresas do setor informal, trabalhadores familiares contribuintes, independentemente de trabalharem em empresas do setor formal ou informal, membros de cooperativas de produtores informais, funcionários que mantêm empregos informais em empresas do setor formal, empresas do setor informal ou como trabalhadores domésticos remunerados empregados pelas famílias; e trabalhadores autônomos envolvidos na produção de bens exclusivamente para uso fnal próprio por suas famílias [10]. A força de trabalho deve se referir à soma do total de pessoas empregadas e desempregadas legalmente qualifcadas para trabalhar',
          ],
        },
        {
          'Renda familiar média líquida': [
            'null',
            'O valor total da renda disponível para os gastos e poupança após subtração dos impostos de renda e contribuições previdenciárias durante o ano civil por todas as famílias dentro dos limites da cidade (numerador) dividida pelo número total de famílias dentro dos limites da cidade (denominador)',
            'A renda familiar média líquida deve ser calculada como o valor total da renda disponível para os gastos e poupança após subtração dos impostos de renda e contribuições previdenciárias durante o ano civil por todas as famílias dentro dos limites da cidade (numerador) dividida pelo número total de famílias dentro dos limites da cidade (denominador). O resultado deve ser expresso como a renda média disponível das famílias em dólares. A renda familiar líquida deve incluir a renda disponível de todos os membros da família com 15 anos ou mais. NOTA BRASILEIRA Conforme a legislação vigente, entre os direitos e garantias fundamentais estão a “proibição de trabalho noturno, perigoso ou insalubre a menores de 18 anos e de qualquer trabalho a menores de 16 anos, salvo na condição de aprendiz, a partir de 14 anos”. Para fazer a conversão da moeda local, as cidades devem usar as taxas publicadas pelo US Federal Reserve Bank (FED) (Banco Central dos EUA): https://www.newyorkfed.org/markets/internationalmarket-operations/foreign-exchange-operations . As cidades também devem observar a taxa e a data de conversão.',
          ],
        },
      ],
      'Educação': [
        {
          'Porcentagem de escolas que ensinam preparação para situações de emergência situações de emergência e redução de riscos de desastres':
              [
            'null',
            'o número de escolas dentro da cidade que ensinam a preparação para situações de emergência e redução de riscos de desastres (numerador) dividido pelo número total de escolas na cidade (denominador)',
            'A porcentagem de escolas que ensinam preparação para situações de emergência e redução de riscos de desastres deve ser calculada como o número de escolas dentro da cidade que ensinam a preparação para situações de emergência e redução de riscos de desastres (numerador) dividido pelo número total de escolas na cidade (denominador). O resultado deve ser multiplicado por 100 e expresso como porcentagem das escolas que ensinam preparação para emergências e redução de riscos de desastres. Escolas devem se referir às instituições educacionais de ensino primário e secundário. As atividades de preparação para situações de emergência e redução de riscos de desastres devem se referir aos exercícios de treinamento e programas de conscientização, por exemplo, mas não limitadas a, simulações de evacuação, prática/ensaio de protocolos de emergência, testes da capacidade de realização de possíveis rotas de evacuação e avaliação dos tempos de resposta para os serviços de emergência.',
          ],
        },
        {
          'Porcentagem da população treinada em preparação para situações de emergência e redução de riscos de desastres':
              [
            'null',
            'o número total de pessoas dentro da cidade treinadas pelas autoridades responsáveis nas atividades de preparação para emergências e redução de riscos de desastres nos 12 meses anteriores (numerador) dividido pela população total da cidade (denominador)',
            'A porcentagem da população treinada em preparação para situações de emergência e redução de riscos de desastres deve ser calculada como o número total de pessoas dentro da cidade treinadas pelas autoridades responsáveis nas atividades de preparação para emergências e redução de riscos de desastres nos 12 meses anteriores (numerador) dividido pela população total da cidade (denominador). O resultado deve ser multiplicado por 100 e expresso como porcentagem da população treinada em preparação para emergências e redução de riscos de desastres. As atividades de preparação para situações de emergência e redução de riscos de desastres devem se referir aos exercícios de treinamento e programas de conscientização, por exemplo, mas não limitadas a, simulações de evacuação, prática/ensaio de protocolos de emergência, testes da capacidade de realização de possíveis rotas de evacuação e avaliação dos tempos de resposta para os serviços de emergência.',
          ],
        },
        {
          'Porcentagem de publicações de preparação para emergências fornecidas em idiomas alternativos':
              [
            'null',
            'o número de publicações de preparação para emergências fornecidas em idiomas alternativos dentro da cidade (numerador) dividido pelo número total de publicações de preparação para emergências publicadas pela cidade (denominador).',
            'A porcentagem das publicações de preparação para emergências fornecidas em idiomas alternativos deve ser calculada como o número de publicações de preparação para emergências fornecidas em idiomas alternativos dentro da cidade (numerador) dividido pelo número total de publicações de preparação para emergências publicadas pela cidade (denominador). O resultado deve ser multiplicado por 100 e expresso como a porcentagem de publicações de preparação para emergências fornecidas em idiomas alternativos. Idiomas alternativos devem se referir a outros idiomas que não seja o idioma falado na cidade, incluindo aqueles que não têm status ofcial ou legal com o governo municipal.',
          ],
        },
        {
          'Interrupção educacional': [
            'null',
            'o número de horas de ensino perdidas anualmente devido a choques ou estresses',
            'A interrupção educacional deve ser calculada como o número de horas de ensino perdidas anualmente devido a choques ou estresses. As horas de ensino perdidas devem se referir às horas em que as instituições educacionais não são operacionais durante as horas regulares de ensino. Qualquer fechamento de um estabelecimento de ensino na cidade deve ser contabilizado. Várias instalações educacionais fechadas na mesma data do calendário devem ser contabilizadas como uma, a fm de evitar a contagem dupla. Por exemplo, se houver várias instalações educacionais fechadas por 8 h no mesmo dia, apenas 8 h serão contadas para aquele dia e não multiplicadas pelo número de instalações afetadas.',
          ],
        },
      ],
      'Energia': [
        {
          'Número de diferentes fontes de energia elétrica que fornecem pelo menos 5% da capacidade total de fornecimento de energia':
              [
            'null',
            'O número de diferentes fontes de fornecimento de energia elétrica que fornecem pelo menos 5% da capacidade total de fornecimento de energia deve se referir ao número de fontes de fornecimento de energia diferentes, ou separadas, para a cidade, cada qual fornecendo pelo menos 5 % da capacidade total de fornecimento de energia.',
            'O número de diferentes fontes de fornecimento de energia elétrica que fornecem pelo menos 5 % da capacidade total de fornecimento de energia deve se referir ao número de fontes de fornecimento de energia diferentes, ou separadas, para a cidade, cada qual fornecendo pelo menos 5 % da capacidade total de fornecimento de energia. NOTA O patamar de 5 % é utilizado por organizações internacionais, como o Banco Mundial, por exemplo, para facilitar os cálculos e capturar as principais fontes de fornecimento. Quando o número de diferentes fontes de energia elétrica exceder dois, convém que a porcentagem da capacidade de fornecimento de energia de cada fonte seja reportada. Além de fornecer o número de diferentes fontes de fornecimento de energia elétrica e capacidade de fornecimento de cada fonte, convém que o número de diferentes fontes de fornecimento de energia elétrica e o valor total de energia fornecida para a cidade (GJ) por estas fontes sejam reportados',
          ],
        },
        {
          'Capacidade de fornecimento de energia elétrica como porcentagem da demanda de pico de energia elétrica':
              [
            'null',
            'A capacidade de fornecimento de energia elétrica disponível para a cidade (numerador) dividida pela média mensal das demandas de pico de energia elétrica da cidade ao longo do ano (denominador)',
            'A capacidade de fornecimento de energia elétrica como porcentagem da demanda de pico de energia elétrica deve ser calculada como a capacidade de fornecimento de energia elétrica disponível para a cidade (numerador) dividida pela média mensal das demandas de pico de energia elétrica da cidade ao longo do ano (denominador). O resultado deve ser multiplicado por 100 e expresso como a capacidade de fornecimento de energia elétrica como a porcentagem da demanda de pico de energia elétrica. A capacidade de fornecimento de energia elétrica deve se referir ao fornecimento máximo previsto disponível de energia elétrica para atender às demandas de pico de energia elétrica projetadas, incluindo reservas de fornecimento para atender a perdas inesperadas, interrupções ou picos de demanda. Demandas de picos de energia elétrica devem se referir ao nível mais alto de necessidade de energia elétrica por parte dos consumidores em todo um período específco. A demanda de pico futua com os ciclos de atividade humana, a hora do dia, a estação do ano, climas extremos e a atividade industrial.',
          ],
        },
        {
          'Porcentagem de instalações críticas atendidas por serviços de energia fora da rede':
              [
            'null',
            'o número de instalações críticas atendidas por serviços de energia fora da rede (numerador) dividido pelo número total de instalações críticas na cidade (denominador).',
            'A porcentagem de instalações críticas atendidas por serviços de energia fora da rede deve ser calculada como o número de instalações críticas atendidas por serviços de energia fora da rede (numerador) dividido pelo número total de instalações críticas na cidade (denominador). O resultado deve ser multiplicado por 100 e expresso como a porcentagem de instalações críticas atendidas por serviços de energia fora da rede. Instalação crítica deve se referir à uma instalação que presta serviços e funções essenciais para uma cidade, especialmente durante e após um desastre. As categorias de instalações críticas incluem, entre outras, respostas a emergências (por exemplo, incêndios, resgates e delegacia de polícia), médicas (por exemplo, hospitais, instalações de cuidados intensivos e ambulatórios), abrigos de emergência (por exemplo, edifícios escolares públicos e instalações de ônibus escolares sendo utilizados como abrigos em caso de emergência), redes vitais (por exemplo, sistemas de distribuição e instalações correlatas necessárias para fornecer energia elétrica), transporte (por exemplo, estradas, pontes, túneis, linhas e estações ferroviárias), telecomunicações (por exemplo, centrais de comutação de telefone e telefone celular e torres de antena ou retransmissão), centrais de dados (por exemplo, instalações e sistemas que fornecem recursos locais de informática e de Internet e instalações para armazenamento de informações críticas), instituições fnanceiras (por exemplo, bancos centrais e comerciais), principais organizações industriais/comerciais (por exemplo, principais empregadores sem os quais a comunidade não seria capaz de se sustentar) e outras instalações e serviços relacionados que são essenciais para o bem-estar da comunidade atendida por estes sistemas. Quando possível, os tipos de instalações críticas inclusas devem ser indicados. Este indicador deve incluir apenas as instalações críticas situadas dentro dos limites administrativos da cidade. Serviços de energia fora da rede devem se referir tanto aos sistemas de energia independentes como às minirredes de energia que não estão conectados à rede primária central de energia para geração de energia em larga escala em instalações centralizadas, e geralmente utilizam células de bateria e/ou combustível como fonte de energia. Sistemas de energia independentes devem se referir a sistemas de energia muitas vezes utilizados para energizar aparelhos individuais e para usuários que não estejam conectados à rede primária central de energia fora das dependências do usuário. Uma minirrede de energia deve se referir a um pequeno sistema de rede de energia que fornece energia para usuários que não estejam conectados à rede primária central de energia. Além disto, a produção de energia autônoma sem ligação com a rede pública de energia engloba uma ampla gama de tecnologias, tais como, mas não limitadas a, turbinas ou usinas eólicas, painéis fotovoltaicos (solares), microturbinas e motores modulares de combustão interna. Exemplos de serviços de energia fora da rede englobam, mas não se limitam a, minirredes de energia que fornecem energia elétrica para as comunidades (por exemplo, a Brooklyn Microgrid), instalações críticas e edifícios institucionais e geração de energia solar fotovoltaica que utiliza painéis solares que fornecem energia a domicílios residenciais, instalações críticas e edifícios institucionais. Convém que as cidades contabilizem as instalações críticas com capacidade de operar em “modo ilha” no cálculo deste indicador. O modo ilha deve se referir à capacidade de uma instalação crítica passar da operação na rede local de energia para a operação isolada da rede local de energia. Convém reportar a proporção de instalações críticas que são atendidas exclusivamente por serviços de energia fora da rede e têm a capacidade de operar em modo ilha, e convém que as cidades verifquem se os dados das instalações críticas com capacidade de operar em modo ilha estão inclusos.',
          ],
        },
      ],
      'Meio ambiente e mudanças climáticas': [
        {
          'Magnitude dos efeitos (atmosféricos) das ilhas de calor urbana': [
            'null',
            'diferença entre as temperaturas médias diárias do ar registradas simultaneamente em uma área urbana e uma área não urbana, calculadas como média ao longo do período de 12 meses.',
            'O efeito das ilhas de calor urbanas deve ser calculado como a diferença entre as temperaturas médias diárias do ar registradas simultaneamente em uma área urbana e uma área não urbana, calculadas como média ao longo do período de 12 meses. A área urbana deve se referir a uma parte central da cidade na ordem de diversos hectares, com prédios próximos, estradas pavimentadas, fuxo de tráfego intenso e alta densidade populacional. A área não urbana deve se referir a uma parte periférica da cidade na ordem de diversos hectares, com poucos prédios e estradas, abundante cobertura natural da terra e baixa densidade populacional. Convém que as cidades descrevam os dois locais dos sensores de temperatura (ou estações climáticas) utilizadas para medir a magnitude da ilha de calor (por exemplo, parque, aeroporto, centro da cidade, área agrícola). Isto é necessário para transmitir a representatividade local dos valores medidos, as atividades físicas, demográfcas e humanas representativas da área ao redor dos dois instrumentos (ou estações) e a sua infuência nas temperaturas registradas. Referências às “zonas climáticas urbanas” (ZCU) são úteis neste aspecto. As diretrizes da Organização Meteorológica Mundial (OMM) para a observação de temperaturas em áreas urbanas e não urbanas devem ser seguidas [12]. Se disponível, convém que as cidades informem o local dos sensores ou acrescentem um mapa para indicar os locais',
          ],
        },
        {
          'Porcentagem de áreas naturais dentro da cidade submetidas a avaliação ecológica de seus serviços de proteção':
              [
            'null',
            'o total de áreas naturais de propriedade pública dentro da cidade submetidas a avaliação ecológica de seus serviços de proteção (numerador) dividido pelo total de áreas naturais de propriedade pública na cidade (denominador).',
            'A porcentagem de áreas naturais dentro da cidade submetidas a avaliação ecológica de seus serviços de proteção deve ser calculada como o total de áreas naturais de propriedade pública dentro da cidade submetidas a avaliação ecológica de seus serviços de proteção (numerador) dividido pelo total de áreas naturais de propriedade pública na cidade (denominador). O resultado deve ser multiplicado por 100 e expresso como a porcentagem de áreas naturais dentro da cidade submetidas a avaliação ecológica de seus serviços de proteção. Áreas naturais devem se referir a espaços ou zonas geográfcos cujas características distintivas surgiram naturalmente ou cuja cobertura predominante do território e características da paisagem são naturais (isto é, solo, areia, água ou vegetação) em vez de construídas (isto é, materiais de construção impermeáveis). Os serviços de proteção são benefícios diretos fornecidos por ativos ecológicos para impedir ou reduzir os impactos negativos das ameaças nas cidades e em seus cidadãos. A avaliação ecológica deve se referir a uma avaliação formal ou classifcação dos serviços de proteção fornecidos pelos ativos e sistemas ecológicos na área defnida. Embora esteja fora do escopo para este indicador, o ideal é que também sejam realizadas avaliações dos ecossistemas que estão além dos limites da cidade, mas que fornecem importantes serviços ecológicos à cidade (por exemplo, bacias hidrográfcas a montante). Isto pode requerer colaboração transfronteiriça com administrações de outras cidades, órgãos regulatórios e outras partes interessadas. Também fora do escopo deste documento estão as avaliações ecológicas de proprietários privados, usando os seus próprios recursos. Embora os ativos ecológicos de propriedade privada forneçam o mesmo serviço de proteção que as terras públicas, eles podem ser difíceis de avaliar.',
          ],
        },
        {
          'Território em processo de restauração de ecossistemas como porcentagem da área total da cidade':
              [
            'null',
            'território em processo de restauração de ecossistemas dentro dos limites da cidade em quilômetros quadrados (numerador) dividido pela área total da cidade em quilômetros quadrados (denominador)',
            'O território em processo de restauração de ecossistemas como porcentagem da área total da cidade deve ser calculado como território em processo de restauração de ecossistemas dentro dos limites da cidade em quilômetros quadrados (numerador) dividido pela área total da cidade em quilômetros quadrados (denominador). O resultado deve ser multiplicado por 100 e expresso como uma porcentagem. A restauração de ecossistemas deve se referir ao processo de recuperação natural e elementos seminaturais da paisagem (isto é, relacionados ao solo, corpos d’água e vegetação) que foram degradados, danifcados ou destruídos. Os elementos de vegetação para restauração variam em escala espacial, de fleiras individuais de árvores a sistemas de vales inteiros; elementos de água variam de lagoas únicas a cursos de água inteiros. Exemplos de trabalho de restauração de ecossistemas incluem o recondicionamento de aterros ou campos degradados para parques ou outros usos recreativos.',
          ],
        },
        {
          'Frequência anual dos eventos de tempestades extremas': [
            'null',
            'número de eventos de tempestades extremas em um dado ano. Os eventos de tempestades extremas devem se referir aos eventos de precipitação em que 50 mm ou mais de chuva tenham caído sobre a cidade durante um período de 24 h',
            'A frequência anual de eventos de tempestades extremas deve ser calculada como o número de eventos de tempestades extremas em um dado ano. Os eventos de tempestades extremas devem se referir aos eventos de precipitação em que 50 mm ou mais de chuva tenham caído sobre a cidade durante um período de 24 h. Quando relevantes e disponíveis, convém reportar dados mais precisos em nível de subdivisão.',
          ],
        },
        {
          'Frequência anual de eventos de calor extremo': [
            'null',
            'número de eventos de calor extremo em um dado ano.',
            'A frequência anual de eventos de calor extremo deve ser calculada como o número de eventos de calor extremo em um dado ano. Os eventos de calor extremo devem se referir a um longo período de tempo (pelo menos 72 h) com condições climáticas excepcionalmente quentes que colocam em risco a saúde e o bem-estar humano. Os patamares de temperatura do ar específcos do país para defnir os eventos extremos de calor variam. Por exemplo, no Canadá um evento de calor extremo pode ser defnido em 72 h ou mais com temperaturas acima de 30 °C/86 °F (ou um patamar baseado em uma comunidade específca), enquanto que nos EUA um evento de calor extremo pode ser defnido por temperaturas acima de 32 °C/90 °F (ou um patamar baseado em uma comunidade específca). Os que relatam este indicador devem usar o método específco do país e o patamar de temperatura. Convém que as cidades considerem a localização das medições de temperatura do ar para transmitir a representatividade local dos valores relatados (por exemplo, aeroporto, centro da cidade). Quando relevantes e disponíveis, convém reportar dados mais precisos em nível de subdivisão',
          ],
        },
        {
          'Frequência anual de eventos de frio extremo': [
            'null',
            'o número de eventos de frio extremo em um dado ano.',
            'A frequência anual de eventos de frio extremo deve ser calculada como o número de eventos de frio extremo em um dado ano. Os eventos de frio extremo devem se referir a um longo período de tempo (pelo menos 72 h) com condições climáticas excepcionalmente frias que colocam em risco a saúde e o bem-estar humano. Os patamares de temperatura do ar específcos do país para defnir os eventos de frio extremo variam. Por exemplo, no Canadá um evento de frio extremo pode ser defnido como temperaturas do ar ou sensação térmica abaixo de -30 °C/-22 °F (ou um patamar baseado em uma comunidade específca) por pelo menos 72 h, enquanto que nos EUA um evento de frio extremo pode ser defnido como temperaturas do ar ou sensação térmica abaixo de -29 °C/-20 °F (ou um patamar baseado em uma comunidade específca). Os que relatam este indicador devem usar o método específco do país e o patamar de temperatura. Convém que as cidades considerem a localização das medições de temperatura do ar para transmitir a representatividade local dos valores relatados (por exemplo, aeroporto, centro da cidade). Quando relevantes e disponíveis, convém reportar dados mais precisos em nível de subdivisão.',
          ],
        },
        {
          'Frequência anual de eventos de enchentes': [
            'null',
            'número de eventos de enchentes em um dado ano.',
            'A frequência anual de eventos de enchentes deve ser calculada como o número de eventos de enchentes em um dado ano. Um evento de enchente deve se referir a um excesso de água em terra normalmente seca e pode incluir a inundação de uma área normalmente seca causada por um aumento signifcativo no nível da água de um córrego, lago, reservatório ou região costeira. Um evento de enchente também pode incluir concentração de água em ou perto do ponto de chuva. As enchentes são eventos de longo prazo, diferentes das inundações repentinas, com duração de pelo menos 72 h',
          ],
        },
        {
          'Porcentagem da área territorial da cidade coberta por copas de árvores':
              [
            'null',
            'área territorial da cidade coberta por copas de árvores (numerador) dividida pela área territorial total da cidade (denominador).',
            'A porcentagem da área da cidade coberta por copas de árvores deve ser calculada como a área territorial da cidade coberta por copas de árvores (numerador) dividida pela área territorial total da cidade (denominador). O resultado deve ser multiplicado por 100 e expresso como a porcentagem da área territorial da cidade coberta por copas de árvores. As copas de árvores devem se referir à biomassa em camadas de folhas, galhos e caules das árvores que obscurecem a superfície do solo subjacente quando vistas de cima.',
          ],
        },
        {
          'Porcentagem da área da cidade coberta com materiais com alto índice de albedo, o que contribui para a mitigação das ilhas de calor urbanas':
              [
            'null',
            'área total da superfície da cidade (tais como telhados, ruas, calçadas, pátios de escolas e superfícies expostas de estacionamentos), com exclusão dos espaços verdes, materiais permeáveis/drenantes de cores claras com um alto índice de albedo (numerador) dividido pela área total da cidade, com exclusão dos espaços verdes (denominador)',
            'A porcentagem da área da cidade coberta com materiais com alto índice de albedo que contribuem para a mitigação das ilhas de calor urbanas deve ser calculada como a área total da superfície da cidade (tais como telhados, ruas, calçadas, pátios de escolas e superfícies expostas de estacionamentos), com exclusão dos espaços verdes, materiais permeáveis/drenantes de cores claras com um alto índice de albedo (numerador) dividido pela área total da cidade, com exclusão dos espaços verdes (denominador). O resultado deve ser multiplicado por 100 e expresso como a porcentagem da área da cidade coberta com materiais com alto índice de albedo que contribuem para a mitigação das ilhas de calor urbanas.',
          ],
        },
      ],
      'Finanças': [
        {
          'Despesas anuais com atualização e manutenção dos ativos de serviços urbanos como porcentagem do orçamento total da cidade':
              [
            'null',
            'total anual de todos os recursos fnanceiros gastos com manutenção e atualização de ativos para a prestação dos serviços urbanos (numerador) dividido pelo orçamento total anual da cidade (denominador)',
            'As despesas anuais com manutenção e atualização dos ativos de serviços urbanos como porcentagem do orçamento total da cidade devem ser calculadas como o total anual de todos os recursos fnanceiros gastos com manutenção e atualização de ativos para a prestação dos serviços urbanos (numerador) dividido pelo orçamento total anual da cidade (denominador). O resultado deve ser multiplicado por 100 e expresso como as despesas anuais com manutenção e atualização dos ativos de serviços urbanos como porcentagem do orçamento total da cidade. Quando possível, convém incluir os dados dos gastos por tipo de serviço (por exemplo, água, resíduos, transporte) como valores de porcentagem, inclui-los separadamente em uma tabela. Os serviços urbanos variam de cidade para cidade, mas geralmente incluem, embora não se limitem a, saneamento, abastecimento de água, coleta de lixo, transporte público, fornecimento de energia elétrica e gás, iluminação pública e manutenção de vias.',
          ],
        },
        {
          'Despesas anuais com atualização e manutenção de infraestrutura de águas pluviais como porcentagem do orçamento total da cidade':
              [
            'null',
            'total anual de todos os recursos fnanceiros gastos com atualização e manutenção de infraestrutura física e de gestão de águas pluviais (numerador) dividido pelo orçamento total anual da cidade (denominador)',
            'As despesas anuais com atualização e manutenção da infraestrutura de águas pluviais como porcentagem do orçamento total da cidade devem ser calculadas como o total anual de todos os recursos fnanceiros gastos com atualização e manutenção de infraestrutura física e de gestão de águas pluviais (numerador) dividido pelo orçamento total anual da cidade (denominador). O resultado deve ser multiplicado por 100 e expresso como as despesas anuais com atualização e manutenção da infraestrutura de águas pluviais como porcentagem do orçamento total da cidade. A infraestrutura de águas pluviais deve se referir às instalações e estruturas técnicas e organizacionais que são projetadas, instaladas e/ou mantidas para mitigar os efeitos das ameaças da água da chuva e do derretimento de neve nas áreas urbanas. Exemplos de infraestrutura de águas pluviais incluem diques e barreiras contra inundações; bacias de inundação; quebra-mar; drenos pluviais e tanques de contenção de águas pluviais; canais de águas pluviais, bueiros e bacias hidrográfcas.',
          ],
        },
        {
          'Despesas anuais destinadas à restauração de ecossistemas no território da cidade como porcentagem do orçamento total da cidade':
              [
            'null',
            'total de todos os recursos fnanceiros gastos anualmente com ativos de restauração de ecossistemas com o propósito específco de melhorar os serviços de proteção e outros serviços ecossistêmicos que aprimoram a resiliência da cidade (numerador) dividido pelo orçamento total da cidade (denominador)',
            'As despesas anuais com restauração de ecossistemas como porcentagem do orçamento total da cidade devem ser calculadas como o total de todos os recursos fnanceiros gastos anualmente com ativos de restauração de ecossistemas com o propósito específco de melhorar os serviços de proteção e outros serviços ecossistêmicos que aprimoram a resiliência da cidade (numerador) dividido pelo orçamento total da cidade (denominador). O resultado deve ser multiplicado por 100 e expresso como a despesa com a restauração de ecossistemas como porcentagem do orçamento total de capital da cidade. A restauração de ecossistemas deve se referir ao processo de recuperação de elementos naturais e seminaturais da paisagem (isto é, relacionados ao solo, corpos d’água e vegetação) que foram degradados, danifcados ou destruídos.',
          ],
        },
        {
          'Despesas anuais com infraestruturas verde e azul como porcentagem do orçamento total da cidade':
              [
            'null',
            'total de todos os recursos fnanceiros gastos na criação, manutenção ou aprimoramento dos ativos de infraestrutura verde e azul para o propósito específco de prestação de serviços relacionados à infraestrutura para a cidade (numerador) dividido pelo orçamento total da cidade (denominador)',
            'As despesas anuais com infraestruturas verde e azul como porcentagem de orçamento total devem ser calculadas como o total de todos os recursos fnanceiros gastos na criação, manutenção ou aprimoramento dos ativos de infraestrutura verde e azul para o propósito específco de prestação de serviços relacionados à infraestrutura para a cidade (numerador) dividido pelo orçamento total da cidade (denominador). O resultado deve ser multiplicado por 100 e expresso como as despesas com infraestruturas verde e azul como porcentagem do orçamento total da cidade. As infraestruturas verde e azul devem se referir a todos os elementos naturais e seminaturais da paisagem que podem ser amplamente defnidas como uma rede estrategicamente planejada de áreas naturais e seminaturais de alta qualidade com outras características ambientais, a qual é projetada e gerenciada para fornecer uma ampla gama de serviços de infraestrutura e ecossistema e proteger a biodiversidade [15]. Os elementos verdes estão relacionados à vegetação e variam em escala espacial, de fleiras individuais de árvores a sistemas de vales inteiros, e podem incluir, entre outros, as seguintes ações: tornar mais verdes ruas, praças e estradas; tornar mais verdes telhados e fachadas; desenvolver a agricultura urbana; criar corredores verdes urbanos; substituir superfícies impermeáveis; implementar fltração natural de água; rios urbanos à luz do dia; e restaurar aterros. Os elementos azuis estão relacionados a água e variam de lagoas isoladas a cursos de água inteiros e podem incluir, entre outros, corredores de rios, pântanos e outras vias navegáveis.',
          ],
        },
        {
          'Despesas anuais com planejamento do gerenciamento de emergências como porcentagem do orçamento total da cidade':
              [
            'null',
            'total das despesas anuais com planejamento do gerenciamento de emergências (numerador) dividido pelo orçamento anual total da cidade (denominador)',
            'As despesas anuais com planejamento do gerenciamento de emergências como porcentagem do orçamento total da cidade devem ser calculadas como o total das despesas anuais com planejamento do gerenciamento de emergências (numerador) dividido pelo orçamento anual total da cidade (denominador). O resultado deve ser multiplicado por 100 e expresso como despesas anuais com planejamento do gerenciamento de emergências como porcentagem do orçamento total da cidade. O planejamento do gerenciamento de emergências deve se referir ao processo de avaliação dos objetivos da cidade para a redução dos riscos de desastre e preparação para emergências, e criar um plano detalhado de ação para atender a estes objetivos, de forma que a cidade possa responder aos choques e tensões. Os elementos do planejamento do gerenciamento de emergências englobam a determinação das situações de emergências em potencial e as consequências destas situações (isto é, por meio de avaliações de riscos, mapeamento de ameaças/riscos, análise de vulnerabilidades) e identifcação das respostas e procedimentos necessários e adequados para cada situação de emergência (por exemplo, sistemas de alerta, rotas para evacuação, canais de serviço). O planejamento do gerenciamento de emergências deve excluir os orçamentos contínuos de custeio dos serviços de emergência para os serviços de polícia, bombeiros ou ambulâncias.',
          ],
        },
        {
          'Despesas anuais com serviços sociais e comunitários como porcentagem do orçamento total da cidade':
              [
            'null',
            'total das despesas anuais com serviços sociais e comunitários da cidade (numerador) dividido pelo orçamento total anual da cidade (denominador)',
            'As despesas anuais com serviços sociais e comunitários como porcentagem do orçamento total da cidade devem ser calculadas como o total das despesas anuais com serviços sociais e comunitários da cidade (numerador) dividido pelo orçamento total anual da cidade (denominador). O resultado deve ser multiplicado por 100 e expresso como as despesas com serviços sociais e comunitários como porcentagem do orçamento total da cidade. Os serviços sociais e comunitários devem ser defnidos como os serviços prestados ou apoiados diretamente pela cidade com o objetivo de promover ou apoiar a resiliência e o bem-estar individual e da comunidade. Isto pode incluir, mas não está limitado a, programas e fnanciamento de grupos e associações comunitárias, conscientização da saúde pública, bibliotecas, abrigos de emergência, abrigos para sem-teto, centros de acolhimento, centros comunitários, eventos cívicos, sensibilização da comunidade, programas de alimentação, saúde e serviços humanos, programas de idosos, serviços e divulgação, apoio e assistência a grupos desfavorecidos e vulneráveis.',
          ],
        },
        {
          'Alocação total de fundos de reserva para desastres como porcentagem do orçamento total da cidade':
              [
            'null',
            'a alocação total dos fundos de reserva para desastres (numerador) dividida pelo orçamento total da cidade (denominador).',
            'A alocação total dos fundos de reserva para desastres como porcentagem do orçamento total da cidade deve ser calculada como a alocação total dos fundos de reserva para desastres (numerador) dividida pelo orçamento total da cidade (denominador). O resultado deve ser multiplicado por 100 e expresso como a alocação total de fundos de reserva para desastres como porcentagem do orçamento total da cidade. Um fundo de reserva para desastres deve se referir aos orçamentos gerenciados pela administração da cidade e alocados especificamente para atender às despesas imprevistas de resposta a emergências, recuperação e reconstrução após um evento de desastre.',
          ],
        },
      ],
      'Governança': [
        {
          'Frequência da atualização dos planos de gerenciamento de desastres':
              [
            'null',
            'o número total das atualizações dos planos de gerenciamento de desastres em toda a cidade ocorridas nos cinco anos anteriores (numerador) dividido por cinco (denominador)',
            'A frequência da atualização dos planos de gerenciamento de desastres deve ser calculada como o número total das atualizações dos planos de gerenciamento de desastres em toda a cidade ocorridas nos cinco anos anteriores (numerador) dividido por cinco (denominador). O gerenciamento de desastres deve se referir à organização, planejamento e aplicação de medidas a longo prazo para a preparação, resposta e recuperação de eventos de desastres. Os planos de gerenciamento de desastres devem ser integrados a respostas regionais ou nacionais mais amplas e estipularem a agência que assumirá a liderança em diferentes cenários de emergência, assim como os papéis de resposta de diferentes agências e os recursos humanos e não humanos disponíveis. Os principais componentes de um plano de gerenciamento de desastres são comando e controle; evacuações (por exemplo, hospitais, cadeias); sistemas de comunicação; gerenciamento de ativos críticos (por exemplo, prováveis “cadeias de falhas”); integração de serviços públicos do setor privado, cobrindo, por exemplo, energia, água/saneamento, coleta de lixo e comunicações; resposta médica; resposta da lei e da ordem; resposta a incêndios e resgates; informações públicas; e políticas de triagem.',
          ],
        },
        {
          'Porcentagem de serviços urbanos essenciais cobertos por um plano de continuidade documentado':
              [
            'null',
            'número total de serviços essenciais que são cobertos por um plano de continuidade documentado (numerador) divido pelo número total de serviços públicos essenciais prestados na cidade (denominador)',
            'A porcentagem de serviços urbanos essenciais cobertos por um plano de continuidade documentado deve ser calculada como o número total de serviços essenciais que são cobertos por um plano de continuidade documentado (numerador) divido pelo número total de serviços públicos essenciais prestados na cidade (denominador). O resultado deve ser multiplicado por 100 e expresso como a porcentagem de serviços urbanos essenciais cobertos por um plano de continuidade documentado. Os serviços urbanos essenciais devem se referir aos serviços que são considerados vitais para o bem-estar e funcionamento da comunidade. Eles podem englobar, mas não estão limitados a, transporte, energia elétrica, gás, água, coleta e tratamento de esgoto, gerenciamento de resíduos, alimentos, saúde, polícia, bombeiros e serviços de emergência e ambulâncias. Convém que as cidades reportem quais serviços urbanos essenciais estão inclusos no cálculo. O termo plano de continuidade deve se referir a uma estratégia documentada que identifca as ameaças e riscos enfrentados pelas operações da cidade e ajuda a proteger os seus ativos e funcionários dos efeitos negativos de choques. O planejamento da continuidade envolve a defnição de riscos em potencial, a determinação de como estes riscos afetarão as operações, a implementação de salvaguardas e procedimentos para mitigá-los e a revisão periódica dos riscos para garantir sua relevância e moeda. Planos de continuidade devem ser atualizados regularmente. NOTA A ABNT NBR ISO 22301 é o parâmetro de referência reconhecido internacionalmente para continuidade organizacional. Ela especifca os requisitos para planejar, estabelecer, implementar, operar, monitorar, revisar, manter e melhorar continuamente um sistema de gerenciamento documentado para proteger-se, reduzir a probabilidade de ocorrência, preparar-se, responder e recuperar-se de incidentes.',
          ],
        },
        {
          'Porcentagem de dados eletrônicos da cidade com back-up de armazenamento seguro e remoto':
              [
            'null',
            'Volume dos dados eletrônicos da cidade com back-up de armazenamento seguro e remoto (numerador) dividido pelo volume total de dados eletrônicos da cidade (denominador)',
            'A porcentagem de dados eletrônicos da cidade com back-up de armazenamento seguro e remoto deve ser calculada como o volume dos dados eletrônicos da cidade com back-up de armazenamento seguro e remoto (numerador) dividido pelo volume total de dados eletrônicos da cidade (denominador). O resultado deve ser multiplicado por 100 e expresso como a porcentagem dos dados da cidade com back-up de armazenamento seguro e remoto. O back-up de armazenamento remoto deve se referir ao armazenamento de dados (mantidos em servidores, estações de trabalho e laptops) em um local secundário seguro (por exemplo, externo). Os planos e mecanismos para o armazenamento seguro e de longo prazo de dados da cidade refetem as vulnerabilidades da cidade às ameaças e convém que sejam atualizados e testados regularmente.',
          ],
        },
        {
          'Porcentagem de reuniões públicas destinadas à resiliência na cidade':
              [
            'null',
            'o número de reuniões públicas destinadas à resiliência na cidade (numerador) dividido pelo número total de reuniões públicas na cidade (denominador)',
            'A porcentagem de reuniões públicas destinadas à resiliência na cidade deve ser calculada como o número de reuniões públicas destinadas à resiliência na cidade (numerador) dividido pelo número total de reuniões públicas na cidade (denominador). O resultado deve ser multiplicado por 100 e expresso como a porcentagem de reuniões públicas destinadas à resiliência na cidade. As reuniões públicas devem se referir a reuniões realizadas pela cidade e abertas a todos os moradores e partes interessadas. Reuniões públicas são reuniões realizadas para aumentar a conscientização sobre uma questão ou proposta, e podem englobar, mas não estão limitadas a, reuniões realizadas pelo departamento de planejamento urbano da cidade relativo a uma proposta de desenvolvimento para um novo edifício de apartamentos ou nova rota de transporte público. As reuniões públicas destinadas à resiliência na cidade podem cobrir uma ampla gama de temas, como, mas não limitados a, desenvolvimento de infraestrutura para mitigar os impactos de potenciais choques e estresses, desenvolvimento de políticas ambientais para mitigar os impactos de mudanças climáticas e fnanciamento de programas sociais que aumentam a coesão social na cidade. Portanto, convém que as cidades reportem o propósito de cada reunião pública no numerador do cálculo do indicador. Convém que as cidades também reportem quem facilitará a reunião e os requisitos mínimos de alcance e participação para reuniões públicas. Além disto, convém que as cidades reportem o número de participantes em cada reunião e o modo de participação (por exemplo, on-line ou presencial), se possível.',
          ],
        },
        {
          'Número de acordos intergovernamentais destinados ao planejamento de choques como porcentagem do total de acordos intergovernamentais':
              [
            'null',
            'o número de acordos intergovernamentais que envolvem a cidade e são destinados ao planejamento de choques (numerador) dividido pelo número total de acordos intergovernamentais (denominador)',
            'O número de acordos intergovernamentais destinados ao planejamento de choques como porcentagem do total de acordos intergovernamentais deve ser calculado como o número de acordos intergovernamentais que envolvem a cidade e são destinados ao planejamento de choques (numerador) dividido pelo número total de acordos intergovernamentais (denominador). O resultado deve ser multiplicado por 100 e expresso como o número de acordos intergovernamentais destinados ao planejamento de choques como porcentagem do total de acordos intergovernamentais. Um acordo intergovernamental deve se referir a um acordo celebrado pela cidade com pelo menos um outro nível de governo (por exemplo, níveis estaduais e federais do governo). NOTA Existem inúmeras redes de cidades transnacionais, algumas das quais têm uma missão geral, enquanto outras trabalham em aspectos individuais, como lidar com os impactos das mudanças climáticas. Nos últimos anos, mais e mais redes de cidades vêm abordando a questão de resiliência da cidade, incluindo a preparação para choques externos. Em alguns casos, estas redes de cidades existentes podem ser uma fonte de acordos intergovernamentais.',
          ],
        },
        {
          'Porcentagem de prestadores de serviços essenciais que possuem um plano de continuidade documentado':
              [
            'null',
            'o número total de prestadores de serviços essenciais que possuem um plano de continuidade dos negócios documentado (numerador) divido pelo número total de prestadores de serviços essenciais (denominador)',
            'A porcentagem de prestadores de serviços essenciais que possuem um plano de continuidade dos negócios documentado deve ser calculada como o número total de prestadores de serviços essenciais que possuem um plano de continuidade dos negócios documentado (numerador) divido pelo número total de prestadores de serviços essenciais (denominador). O resultado deve ser multiplicado por 100 e expresso como a porcentagem de fornecedores de serviços essenciais da cidade que possuem um plano de continuidade documentado.  Os prestadores de serviços essenciais devem se referir às entidades externas ao governo que prestam serviços vitais para o funcionamento da cidade. Isto engloba fornecedores de serviços de infraestrutura do setor privado, incluindo energia elétrica, gás, água, coleta e tratamento de esgoto e gestão de resíduos. Convém incluir também os principais distribuidores de alimentos e fornecedores de serviços bancários de varejo. O termo plano de continuidade dos negócios deve se referir a uma estratégia documentada que identifca as ameaças e riscos enfrentados por uma empresa ou organização, e que ajuda a proteger seus ativos e pessoal dos efeitos negativos de um estresse ou choque, garantindo assim a continuidade operacional. O planejamento da continuidade dos negócios deve incluir a identifcação de riscos em potencial, a determinação de como estes riscos afetarão as operações, a implementação de medidas de segurança e os procedimentos para mitigá-los e a revisão periódica dos riscos para garantir a sua relevância e rigor. Convém que os planos de continuidade dos negócios sejam atualizados regularmente. NOTA A ABNT NBR ISO 22301 é o parâmetro de referência reconhecido internacionalmente para continuidade organizacional. Ela especifca os requisitos para planejar, estabelecer, implementar, operar, monitorar, revisar, manter e melhorar continuamente um sistema de gerenciamento documentado para proteger-se, reduzir a probabilidade de ocorrência, preparar-se, responder e recuperar-se de incidentes perturbadores quando eles surgirem.',
          ],
        },
      ],
      'Saúde': [
        {
          'Porcentagem de hospitais equipados com geradores back-up de energia elétrica':
              [
            'null',
            'número de hospitais equipados com geradores back-up de energia elétrica (numerador) dividido pelo número total de hospitais na cidade (denominador)',
            'A porcentagem de hospitais equipados com geradores back-up de energia elétrica deve ser calculada como o número de hospitais equipados com geradores back-up de energia elétrica (numerador) dividido pelo número total de hospitais na cidade (denominador). O resultado deve ser multiplicado por 100 e expresso como a porcentagem de instalações da área da saúde equipadas com geradores back-up de energia elétrica. Os geradores back-up de energia elétrica incluirão fontes de energia elétrica (incluindo estoque de geradores e baterias) protegidas de prováveis ameaças e com suprimentos de energia ou combustível sufcientes para fornecer energia sufciente para realizar as funções essenciais do hospital por um período de 72 h.',
          ],
        },
        {
          'Porcentagem da população com seguro básico de saúde': [
            'null',
            'número total de habitantes da cidade com cobertura de seguro básico de saúde (numerador) dividido pela população total da cidade (denominador).',
            'A porcentagem da população com seguro básico de saúde deve ser calculada como o número total de habitantes da cidade com cobertura de seguro básico de saúde (numerador) dividido pela população total da cidade (denominador). O resultado deve ser multiplicado por 100 e expresso como porcentagem da população com seguro de saúde básico. O seguro de saúde básico deve se referir a uma forma de proteção contra riscos de despesas médicas incorridas, seja por meio do acesso gratuito ou de baixo custo a serviços médicos ou por meio do pagamento de benefícios em consequência de doença ou lesão para recuperar custos. O seguro saúde pode ser fornecido de maneira pública ou privada.',
          ],
        },
        {
          'Porcentagem da população totalmente imunizada': [
            'null',
            'número de habitantes que foram totalmente imunizados na cidade (numerador) dividido pela população total da cidade (denominador)',
            'A porcentagem da população totalmente imunizada deve ser calculada como o número de habitantes que foram totalmente imunizados na cidade (numerador) dividido pela população total da cidade (denominador). O resultado deve ser multiplicado por 100 e expresso como a porcentagem da população que foi totalmente imunizada. De acordo com a Organização Mundial da Saúde, uma pessoa que foi totalmente imunizada deve se referir uma pessoa que recebeu todas as vacinas básicas antes de fazer um ano de idade. Mais especifcamente, a pessoa é totalmente imunizada com todas as vacinas básicas se ela tiver recebido vacina Bacillus Calmette-Guerin (BCG) contra tuberculose no nascimento; três doses de vacina contra a poliomielite e pentavalente [difteria-tétano-pertussis-hepatite B (Hep), Haemophilus infuenza tipo B (Hib)] com 6 semanas, 10 semanas e 14 semanas de idade; e uma vacina contra o sarampo com 9 meses de idade [17].',
          ],
        },
        {
          'Número de surtos de doenças infecciosas por ano': [
            'null',
            'contagem de surtos de doenças infecciosas em um determinado ano na cidade.',
            'O número de surtos de doenças infecciosas por ano deve ser calculado como a contagem de surtos de doenças infecciosas em um determinado ano na cidade. Uma doença infecciosa deve se referir a uma doença causada por micro-organismos patogênicos como bactérias, vírus, parasitas ou fungos; as doenças podem ser espalhadas, direta ou indiretamente, de uma pessoa para outra. Conforme defnido pela Organização Mundial da Saúde, um surto deve se referir a uma ocorrência de casos de doença superior ao esperado normalmente em uma determinada comunidade, área geográfca ou estação. Um surto pode ocorrer em uma área geográfca restrita ou pode estender-se por vários países. Pode durar poucos dias ou semanas ou diversos anos [18].',
          ],
        },
      ],
      'Habitação': [
        {
          'Capacidade de abrigos destinados a emergências por 100 000 habitantes':
              [
            'null',
            'a capacidade total de todos os abrigos destinados a emergências na cidade (numerador) dividido por 1/100 000 da população total da cidade (denominador)',
            'A capacidade de abrigos destinados a emergências por 100 000 habitantes deve ser calculada como a capacidade total de todos os abrigos destinados a emergências na cidade (numerador) dividido por 1/100 000 da população total da cidade (denominador). O resultado deve ser expresso como a capacidade de abrigos de emergência designados por 100 000 habitantes. A capacidade deve se referir ao número máximo, predeterminado de pessoas que podem ser acomodadas em um abrigo de emergência. O termo abrigo de emergência deve se referir a uma estrutura existente que tenha sido ofcialmente destinada a ser utilizada como habitação temporária para pessoas cuja habitação anterior não  é segura ou não está disponível durante ou após um desastre, ou que estão fugindo dos efeitos de um desastre. Os abrigos de emergência devem ser capazes de resistir a um desastre em virtude de sua construção e/ou localização.',
          ],
        },
        {
          'Porcentagem de edifícios estruturalmente vulneráveis a ameaças de alto risco':
              [
            'null',
            'como o número total de edifícios na cidade vulneráveis a ameaças de alto risco (numerador) dividido pelo número total de edifícios na cidade (denominador).',
            'A porcentagem de edifícios estruturalmente vulneráveis a ameaças de alto risco deve ser calculada como o número total de edifícios na cidade vulneráveis a ameaças de alto risco (numerador) dividido pelo número total de edifícios na cidade (denominador). O resultado deve ser multiplicado por 100 e expresso como a porcentagem de edifícios estruturalmente vulneráveis a ameaças de alto risco. Os edifícios devem se referir a todas as estruturas residenciais e não residenciais designadas para ocupação humana (isto é, com telhados e paredes) e que se situam em locais permanentes ou semipermanentes. Isto inclui edifícios públicos e privados utilizados para fns residenciais, comerciais, industriais, institucionais, recreacionais ou outros. Os edifícios estruturalmente vulneráveis a ameaças de alto risco (como terremotos, ciclones e enchentes) correm alto risco de sofrer um colapso ou danos signifcativos devidos aos efeitos de ameaças que podem causar morte ou lesões aos ocupantes do edifício.',
          ],
        },
        {
          'Porcentagem de edifícios residenciais não conformes com os códigos e normas de construção':
              [
            'null',
            'número total de edifícios residenciais na cidade não conformes com códigos e normas de construção (numerador) dividido pelo número total de edifícios residenciais na cidade (denominador)',
            'A porcentagem de edifícios residenciais não conformes com códigos e normas de construção deve ser calculada como o número total de edifícios residenciais na cidade não conformes com códigos e normas de construção (numerador) dividido pelo número total de edifícios residenciais na cidade (denominador). O resultado deve ser multiplicado por 100 e expresso como a porcentagem de edifícios residenciais não conformes com os códigos e normas de construção. Este indicador se refere a todos os códigos e normas de construção, incluindo (e especialmente) aqueles que regulam a integridade estrutural de edifícios residenciais e sua resistência a danos graves ou colapso durante um desastre (por exemplo, terremotos, enchentes, ciclones, deslizamentos de terra). Os edifícios residenciais devem se referir a todas as estruturas projetadas para ocupação humana de longo prazo (isto é, com telhados e paredes) e situadas em locais permanentes ou semipermanentes. Os códigos de construção devem se referir às portarias, regulamentos e normas associados destinados a regular aspectos de projetos, construções, uso de materiais, alteração e ocupação de estruturas construídas.',
          ],
        },
        {
          'Porcentagem de infraestrutura danifcada que foi “reconstruída melhor” após um desastre':
              [
            'null',
            'infraestrutura total na cidade que foi “reconstruída melhor” após um desastre ou evento extremo (numerador) dividido pela quantidade total de infraestruturas danifcadas no último evento na cidade (denominador).',
            'A porcentagem de infraestrutura danifcada que foi “reconstruída melhor” após um desastre deve ser calculada como a infraestrutura total na cidade que foi “reconstruída melhor” após um desastre ou evento extremo (numerador) dividido pela quantidade total de infraestruturas danifcadas no último evento na cidade (denominador). O resultado deve ser multiplicado por 100 e expresso como a porcentagem de infraestrutura danifcada que foi “reconstruída melhor após um desastre. A quantidade de infraestruturas deve se referir a metros quadrados para infraestruturas pontuais ou quilômetros para infraestruturas lineares. Este indicador só pode ser avaliado nos casos em que um evento de desastre ou extremo tenha impactado a cidade, resultando em danos a edifícios e estruturas. A infraestrutura deve se referir aos ativos pontuais e lineares (físicos, construídos) que fornecem funções essenciais em locais ou posições únicas, identifcáveis na cidade, ao longo de canais, corredores, rotas ou linhas dentro da cidade e que continuam em localizações permanentes ou semipermanentes. As infraestruturas pontuais devem englobar os principais edifícios utilizados para a educação (por exemplo, escolas, universidades, faculdades) e serviços de saúde (por exemplo, hospitais, clínicas médicas), bem como estações, equipamentos, fábricas, instalações ou outras obras de origem pontual utilizadas para disposição e tratamento de resíduos sólidos, tratamento de águas e efuentes e geração, transmissão e distribuição de energia. A infraestrutura linear deve englobar os principais dutos utilizados para a distribuição de água e gás ou para o afastamento de esgotos; linhas de transmissão para distribuição de energia elétrica; e principais rotas e corredores de transporte para a movimentação de pessoas e mercadorias por terra e água (por exemplo, rodovias, estradas, ferrovias, caminhos, pontes).',
          ],
        },
        {
          'Número anual de propriedades residenciais inundadas como porcentagem do total de propriedades residenciais na cidade':
              [
            'null',
            'como o número anual de propriedades residenciais que foram inundadas na cidade (numerador) dividido pelo número total de propriedades residenciais na cidade (denominador).',
            'O número anual de propriedades residenciais inundadas como porcentagem do total de propriedades residenciais na cidade deve ser calculado como o número anual de propriedades residenciais que foram inundadas na cidade (numerador) dividido pelo número total de propriedades residenciais na cidade (denominador). O número deve ser multiplicado por 100 e expresso como o número anual de propriedades residenciais inundadas como porcentagem do total de propriedades residenciais na cidade.  Propriedades residenciais devem se referir a habitações (ou estruturas) classifcadas para uso residencial. Convém que exemplos de propriedades residenciais incluam, mas não se limitem a, habitações unifamiliares, habitações móveis, habitações geminadas, casas geminadas, condomínios e edifícios de apartamentos.',
          ],
        },
        {
          'Porcentagem de propriedades residenciais situadas em áreas de alto risco':
              [
            'null',
            'como o número de propriedades residenciais situadas em áreas de alto risco na cidade (numerador) dividido pelo número total de propriedades residenciais na cidade (denominador).',
            'A porcentagem de propriedades residenciais situadas em áreas de alto risco deve ser calculada como o número de propriedades residenciais situadas em áreas de alto risco na cidade (numerador) dividido pelo número total de propriedades residenciais na cidade (denominador). O resultado deve ser multiplicado por 100 e expresso como a porcentagem de propriedades residenciais situadas em áreas de alto risco. Propriedades residenciais devem se referir a habitações (ou estruturas) classifcadas para uso residencial. Convém que exemplos de propriedades residenciais incluam, mas não se limitem a, habitações unifamiliares, habitações móveis, habitações geminadas, casas geminadas, condomínios e edifícios de apartamentos. As áreas de alto risco devem se referir às áreas da cidade particularmente vulneráveis a riscos naturais, como planícies inundáveis, encostas propensas a deslizamentos de terra e áreas costeiras baixas. Convém que os mapas de ameaças criados pela cidade sejam utilizados para identifcar estas áreas e indicar a probabilidade de ocorrência de uma ameaça relevante.',
          ],
        },
      ],
      'População e condições sociais': [
        {
          'População vulnerável como porcentagem da população da cidade': [
            'null',
            'o número total de pessoas vulneráveis na cidade (numerador) dividido pela população total da cidade (denominador)',
            'A população vulnerável como porcentagem da população total da cidade deve ser calculada como o número total de pessoas vulneráveis na cidade (numerador) dividido pela população total da cidade (denominador). O resultado deve ser multiplicado por 100 e expresso como a população vulnerável como porcentagem da população total da cidade. O termo população vulnerável deve se referir a pessoas com capacidade limitada para antecipar, lidar, resistir e se recuperar dos efeitos de um desastre e podem englobar os seguintes segmentos da população: — pessoas com comprometimento físico ou mental; — mulheres grávidas; — pessoas doentes ou desnutridas; — sem-teto; — pessoas localizadas em favelas, cortiços e moradias informais; — refugiados e pessoas internamente deslocadas; — comunidades transitórias ou nômades. Outros segmentos da população na cidade (isto é, crianças e idosos) que podem ser vulneráveis às ameaças devido à localização, ou a fatores específcos do contexto, também podem ser considerados na interpretação da vulnerabilidade da população da cidade. Eles não são relatados aqui, pois já foram considerados na ABNT NBR ISO 37120.',
          ],
        },
        {
          'Porcentagem da população inscrita em programas sociais': [
            'null',
            'o número de pessoas na cidade cadastradas em programas de assistência social (numerador) dividido pela população total da cidade (denominador)',
            'A porcentagem da população inscrita em programas sociais deve ser calculada como o número de pessoas na cidade cadastradas em programas de assistência social (numerador) dividido pela população total da cidade (denominador). O resultado deve ser multiplicado por 100 e expresso como a porcentagem da população inscrita em programas de assistência social. Assistência social deve se referir à ajuda fnanceira oferecida pelo governo que assiste famílias e pessoas que não conseguem pagar os seus custos básicos de vida devido a doença, incapacidade, baixa renda ou desemprego. Para algumas pessoas que recebem, a necessidade de assistência é temporária, enquanto para outras é por longo prazo',
          ],
        },
        {
          'Porcentagem da população exposta a alto risco de ameaças naturais': [
            'null',
            'o número de pessoas na cidade em alto risco de exposição de ameaças naturais (numerador) dividido pela população total da cidade (denominador)',
            'A porcentagem da população exposta a alto risco de ameaças naturais deve ser calculada como o número de pessoas na cidade em alto risco de exposição de ameaças naturais (numerador) dividido pela população total da cidade (denominador). O resultado deve ser multiplicado por 100 e expresso como a porcentagem da população exposta a alto risco de ameaças naturais. Delinear exposição de alto risco requer avaliação de risco local detalhada e mapas atualizados de ameaças e vulnerabilidades. Convém que as avaliações e mapas sejam disponibilizados ao público e incluam áreas urbanas inteiras. Informações atualizadas são especialmente importantes para ameaças como enchentes, porque mudanças na urbanização podem afetar a área de uma comunidade em risco. Quando possível, convém incluir os dados percentuais de cada tipo respectivo de ameaça e listá-los em uma tabela.',
          ],
        },
        {
          'Porcentagem de bairros com reuniões regulares e abertas da associação de bairro':
              [
            'null',
            'o número de bairros na cidade com reuniões regulares e abertas de associações de bairro (numerador) dividido pelo número total de bairros na cidade (denominador).',
            'A porcentagem de bairros com reuniões regulares e abertas da associação de bairro deve ser calculada como o número de bairros na cidade com reuniões regulares e abertas de associações de bairro (numerador) dividido pelo número total de bairros na cidade (denominador). O resultado deve ser multiplicado por 100 e expresso como a porcentagem de bairros com reuniões regulares e abertas da associação de bairro. Um bairro deve se referir a uma área geográfca defnida administrativamente na cidade. As reuniões regulares e abertas de associações de bairro devem referir-se a reuniões de associações de bairro que ocorrem pelo menos anualmente e não há exclusões em relação a quem pode participar das reuniões. Uma associação de bairro deve se referir a uma associação que representa os residentes de um bairro específco.',
          ],
        },
        {
          'Porcentagem anual da população da cidade diretamente afetada por ameaças naturais':
              [
            'null',
            'o número anual de pessoas evacuadas, remanejadas, feridas ou adoecidas devido a ameaças naturais (numerador) dividido pela população total da cidade (denominador).',
            'A porcentagem anual da população da cidade diretamente afetada por ameaças naturais deve ser calculada como o número anual de pessoas evacuadas, remanejadas, feridas ou adoecidas devido a ameaças naturais (numerador) dividido pela população total da cidade (denominador). O resultado deve ser multiplicado por 100 e expresso como a porcentagem anual da população da cidade diretamente afetada por ameaças naturais. Quando possível, convém incluir os dados percentuais de cada tipo respectivo de ameaça e listá-los em uma tabela.',
          ],
        },
      ],
      'Segurança': [
        {
          'Porcentagem da população da cidade coberta por sistemas de alerta prévio de ameaças múltiplas':
              [
            'null',
            'o número total de pessoas na cidade cobertas por sistemas de alerta prévio de ameaças múltiplas (numerador) dividido pela população total da cidade (denominador).',
            'A porcentagem da população da cidade coberta por sistemas de alerta prévio de ameaças múltiplas deve ser calculada como o número total de pessoas na cidade cobertas por sistemas de alerta prévio de ameaças múltiplas (numerador) dividido pela população total da cidade (denominador). O resultado deve ser multiplicado por 100 e expresso como porcentagem da população coberta por sistemas de alerta prévio de ameaças múltiplas. Os sistemas de alerta prévio devem se referir a um acordo integrado e coordenado de monitoramento e previsão de ameaças, avaliação de risco de desastres e atividades de comunicação e preparação que permitem às cidades e habitantes tomarem medidas para reduzir os riscos antes dos eventos perigosos. Os sistemas de alerta prévio de ameaças múltiplas cobrem uma gama de ameaças e impactos e são idealmente projetados para serem utilizados em contextos de ameaças múltiplas, em que os eventos perigosos ocorrem como evento(s) único(s), sucessivo(s) ou cumulativo(s) ao longo do tempo, levando a uma série de efeitos interrelacionados e com efeito cascata em uma cidade. Os alertas devem ser feitos durante o período máximo possível do aviso prévio por meio de várias mídias, incluindo, entre outros, telefone, TV, rádio, web e sirenes. Convém que os alertas sejam confáveis e específcos para o tipo de ameaça e convém que eles proporcionem bastante tempo para a preparação e resposta (tanto quanto a tecnologia permitir). NOTA A tecnologia de alertas de desastres está evoluindo rapidamente, tanto na avaliação de risco de longo prazo (por exemplo, previsão meteorológica sazonal) e no período de notifcação quanto na frequência de atualização para um evento específco (por exemplo, risco de deslizamento, alertas de tornados, movimentos na crista da inundação). No entanto, não existem sistemas de alertas de terremotos relevantes para fns práticos.',
          ],
        },
        {
          'Porcentagem de equipes de emergência que receberam treinamento de resposta a desastres':
              [
            'null',
            'o número total de equipes de emergência que receberam treinamento de resposta a desastres na cidade (numerador) dividido pelo número total de equipes de emergência na cidade (denominador)',
            'A porcentagem de equipes de emergência que receberam treinamento de resposta a desastres deve ser calculada como o número total de equipes de emergência que receberam treinamento de resposta a desastres na cidade (numerador) dividido pelo número total de equipes de emergência na cidade (denominador). O resultado deve ser multiplicado por 100 e expresso como porcentagem de equipes de emergência que receberam treinamento de resposta a desastres. O termo equipes de emergência deve se referir a policiais, bombeiros, paramédicos e socorristas. Eles estão entre as primeiras pessoas a chegarem na cena de uma emergência relacionada a um desastre e são treinados para lidar com uma gama de questões médicas e de segurança que podem surgir imediatamente antes, durante ou depois de um desastre. Convém que o treinamento em desastres cubra os piores cenários. NOTA BRASILEIRA No Brasil, conforme a legislação vigente institui a Política Nacional de Proteção e Defesa Civil (PNPDEC) e o Conselho Nacional de Proteção e Defesa Civil (CONPDEC) e autoriza a criação de um sistema de informações e monitoramento de desastres, abrangendo as ações de prevenção, mitigação, preparação, resposta e recuperação. Para este indicador, a Defesa Civil pode ser incluída como equipe de resposta',
          ],
        },
        {
          'Porcentagem de alertas locais de ameaças emitidos anualmente por agências nacionais e recebidos em tempo hábil pela cidade':
              [
            'null',
            'o número de alertas locais de ameaças emitidos anualmente por agências nacionais e recebidos em tempo hábil pela cidade (numerador) dividido pelo número total anual de alertas locais de ameaças emitidos por agências nacionais para a cidade (denominador)',
            'A porcentagem de alertas locais de ameaças emitidos anualmente por agências nacionais e recebidos em tempo hábil pela cidade deve ser calculada como o número de alertas locais de ameaças emitidos anualmente por agências nacionais e recebidos em tempo hábil pela cidade (numerador) dividido pelo número total anual de alertas locais de ameaças emitidos por agências nacionais para a cidade (denominador). O resultado deve ser multiplicado por 100 e expresso como a porcentagem de alertas locais de ameaça emitidos anualmente por agências nacionais e recebidos em tempo hábil pela cidade. O alerta ou previsão de ameaça deve se referir a uma chamada, notifcação, projeção, alerta ou alarme específco de um potencial evento de desastre. Os alertas devem ser feitos durante o período máximo possível do aviso prévio por meio de várias mídias, incluindo, entre outros, telefone, TV, rádio e Web. Em tempo hábil ou de maneira oportuna devem se referir-se a alertas ou previsões recebidas das equipes de emergência da cidade com tempo sufciente para acionar os sistemas de informação, implementar os planos de emergência (por exemplo, rotas para evacuação) e alertar os cidadãos. Isto fornece tempo às equipes de emergência para fazer perguntas e obter informações sobre o alerta ou previsão com os representantes do órgão emissor. O termo equipes de emergência deve se referir a policiais, bombeiros, paramédicos e socorristas. Eles estão entre as primeiras pessoas a chegar na cena de uma emergência relacionada a um desastre e são treinados para lidar com uma gama de questões médicas e de segurança que podem surgir imediatamente antes, durante ou depois de um desastre. NOTA A tecnologia de alertas de desastres está evoluindo rapidamente, tanto na avaliação de risco de longo prazo (por exemplo, previsão meteorológica sazonal) e no período de notifcação, quanto na frequência de atualização para um evento específco (por exemplo, risco de deslizamento, alertas de tornados, movimentos na crista da inundação). No entanto, não existem sistemas de alertas de terremotos relevantes para fns práticos.',
          ],
        },
        {
          'Número de leitos hospitalares na cidade destruídos ou danifcados por desastres naturais por 100 000 habitantes':
              [
            'null',
            'o número total de leitos hospitalares destruídos ou danifcados na cidade (numerador) dividido por 1/100 000 da população da cidade (denominador)',
            'O número de leitos hospitalares na cidade destruídos ou danifcados por desastres naturais por 100 000 habitantes deve ser calculado como o número total de leitos hospitalares destruídos ou danifcados na cidade (numerador) dividido por 1/100 000 da população da cidade (denominador). O resultado deve ser expresso como o número de leitos hospitalares na cidade destruídos ou danifcados por desastres naturais por 100 000 habitantes. Este indicador somente é aplicável caso um desastre ou evento extremo tenha ocorrido nos últimos 12 meses.',
          ],
        },
      ],
      'Resíduos sólidos': [
        {
          'Número de locais disponíveis, ativos e temporários de gestão de resíduos para detritos e destroços por quilômetro quadrado':
              [
            'null',
            'o número de locais disponíveis, ativos e temporários de gestão de resíduos da cidade, onde detritos e destroços podem ser dispostos (numerador) dividido pela área territorial total da cidade em quilômetros quadrados (denominador)',
            'O número de locais disponíveis, ativos e temporários de gestão de resíduos para detritos e destroços por quilômetro quadrado deve ser calculado como o número de locais disponíveis, ativos e temporários de gestão de resíduos da cidade, onde detritos e destroços podem ser dispostos (numerador) dividido pela área territorial total da cidade em quilômetros quadrados (denominador). O resultado deve ser expresso como o número de locais disponíveis, ativos e temporários de gestão de resíduos para detritos e destroços por quilômetro quadrado. O termo local de gestão de resíduos deve se referir a um local utilizado para a acumulação de resíduos, cujo propósito é eliminar ou tratar estes resíduos. Um local de gestão de resíduos pode englobar instalações de pirólise a vácuo, incineradoras, usinas de compostagem, estações de transferência, instalações de armazenamento, usinas de reciclagem e locais de eliminação. Estas instalações  são vistas como locais de gestão de resíduos porque elas permitem o armazenamento “contínuo” de resíduos em suas dependências antes do tratamento, eliminação, remoção ou manuseio dos resíduos. Um local de gestão de resíduos ativo deve incluir qualquer local que esteja atualmente em uso, esteja em pleno funcionamento e seja acessível à cidade. Um local de gestão de resíduos temporário é um local que pode ser construído temporariamente para gerenciar detritos e destroços por um período limitado de tempo de maneira segura para a saúde e o meio ambiente. Convém que detritos e destroços englobem materiais de construção (por exemplo, revestimentos de parede, gesso, drywall, louças sanitárias, telhas para cobertura e outros revestimentos de cobertura) e outros resíduos sólidos soltos, como mesas, cadeiras, chapas, tubos de PVC e papel.',
          ],
        },
      ],
      'Telecomunicações': [
        {
          'Porcentagem de equipes de emergência na cidade equipadas com tecnologias de comunicação especializadas capazes de operar de maneira confável durante um evento de desastre':
              [
            'null',
            'o número de equipes de emergência na cidade, com acesso ao PMR, à telefonia via satélite ou às redes de comunicações móveis com acesso privilegiado (numerador) dividido pelo número total de equipes de emergência na cidade (denominador).',
            'A porcentagem de equipes de emergência na cidade equipadas com tecnologias de comunicação especializadas capazes de operar de maneira confável durante um evento de desastre deve ser calculada como o número de equipes de emergência na cidade, com acesso ao PMR, à telefonia via satélite ou às redes de comunicações móveis com acesso privilegiado (numerador) dividido pelo número total de equipes de emergência na cidade (denominador). O resultado deve ser multiplicado por 100 e expresso como porcentagem de equipes de emergência na cidade equipadas com tecnologias de comunicação especializadas capazes de operar de maneira confável durante um evento de desastre. O termo equipes de emergência deve se referir a policiais, bombeiros, paramédicos e socorristas. Eles estão entre as primeiras pessoas a chegarem na cena de uma emergência relacionada a um desastre e são treinados para lidar com uma gama de questões médicas e de segurança que podem surgir imediatamente antes, durante ou depois de um desastre. O PMR deve se referir aos sistemas de comunicação de rádio em campo projetados para o uso específco de organizações como as forças policiais e o corpo de bombeiros. Estes sistemas de rádio permitem a comunicação ponto a multiponto em grandes áreas. NOTA O PMR também é conhecido como rádio móvel privado e rádio móvel terrestre. O termo telefonia via satélite deve se referir à tecnologia associada aos telefones móveis conectados aos satélites em órbita, e não aos locais terrestres para celular. A comunicação móvel com acesso privilegiado deve se referir à troca de informações nas redes de telefonia móvel que priorizaram o acesso para pessoas como os membros de serviços de emergência e equipes de resposta a emergências.',
          ],
        },
      ],
      'Transporte': [
        {
          'Número de rotas de evacuação disponíveis por 100 000 habitantes': [
            'null',
            'o número total de rotas de evacuação (numerador) dividido por 1/100 000 da população total da cidade (denominador)',
            'O número de rotas de evacuação disponíveis por 100 000 habitantes deve ser calculado como o número total de rotas de evacuação (numerador) dividido por 1/100 000 da população total da cidade (denominador). O resultado deve ser expresso como o número de rotas de evacuação disponíveis por 100 000 habitantes. O termo rotas de evacuação deve se referir a rodovias, estradas, vias navegáveis e ferrovias e ofcialmente designadas para remoção urgente e remanejamento temporário de pessoas e de seus ativos para longe da ameaça iminente ou contínua associada a um desastre. Uma única rota de evacuação pode não ser adequada para todas as emergências.',
          ],
        },
      ],
      'Agricultura urbana/local e segurança alimentar': [
        {
          'Porcentagem da população da cidade que pode ser atendida com as reservas de alimentos da cidade por 72 h em caso de emergência':
              [
            'null',
            'número de pessoas na cidade que pode ser atendida com as reservas de alimentos da cidade por 72 h (numerador) dividido pela população total da cidade (denominador)',
            'A porcentagem da população da cidade que pode ser atendida com as reservas de alimentos da cidade por 72 h em caso de emergência deve ser calculada como o número de pessoas na cidade que pode ser atendida com as reservas de alimentos da cidade por 72 h (numerador) dividido pela população total da cidade (denominador). O resultado deve ser multiplicado por 100 e expresso como a porcentagem da população que pode ser atendida com as reservas de alimentos dentro da cidade por 72 h. O termo reservas de alimentos da cidade deve se referir aos suprimentos essenciais de lojas de emergência da cidade, de acordo com supermercados locais e outros planos de contingência que garantem estoques de alimentos para os domicílios.',
          ],
        },
        {
          'Porcentagem da população da cidade que vive a 1 km de um mercado': [
            'null',
            'o número de pessoas na cidade que vivem a 1 km de um mercado (numerador) dividido pela população total da cidade (denominador).',
            'A porcentagem da população da cidade que vive a 1 km de um mercado deve ser calculada como o número de pessoas na cidade que vivem a 1 km de um mercado (numerador) dividido pela população total da cidade (denominador). O resultado deve ser multiplicado por 100 e expresso como a porcentagem da população da cidade que vive a 1 km de um mercado. O termo mercado deve se referir a uma loja de varejo que vende principalmente alimentos.',
          ],
        },
      ],
      'Planejamento urbano': [
        {
          'Porcentagem da área da cidade coberta por mapas de ameaças disponíveis ao público':
              [
            'null',
            'área da cidade coberta por mapas de ameaças disponíveis ao público em quilômetros quadrados (numerador) dividido pela área total da cidade em quilômetros quadrados (denominador)',
            'A porcentagem da área da cidade coberta por mapas de ameaças disponíveis ao público deve ser calculada como a área da cidade coberta por mapas de ameaças disponíveis ao público em quilômetros quadrados (numerador) dividido pela área total da cidade em quilômetros quadrados (denominador). O resultado deve ser multiplicado por 100 e expresso como a porcentagem da área total da cidade coberta por mapas de ameaças disponíveis ao público. Convém que estes mapas sejam disponíveis ao público e cubram a cidade inteira.',
          ],
        },
        {
          'Áreas e espaços públicos permeáveis e pavimentos construídos com materiais porosos e drenantes como porcentagem da área territorial da cidade':
              [
            'null',
            'a área total de espaços públicos permeáveis e pavimentos construídos com materiais porosos e drenantes (numerador) dividido pela área territorial total da cidade (denominador)',
            'A porcentagem de áreas e espaços públicos permeáveis e pavimentos construídos com materiais porosos e drenantes como porcentagem da área territorial total da cidade deve ser calculada como a área total de espaços públicos permeáveis e pavimentos construídos com materiais porosos e drenantes (numerador) dividido pela área territorial total da cidade (denominador). O resultado deve ser multiplicado por 100 e expresso como a porcentagem de áreas e espaços públicos permeáveis e pavimentos construídos com materiais porosos e drenantes como porcentagem da área territorial da cidade.  O termo área permeável deve se referir a todas as superfícies permeáveis na cidade que permitem a absorção e a drenagem da água. Superfícies permeáveis englobam áreas de vegetação (por exemplo, gramíneas e forestas), solo nu (por exemplo, jardins, terrenos agrícolas), areia (por exemplo, praias, deserto) e água (por exemplo, lagos, rios). Áreas permeáveis também abrangem telhados verdes em edifícios. Presume-se que as áreas sem cobertura permeável estejam vedadas (isto é, pavimentadas ou impermeáveis).',
          ],
        },
        {
          'Porcentagem de área territorial da cidade em zonas de alto risco em que medidas de redução de riscos foram implementadas':
              [
            'null',
            'a área territorial da cidade em zonas de alto risco em que medidas de redução de riscos foram implementadas, em quilômetros quadrados (numerador) dividida pela área territorial da cidade em zonas de alto risco, em quilômetros quadrados (denominador).',
            'A porcentagem de área territorial da cidade em zonas de alto risco em que medidas de redução de riscos foram implementadas deve ser calculada como a área territorial da cidade em zonas de alto risco em que medidas de redução de riscos foram implementadas, em quilômetros quadrados (numerador) dividida pela área territorial da cidade em zonas de alto risco, em quilômetros quadrados (denominador). O resultado deve ser multiplicado por 100 e expresso como a porcentagem de área territorial da cidade em zonas de alto risco em que medidas de redução de riscos foram implementadas. O termo medidas de redução de riscos deve se referir às atividades projetadas para aplicar ou capacitar diretamente os atores locais para conter a vulnerabilidade e os riscos humanos locais e melhorar a capacidade e as ações adaptativas a curto e longo prazo. As medidas de redução de riscos englobam, mas não se limitam a, obras de proteção. O termo infraestrutura de proteção deve se referir às estruturas físicas e amortecedores naturais que minimizam os impactos físicos, humanitários e econômicos das ameaças (por exemplo, diques e barreiras contra inundações; bacias de inundação; quebra-mar; drenos pluviais e tanques de contenção de águas pluviais; zonas úmidas e manguezais; e recursos de absorção de choques instalados na infraestrutura para lidar com terremotos).',
          ],
        },
        {
          'Porcentagem de departamentos e serviços de utilidades da cidade que realizam avaliação de riscos em seu planejamento e investimento':
              [
            'null',
            'o número de departamentos e serviços de utilidades que realizam avaliação de riscos em seu planejamento e investimento (numerador) dividido pelo número total de departamentos e serviços de utilidades da cidade (denominador)',
            'A porcentagem de departamentos e serviços de utilidades da cidade que realizam avaliação de riscos em seu planejamento e investimento deve ser calculada como o número de departamentos e serviços de utilidades que realizam avaliação de riscos em seu planejamento e investimento (numerador) dividido pelo número total de departamentos e serviços de utilidades da cidade (denominador). O resultado deve ser multiplicado por 100 e expresso como a porcentagem de departamentos e serviços de utilidades da cidade que realizam avaliação de riscos em seu planejamento e investimento. O termo serviços de utilidades deve se referir a todas as empresas públicas e privadas que prestam serviços e a instalações básicas relacionadas a energia elétrica, gás natural, água, esgoto, gestão de resíduos e telecomunicações. O termo avaliação de risco deve se referir ao processo sistemático de avaliação de potenciais riscos de ameaças e desastres a pessoas, grupos, organizações, ativos críticos e infraestrutura de proteção na cidade. A fnalidade de uma avaliação regular de riscos é (i) garantir que as atividades de construção de resiliência sejam relevantes para o contexto da cidade; (ii) garantir o investimento adequado e proporcional de recursos, de acordo com os riscos, ameaças, choques e tensões; (iii) possibilitar a compreensão das diferentes exposições e vulnerabilidades de risco da cidade; e (iv) permitir que consequências comuns sejam identifcadas para que possam ser desenvolvidos recursos que abordem o impacto de muitos riscos em combinação (ISO 31000:2018, Anexo C). Os resultados de uma avaliação de risco devem ser transmitidos parcialmente por meio de mapas, quer sejam de ameaças, vulnerabilidade, exposição, evacuação ou riscos.',
          ],
        },
        {
          'Número anual de infraestruturas críticas inundadas como porcentagem da infraestrutura crítica na cidade':
              [
            'null',
            'o número anual de infraestruturas críticas inundadas na cidade (numerador) dividido pelo número total de infraestruturas críticas na cidade (denominador)',
            'O número anual de infraestruturas críticas inundadas como porcentagem da infraestrutura crítica na cidade deve ser calculado como o número anual de infraestruturas críticas inundadas na cidade (numerador) dividido pelo número total de infraestruturas críticas na cidade (denominador). O resultado deve ser multiplicado por 100 e expresso como o número anual de infraestruturas críticas inundadas como porcentagem da infraestrutura crítica na cidade. Infraestruturas críticas devem se referir às estruturas físicas, instalações, redes e outros ativos que prestam serviços essenciais ao funcionamento social e econômico de uma comunidade ou sociedade. Infraestruturas críticas podem incluir, mas não se limitam a, geração, transmissão e distribuição de energia, tratamento, distribuição e drenagem de águas, infraestrutura de esgotos e de águas pluviais, transporte, abastecimento e distribuição de gás, infraestrutura de telecomunicações, instalações educacionais, hospitais e outras instalações de saúde.',
          ],
        },
        {
          'Despesas anuais em medidas de retenção de água como porcentagem do orçamento de medidas de prevenção da cidade':
              [
            'null',
            'o orçamento total das medidas de retenção de água (numerador) dividido pelo orçamento total das medidas de prevenção da cidade (denominador).',
            'As despesas anuais em medidas de retenção de água como porcentagem do orçamento de medidas de prevenção da cidade devem ser calculadas como o orçamento total das medidas de retenção de água (numerador) dividido pelo orçamento total das medidas de prevenção da cidade (denominador). O resultado deve ser multiplicado por 100 e expresso como uma porcentagem. As medidas de prevenção de enchentes devem se referir à construção de obras de tanques de amortecimento/controle de inundações para confnar o corpo d’água, à adaptação das infraestruturas subterrâneas existentes (por exemplo, estacionamentos de carros) como tanques de contenção para águas pluviais e paisagismo de espaços públicos (por exemplo, parques) para servir como planície de inundação em caso de enchente.',
          ],
        },
      ],
      'Água': [
        {
          'Número de fontes diferentes que fornecem pelo menos 5% da capacidade total de abastecimento de água':
              [
            data[indexSelected0]['data']['numeroFontesCapitacaoAgua'],
            'O número de fontes diferentes de fornecimento de água que fornecem pelo menos 5% da capacidade total de abastecimento de água deve referir-se ao número de fontes diferentes, ou separadas, de fornecimento de água para a cidade, cada qual fornecendo pelo menos 5% da capacidade total de abastecimento de água.',
            'O número de fontes diferentes de fornecimento de água que fornecem pelo menos 5 % da capacidade total de abastecimento de água deve referir-se ao número de fontes diferentes, ou separadas, de fornecimento de água para a cidade, cada qual fornecendo pelo menos 5 % da capacidade total de abastecimento de água. NOTA O patamar de 5 % é utilizado por organizações internacionais, como o Banco Mundial, por exemplo, para facilitar os cálculos e capturar as principais fontes de fornecimento. Quando houver mais de duas fontes diferentes de fornecimento de água, convém que a porcentagem da capacidade de abastecimento de água das duas fontes mais signifcativas seja reportada em tabelas. Uma fonte diferente (ou separada) de fornecimento de água deve se referir às fontes de água que não são interrompidas ou diretamente infuenciadas por outras fontes. As fontes de abastecimento de água devem incluir barragens, reservatórios, rios, lagos, aquíferos e usinas de dessalinização.',
          ],
        },
        {
          'Porcentagem da população da cidade que pode ser abastecida de água potável por métodos alternativos por 72 h':
              [
            'null',
            'o número de pessoas na cidade que podem ser abastecidas de água potável por métodos alternativos por 72 h (numerador) dividido pela população total da cidade (denominador).',
            'A porcentagem da população da cidade que pode ser abastecida de água potável por métodos alternativos por 72 h deve ser calculada como o número de pessoas na cidade que podem ser abastecidas de água potável por métodos alternativos por 72 h (numerador) dividido pela população total da cidade (denominador). O resultado deve ser multiplicado por 100 e expresso como a porcentagem da população da cidade que pode ser abastecida de água potável por métodos alternativos por 72 h. Os métodos alternativos de abastecimento de água devem englobar tanques de água de emergência, água engarrafada e captação de água da chuva.',
          ],
        },
      ],
    };
  }

  setInfos1() {
    _infos1 = {
      data[indexSelected1]['data']['nome']: [
        {
          'População': [
            data[indexSelected1]['data']['populacao'] + ' hab',
            'null',
          ],
        },
        {
          'Área': [
            data[indexSelected1]['data']['areaMunicipio']['area'] + ' km^2',
            'null',
          ],
        },
        {
          'Densidade Demográfica': [
            data[indexSelected1]['data']['areaMunicipio']['densidade'] +
                ' hab/Km^2',
            'null',
          ],
        },
      ],
      'Economia': [
        {
          'Perdas históricas por desastres como porcentagem do produto da cidade':
              [
            'null',
            'Perdas econômicas diretas por desastre(s) na cidade somadas ao longo de um período de cinco anos (numerador) divididos pela soma total do produto da cidade ao longo do mesmo período (denominador)',
            'Perdas históricas por desastres como porcentagem do produto da cidade devem ser calculadas como perdas econômicas diretas por desastre(s) na cidade somadas ao longo de um período de cinco anos (numerador) divididos pela soma total do produto da cidade ao longo do mesmo período (denominador). O resultado deve ser multiplicado por 100 e expresso como perdas históricas por desastres como porcentagem de produto da cidade. O produto urbano pode ser obtido da ISO 37120:2018, 5.9.3. Perdas históricas por desastres devem se referir a perdas (em termos monetários) que resultam de desastres. Estas perdas são associadas a danos ou destruição de infraestrutura física, social e crítica dentro dos limites administrativos da cidade (mesmo se não estiverem sob a jurisdição da cidade). A infraestrutura física se refere às estruturas de construção, sistemas e ativos necessários para a economia de uma cidade funcionar, incluindo as redes de transporte, serviços de telecomunicações, redes de energia, sistemas de esgoto e eliminação de resíduos, abastecimento de água, edifícios e instalações da cidade e moradias. A infraestrutura social é um subconjunto importante da estrutura física e inclui as estruturas que acomodam os serviços sociais, como escolas, universidades, hospitais e prisões. A infraestrutura crítica se refere aos sistemas, serviços ou ativos (físicos ou virtuais) vitais para o bem-estar da sociedade',
          ],
        },
        {
          'Perda anual média por desastres como porcentagem do produto da cidade':
              [
            'null',
            'Perda econômica média resultante diretamente de desastre(s), estimada por cenários de modelagem de catástrofe em toda a cidade (numerador) pelo produto total da cidade (denominador)',
            'A perda anual média por desastres como porcentagem de produto da cidade deve ser calculada como a perda econômica média resultante diretamente de desastre(s), estimada por cenários de modelagem de catástrofe em toda a cidade (numerador), dividida pelo produto total da cidade (denominador). O resultado deve ser multiplicado por 100 e expresso como perda anual média por desastres como porcentagem do produto da cidade. O termo perdas econômicas diretas deve se referir a perdas (em termos monetários) que resultam de desastres. Estas perdas são associadas a danos ou destruição de infraestrutura física, social e crítica dentro dos limites administrativos da cidade (mesmo se não estiverem sob a jurisdição da cidade). A infraestrutura física se refere às estruturas de construção, sistemas e ativos necessários para a economia de uma cidade funcionar, incluindo as redes de transporte, serviços de telecomunicações, redes de energia, sistemas de esgoto e eliminação de resíduos, abastecimento de água, edifícios e instalações da cidade e moradias. A infraestrutura social é um subconjunto importante da estrutura física e inclui as estruturas que acomodam os serviços sociais, como escolas, universidades, hospitais e prisões. A infraestrutura crítica se refere aos sistemas, serviços ou ativos (físicos ou virtuais) vitais para o bem-estar da sociedade',
          ],
        },
        {
          'Porcentagem de propriedades com cobertura de seguro para ameaças de alto risco':
              [
            'null',
            'Número total de propriedades (residenciais e não residenciais) da cidade com cobertura de seguro para as ameaças de alto risco que afetam a cidade (numerador) dividido pelo número total de propriedades (domicílios e empresas) na cidade (denominador)',
            'A porcentagem de propriedades com cobertura de seguro para ameaças de alto risco deve ser calculada como o número total de propriedades (residenciais e não residenciais) da cidade com cobertura de seguro para as ameaças de alto risco que afetam a cidade (numerador) dividido pelo número total de propriedades (domicílios e empresas) na cidade (denominador). O resultado deve ser multiplicado por 100 e expresso como a porcentagem de propriedades com cobertura de seguro para ameaças de alto risco. Propriedades residenciais devem se referir a habitações (ou estruturas) classifcadas para uso residencial. Convém que exemplos de propriedades residenciais incluam, mas não se limitem a, habitações unifamiliares, habitações móveis, habitações geminadas, casas geminadas, condomínios e edifícios de apartamentos. Propriedades não residenciais devem se referir a estruturas classifcadas para uso não residencial. Convém que exemplos de propriedades não residenciais incluam, mas não se limitem a, edifícios de escritórios/edifícios comerciais privados, hotéis, restaurantes, edifícios do governo, edifícios institucionais (por exemplo, instalações educacionais e de saúde), fábricas e outras propriedades especiais isentas (por exemplo, espaços recreativos não comerciais, locais de culto, funerárias e cemitérios). Quando possível, convém reportar os dados de cobertura de seguro de cada setor (isto é, residencial e não residencial) e as ameaças cobertas, e listá-los em tabelas. Para os fns deste indicador, ameaças de alto risco devem se referir às ameaças para as quais exista uma probabilidade de evento(s) extremo(s) com base em mapas de ameaças gerados pela cidade que possa(m) afetar signifcativamente muitas propriedades na cidade e/ou ter um grande impacto na cidade. Este indicador abrange seguro patrimonial e exclui cobertura pessoal ou de vida. O seguro pode vir de vários prestadores públicos ou privados',
          ],
        },
        {
          'Porcentagem do valor total segurado em relação ao valor total em risco dentro da cidade':
              [
            'null',
            'O valor total segurado de todas as propriedades residenciais e não residenciais dentro da cidade (numerador) pelo valor total de todas as propriedades residenciais e não residenciais na cidade (denominador)',
            'A porcentagem do valor total segurado em relação ao valor total em risco dentro da cidade deve ser calculada como o valor total segurado de todas as propriedades residenciais e não residenciais dentro da cidade (numerador) dividido pelo valor total de todas as propriedades residenciais e não residenciais na cidade (denominador). O resultado deve ser multiplicado por 100 e expresso como a porcentagem do valor total segurado em relação ao valor total em risco dentro da cidade. Propriedades residenciais devem se referir a habitações (ou estruturas) classifcadas para uso residencial. Convém que exemplos de propriedades residenciais incluam, mas não se limitem a, habitações unifamiliares, habitações móveis, habitações geminadas, casas geminadas, condomínios e edifícios de apartamentos. Propriedades não residenciais devem se referir a estruturas classifcadas para uso não residencial. Convém que exemplos de propriedades não residenciais incluam, mas não se limitem a, edifícios de escritórios/edifícios comerciais privados, hotéis, restaurantes, edifícios do governo, edifícios institucionais (por exemplo, instalações educacionais e de saúde), fábricas e outras propriedades especiais isentas (por exemplo, espaços recreativos não comerciais, locais de culto, funerárias e cemitérios). Quando possível, convém reportar os dados de cobertura de seguro de cada setor (isto é, residencial e não residencial) e as ameaças cobertas, e listá-los em tabelas.',
          ],
        },
        {
          'Concentração de empregos': [
            (100 *
                        int.parse(
                            data[indexSelected1]['data']['popEmpregada']) /
                        int.parse(data[indexSelected1]['data']['popEconAtiva']))
                    .toStringAsFixed(2) +
                '%',
            'Número de pessoas na cidade empregadas nos três maiores setores da economia local (conforme medido pelo emprego total) (numerador)  (OBS: total de trabalhadores ) dividido pela força de trabalho total da cidade (denominador)',
            'A concentração de empregos deve ser calculada como o número de pessoas na cidade empregadas nos três maiores setores da economia local (conforme medido pelo emprego total) (numerador) dividido pela força de trabalho total da cidade (denominador). O resultado deve ser multiplicado por 100 e expresso como uma porcentagem. A força de trabalho deve se referir à soma do total de pessoas empregadas e desempregadas legalmente aptas para trabalhar e que são residentes na cidade. Normalmente, isto engloba todos os adultos economicamente ativos entre 15 e 64 anos, mas a idade específca varia de país para país. Os setores utilizados para o cálculo deste indicador devem ser defnidos conforme a Classifcação Internacional Normalizada Industrial de Todas as Atividades Econômicas, Rev. 4 [8] ou uma classifcação equivalente.',
          ],
        },
        {
          'Porcentagem da força de trabalho em empregos informais': [
            ((int.parse(data[indexSelected1]['data']['popInformal'][0]) +
                        int.parse(
                            data[indexSelected1]['data']['popInformal'][1])) /
                    int.parse(data[indexSelected1]['data']['popEconAtiva']))
                .toStringAsFixed(2),
            'Número de pessoas que trabalham em empregos informais (numerador) dividido pela força de trabalho total da cidade (denominador)',
            'A porcentagem da força de trabalho em empregos informais deve ser calculada como o número de pessoas que trabalham em empregos informais (numerador) dividido pela força de trabalho total da cidade (denominador). Este resultado deve ser multiplicado por 100 e expresso como a porcentagem da força de trabalho em empregos informais. O emprego informal deve se referir ao emprego em que a relação de trabalho não esteja, por lei ou na prática, sujeita à legislação trabalhista nacional, imposto de renda, proteção social ou direito a certos benefícios trabalhistas (por exemplo, aviso prévio de dispensa, pagamento de verbas rescisórias, férias anuais pagas ou licença médica). Os motivos podem ser a não declaração dos empregos ou dos funcionários; trabalhos temporários ou trabalhos de curta duração; empregos com horas de trabalho ou salários abaixo de um patamar especifcado (por exemplo, para contribuições de previdência social); emprego por empresas não registradas ou por pessoas em domicílios; empregos em que o local de trabalho do funcionário esteja fora das instalações da empresa do empregador (por exemplo, trabalhadores externos sem contrato de trabalho); ou trabalhos aos quais a legislação trabalhista não se aplica, não é aplicada ou não é cumprida por qualquer outro motivo. Os critérios operacionais para defnição de trabalhos informais de funcionários devem ser determinados de acordo com circunstâncias nacionais e disponibilidade de dados [10]. Convém que emprego informal inclua trabalhadores autônomos empregados em suas próprias empresas do setor informal, empregadores empregados em suas próprias empresas do setor informal, trabalhadores familiares contribuintes, independentemente de trabalharem em empresas do setor formal ou informal, membros de cooperativas de produtores informais, funcionários que mantêm empregos informais em empresas do setor formal, empresas do setor informal ou como trabalhadores domésticos remunerados empregados pelas famílias; e trabalhadores autônomos envolvidos na produção de bens exclusivamente para uso fnal próprio por suas famílias [10]. A força de trabalho deve se referir à soma do total de pessoas empregadas e desempregadas legalmente qualifcadas para trabalhar',
          ],
        },
        {
          'Renda familiar média líquida': [
            'null',
            'O valor total da renda disponível para os gastos e poupança após subtração dos impostos de renda e contribuições previdenciárias durante o ano civil por todas as famílias dentro dos limites da cidade (numerador) dividida pelo número total de famílias dentro dos limites da cidade (denominador)',
            'A renda familiar média líquida deve ser calculada como o valor total da renda disponível para os gastos e poupança após subtração dos impostos de renda e contribuições previdenciárias durante o ano civil por todas as famílias dentro dos limites da cidade (numerador) dividida pelo número total de famílias dentro dos limites da cidade (denominador). O resultado deve ser expresso como a renda média disponível das famílias em dólares. A renda familiar líquida deve incluir a renda disponível de todos os membros da família com 15 anos ou mais. NOTA BRASILEIRA Conforme a legislação vigente, entre os direitos e garantias fundamentais estão a “proibição de trabalho noturno, perigoso ou insalubre a menores de 18 anos e de qualquer trabalho a menores de 16 anos, salvo na condição de aprendiz, a partir de 14 anos”. Para fazer a conversão da moeda local, as cidades devem usar as taxas publicadas pelo US Federal Reserve Bank (FED) (Banco Central dos EUA): https://www.newyorkfed.org/markets/internationalmarket-operations/foreign-exchange-operations . As cidades também devem observar a taxa e a data de conversão.',
          ],
        },
      ],
      'Educação': [
        {
          'Porcentagem de escolas que ensinam preparação para situações de emergência situações de emergência e redução de riscos de desastres':
              [
            'null',
            'o número de escolas dentro da cidade que ensinam a preparação para situações de emergência e redução de riscos de desastres (numerador) dividido pelo número total de escolas na cidade (denominador)',
            'A porcentagem de escolas que ensinam preparação para situações de emergência e redução de riscos de desastres deve ser calculada como o número de escolas dentro da cidade que ensinam a preparação para situações de emergência e redução de riscos de desastres (numerador) dividido pelo número total de escolas na cidade (denominador). O resultado deve ser multiplicado por 100 e expresso como porcentagem das escolas que ensinam preparação para emergências e redução de riscos de desastres. Escolas devem se referir às instituições educacionais de ensino primário e secundário. As atividades de preparação para situações de emergência e redução de riscos de desastres devem se referir aos exercícios de treinamento e programas de conscientização, por exemplo, mas não limitadas a, simulações de evacuação, prática/ensaio de protocolos de emergência, testes da capacidade de realização de possíveis rotas de evacuação e avaliação dos tempos de resposta para os serviços de emergência.',
          ],
        },
        {
          'Porcentagem da população treinada em preparação para situações de emergência e redução de riscos de desastres':
              [
            'null',
            'o número total de pessoas dentro da cidade treinadas pelas autoridades responsáveis nas atividades de preparação para emergências e redução de riscos de desastres nos 12 meses anteriores (numerador) dividido pela população total da cidade (denominador)',
            'A porcentagem da população treinada em preparação para situações de emergência e redução de riscos de desastres deve ser calculada como o número total de pessoas dentro da cidade treinadas pelas autoridades responsáveis nas atividades de preparação para emergências e redução de riscos de desastres nos 12 meses anteriores (numerador) dividido pela população total da cidade (denominador). O resultado deve ser multiplicado por 100 e expresso como porcentagem da população treinada em preparação para emergências e redução de riscos de desastres. As atividades de preparação para situações de emergência e redução de riscos de desastres devem se referir aos exercícios de treinamento e programas de conscientização, por exemplo, mas não limitadas a, simulações de evacuação, prática/ensaio de protocolos de emergência, testes da capacidade de realização de possíveis rotas de evacuação e avaliação dos tempos de resposta para os serviços de emergência.',
          ],
        },
        {
          'Porcentagem de publicações de preparação para emergências fornecidas em idiomas alternativos':
              [
            'null',
            'o número de publicações de preparação para emergências fornecidas em idiomas alternativos dentro da cidade (numerador) dividido pelo número total de publicações de preparação para emergências publicadas pela cidade (denominador).',
            'A porcentagem das publicações de preparação para emergências fornecidas em idiomas alternativos deve ser calculada como o número de publicações de preparação para emergências fornecidas em idiomas alternativos dentro da cidade (numerador) dividido pelo número total de publicações de preparação para emergências publicadas pela cidade (denominador). O resultado deve ser multiplicado por 100 e expresso como a porcentagem de publicações de preparação para emergências fornecidas em idiomas alternativos. Idiomas alternativos devem se referir a outros idiomas que não seja o idioma falado na cidade, incluindo aqueles que não têm status ofcial ou legal com o governo municipal.',
          ],
        },
        {
          'Interrupção educacional': [
            'null',
            'o número de horas de ensino perdidas anualmente devido a choques ou estresses',
            'A interrupção educacional deve ser calculada como o número de horas de ensino perdidas anualmente devido a choques ou estresses. As horas de ensino perdidas devem se referir às horas em que as instituições educacionais não são operacionais durante as horas regulares de ensino. Qualquer fechamento de um estabelecimento de ensino na cidade deve ser contabilizado. Várias instalações educacionais fechadas na mesma data do calendário devem ser contabilizadas como uma, a fm de evitar a contagem dupla. Por exemplo, se houver várias instalações educacionais fechadas por 8 h no mesmo dia, apenas 8 h serão contadas para aquele dia e não multiplicadas pelo número de instalações afetadas.',
          ],
        },
      ],
      'Energia': [
        {
          'Número de diferentes fontes de energia elétrica que fornecem pelo menos 5% da capacidade total de fornecimento de energia':
              [
            'null',
            'O número de diferentes fontes de fornecimento de energia elétrica que fornecem pelo menos 5% da capacidade total de fornecimento de energia deve se referir ao número de fontes de fornecimento de energia diferentes, ou separadas, para a cidade, cada qual fornecendo pelo menos 5 % da capacidade total de fornecimento de energia.',
            'O número de diferentes fontes de fornecimento de energia elétrica que fornecem pelo menos 5 % da capacidade total de fornecimento de energia deve se referir ao número de fontes de fornecimento de energia diferentes, ou separadas, para a cidade, cada qual fornecendo pelo menos 5 % da capacidade total de fornecimento de energia. NOTA O patamar de 5 % é utilizado por organizações internacionais, como o Banco Mundial, por exemplo, para facilitar os cálculos e capturar as principais fontes de fornecimento. Quando o número de diferentes fontes de energia elétrica exceder dois, convém que a porcentagem da capacidade de fornecimento de energia de cada fonte seja reportada. Além de fornecer o número de diferentes fontes de fornecimento de energia elétrica e capacidade de fornecimento de cada fonte, convém que o número de diferentes fontes de fornecimento de energia elétrica e o valor total de energia fornecida para a cidade (GJ) por estas fontes sejam reportados',
          ],
        },
        {
          'Capacidade de fornecimento de energia elétrica como porcentagem da demanda de pico de energia elétrica':
              [
            'null',
            'A capacidade de fornecimento de energia elétrica disponível para a cidade (numerador) dividida pela média mensal das demandas de pico de energia elétrica da cidade ao longo do ano (denominador)',
            'A capacidade de fornecimento de energia elétrica como porcentagem da demanda de pico de energia elétrica deve ser calculada como a capacidade de fornecimento de energia elétrica disponível para a cidade (numerador) dividida pela média mensal das demandas de pico de energia elétrica da cidade ao longo do ano (denominador). O resultado deve ser multiplicado por 100 e expresso como a capacidade de fornecimento de energia elétrica como a porcentagem da demanda de pico de energia elétrica. A capacidade de fornecimento de energia elétrica deve se referir ao fornecimento máximo previsto disponível de energia elétrica para atender às demandas de pico de energia elétrica projetadas, incluindo reservas de fornecimento para atender a perdas inesperadas, interrupções ou picos de demanda. Demandas de picos de energia elétrica devem se referir ao nível mais alto de necessidade de energia elétrica por parte dos consumidores em todo um período específco. A demanda de pico futua com os ciclos de atividade humana, a hora do dia, a estação do ano, climas extremos e a atividade industrial.',
          ],
        },
        {
          'Porcentagem de instalações críticas atendidas por serviços de energia fora da rede':
              [
            'null',
            'o número de instalações críticas atendidas por serviços de energia fora da rede (numerador) dividido pelo número total de instalações críticas na cidade (denominador).',
            'A porcentagem de instalações críticas atendidas por serviços de energia fora da rede deve ser calculada como o número de instalações críticas atendidas por serviços de energia fora da rede (numerador) dividido pelo número total de instalações críticas na cidade (denominador). O resultado deve ser multiplicado por 100 e expresso como a porcentagem de instalações críticas atendidas por serviços de energia fora da rede. Instalação crítica deve se referir à uma instalação que presta serviços e funções essenciais para uma cidade, especialmente durante e após um desastre. As categorias de instalações críticas incluem, entre outras, respostas a emergências (por exemplo, incêndios, resgates e delegacia de polícia), médicas (por exemplo, hospitais, instalações de cuidados intensivos e ambulatórios), abrigos de emergência (por exemplo, edifícios escolares públicos e instalações de ônibus escolares sendo utilizados como abrigos em caso de emergência), redes vitais (por exemplo, sistemas de distribuição e instalações correlatas necessárias para fornecer energia elétrica), transporte (por exemplo, estradas, pontes, túneis, linhas e estações ferroviárias), telecomunicações (por exemplo, centrais de comutação de telefone e telefone celular e torres de antena ou retransmissão), centrais de dados (por exemplo, instalações e sistemas que fornecem recursos locais de informática e de Internet e instalações para armazenamento de informações críticas), instituições fnanceiras (por exemplo, bancos centrais e comerciais), principais organizações industriais/comerciais (por exemplo, principais empregadores sem os quais a comunidade não seria capaz de se sustentar) e outras instalações e serviços relacionados que são essenciais para o bem-estar da comunidade atendida por estes sistemas. Quando possível, os tipos de instalações críticas inclusas devem ser indicados. Este indicador deve incluir apenas as instalações críticas situadas dentro dos limites administrativos da cidade. Serviços de energia fora da rede devem se referir tanto aos sistemas de energia independentes como às minirredes de energia que não estão conectados à rede primária central de energia para geração de energia em larga escala em instalações centralizadas, e geralmente utilizam células de bateria e/ou combustível como fonte de energia. Sistemas de energia independentes devem se referir a sistemas de energia muitas vezes utilizados para energizar aparelhos individuais e para usuários que não estejam conectados à rede primária central de energia fora das dependências do usuário. Uma minirrede de energia deve se referir a um pequeno sistema de rede de energia que fornece energia para usuários que não estejam conectados à rede primária central de energia. Além disto, a produção de energia autônoma sem ligação com a rede pública de energia engloba uma ampla gama de tecnologias, tais como, mas não limitadas a, turbinas ou usinas eólicas, painéis fotovoltaicos (solares), microturbinas e motores modulares de combustão interna. Exemplos de serviços de energia fora da rede englobam, mas não se limitam a, minirredes de energia que fornecem energia elétrica para as comunidades (por exemplo, a Brooklyn Microgrid), instalações críticas e edifícios institucionais e geração de energia solar fotovoltaica que utiliza painéis solares que fornecem energia a domicílios residenciais, instalações críticas e edifícios institucionais. Convém que as cidades contabilizem as instalações críticas com capacidade de operar em “modo ilha” no cálculo deste indicador. O modo ilha deve se referir à capacidade de uma instalação crítica passar da operação na rede local de energia para a operação isolada da rede local de energia. Convém reportar a proporção de instalações críticas que são atendidas exclusivamente por serviços de energia fora da rede e têm a capacidade de operar em modo ilha, e convém que as cidades verifquem se os dados das instalações críticas com capacidade de operar em modo ilha estão inclusos.',
          ],
        },
      ],
      'Meio ambiente e mudanças climáticas': [
        {
          'Magnitude dos efeitos (atmosféricos) das ilhas de calor urbana': [
            'null',
            'diferença entre as temperaturas médias diárias do ar registradas simultaneamente em uma área urbana e uma área não urbana, calculadas como média ao longo do período de 12 meses.',
            'O efeito das ilhas de calor urbanas deve ser calculado como a diferença entre as temperaturas médias diárias do ar registradas simultaneamente em uma área urbana e uma área não urbana, calculadas como média ao longo do período de 12 meses. A área urbana deve se referir a uma parte central da cidade na ordem de diversos hectares, com prédios próximos, estradas pavimentadas, fuxo de tráfego intenso e alta densidade populacional. A área não urbana deve se referir a uma parte periférica da cidade na ordem de diversos hectares, com poucos prédios e estradas, abundante cobertura natural da terra e baixa densidade populacional. Convém que as cidades descrevam os dois locais dos sensores de temperatura (ou estações climáticas) utilizadas para medir a magnitude da ilha de calor (por exemplo, parque, aeroporto, centro da cidade, área agrícola). Isto é necessário para transmitir a representatividade local dos valores medidos, as atividades físicas, demográfcas e humanas representativas da área ao redor dos dois instrumentos (ou estações) e a sua infuência nas temperaturas registradas. Referências às “zonas climáticas urbanas” (ZCU) são úteis neste aspecto. As diretrizes da Organização Meteorológica Mundial (OMM) para a observação de temperaturas em áreas urbanas e não urbanas devem ser seguidas [12]. Se disponível, convém que as cidades informem o local dos sensores ou acrescentem um mapa para indicar os locais',
          ],
        },
        {
          'Porcentagem de áreas naturais dentro da cidade submetidas a avaliação ecológica de seus serviços de proteção':
              [
            'null',
            'o total de áreas naturais de propriedade pública dentro da cidade submetidas a avaliação ecológica de seus serviços de proteção (numerador) dividido pelo total de áreas naturais de propriedade pública na cidade (denominador).',
            'A porcentagem de áreas naturais dentro da cidade submetidas a avaliação ecológica de seus serviços de proteção deve ser calculada como o total de áreas naturais de propriedade pública dentro da cidade submetidas a avaliação ecológica de seus serviços de proteção (numerador) dividido pelo total de áreas naturais de propriedade pública na cidade (denominador). O resultado deve ser multiplicado por 100 e expresso como a porcentagem de áreas naturais dentro da cidade submetidas a avaliação ecológica de seus serviços de proteção. Áreas naturais devem se referir a espaços ou zonas geográfcos cujas características distintivas surgiram naturalmente ou cuja cobertura predominante do território e características da paisagem são naturais (isto é, solo, areia, água ou vegetação) em vez de construídas (isto é, materiais de construção impermeáveis). Os serviços de proteção são benefícios diretos fornecidos por ativos ecológicos para impedir ou reduzir os impactos negativos das ameaças nas cidades e em seus cidadãos. A avaliação ecológica deve se referir a uma avaliação formal ou classifcação dos serviços de proteção fornecidos pelos ativos e sistemas ecológicos na área defnida. Embora esteja fora do escopo para este indicador, o ideal é que também sejam realizadas avaliações dos ecossistemas que estão além dos limites da cidade, mas que fornecem importantes serviços ecológicos à cidade (por exemplo, bacias hidrográfcas a montante). Isto pode requerer colaboração transfronteiriça com administrações de outras cidades, órgãos regulatórios e outras partes interessadas. Também fora do escopo deste documento estão as avaliações ecológicas de proprietários privados, usando os seus próprios recursos. Embora os ativos ecológicos de propriedade privada forneçam o mesmo serviço de proteção que as terras públicas, eles podem ser difíceis de avaliar.',
          ],
        },
        {
          'Território em processo de restauração de ecossistemas como porcentagem da área total da cidade':
              [
            'null',
            'território em processo de restauração de ecossistemas dentro dos limites da cidade em quilômetros quadrados (numerador) dividido pela área total da cidade em quilômetros quadrados (denominador)',
            'O território em processo de restauração de ecossistemas como porcentagem da área total da cidade deve ser calculado como território em processo de restauração de ecossistemas dentro dos limites da cidade em quilômetros quadrados (numerador) dividido pela área total da cidade em quilômetros quadrados (denominador). O resultado deve ser multiplicado por 100 e expresso como uma porcentagem. A restauração de ecossistemas deve se referir ao processo de recuperação natural e elementos seminaturais da paisagem (isto é, relacionados ao solo, corpos d’água e vegetação) que foram degradados, danifcados ou destruídos. Os elementos de vegetação para restauração variam em escala espacial, de fleiras individuais de árvores a sistemas de vales inteiros; elementos de água variam de lagoas únicas a cursos de água inteiros. Exemplos de trabalho de restauração de ecossistemas incluem o recondicionamento de aterros ou campos degradados para parques ou outros usos recreativos.',
          ],
        },
        {
          'Frequência anual dos eventos de tempestades extremas': [
            'null',
            'número de eventos de tempestades extremas em um dado ano. Os eventos de tempestades extremas devem se referir aos eventos de precipitação em que 50 mm ou mais de chuva tenham caído sobre a cidade durante um período de 24 h',
            'A frequência anual de eventos de tempestades extremas deve ser calculada como o número de eventos de tempestades extremas em um dado ano. Os eventos de tempestades extremas devem se referir aos eventos de precipitação em que 50 mm ou mais de chuva tenham caído sobre a cidade durante um período de 24 h. Quando relevantes e disponíveis, convém reportar dados mais precisos em nível de subdivisão.',
          ],
        },
        {
          'Frequência anual de eventos de calor extremo': [
            'null',
            'número de eventos de calor extremo em um dado ano.',
            'A frequência anual de eventos de calor extremo deve ser calculada como o número de eventos de calor extremo em um dado ano. Os eventos de calor extremo devem se referir a um longo período de tempo (pelo menos 72 h) com condições climáticas excepcionalmente quentes que colocam em risco a saúde e o bem-estar humano. Os patamares de temperatura do ar específcos do país para defnir os eventos extremos de calor variam. Por exemplo, no Canadá um evento de calor extremo pode ser defnido em 72 h ou mais com temperaturas acima de 30 °C/86 °F (ou um patamar baseado em uma comunidade específca), enquanto que nos EUA um evento de calor extremo pode ser defnido por temperaturas acima de 32 °C/90 °F (ou um patamar baseado em uma comunidade específca). Os que relatam este indicador devem usar o método específco do país e o patamar de temperatura. Convém que as cidades considerem a localização das medições de temperatura do ar para transmitir a representatividade local dos valores relatados (por exemplo, aeroporto, centro da cidade). Quando relevantes e disponíveis, convém reportar dados mais precisos em nível de subdivisão',
          ],
        },
        {
          'Frequência anual de eventos de frio extremo': [
            'null',
            'o número de eventos de frio extremo em um dado ano.',
            'A frequência anual de eventos de frio extremo deve ser calculada como o número de eventos de frio extremo em um dado ano. Os eventos de frio extremo devem se referir a um longo período de tempo (pelo menos 72 h) com condições climáticas excepcionalmente frias que colocam em risco a saúde e o bem-estar humano. Os patamares de temperatura do ar específcos do país para defnir os eventos de frio extremo variam. Por exemplo, no Canadá um evento de frio extremo pode ser defnido como temperaturas do ar ou sensação térmica abaixo de -30 °C/-22 °F (ou um patamar baseado em uma comunidade específca) por pelo menos 72 h, enquanto que nos EUA um evento de frio extremo pode ser defnido como temperaturas do ar ou sensação térmica abaixo de -29 °C/-20 °F (ou um patamar baseado em uma comunidade específca). Os que relatam este indicador devem usar o método específco do país e o patamar de temperatura. Convém que as cidades considerem a localização das medições de temperatura do ar para transmitir a representatividade local dos valores relatados (por exemplo, aeroporto, centro da cidade). Quando relevantes e disponíveis, convém reportar dados mais precisos em nível de subdivisão.',
          ],
        },
        {
          'Frequência anual de eventos de enchentes': [
            'null',
            'número de eventos de enchentes em um dado ano.',
            'A frequência anual de eventos de enchentes deve ser calculada como o número de eventos de enchentes em um dado ano. Um evento de enchente deve se referir a um excesso de água em terra normalmente seca e pode incluir a inundação de uma área normalmente seca causada por um aumento signifcativo no nível da água de um córrego, lago, reservatório ou região costeira. Um evento de enchente também pode incluir concentração de água em ou perto do ponto de chuva. As enchentes são eventos de longo prazo, diferentes das inundações repentinas, com duração de pelo menos 72 h',
          ],
        },
        {
          'Porcentagem da área territorial da cidade coberta por copas de árvores':
              [
            'null',
            'área territorial da cidade coberta por copas de árvores (numerador) dividida pela área territorial total da cidade (denominador).',
            'A porcentagem da área da cidade coberta por copas de árvores deve ser calculada como a área territorial da cidade coberta por copas de árvores (numerador) dividida pela área territorial total da cidade (denominador). O resultado deve ser multiplicado por 100 e expresso como a porcentagem da área territorial da cidade coberta por copas de árvores. As copas de árvores devem se referir à biomassa em camadas de folhas, galhos e caules das árvores que obscurecem a superfície do solo subjacente quando vistas de cima.',
          ],
        },
        {
          'Porcentagem da área da cidade coberta com materiais com alto índice de albedo, o que contribui para a mitigação das ilhas de calor urbanas':
              [
            'null',
            'área total da superfície da cidade (tais como telhados, ruas, calçadas, pátios de escolas e superfícies expostas de estacionamentos), com exclusão dos espaços verdes, materiais permeáveis/drenantes de cores claras com um alto índice de albedo (numerador) dividido pela área total da cidade, com exclusão dos espaços verdes (denominador)',
            'A porcentagem da área da cidade coberta com materiais com alto índice de albedo que contribuem para a mitigação das ilhas de calor urbanas deve ser calculada como a área total da superfície da cidade (tais como telhados, ruas, calçadas, pátios de escolas e superfícies expostas de estacionamentos), com exclusão dos espaços verdes, materiais permeáveis/drenantes de cores claras com um alto índice de albedo (numerador) dividido pela área total da cidade, com exclusão dos espaços verdes (denominador). O resultado deve ser multiplicado por 100 e expresso como a porcentagem da área da cidade coberta com materiais com alto índice de albedo que contribuem para a mitigação das ilhas de calor urbanas.',
          ],
        },
      ],
      'Finanças': [
        {
          'Despesas anuais com atualização e manutenção dos ativos de serviços urbanos como porcentagem do orçamento total da cidade':
              [
            'null',
            'total anual de todos os recursos fnanceiros gastos com manutenção e atualização de ativos para a prestação dos serviços urbanos (numerador) dividido pelo orçamento total anual da cidade (denominador)',
            'As despesas anuais com manutenção e atualização dos ativos de serviços urbanos como porcentagem do orçamento total da cidade devem ser calculadas como o total anual de todos os recursos fnanceiros gastos com manutenção e atualização de ativos para a prestação dos serviços urbanos (numerador) dividido pelo orçamento total anual da cidade (denominador). O resultado deve ser multiplicado por 100 e expresso como as despesas anuais com manutenção e atualização dos ativos de serviços urbanos como porcentagem do orçamento total da cidade. Quando possível, convém incluir os dados dos gastos por tipo de serviço (por exemplo, água, resíduos, transporte) como valores de porcentagem, inclui-los separadamente em uma tabela. Os serviços urbanos variam de cidade para cidade, mas geralmente incluem, embora não se limitem a, saneamento, abastecimento de água, coleta de lixo, transporte público, fornecimento de energia elétrica e gás, iluminação pública e manutenção de vias.',
          ],
        },
        {
          'Despesas anuais com atualização e manutenção de infraestrutura de águas pluviais como porcentagem do orçamento total da cidade':
              [
            'null',
            'total anual de todos os recursos fnanceiros gastos com atualização e manutenção de infraestrutura física e de gestão de águas pluviais (numerador) dividido pelo orçamento total anual da cidade (denominador)',
            'As despesas anuais com atualização e manutenção da infraestrutura de águas pluviais como porcentagem do orçamento total da cidade devem ser calculadas como o total anual de todos os recursos fnanceiros gastos com atualização e manutenção de infraestrutura física e de gestão de águas pluviais (numerador) dividido pelo orçamento total anual da cidade (denominador). O resultado deve ser multiplicado por 100 e expresso como as despesas anuais com atualização e manutenção da infraestrutura de águas pluviais como porcentagem do orçamento total da cidade. A infraestrutura de águas pluviais deve se referir às instalações e estruturas técnicas e organizacionais que são projetadas, instaladas e/ou mantidas para mitigar os efeitos das ameaças da água da chuva e do derretimento de neve nas áreas urbanas. Exemplos de infraestrutura de águas pluviais incluem diques e barreiras contra inundações; bacias de inundação; quebra-mar; drenos pluviais e tanques de contenção de águas pluviais; canais de águas pluviais, bueiros e bacias hidrográfcas.',
          ],
        },
        {
          'Despesas anuais destinadas à restauração de ecossistemas no território da cidade como porcentagem do orçamento total da cidade':
              [
            'null',
            'total de todos os recursos fnanceiros gastos anualmente com ativos de restauração de ecossistemas com o propósito específco de melhorar os serviços de proteção e outros serviços ecossistêmicos que aprimoram a resiliência da cidade (numerador) dividido pelo orçamento total da cidade (denominador)',
            'As despesas anuais com restauração de ecossistemas como porcentagem do orçamento total da cidade devem ser calculadas como o total de todos os recursos fnanceiros gastos anualmente com ativos de restauração de ecossistemas com o propósito específco de melhorar os serviços de proteção e outros serviços ecossistêmicos que aprimoram a resiliência da cidade (numerador) dividido pelo orçamento total da cidade (denominador). O resultado deve ser multiplicado por 100 e expresso como a despesa com a restauração de ecossistemas como porcentagem do orçamento total de capital da cidade. A restauração de ecossistemas deve se referir ao processo de recuperação de elementos naturais e seminaturais da paisagem (isto é, relacionados ao solo, corpos d’água e vegetação) que foram degradados, danifcados ou destruídos.',
          ],
        },
        {
          'Despesas anuais com infraestruturas verde e azul como porcentagem do orçamento total da cidade':
              [
            'null',
            'total de todos os recursos fnanceiros gastos na criação, manutenção ou aprimoramento dos ativos de infraestrutura verde e azul para o propósito específco de prestação de serviços relacionados à infraestrutura para a cidade (numerador) dividido pelo orçamento total da cidade (denominador)',
            'As despesas anuais com infraestruturas verde e azul como porcentagem de orçamento total devem ser calculadas como o total de todos os recursos fnanceiros gastos na criação, manutenção ou aprimoramento dos ativos de infraestrutura verde e azul para o propósito específco de prestação de serviços relacionados à infraestrutura para a cidade (numerador) dividido pelo orçamento total da cidade (denominador). O resultado deve ser multiplicado por 100 e expresso como as despesas com infraestruturas verde e azul como porcentagem do orçamento total da cidade. As infraestruturas verde e azul devem se referir a todos os elementos naturais e seminaturais da paisagem que podem ser amplamente defnidas como uma rede estrategicamente planejada de áreas naturais e seminaturais de alta qualidade com outras características ambientais, a qual é projetada e gerenciada para fornecer uma ampla gama de serviços de infraestrutura e ecossistema e proteger a biodiversidade [15]. Os elementos verdes estão relacionados à vegetação e variam em escala espacial, de fleiras individuais de árvores a sistemas de vales inteiros, e podem incluir, entre outros, as seguintes ações: tornar mais verdes ruas, praças e estradas; tornar mais verdes telhados e fachadas; desenvolver a agricultura urbana; criar corredores verdes urbanos; substituir superfícies impermeáveis; implementar fltração natural de água; rios urbanos à luz do dia; e restaurar aterros. Os elementos azuis estão relacionados a água e variam de lagoas isoladas a cursos de água inteiros e podem incluir, entre outros, corredores de rios, pântanos e outras vias navegáveis.',
          ],
        },
        {
          'Despesas anuais com planejamento do gerenciamento de emergências como porcentagem do orçamento total da cidade':
              [
            'null',
            'total das despesas anuais com planejamento do gerenciamento de emergências (numerador) dividido pelo orçamento anual total da cidade (denominador)',
            'As despesas anuais com planejamento do gerenciamento de emergências como porcentagem do orçamento total da cidade devem ser calculadas como o total das despesas anuais com planejamento do gerenciamento de emergências (numerador) dividido pelo orçamento anual total da cidade (denominador). O resultado deve ser multiplicado por 100 e expresso como despesas anuais com planejamento do gerenciamento de emergências como porcentagem do orçamento total da cidade. O planejamento do gerenciamento de emergências deve se referir ao processo de avaliação dos objetivos da cidade para a redução dos riscos de desastre e preparação para emergências, e criar um plano detalhado de ação para atender a estes objetivos, de forma que a cidade possa responder aos choques e tensões. Os elementos do planejamento do gerenciamento de emergências englobam a determinação das situações de emergências em potencial e as consequências destas situações (isto é, por meio de avaliações de riscos, mapeamento de ameaças/riscos, análise de vulnerabilidades) e identifcação das respostas e procedimentos necessários e adequados para cada situação de emergência (por exemplo, sistemas de alerta, rotas para evacuação, canais de serviço). O planejamento do gerenciamento de emergências deve excluir os orçamentos contínuos de custeio dos serviços de emergência para os serviços de polícia, bombeiros ou ambulâncias.',
          ],
        },
        {
          'Despesas anuais com serviços sociais e comunitários como porcentagem do orçamento total da cidade':
              [
            'null',
            'total das despesas anuais com serviços sociais e comunitários da cidade (numerador) dividido pelo orçamento total anual da cidade (denominador)',
            'As despesas anuais com serviços sociais e comunitários como porcentagem do orçamento total da cidade devem ser calculadas como o total das despesas anuais com serviços sociais e comunitários da cidade (numerador) dividido pelo orçamento total anual da cidade (denominador). O resultado deve ser multiplicado por 100 e expresso como as despesas com serviços sociais e comunitários como porcentagem do orçamento total da cidade. Os serviços sociais e comunitários devem ser defnidos como os serviços prestados ou apoiados diretamente pela cidade com o objetivo de promover ou apoiar a resiliência e o bem-estar individual e da comunidade. Isto pode incluir, mas não está limitado a, programas e fnanciamento de grupos e associações comunitárias, conscientização da saúde pública, bibliotecas, abrigos de emergência, abrigos para sem-teto, centros de acolhimento, centros comunitários, eventos cívicos, sensibilização da comunidade, programas de alimentação, saúde e serviços humanos, programas de idosos, serviços e divulgação, apoio e assistência a grupos desfavorecidos e vulneráveis.',
          ],
        },
        {
          'Alocação total de fundos de reserva para desastres como porcentagem do orçamento total da cidade':
              [
            'null',
            'a alocação total dos fundos de reserva para desastres (numerador) dividida pelo orçamento total da cidade (denominador).',
            'A alocação total dos fundos de reserva para desastres como porcentagem do orçamento total da cidade deve ser calculada como a alocação total dos fundos de reserva para desastres (numerador) dividida pelo orçamento total da cidade (denominador). O resultado deve ser multiplicado por 100 e expresso como a alocação total de fundos de reserva para desastres como porcentagem do orçamento total da cidade. Um fundo de reserva para desastres deve se referir aos orçamentos gerenciados pela administração da cidade e alocados especificamente para atender às despesas imprevistas de resposta a emergências, recuperação e reconstrução após um evento de desastre.',
          ],
        },
      ],
      'Governança': [
        {
          'Frequência da atualização dos planos de gerenciamento de desastres':
              [
            'null',
            'o número total das atualizações dos planos de gerenciamento de desastres em toda a cidade ocorridas nos cinco anos anteriores (numerador) dividido por cinco (denominador)',
            'A frequência da atualização dos planos de gerenciamento de desastres deve ser calculada como o número total das atualizações dos planos de gerenciamento de desastres em toda a cidade ocorridas nos cinco anos anteriores (numerador) dividido por cinco (denominador). O gerenciamento de desastres deve se referir à organização, planejamento e aplicação de medidas a longo prazo para a preparação, resposta e recuperação de eventos de desastres. Os planos de gerenciamento de desastres devem ser integrados a respostas regionais ou nacionais mais amplas e estipularem a agência que assumirá a liderança em diferentes cenários de emergência, assim como os papéis de resposta de diferentes agências e os recursos humanos e não humanos disponíveis. Os principais componentes de um plano de gerenciamento de desastres são comando e controle; evacuações (por exemplo, hospitais, cadeias); sistemas de comunicação; gerenciamento de ativos críticos (por exemplo, prováveis “cadeias de falhas”); integração de serviços públicos do setor privado, cobrindo, por exemplo, energia, água/saneamento, coleta de lixo e comunicações; resposta médica; resposta da lei e da ordem; resposta a incêndios e resgates; informações públicas; e políticas de triagem.',
          ],
        },
        {
          'Porcentagem de serviços urbanos essenciais cobertos por um plano de continuidade documentado':
              [
            'null',
            'número total de serviços essenciais que são cobertos por um plano de continuidade documentado (numerador) divido pelo número total de serviços públicos essenciais prestados na cidade (denominador)',
            'A porcentagem de serviços urbanos essenciais cobertos por um plano de continuidade documentado deve ser calculada como o número total de serviços essenciais que são cobertos por um plano de continuidade documentado (numerador) divido pelo número total de serviços públicos essenciais prestados na cidade (denominador). O resultado deve ser multiplicado por 100 e expresso como a porcentagem de serviços urbanos essenciais cobertos por um plano de continuidade documentado. Os serviços urbanos essenciais devem se referir aos serviços que são considerados vitais para o bem-estar e funcionamento da comunidade. Eles podem englobar, mas não estão limitados a, transporte, energia elétrica, gás, água, coleta e tratamento de esgoto, gerenciamento de resíduos, alimentos, saúde, polícia, bombeiros e serviços de emergência e ambulâncias. Convém que as cidades reportem quais serviços urbanos essenciais estão inclusos no cálculo. O termo plano de continuidade deve se referir a uma estratégia documentada que identifca as ameaças e riscos enfrentados pelas operações da cidade e ajuda a proteger os seus ativos e funcionários dos efeitos negativos de choques. O planejamento da continuidade envolve a defnição de riscos em potencial, a determinação de como estes riscos afetarão as operações, a implementação de salvaguardas e procedimentos para mitigá-los e a revisão periódica dos riscos para garantir sua relevância e moeda. Planos de continuidade devem ser atualizados regularmente. NOTA A ABNT NBR ISO 22301 é o parâmetro de referência reconhecido internacionalmente para continuidade organizacional. Ela especifca os requisitos para planejar, estabelecer, implementar, operar, monitorar, revisar, manter e melhorar continuamente um sistema de gerenciamento documentado para proteger-se, reduzir a probabilidade de ocorrência, preparar-se, responder e recuperar-se de incidentes.',
          ],
        },
        {
          'Porcentagem de dados eletrônicos da cidade com back-up de armazenamento seguro e remoto':
              [
            'null',
            'Volume dos dados eletrônicos da cidade com back-up de armazenamento seguro e remoto (numerador) dividido pelo volume total de dados eletrônicos da cidade (denominador)',
            'A porcentagem de dados eletrônicos da cidade com back-up de armazenamento seguro e remoto deve ser calculada como o volume dos dados eletrônicos da cidade com back-up de armazenamento seguro e remoto (numerador) dividido pelo volume total de dados eletrônicos da cidade (denominador). O resultado deve ser multiplicado por 100 e expresso como a porcentagem dos dados da cidade com back-up de armazenamento seguro e remoto. O back-up de armazenamento remoto deve se referir ao armazenamento de dados (mantidos em servidores, estações de trabalho e laptops) em um local secundário seguro (por exemplo, externo). Os planos e mecanismos para o armazenamento seguro e de longo prazo de dados da cidade refetem as vulnerabilidades da cidade às ameaças e convém que sejam atualizados e testados regularmente.',
          ],
        },
        {
          'Porcentagem de reuniões públicas destinadas à resiliência na cidade':
              [
            'null',
            'o número de reuniões públicas destinadas à resiliência na cidade (numerador) dividido pelo número total de reuniões públicas na cidade (denominador)',
            'A porcentagem de reuniões públicas destinadas à resiliência na cidade deve ser calculada como o número de reuniões públicas destinadas à resiliência na cidade (numerador) dividido pelo número total de reuniões públicas na cidade (denominador). O resultado deve ser multiplicado por 100 e expresso como a porcentagem de reuniões públicas destinadas à resiliência na cidade. As reuniões públicas devem se referir a reuniões realizadas pela cidade e abertas a todos os moradores e partes interessadas. Reuniões públicas são reuniões realizadas para aumentar a conscientização sobre uma questão ou proposta, e podem englobar, mas não estão limitadas a, reuniões realizadas pelo departamento de planejamento urbano da cidade relativo a uma proposta de desenvolvimento para um novo edifício de apartamentos ou nova rota de transporte público. As reuniões públicas destinadas à resiliência na cidade podem cobrir uma ampla gama de temas, como, mas não limitados a, desenvolvimento de infraestrutura para mitigar os impactos de potenciais choques e estresses, desenvolvimento de políticas ambientais para mitigar os impactos de mudanças climáticas e fnanciamento de programas sociais que aumentam a coesão social na cidade. Portanto, convém que as cidades reportem o propósito de cada reunião pública no numerador do cálculo do indicador. Convém que as cidades também reportem quem facilitará a reunião e os requisitos mínimos de alcance e participação para reuniões públicas. Além disto, convém que as cidades reportem o número de participantes em cada reunião e o modo de participação (por exemplo, on-line ou presencial), se possível.',
          ],
        },
        {
          'Número de acordos intergovernamentais destinados ao planejamento de choques como porcentagem do total de acordos intergovernamentais':
              [
            'null',
            'o número de acordos intergovernamentais que envolvem a cidade e são destinados ao planejamento de choques (numerador) dividido pelo número total de acordos intergovernamentais (denominador)',
            'O número de acordos intergovernamentais destinados ao planejamento de choques como porcentagem do total de acordos intergovernamentais deve ser calculado como o número de acordos intergovernamentais que envolvem a cidade e são destinados ao planejamento de choques (numerador) dividido pelo número total de acordos intergovernamentais (denominador). O resultado deve ser multiplicado por 100 e expresso como o número de acordos intergovernamentais destinados ao planejamento de choques como porcentagem do total de acordos intergovernamentais. Um acordo intergovernamental deve se referir a um acordo celebrado pela cidade com pelo menos um outro nível de governo (por exemplo, níveis estaduais e federais do governo). NOTA Existem inúmeras redes de cidades transnacionais, algumas das quais têm uma missão geral, enquanto outras trabalham em aspectos individuais, como lidar com os impactos das mudanças climáticas. Nos últimos anos, mais e mais redes de cidades vêm abordando a questão de resiliência da cidade, incluindo a preparação para choques externos. Em alguns casos, estas redes de cidades existentes podem ser uma fonte de acordos intergovernamentais.',
          ],
        },
        {
          'Porcentagem de prestadores de serviços essenciais que possuem um plano de continuidade documentado':
              [
            'null',
            'o número total de prestadores de serviços essenciais que possuem um plano de continuidade dos negócios documentado (numerador) divido pelo número total de prestadores de serviços essenciais (denominador)',
            'A porcentagem de prestadores de serviços essenciais que possuem um plano de continuidade dos negócios documentado deve ser calculada como o número total de prestadores de serviços essenciais que possuem um plano de continuidade dos negócios documentado (numerador) divido pelo número total de prestadores de serviços essenciais (denominador). O resultado deve ser multiplicado por 100 e expresso como a porcentagem de fornecedores de serviços essenciais da cidade que possuem um plano de continuidade documentado.  Os prestadores de serviços essenciais devem se referir às entidades externas ao governo que prestam serviços vitais para o funcionamento da cidade. Isto engloba fornecedores de serviços de infraestrutura do setor privado, incluindo energia elétrica, gás, água, coleta e tratamento de esgoto e gestão de resíduos. Convém incluir também os principais distribuidores de alimentos e fornecedores de serviços bancários de varejo. O termo plano de continuidade dos negócios deve se referir a uma estratégia documentada que identifca as ameaças e riscos enfrentados por uma empresa ou organização, e que ajuda a proteger seus ativos e pessoal dos efeitos negativos de um estresse ou choque, garantindo assim a continuidade operacional. O planejamento da continuidade dos negócios deve incluir a identifcação de riscos em potencial, a determinação de como estes riscos afetarão as operações, a implementação de medidas de segurança e os procedimentos para mitigá-los e a revisão periódica dos riscos para garantir a sua relevância e rigor. Convém que os planos de continuidade dos negócios sejam atualizados regularmente. NOTA A ABNT NBR ISO 22301 é o parâmetro de referência reconhecido internacionalmente para continuidade organizacional. Ela especifca os requisitos para planejar, estabelecer, implementar, operar, monitorar, revisar, manter e melhorar continuamente um sistema de gerenciamento documentado para proteger-se, reduzir a probabilidade de ocorrência, preparar-se, responder e recuperar-se de incidentes perturbadores quando eles surgirem.',
          ],
        },
      ],
      'Saúde': [
        {
          'Porcentagem de hospitais equipados com geradores back-up de energia elétrica':
              [
            'null',
            'número de hospitais equipados com geradores back-up de energia elétrica (numerador) dividido pelo número total de hospitais na cidade (denominador)',
            'A porcentagem de hospitais equipados com geradores back-up de energia elétrica deve ser calculada como o número de hospitais equipados com geradores back-up de energia elétrica (numerador) dividido pelo número total de hospitais na cidade (denominador). O resultado deve ser multiplicado por 100 e expresso como a porcentagem de instalações da área da saúde equipadas com geradores back-up de energia elétrica. Os geradores back-up de energia elétrica incluirão fontes de energia elétrica (incluindo estoque de geradores e baterias) protegidas de prováveis ameaças e com suprimentos de energia ou combustível sufcientes para fornecer energia sufciente para realizar as funções essenciais do hospital por um período de 72 h.',
          ],
        },
        {
          'Porcentagem da população com seguro básico de saúde': [
            'null',
            'número total de habitantes da cidade com cobertura de seguro básico de saúde (numerador) dividido pela população total da cidade (denominador).',
            'A porcentagem da população com seguro básico de saúde deve ser calculada como o número total de habitantes da cidade com cobertura de seguro básico de saúde (numerador) dividido pela população total da cidade (denominador). O resultado deve ser multiplicado por 100 e expresso como porcentagem da população com seguro de saúde básico. O seguro de saúde básico deve se referir a uma forma de proteção contra riscos de despesas médicas incorridas, seja por meio do acesso gratuito ou de baixo custo a serviços médicos ou por meio do pagamento de benefícios em consequência de doença ou lesão para recuperar custos. O seguro saúde pode ser fornecido de maneira pública ou privada.',
          ],
        },
        {
          'Porcentagem da população totalmente imunizada': [
            'null',
            'número de habitantes que foram totalmente imunizados na cidade (numerador) dividido pela população total da cidade (denominador)',
            'A porcentagem da população totalmente imunizada deve ser calculada como o número de habitantes que foram totalmente imunizados na cidade (numerador) dividido pela população total da cidade (denominador). O resultado deve ser multiplicado por 100 e expresso como a porcentagem da população que foi totalmente imunizada. De acordo com a Organização Mundial da Saúde, uma pessoa que foi totalmente imunizada deve se referir uma pessoa que recebeu todas as vacinas básicas antes de fazer um ano de idade. Mais especifcamente, a pessoa é totalmente imunizada com todas as vacinas básicas se ela tiver recebido vacina Bacillus Calmette-Guerin (BCG) contra tuberculose no nascimento; três doses de vacina contra a poliomielite e pentavalente [difteria-tétano-pertussis-hepatite B (Hep), Haemophilus infuenza tipo B (Hib)] com 6 semanas, 10 semanas e 14 semanas de idade; e uma vacina contra o sarampo com 9 meses de idade [17].',
          ],
        },
        {
          'Número de surtos de doenças infecciosas por ano': [
            'null',
            'contagem de surtos de doenças infecciosas em um determinado ano na cidade.',
            'O número de surtos de doenças infecciosas por ano deve ser calculado como a contagem de surtos de doenças infecciosas em um determinado ano na cidade. Uma doença infecciosa deve se referir a uma doença causada por micro-organismos patogênicos como bactérias, vírus, parasitas ou fungos; as doenças podem ser espalhadas, direta ou indiretamente, de uma pessoa para outra. Conforme defnido pela Organização Mundial da Saúde, um surto deve se referir a uma ocorrência de casos de doença superior ao esperado normalmente em uma determinada comunidade, área geográfca ou estação. Um surto pode ocorrer em uma área geográfca restrita ou pode estender-se por vários países. Pode durar poucos dias ou semanas ou diversos anos [18].',
          ],
        },
      ],
      'Habitação': [
        {
          'Capacidade de abrigos destinados a emergências por 100 000 habitantes':
              [
            'null',
            'a capacidade total de todos os abrigos destinados a emergências na cidade (numerador) dividido por 1/100 000 da população total da cidade (denominador)',
            'A capacidade de abrigos destinados a emergências por 100 000 habitantes deve ser calculada como a capacidade total de todos os abrigos destinados a emergências na cidade (numerador) dividido por 1/100 000 da população total da cidade (denominador). O resultado deve ser expresso como a capacidade de abrigos de emergência designados por 100 000 habitantes. A capacidade deve se referir ao número máximo, predeterminado de pessoas que podem ser acomodadas em um abrigo de emergência. O termo abrigo de emergência deve se referir a uma estrutura existente que tenha sido ofcialmente destinada a ser utilizada como habitação temporária para pessoas cuja habitação anterior não  é segura ou não está disponível durante ou após um desastre, ou que estão fugindo dos efeitos de um desastre. Os abrigos de emergência devem ser capazes de resistir a um desastre em virtude de sua construção e/ou localização.',
          ],
        },
        {
          'Porcentagem de edifícios estruturalmente vulneráveis a ameaças de alto risco':
              [
            'null',
            'como o número total de edifícios na cidade vulneráveis a ameaças de alto risco (numerador) dividido pelo número total de edifícios na cidade (denominador).',
            'A porcentagem de edifícios estruturalmente vulneráveis a ameaças de alto risco deve ser calculada como o número total de edifícios na cidade vulneráveis a ameaças de alto risco (numerador) dividido pelo número total de edifícios na cidade (denominador). O resultado deve ser multiplicado por 100 e expresso como a porcentagem de edifícios estruturalmente vulneráveis a ameaças de alto risco. Os edifícios devem se referir a todas as estruturas residenciais e não residenciais designadas para ocupação humana (isto é, com telhados e paredes) e que se situam em locais permanentes ou semipermanentes. Isto inclui edifícios públicos e privados utilizados para fns residenciais, comerciais, industriais, institucionais, recreacionais ou outros. Os edifícios estruturalmente vulneráveis a ameaças de alto risco (como terremotos, ciclones e enchentes) correm alto risco de sofrer um colapso ou danos signifcativos devidos aos efeitos de ameaças que podem causar morte ou lesões aos ocupantes do edifício.',
          ],
        },
        {
          'Porcentagem de edifícios residenciais não conformes com os códigos e normas de construção':
              [
            'null',
            'número total de edifícios residenciais na cidade não conformes com códigos e normas de construção (numerador) dividido pelo número total de edifícios residenciais na cidade (denominador)',
            'A porcentagem de edifícios residenciais não conformes com códigos e normas de construção deve ser calculada como o número total de edifícios residenciais na cidade não conformes com códigos e normas de construção (numerador) dividido pelo número total de edifícios residenciais na cidade (denominador). O resultado deve ser multiplicado por 100 e expresso como a porcentagem de edifícios residenciais não conformes com os códigos e normas de construção. Este indicador se refere a todos os códigos e normas de construção, incluindo (e especialmente) aqueles que regulam a integridade estrutural de edifícios residenciais e sua resistência a danos graves ou colapso durante um desastre (por exemplo, terremotos, enchentes, ciclones, deslizamentos de terra). Os edifícios residenciais devem se referir a todas as estruturas projetadas para ocupação humana de longo prazo (isto é, com telhados e paredes) e situadas em locais permanentes ou semipermanentes. Os códigos de construção devem se referir às portarias, regulamentos e normas associados destinados a regular aspectos de projetos, construções, uso de materiais, alteração e ocupação de estruturas construídas.',
          ],
        },
        {
          'Porcentagem de infraestrutura danifcada que foi “reconstruída melhor” após um desastre':
              [
            'null',
            'infraestrutura total na cidade que foi “reconstruída melhor” após um desastre ou evento extremo (numerador) dividido pela quantidade total de infraestruturas danifcadas no último evento na cidade (denominador).',
            'A porcentagem de infraestrutura danifcada que foi “reconstruída melhor” após um desastre deve ser calculada como a infraestrutura total na cidade que foi “reconstruída melhor” após um desastre ou evento extremo (numerador) dividido pela quantidade total de infraestruturas danifcadas no último evento na cidade (denominador). O resultado deve ser multiplicado por 100 e expresso como a porcentagem de infraestrutura danifcada que foi “reconstruída melhor após um desastre. A quantidade de infraestruturas deve se referir a metros quadrados para infraestruturas pontuais ou quilômetros para infraestruturas lineares. Este indicador só pode ser avaliado nos casos em que um evento de desastre ou extremo tenha impactado a cidade, resultando em danos a edifícios e estruturas. A infraestrutura deve se referir aos ativos pontuais e lineares (físicos, construídos) que fornecem funções essenciais em locais ou posições únicas, identifcáveis na cidade, ao longo de canais, corredores, rotas ou linhas dentro da cidade e que continuam em localizações permanentes ou semipermanentes. As infraestruturas pontuais devem englobar os principais edifícios utilizados para a educação (por exemplo, escolas, universidades, faculdades) e serviços de saúde (por exemplo, hospitais, clínicas médicas), bem como estações, equipamentos, fábricas, instalações ou outras obras de origem pontual utilizadas para disposição e tratamento de resíduos sólidos, tratamento de águas e efuentes e geração, transmissão e distribuição de energia. A infraestrutura linear deve englobar os principais dutos utilizados para a distribuição de água e gás ou para o afastamento de esgotos; linhas de transmissão para distribuição de energia elétrica; e principais rotas e corredores de transporte para a movimentação de pessoas e mercadorias por terra e água (por exemplo, rodovias, estradas, ferrovias, caminhos, pontes).',
          ],
        },
        {
          'Número anual de propriedades residenciais inundadas como porcentagem do total de propriedades residenciais na cidade':
              [
            'null',
            'como o número anual de propriedades residenciais que foram inundadas na cidade (numerador) dividido pelo número total de propriedades residenciais na cidade (denominador).',
            'O número anual de propriedades residenciais inundadas como porcentagem do total de propriedades residenciais na cidade deve ser calculado como o número anual de propriedades residenciais que foram inundadas na cidade (numerador) dividido pelo número total de propriedades residenciais na cidade (denominador). O número deve ser multiplicado por 100 e expresso como o número anual de propriedades residenciais inundadas como porcentagem do total de propriedades residenciais na cidade.  Propriedades residenciais devem se referir a habitações (ou estruturas) classifcadas para uso residencial. Convém que exemplos de propriedades residenciais incluam, mas não se limitem a, habitações unifamiliares, habitações móveis, habitações geminadas, casas geminadas, condomínios e edifícios de apartamentos.',
          ],
        },
        {
          'Porcentagem de propriedades residenciais situadas em áreas de alto risco':
              [
            'null',
            'como o número de propriedades residenciais situadas em áreas de alto risco na cidade (numerador) dividido pelo número total de propriedades residenciais na cidade (denominador).',
            'A porcentagem de propriedades residenciais situadas em áreas de alto risco deve ser calculada como o número de propriedades residenciais situadas em áreas de alto risco na cidade (numerador) dividido pelo número total de propriedades residenciais na cidade (denominador). O resultado deve ser multiplicado por 100 e expresso como a porcentagem de propriedades residenciais situadas em áreas de alto risco. Propriedades residenciais devem se referir a habitações (ou estruturas) classifcadas para uso residencial. Convém que exemplos de propriedades residenciais incluam, mas não se limitem a, habitações unifamiliares, habitações móveis, habitações geminadas, casas geminadas, condomínios e edifícios de apartamentos. As áreas de alto risco devem se referir às áreas da cidade particularmente vulneráveis a riscos naturais, como planícies inundáveis, encostas propensas a deslizamentos de terra e áreas costeiras baixas. Convém que os mapas de ameaças criados pela cidade sejam utilizados para identifcar estas áreas e indicar a probabilidade de ocorrência de uma ameaça relevante.',
          ],
        },
      ],
      'População e condições sociais': [
        {
          'População vulnerável como porcentagem da população da cidade': [
            'null',
            'o número total de pessoas vulneráveis na cidade (numerador) dividido pela população total da cidade (denominador)',
            'A população vulnerável como porcentagem da população total da cidade deve ser calculada como o número total de pessoas vulneráveis na cidade (numerador) dividido pela população total da cidade (denominador). O resultado deve ser multiplicado por 100 e expresso como a população vulnerável como porcentagem da população total da cidade. O termo população vulnerável deve se referir a pessoas com capacidade limitada para antecipar, lidar, resistir e se recuperar dos efeitos de um desastre e podem englobar os seguintes segmentos da população: — pessoas com comprometimento físico ou mental; — mulheres grávidas; — pessoas doentes ou desnutridas; — sem-teto; — pessoas localizadas em favelas, cortiços e moradias informais; — refugiados e pessoas internamente deslocadas; — comunidades transitórias ou nômades. Outros segmentos da população na cidade (isto é, crianças e idosos) que podem ser vulneráveis às ameaças devido à localização, ou a fatores específcos do contexto, também podem ser considerados na interpretação da vulnerabilidade da população da cidade. Eles não são relatados aqui, pois já foram considerados na ABNT NBR ISO 37120.',
          ],
        },
        {
          'Porcentagem da população inscrita em programas sociais': [
            'null',
            'o número de pessoas na cidade cadastradas em programas de assistência social (numerador) dividido pela população total da cidade (denominador)',
            'A porcentagem da população inscrita em programas sociais deve ser calculada como o número de pessoas na cidade cadastradas em programas de assistência social (numerador) dividido pela população total da cidade (denominador). O resultado deve ser multiplicado por 100 e expresso como a porcentagem da população inscrita em programas de assistência social. Assistência social deve se referir à ajuda fnanceira oferecida pelo governo que assiste famílias e pessoas que não conseguem pagar os seus custos básicos de vida devido a doença, incapacidade, baixa renda ou desemprego. Para algumas pessoas que recebem, a necessidade de assistência é temporária, enquanto para outras é por longo prazo',
          ],
        },
        {
          'Porcentagem da população exposta a alto risco de ameaças naturais': [
            'null',
            'o número de pessoas na cidade em alto risco de exposição de ameaças naturais (numerador) dividido pela população total da cidade (denominador)',
            'A porcentagem da população exposta a alto risco de ameaças naturais deve ser calculada como o número de pessoas na cidade em alto risco de exposição de ameaças naturais (numerador) dividido pela população total da cidade (denominador). O resultado deve ser multiplicado por 100 e expresso como a porcentagem da população exposta a alto risco de ameaças naturais. Delinear exposição de alto risco requer avaliação de risco local detalhada e mapas atualizados de ameaças e vulnerabilidades. Convém que as avaliações e mapas sejam disponibilizados ao público e incluam áreas urbanas inteiras. Informações atualizadas são especialmente importantes para ameaças como enchentes, porque mudanças na urbanização podem afetar a área de uma comunidade em risco. Quando possível, convém incluir os dados percentuais de cada tipo respectivo de ameaça e listá-los em uma tabela.',
          ],
        },
        {
          'Porcentagem de bairros com reuniões regulares e abertas da associação de bairro':
              [
            'null',
            'o número de bairros na cidade com reuniões regulares e abertas de associações de bairro (numerador) dividido pelo número total de bairros na cidade (denominador).',
            'A porcentagem de bairros com reuniões regulares e abertas da associação de bairro deve ser calculada como o número de bairros na cidade com reuniões regulares e abertas de associações de bairro (numerador) dividido pelo número total de bairros na cidade (denominador). O resultado deve ser multiplicado por 100 e expresso como a porcentagem de bairros com reuniões regulares e abertas da associação de bairro. Um bairro deve se referir a uma área geográfca defnida administrativamente na cidade. As reuniões regulares e abertas de associações de bairro devem referir-se a reuniões de associações de bairro que ocorrem pelo menos anualmente e não há exclusões em relação a quem pode participar das reuniões. Uma associação de bairro deve se referir a uma associação que representa os residentes de um bairro específco.',
          ],
        },
        {
          'Porcentagem anual da população da cidade diretamente afetada por ameaças naturais':
              [
            'null',
            'o número anual de pessoas evacuadas, remanejadas, feridas ou adoecidas devido a ameaças naturais (numerador) dividido pela população total da cidade (denominador).',
            'A porcentagem anual da população da cidade diretamente afetada por ameaças naturais deve ser calculada como o número anual de pessoas evacuadas, remanejadas, feridas ou adoecidas devido a ameaças naturais (numerador) dividido pela população total da cidade (denominador). O resultado deve ser multiplicado por 100 e expresso como a porcentagem anual da população da cidade diretamente afetada por ameaças naturais. Quando possível, convém incluir os dados percentuais de cada tipo respectivo de ameaça e listá-los em uma tabela.',
          ],
        },
      ],
      'Segurança': [
        {
          'Porcentagem da população da cidade coberta por sistemas de alerta prévio de ameaças múltiplas':
              [
            'null',
            'o número total de pessoas na cidade cobertas por sistemas de alerta prévio de ameaças múltiplas (numerador) dividido pela população total da cidade (denominador).',
            'A porcentagem da população da cidade coberta por sistemas de alerta prévio de ameaças múltiplas deve ser calculada como o número total de pessoas na cidade cobertas por sistemas de alerta prévio de ameaças múltiplas (numerador) dividido pela população total da cidade (denominador). O resultado deve ser multiplicado por 100 e expresso como porcentagem da população coberta por sistemas de alerta prévio de ameaças múltiplas. Os sistemas de alerta prévio devem se referir a um acordo integrado e coordenado de monitoramento e previsão de ameaças, avaliação de risco de desastres e atividades de comunicação e preparação que permitem às cidades e habitantes tomarem medidas para reduzir os riscos antes dos eventos perigosos. Os sistemas de alerta prévio de ameaças múltiplas cobrem uma gama de ameaças e impactos e são idealmente projetados para serem utilizados em contextos de ameaças múltiplas, em que os eventos perigosos ocorrem como evento(s) único(s), sucessivo(s) ou cumulativo(s) ao longo do tempo, levando a uma série de efeitos interrelacionados e com efeito cascata em uma cidade. Os alertas devem ser feitos durante o período máximo possível do aviso prévio por meio de várias mídias, incluindo, entre outros, telefone, TV, rádio, web e sirenes. Convém que os alertas sejam confáveis e específcos para o tipo de ameaça e convém que eles proporcionem bastante tempo para a preparação e resposta (tanto quanto a tecnologia permitir). NOTA A tecnologia de alertas de desastres está evoluindo rapidamente, tanto na avaliação de risco de longo prazo (por exemplo, previsão meteorológica sazonal) e no período de notifcação quanto na frequência de atualização para um evento específco (por exemplo, risco de deslizamento, alertas de tornados, movimentos na crista da inundação). No entanto, não existem sistemas de alertas de terremotos relevantes para fns práticos.',
          ],
        },
        {
          'Porcentagem de equipes de emergência que receberam treinamento de resposta a desastres':
              [
            'null',
            'o número total de equipes de emergência que receberam treinamento de resposta a desastres na cidade (numerador) dividido pelo número total de equipes de emergência na cidade (denominador)',
            'A porcentagem de equipes de emergência que receberam treinamento de resposta a desastres deve ser calculada como o número total de equipes de emergência que receberam treinamento de resposta a desastres na cidade (numerador) dividido pelo número total de equipes de emergência na cidade (denominador). O resultado deve ser multiplicado por 100 e expresso como porcentagem de equipes de emergência que receberam treinamento de resposta a desastres. O termo equipes de emergência deve se referir a policiais, bombeiros, paramédicos e socorristas. Eles estão entre as primeiras pessoas a chegarem na cena de uma emergência relacionada a um desastre e são treinados para lidar com uma gama de questões médicas e de segurança que podem surgir imediatamente antes, durante ou depois de um desastre. Convém que o treinamento em desastres cubra os piores cenários. NOTA BRASILEIRA No Brasil, conforme a legislação vigente institui a Política Nacional de Proteção e Defesa Civil (PNPDEC) e o Conselho Nacional de Proteção e Defesa Civil (CONPDEC) e autoriza a criação de um sistema de informações e monitoramento de desastres, abrangendo as ações de prevenção, mitigação, preparação, resposta e recuperação. Para este indicador, a Defesa Civil pode ser incluída como equipe de resposta',
          ],
        },
        {
          'Porcentagem de alertas locais de ameaças emitidos anualmente por agências nacionais e recebidos em tempo hábil pela cidade':
              [
            'null',
            'o número de alertas locais de ameaças emitidos anualmente por agências nacionais e recebidos em tempo hábil pela cidade (numerador) dividido pelo número total anual de alertas locais de ameaças emitidos por agências nacionais para a cidade (denominador)',
            'A porcentagem de alertas locais de ameaças emitidos anualmente por agências nacionais e recebidos em tempo hábil pela cidade deve ser calculada como o número de alertas locais de ameaças emitidos anualmente por agências nacionais e recebidos em tempo hábil pela cidade (numerador) dividido pelo número total anual de alertas locais de ameaças emitidos por agências nacionais para a cidade (denominador). O resultado deve ser multiplicado por 100 e expresso como a porcentagem de alertas locais de ameaça emitidos anualmente por agências nacionais e recebidos em tempo hábil pela cidade. O alerta ou previsão de ameaça deve se referir a uma chamada, notifcação, projeção, alerta ou alarme específco de um potencial evento de desastre. Os alertas devem ser feitos durante o período máximo possível do aviso prévio por meio de várias mídias, incluindo, entre outros, telefone, TV, rádio e Web. Em tempo hábil ou de maneira oportuna devem se referir-se a alertas ou previsões recebidas das equipes de emergência da cidade com tempo sufciente para acionar os sistemas de informação, implementar os planos de emergência (por exemplo, rotas para evacuação) e alertar os cidadãos. Isto fornece tempo às equipes de emergência para fazer perguntas e obter informações sobre o alerta ou previsão com os representantes do órgão emissor. O termo equipes de emergência deve se referir a policiais, bombeiros, paramédicos e socorristas. Eles estão entre as primeiras pessoas a chegar na cena de uma emergência relacionada a um desastre e são treinados para lidar com uma gama de questões médicas e de segurança que podem surgir imediatamente antes, durante ou depois de um desastre. NOTA A tecnologia de alertas de desastres está evoluindo rapidamente, tanto na avaliação de risco de longo prazo (por exemplo, previsão meteorológica sazonal) e no período de notifcação, quanto na frequência de atualização para um evento específco (por exemplo, risco de deslizamento, alertas de tornados, movimentos na crista da inundação). No entanto, não existem sistemas de alertas de terremotos relevantes para fns práticos.',
          ],
        },
        {
          'Número de leitos hospitalares na cidade destruídos ou danifcados por desastres naturais por 100 000 habitantes':
              [
            'null',
            'o número total de leitos hospitalares destruídos ou danifcados na cidade (numerador) dividido por 1/100 000 da população da cidade (denominador)',
            'O número de leitos hospitalares na cidade destruídos ou danifcados por desastres naturais por 100 000 habitantes deve ser calculado como o número total de leitos hospitalares destruídos ou danifcados na cidade (numerador) dividido por 1/100 000 da população da cidade (denominador). O resultado deve ser expresso como o número de leitos hospitalares na cidade destruídos ou danifcados por desastres naturais por 100 000 habitantes. Este indicador somente é aplicável caso um desastre ou evento extremo tenha ocorrido nos últimos 12 meses.',
          ],
        },
      ],
      'Resíduos sólidos': [
        {
          'Número de locais disponíveis, ativos e temporários de gestão de resíduos para detritos e destroços por quilômetro quadrado':
              [
            'null',
            'o número de locais disponíveis, ativos e temporários de gestão de resíduos da cidade, onde detritos e destroços podem ser dispostos (numerador) dividido pela área territorial total da cidade em quilômetros quadrados (denominador)',
            'O número de locais disponíveis, ativos e temporários de gestão de resíduos para detritos e destroços por quilômetro quadrado deve ser calculado como o número de locais disponíveis, ativos e temporários de gestão de resíduos da cidade, onde detritos e destroços podem ser dispostos (numerador) dividido pela área territorial total da cidade em quilômetros quadrados (denominador). O resultado deve ser expresso como o número de locais disponíveis, ativos e temporários de gestão de resíduos para detritos e destroços por quilômetro quadrado. O termo local de gestão de resíduos deve se referir a um local utilizado para a acumulação de resíduos, cujo propósito é eliminar ou tratar estes resíduos. Um local de gestão de resíduos pode englobar instalações de pirólise a vácuo, incineradoras, usinas de compostagem, estações de transferência, instalações de armazenamento, usinas de reciclagem e locais de eliminação. Estas instalações  são vistas como locais de gestão de resíduos porque elas permitem o armazenamento “contínuo” de resíduos em suas dependências antes do tratamento, eliminação, remoção ou manuseio dos resíduos. Um local de gestão de resíduos ativo deve incluir qualquer local que esteja atualmente em uso, esteja em pleno funcionamento e seja acessível à cidade. Um local de gestão de resíduos temporário é um local que pode ser construído temporariamente para gerenciar detritos e destroços por um período limitado de tempo de maneira segura para a saúde e o meio ambiente. Convém que detritos e destroços englobem materiais de construção (por exemplo, revestimentos de parede, gesso, drywall, louças sanitárias, telhas para cobertura e outros revestimentos de cobertura) e outros resíduos sólidos soltos, como mesas, cadeiras, chapas, tubos de PVC e papel.',
          ],
        },
      ],
      'Telecomunicações': [
        {
          'Porcentagem de equipes de emergência na cidade equipadas com tecnologias de comunicação especializadas capazes de operar de maneira confável durante um evento de desastre':
              [
            'null',
            'o número de equipes de emergência na cidade, com acesso ao PMR, à telefonia via satélite ou às redes de comunicações móveis com acesso privilegiado (numerador) dividido pelo número total de equipes de emergência na cidade (denominador).',
            'A porcentagem de equipes de emergência na cidade equipadas com tecnologias de comunicação especializadas capazes de operar de maneira confável durante um evento de desastre deve ser calculada como o número de equipes de emergência na cidade, com acesso ao PMR, à telefonia via satélite ou às redes de comunicações móveis com acesso privilegiado (numerador) dividido pelo número total de equipes de emergência na cidade (denominador). O resultado deve ser multiplicado por 100 e expresso como porcentagem de equipes de emergência na cidade equipadas com tecnologias de comunicação especializadas capazes de operar de maneira confável durante um evento de desastre. O termo equipes de emergência deve se referir a policiais, bombeiros, paramédicos e socorristas. Eles estão entre as primeiras pessoas a chegarem na cena de uma emergência relacionada a um desastre e são treinados para lidar com uma gama de questões médicas e de segurança que podem surgir imediatamente antes, durante ou depois de um desastre. O PMR deve se referir aos sistemas de comunicação de rádio em campo projetados para o uso específco de organizações como as forças policiais e o corpo de bombeiros. Estes sistemas de rádio permitem a comunicação ponto a multiponto em grandes áreas. NOTA O PMR também é conhecido como rádio móvel privado e rádio móvel terrestre. O termo telefonia via satélite deve se referir à tecnologia associada aos telefones móveis conectados aos satélites em órbita, e não aos locais terrestres para celular. A comunicação móvel com acesso privilegiado deve se referir à troca de informações nas redes de telefonia móvel que priorizaram o acesso para pessoas como os membros de serviços de emergência e equipes de resposta a emergências.',
          ],
        },
      ],
      'Transporte': [
        {
          'Número de rotas de evacuação disponíveis por 100 000 habitantes': [
            'null',
            'o número total de rotas de evacuação (numerador) dividido por 1/100 000 da população total da cidade (denominador)',
            'O número de rotas de evacuação disponíveis por 100 000 habitantes deve ser calculado como o número total de rotas de evacuação (numerador) dividido por 1/100 000 da população total da cidade (denominador). O resultado deve ser expresso como o número de rotas de evacuação disponíveis por 100 000 habitantes. O termo rotas de evacuação deve se referir a rodovias, estradas, vias navegáveis e ferrovias e ofcialmente designadas para remoção urgente e remanejamento temporário de pessoas e de seus ativos para longe da ameaça iminente ou contínua associada a um desastre. Uma única rota de evacuação pode não ser adequada para todas as emergências.',
          ],
        },
      ],
      'Agricultura urbana/local e segurança alimentar': [
        {
          'Porcentagem da população da cidade que pode ser atendida com as reservas de alimentos da cidade por 72 h em caso de emergência':
              [
            'null',
            'número de pessoas na cidade que pode ser atendida com as reservas de alimentos da cidade por 72 h (numerador) dividido pela população total da cidade (denominador)',
            'A porcentagem da população da cidade que pode ser atendida com as reservas de alimentos da cidade por 72 h em caso de emergência deve ser calculada como o número de pessoas na cidade que pode ser atendida com as reservas de alimentos da cidade por 72 h (numerador) dividido pela população total da cidade (denominador). O resultado deve ser multiplicado por 100 e expresso como a porcentagem da população que pode ser atendida com as reservas de alimentos dentro da cidade por 72 h. O termo reservas de alimentos da cidade deve se referir aos suprimentos essenciais de lojas de emergência da cidade, de acordo com supermercados locais e outros planos de contingência que garantem estoques de alimentos para os domicílios.',
          ],
        },
        {
          'Porcentagem da população da cidade que vive a 1 km de um mercado': [
            'null',
            'o número de pessoas na cidade que vivem a 1 km de um mercado (numerador) dividido pela população total da cidade (denominador).',
            'A porcentagem da população da cidade que vive a 1 km de um mercado deve ser calculada como o número de pessoas na cidade que vivem a 1 km de um mercado (numerador) dividido pela população total da cidade (denominador). O resultado deve ser multiplicado por 100 e expresso como a porcentagem da população da cidade que vive a 1 km de um mercado. O termo mercado deve se referir a uma loja de varejo que vende principalmente alimentos.',
          ],
        },
      ],
      'Planejamento urbano': [
        {
          'Porcentagem da área da cidade coberta por mapas de ameaças disponíveis ao público':
              [
            'null',
            'área da cidade coberta por mapas de ameaças disponíveis ao público em quilômetros quadrados (numerador) dividido pela área total da cidade em quilômetros quadrados (denominador)',
            'A porcentagem da área da cidade coberta por mapas de ameaças disponíveis ao público deve ser calculada como a área da cidade coberta por mapas de ameaças disponíveis ao público em quilômetros quadrados (numerador) dividido pela área total da cidade em quilômetros quadrados (denominador). O resultado deve ser multiplicado por 100 e expresso como a porcentagem da área total da cidade coberta por mapas de ameaças disponíveis ao público. Convém que estes mapas sejam disponíveis ao público e cubram a cidade inteira.',
          ],
        },
        {
          'Áreas e espaços públicos permeáveis e pavimentos construídos com materiais porosos e drenantes como porcentagem da área territorial da cidade':
              [
            'null',
            'a área total de espaços públicos permeáveis e pavimentos construídos com materiais porosos e drenantes (numerador) dividido pela área territorial total da cidade (denominador)',
            'A porcentagem de áreas e espaços públicos permeáveis e pavimentos construídos com materiais porosos e drenantes como porcentagem da área territorial total da cidade deve ser calculada como a área total de espaços públicos permeáveis e pavimentos construídos com materiais porosos e drenantes (numerador) dividido pela área territorial total da cidade (denominador). O resultado deve ser multiplicado por 100 e expresso como a porcentagem de áreas e espaços públicos permeáveis e pavimentos construídos com materiais porosos e drenantes como porcentagem da área territorial da cidade.  O termo área permeável deve se referir a todas as superfícies permeáveis na cidade que permitem a absorção e a drenagem da água. Superfícies permeáveis englobam áreas de vegetação (por exemplo, gramíneas e forestas), solo nu (por exemplo, jardins, terrenos agrícolas), areia (por exemplo, praias, deserto) e água (por exemplo, lagos, rios). Áreas permeáveis também abrangem telhados verdes em edifícios. Presume-se que as áreas sem cobertura permeável estejam vedadas (isto é, pavimentadas ou impermeáveis).',
          ],
        },
        {
          'Porcentagem de área territorial da cidade em zonas de alto risco em que medidas de redução de riscos foram implementadas':
              [
            'null',
            'a área territorial da cidade em zonas de alto risco em que medidas de redução de riscos foram implementadas, em quilômetros quadrados (numerador) dividida pela área territorial da cidade em zonas de alto risco, em quilômetros quadrados (denominador).',
            'A porcentagem de área territorial da cidade em zonas de alto risco em que medidas de redução de riscos foram implementadas deve ser calculada como a área territorial da cidade em zonas de alto risco em que medidas de redução de riscos foram implementadas, em quilômetros quadrados (numerador) dividida pela área territorial da cidade em zonas de alto risco, em quilômetros quadrados (denominador). O resultado deve ser multiplicado por 100 e expresso como a porcentagem de área territorial da cidade em zonas de alto risco em que medidas de redução de riscos foram implementadas. O termo medidas de redução de riscos deve se referir às atividades projetadas para aplicar ou capacitar diretamente os atores locais para conter a vulnerabilidade e os riscos humanos locais e melhorar a capacidade e as ações adaptativas a curto e longo prazo. As medidas de redução de riscos englobam, mas não se limitam a, obras de proteção. O termo infraestrutura de proteção deve se referir às estruturas físicas e amortecedores naturais que minimizam os impactos físicos, humanitários e econômicos das ameaças (por exemplo, diques e barreiras contra inundações; bacias de inundação; quebra-mar; drenos pluviais e tanques de contenção de águas pluviais; zonas úmidas e manguezais; e recursos de absorção de choques instalados na infraestrutura para lidar com terremotos).',
          ],
        },
        {
          'Porcentagem de departamentos e serviços de utilidades da cidade que realizam avaliação de riscos em seu planejamento e investimento':
              [
            'null',
            'o número de departamentos e serviços de utilidades que realizam avaliação de riscos em seu planejamento e investimento (numerador) dividido pelo número total de departamentos e serviços de utilidades da cidade (denominador)',
            'A porcentagem de departamentos e serviços de utilidades da cidade que realizam avaliação de riscos em seu planejamento e investimento deve ser calculada como o número de departamentos e serviços de utilidades que realizam avaliação de riscos em seu planejamento e investimento (numerador) dividido pelo número total de departamentos e serviços de utilidades da cidade (denominador). O resultado deve ser multiplicado por 100 e expresso como a porcentagem de departamentos e serviços de utilidades da cidade que realizam avaliação de riscos em seu planejamento e investimento. O termo serviços de utilidades deve se referir a todas as empresas públicas e privadas que prestam serviços e a instalações básicas relacionadas a energia elétrica, gás natural, água, esgoto, gestão de resíduos e telecomunicações. O termo avaliação de risco deve se referir ao processo sistemático de avaliação de potenciais riscos de ameaças e desastres a pessoas, grupos, organizações, ativos críticos e infraestrutura de proteção na cidade. A fnalidade de uma avaliação regular de riscos é (i) garantir que as atividades de construção de resiliência sejam relevantes para o contexto da cidade; (ii) garantir o investimento adequado e proporcional de recursos, de acordo com os riscos, ameaças, choques e tensões; (iii) possibilitar a compreensão das diferentes exposições e vulnerabilidades de risco da cidade; e (iv) permitir que consequências comuns sejam identifcadas para que possam ser desenvolvidos recursos que abordem o impacto de muitos riscos em combinação (ISO 31000:2018, Anexo C). Os resultados de uma avaliação de risco devem ser transmitidos parcialmente por meio de mapas, quer sejam de ameaças, vulnerabilidade, exposição, evacuação ou riscos.',
          ],
        },
        {
          'Número anual de infraestruturas críticas inundadas como porcentagem da infraestrutura crítica na cidade':
              [
            'null',
            'o número anual de infraestruturas críticas inundadas na cidade (numerador) dividido pelo número total de infraestruturas críticas na cidade (denominador)',
            'O número anual de infraestruturas críticas inundadas como porcentagem da infraestrutura crítica na cidade deve ser calculado como o número anual de infraestruturas críticas inundadas na cidade (numerador) dividido pelo número total de infraestruturas críticas na cidade (denominador). O resultado deve ser multiplicado por 100 e expresso como o número anual de infraestruturas críticas inundadas como porcentagem da infraestrutura crítica na cidade. Infraestruturas críticas devem se referir às estruturas físicas, instalações, redes e outros ativos que prestam serviços essenciais ao funcionamento social e econômico de uma comunidade ou sociedade. Infraestruturas críticas podem incluir, mas não se limitam a, geração, transmissão e distribuição de energia, tratamento, distribuição e drenagem de águas, infraestrutura de esgotos e de águas pluviais, transporte, abastecimento e distribuição de gás, infraestrutura de telecomunicações, instalações educacionais, hospitais e outras instalações de saúde.',
          ],
        },
        {
          'Despesas anuais em medidas de retenção de água como porcentagem do orçamento de medidas de prevenção da cidade':
              [
            'null',
            'o orçamento total das medidas de retenção de água (numerador) dividido pelo orçamento total das medidas de prevenção da cidade (denominador).',
            'As despesas anuais em medidas de retenção de água como porcentagem do orçamento de medidas de prevenção da cidade devem ser calculadas como o orçamento total das medidas de retenção de água (numerador) dividido pelo orçamento total das medidas de prevenção da cidade (denominador). O resultado deve ser multiplicado por 100 e expresso como uma porcentagem. As medidas de prevenção de enchentes devem se referir à construção de obras de tanques de amortecimento/controle de inundações para confnar o corpo d’água, à adaptação das infraestruturas subterrâneas existentes (por exemplo, estacionamentos de carros) como tanques de contenção para águas pluviais e paisagismo de espaços públicos (por exemplo, parques) para servir como planície de inundação em caso de enchente.',
          ],
        },
      ],
      'Água': [
        {
          'Número de fontes diferentes que fornecem pelo menos 5% da capacidade total de abastecimento de água':
              [
            data[indexSelected1]['data']['numeroFontesCapitacaoAgua'],
            'O número de fontes diferentes de fornecimento de água que fornecem pelo menos 5% da capacidade total de abastecimento de água deve referir-se ao número de fontes diferentes, ou separadas, de fornecimento de água para a cidade, cada qual fornecendo pelo menos 5% da capacidade total de abastecimento de água.',
            'O número de fontes diferentes de fornecimento de água que fornecem pelo menos 5 % da capacidade total de abastecimento de água deve referir-se ao número de fontes diferentes, ou separadas, de fornecimento de água para a cidade, cada qual fornecendo pelo menos 5 % da capacidade total de abastecimento de água. NOTA O patamar de 5 % é utilizado por organizações internacionais, como o Banco Mundial, por exemplo, para facilitar os cálculos e capturar as principais fontes de fornecimento. Quando houver mais de duas fontes diferentes de fornecimento de água, convém que a porcentagem da capacidade de abastecimento de água das duas fontes mais signifcativas seja reportada em tabelas. Uma fonte diferente (ou separada) de fornecimento de água deve se referir às fontes de água que não são interrompidas ou diretamente infuenciadas por outras fontes. As fontes de abastecimento de água devem incluir barragens, reservatórios, rios, lagos, aquíferos e usinas de dessalinização.',
          ],
        },
        {
          'Porcentagem da população da cidade que pode ser abastecida de água potável por métodos alternativos por 72 h':
              [
            'null',
            'o número de pessoas na cidade que podem ser abastecidas de água potável por métodos alternativos por 72 h (numerador) dividido pela população total da cidade (denominador).',
            'A porcentagem da população da cidade que pode ser abastecida de água potável por métodos alternativos por 72 h deve ser calculada como o número de pessoas na cidade que podem ser abastecidas de água potável por métodos alternativos por 72 h (numerador) dividido pela população total da cidade (denominador). O resultado deve ser multiplicado por 100 e expresso como a porcentagem da população da cidade que pode ser abastecida de água potável por métodos alternativos por 72 h. Os métodos alternativos de abastecimento de água devem englobar tanques de água de emergência, água engarrafada e captação de água da chuva.',
          ],
        },
      ],
    };
  }
}

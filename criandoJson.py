import requests
import json

request_populacao = requests.get('https://servicodados.ibge.gov.br/api/v3/agregados/6579/periodos/2021/variaveis/9324?localidades=N6[all]')
request_pib2015_2019 = requests.get('https://servicodados.ibge.gov.br/api/v3/agregados/5938/periodos/2015%7C2016%7C2017%7C2018%7C2019/variaveis/37?localidades=N6[all]')
request_popEconAtiva2000 = requests.get('https://servicodados.ibge.gov.br/api/v3/agregados/2908/periodos/2000/variaveis/1616?localidades=N6[all]&classificacao=2[6794]|1[6795]|11570[95415]')
request_popEmpregada = requests.get('https://servicodados.ibge.gov.br/api/v3/agregados/2967/periodos/2000/variaveis/926?localidades=N6[all]&classificacao=12396[0]')
request_popInformal = requests.get('https://servicodados.ibge.gov.br/api/v3/agregados/2967/periodos/2000/variaveis/926?localidades=N6[all]&classificacao=12396[108008,108012]')
request_areaMunicipio = requests.get('https://servicodados.ibge.gov.br/api/v3/agregados/1301/periodos/2010/variaveis/615|616?localidades=N6[all]')
request_numeroFontesCapitacaoAgua = requests.get('https://servicodados.ibge.gov.br/api/v3/agregados/7465/periodos/2017/variaveis/10501%7C10494?localidades=N6[all]&classificacao=11971[98593]')

populacao = request_populacao.json()[0]['resultados'][0]['series']
pib2015_2019 = request_pib2015_2019.json()[0]['resultados'][0]['series']
popEconAtiva2000 = request_popEconAtiva2000.json()[0]['resultados'][0]['series']
popEmpregada = request_popEmpregada.json()[0]['resultados'][0]['series']
popInformal = request_popInformal.json()[0]['resultados']
areaMunicipio = request_areaMunicipio.json()
numeroFontesCapitacaoAgua = request_numeroFontesCapitacaoAgua.json()[0]['resultados'][0]['series']

print(request_populacao)
print(request_pib2015_2019)
print(request_popEconAtiva2000)
print(request_popEmpregada)
print(request_popInformal)
print(request_areaMunicipio)
print(request_numeroFontesCapitacaoAgua)

data = list()
municipio = dict()

tamanho = len(populacao)
index = 0

print(tamanho)

if request_populacao.status_code == 200 and request_pib2015_2019.status_code == 200 and request_popEconAtiva2000.status_code == 200 and request_popEmpregada.status_code == 200 and request_popInformal.status_code == 200 and request_areaMunicipio.status_code == 200 and request_numeroFontesCapitacaoAgua.status_code == 200 :
    while index < tamanho:
        municipio.clear()

        id = populacao[index]['localidade']['id']

        for x in range(len(pib2015_2019)):
            if id == pib2015_2019[x]['localidade']['id']:
                indice_pib2015_2019 = x
                break
        for x in range(len(popEconAtiva2000)):
            if id == popEconAtiva2000[x]['localidade']['id']:
                indice_popEconAtiva2000 = x
                break
        for x in range(len(popEmpregada)):
            if id == popEmpregada[x]['localidade']['id']:
                indice_popEmpregada = x
                break
        for x in range(len(popInformal[0]['series'])):
            if id == popInformal[0]['series'][x]['localidade']['id']:
                indice_popInformal = x
                break
        for x in range(len(areaMunicipio[0]['resultados'][0]['series'])):
            if id == areaMunicipio[0]['resultados'][0]['series'][x]['localidade']['id']:
                indice_areaMunicipio = x
                break
        for x in range(len(numeroFontesCapitacaoAgua)):
            if id == numeroFontesCapitacaoAgua[x]['localidade']['id']:
                indice_numeroFontesCapitacaoAgua = x
                break


        municipio = {
            'id' : populacao[index]['localidade']['id'],
            'data' : {
                'nome' : populacao[index]['localidade']['nome'],
                'populacao' : populacao[index]['serie']['2021'],
                'pib' : {
                    '2015': pib2015_2019[indice_pib2015_2019]['serie']['2015'],
                    '2016': pib2015_2019[indice_pib2015_2019]['serie']['2016'],
                    '2017': pib2015_2019[indice_pib2015_2019]['serie']['2017'],
                    '2018': pib2015_2019[indice_pib2015_2019]['serie']['2018'],
                    '2019': pib2015_2019[indice_pib2015_2019]['serie']['2019']
                },
                'popEconAtiva' : popEconAtiva2000[indice_popEconAtiva2000]['serie']['2000'],
                'popEmpregada' : popEmpregada[indice_popEmpregada]['serie']['2000'],
                'popInformal' : [
                    popInformal[0]['series'][indice_popInformal]['serie']['2000'],
                    popInformal[1]['series'][indice_popInformal]['serie']['2000']
                ],
                'areaMunicipio' : {
                    'area': areaMunicipio[0]['resultados'][0]['series'][indice_areaMunicipio]['serie']['2010'],
                    'densidade': areaMunicipio[1]['resultados'][0]['series'][indice_areaMunicipio]['serie']['2010']
                },
                'numeroFontesCapitacaoAgua' : numeroFontesCapitacaoAgua[indice_numeroFontesCapitacaoAgua]['serie']['2017']
            }
        }

        data.append(municipio.copy())
        index = index + 1
arquivo = open('municipios.json','w')
arquivo.write(json.dumps(data))
arquivo.close()


print(data)


from flask import Flask, request, make_response, jsonify

from bd import carros

app= Flask('carros')



#metodo 1- visualizacao de dados (GET)
@app.route('/car', methods=['GET'])

def get_carros():
    return carros

#metodo 1 parte 2 - visualicao de daods por id(GET)

@app.route('/car/<int:id_pam>',methods=['GET'])
def get_carros_id(id_pam):
    for carro in carros:
        if carro.get('id')==id_pam:
            return jsonify(carro)
        
@app.route('/carrinho',methods=['POST'])
def criar_carro():
    car = request.json
    carros.append(car)
    return make_response(
              jsonify(
                  mensagem= 'carro cadastrado com sucesso!!', car = car
              )


    )        

@app.route('/carrinho/<int:id>',methods=['DELETE'])
def excluir_carro(id):
    for indice, carro in enumerate(carros):
        if carro.get('id')==id:
            del carros[indice]
            return jsonify(
                {'mensagem': "carro excluido"}
            )

@app.route('/carrinho/<int:id>',methods=['PUT'])
def editar_carro(id):
    carro_alterado= request.get_json()
    for indice, carro in enumerate(carros):
        if carro.get('id')==id:
            carros [indice].update(carro_alterado)
            return jsonify(
                carros[indice]
            )


app.run(port=5000, host= 'localhost',debug=True)






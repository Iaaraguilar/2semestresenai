from flask import Flask, Response, request
from flask_sqlalchemy import SQLAlchemy
import json 
app = Flask('clientes')

app.config['SQLALCHEMY_TRACK_MODIFICATIONS']=True
app.config['SQLALCHEMY_DATABASE_URI'] ='mysql://root:Senai%40134@127.0.0.1/db_clinica'
mybd= SQLAlchemy(app)
#GET
class Clientes(mybd.Model):
    __tabelaname__ ='clientes'
    id_cliente = mybd.Column(mybd.Integer, primary_key=True)
    nome = mybd.Column(mybd.String(100))
    endereco = mybd.Column(mybd.String(100))
    telefone = mybd.Column(mybd.String(100))


    def to_json(self):
        return {
            "id_cliente" : self.id_cliente,
            "nome" : self.nome,
            "endereco" : self.endereco,
            "telefone": self.telefone
        }    

@app.route('/vet',methods=['GET'])
def seleciona_cliente():
   Clienteselecionado = Clientes.query.all()
   cliente_json= [cliente.to_json()
                  for cliente in Clienteselecionado]
   return geraresposta(200, 'cliente', cliente_json)    


def geraresposta (status, conteudo, mensagem = False):
    body={}
    body['Lista clientes'] = conteudo
    if(mensagem):
        body['mensagem']=mensagem
    return Response(json.dumps(body),status=status, mimetype='aplication/json')


#POST

@app.route('/vet',methods=['POST'])
def criar_cliente():
    requisicacao = request.get_json()
    try:
        cliente = Clientes(
            id_cliente=requisicacao['id_cliente'],
            nome= requisicacao['nome'],
            endereco= requisicacao['endereco'],
            telefone = requisicacao['telefone']
        )

        mybd.session.add(cliente)
        mybd.session.commit()
        return geraresposta(201, cliente.to_json(), 'criado com sucesso')
    except Exception as e:
        print('Erro',Exception)
        return geraresposta(400, {}, 'erro')

    
#DELETE

@app.route('/vet/<id_cliente_jim>', methods=['DELETE'])
def delete_cliente(id_cliente_jim):
        cliente = Clientes.query.filter_by(id_cliente=id_cliente_jim).first()

        try:
            mybd.session.delete(cliente)
            mybd.session.commit()
            return geraresposta(200, cliente.to_json(), 'deletado com sucesso')
        
        except Exception as e:
            print('erro', e)
            return geraresposta(400, {}, 'erro ao deletar')
    
#PUT
@app.route('/vet/<id_cliente_jim>', methods=['PUT'])
def atualizar(id_cliente_jim):
    cliente = Clientes.query.filter_by(id_cliente=id_cliente_jim).first()
    requisicao = request.get_json()
    try:
        if('nome' in requisicao):
         cliente.nome=requisicao['nome']
        if('endereco' in requisicao):
         cliente.endereco=requisicao['endereco']
        if('telefone' in requisicao):
         cliente.telefone=requisicao['telefone']

        mybd.session.add(cliente)
        mybd.session.commit()
        return geraresposta(200, cliente.to_json(),'cliente atualizado')

    except Exception as e:
        print('erro',e)
        return geraresposta(400, {}, 'erro ao atualizar') 

#------------------------------------------------------------------
#PET
#GET
class PETS(mybd.Model):
    __tabelaname__ ='pets'
    id_pet = mybd.Column(mybd.Integer, primary_key=True, autoincrement=True)
    nome = mybd.Column(mybd.String(100))
    tipo = mybd.Column(mybd.String(100))
    raca = mybd.Column(mybd.String(100))
    data_nascimento =mybd.Column(mybd.String(100))
    id_cliente= mybd.Column(mybd.Integer, mybd.ForeignKey('clientes.id_cliente'), nullable=False)

    def to_json(self):
        return {
            "id_pet" : self.id_pet,
            "nome" : self.nome,
            "tipo" : self.tipo,
            "raca": self.raca,
            "data_nascimento":str(self.data_nascimento),
            "id_cliente": self.id_cliente,
        }   
#------------GET---------------     
@app.route('/pets',methods=['GET'])
def seleciona_pet():
 petselecionado = PETS.query.all()
 pet_json= [pets.to_json()
             for pets in petselecionado]
 return geraresposta(200, 'pet', pet_json)    


def geraresposta (status, conteudo, mensagem = False):
        body={}
        body['Lista pets'] = conteudo
        if(mensagem):
            body['mensagem']=mensagem
        return Response(json.dumps(body),status=status, mimetype='aplication/json')

@app.route('/pets/<id_pet_dw>',methods=['GET'])
def seleciona_pet_id(id_pet_dw):
    petselecionado = PETS.query.filter_by(id_pet=id_pet_dw).first()
    pet_json= petselecionado.to_json()

    return geraresposta(200, pet_json, 'pet encontrado')


#DELETE
@app.route('/pets/<id_pet_dw>',methods=['DELETE'])
def deleta_pet(id_pet_dw):
    pet = PETS.query.filter_by(id_pet=id_pet_dw).first

    try:
            mybd.session.delete(pet)
            mybd.session.commit()
            return geraresposta(200, pet.to_json(), 'Deletado com sucesso')
        
    except Exception as e:
        print('erro',e)
        return geraresposta(400, {}, 'erro ao deletar')
    

 #---------------PUT-----------------------   
@app.route('/pets/<id_pet_dw>',methods=['PUT'])
def atualiza_pet(id_pet_dw):
    pet= PETS.query.filter_by(id_pet=id_pet_dw).first()
    requisicao = request.get_json()
    try:
        if('nome' in requisicao):
            pet.nome=requisicao['nome']
        if('tipo'in requisicao):
            pet.tipo=requisicao['tipo']
        if('raca'in requisicao):
            pet.raca=requisicao['raca']
        if('data_nascimento' in requisicao):
            pet.data_nascimento=requisicao['data_nascimento']
        if('id_cliente' in requisicao):
            pet.id_cliente=requisicao['id_cliente']    

        mybd.session.add(pet)
        mybd.session.commit()

        return geraresposta(200, pet.to_json(),'pet atualizado')


    except Exception as e:
        print('erro',e)
        return geraresposta(400, {}, 'erro ao atualizar')                   


app.run(port=500, host= 'localhost',debug=True)
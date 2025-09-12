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


app.run(port=500, host= 'localhost',debug=True)
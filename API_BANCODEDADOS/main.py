#FLASK PERMITE CRIACAO DE API NO PYTHON
#response e request -> Requisicao

from flask import Flask, Response, request
from flask_sqlalchemy import SQLAlchemy
import json 
app = Flask('carros')

app.config['SQLALCHEMY_TRACK_MODIFICATIONS']=True
#1- usuario (root) 2 - senha(%40 e o @) 3- localhost(127.0.0.1) 
app.config['SQLALCHEMY_DATABASE_URI'] ='mysql://root:Senai%40134@127.0.0.1/db_carro'
mybd= SQLAlchemy(app)

class Carros(mybd.Model):
    __tablename__ = 'tb_carro'
    id_carro = mybd.Column(mybd.Integer, primary_key=True)
    marca = mybd.Column(mybd.String(100))
    modelo= mybd.Column(mybd.String(100))
    ano=mybd.Column(mybd.String(100))
    cor=mybd.Column(mybd.String(100))
    valor=mybd.Column(mybd.String(100))
    numero_vendas=mybd.Column(mybd.String(100))

#converter o objeto em json
    def to_json(self):
        return{
            "id_carro": self.id_carro,
            "marca": self.marca,
            "modelo": self.modelo,
            "ano": self.ano,
            "cor": self.cor,
            "valor": float(self.valor),
            "numero_vendas": self.numero_vendas

        }

#-----------------------------------------------------------------------------

#GET
@app.route('/carros',methods=['GET'])
def seleciona_carro():
    carro_selecionado= Carros.query.all()
    #executa uma consulta no banco de dados(select* from...)
    carro_json=[carro.to_json()
                for carro in carro_selecionado]
    return gera_resposta(200, "carro",carro_json)



# gerar resposta pra query
   # status
    # nome conteudo
    #conteudo
    #mensagem(opcional)
def gera_resposta(status,conteudo, mensagem=False):
    body={}
    body['Lista de Carros']= conteudo 
    if(mensagem):
        body['mensagem']=mensagem
    return Response(json.dumps(body),status=status,mimetype='aplication/json')
#dumps - converte o dicionario criado (body) em json (json.dumps)
# 
#     






#----------------------------------------------------
#metodo 2 get por ID
@app.route('/carros/<id_carro_pam>',methods=['GET'])
def seleciona_carro_id(id_carro_pam):
    carro_selecionado = Carros.query.filter_by(id_carro=id_carro_pam).first()
    carro_json= carro_selecionado.to_json()

    return gera_resposta(200, carro_json, 'Carro encontrado')


#metodo post 

@app.route('/carro',methods=['POST'])
def criar_carro():
    requisicao = request.get_json()

    try:
        carro = Carros(
            id_carro = requisicao['id_carro'],
            marca = requisicao['marca'],
            modelo= requisicao['modelo'],
            ano=requisicao['ano'],
            valor = requisicao['valor'],
            cor= requisicao['cor'],
            numero_vendas=requisicao['numero_vendas']
        )

        mybd.session.add(carro) #adiciona o banco

        mybd.session.commit() #salva

        return gera_resposta(201, carro.to_json(), 'criado com sucesso') 

    except Exception as e:
        print('erro',Exception)
        return gera_resposta(400, {}, 'erro')
#-------------------------------------------------------------------------------
#DELETE
@app.route('/carros/<id_carro_pam>',methods= ['DELETE'])
def deleta_carro(id_carro_pam):
        carro = Carros.query.filter_by(id_carro=id_carro_pam).first()

        try:
            mybd.session.delete(carro)
            mybd.session.commit()
            return gera_resposta(200, carro.to_json(), 'Deletado com sucesso')
        
        except Exception as e:
            print('erro',e)
            return gera_resposta(400, {}, 'erro ao deletar')


#-----------------------------------------------------------------------------------\
#PUT
@app.route('/carro/<id_carro_pam>',methods=['PUT'])
def atualiza_carro(id_carro_pam):
    carro= Carros.query.filter_by(id_carro=id_carro_pam).first()
    requisicao = request.get_json()
    try:
        if('marca' in requisicao):
            carro.marca=requisicao['marca']
        if('modelo'in requisicao):
            carro.modelo=requisicao['modelo']
        if('ano'in requisicao):
            carro.ano=requisicao['ano']
        if('valor' in requisicao):
            carro.valor=requisicao['valor']
        if('cor' in requisicao):
            carro.cor=requisicao['cor']     
        if('numero_vendas' in requisicao):
            carro.numero_vendas=requisicao['numero_vendas']

        mybd.session.add(carro)
        mybd.session.commit()

        return gera_resposta(200, carro.to_json(),'carro atualizado')


    except Exception as e:
        print('erro',e)
        return gera_resposta(400, {}, 'erro ao atualizar')                   

    
app.run(port=500, host= 'localhost',debug=True)
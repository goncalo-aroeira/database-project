#!/usr/bin/python3

from wsgiref.handlers import CGIHandler
from flask import Flask
from flask import render_template, request, redirect, url_for

## Libs postgres
import psycopg2
import psycopg2.extras

app = Flask(__name__)

## SGBD configs
DB_HOST="db.tecnico.ulisboa.pt"
DB_USER="ist199226" 
DB_DATABASE=DB_USER
DB_PASSWORD="3207"
DB_CONNECTION_STRING = "host=%s dbname=%s user=%s password=%s" % (DB_HOST, DB_DATABASE, DB_USER, DB_PASSWORD)


## Runs the function once the root page is requested.
## The request comes with the folder structure setting ~/web as the root
@app.route('/')
def index():
  try:
    return render_template("index.html", params=request.args)
  except Exception as e:
    return str(e)

@app.route('/menu')
def menu_principal():
  try:
    return render_template("index.html", params=request.args)
  except Exception as e:
    return str(e)

@app.route('/erro')
def erro():
  try:
    return render_template("erro.html", params=request.args)
  except Exception as e:
    return str(e)

@app.route('/categoria')
def editar_categoria():
  try:
    dbConn = psycopg2.connect(DB_CONNECTION_STRING)
    cursor = dbConn.cursor(cursor_factory = psycopg2.extras.DictCursor)
    query = "SELECT * FROM categoria;"
    cursor.execute(query)
    return render_template('categoria.html', cursor = cursor)
  except Exception as e:
    return redirect(url_for('erro'))
  finally:
    dbConn.commit()
    cursor.close()
    dbConn.close()


@app.route('/retalhista')
def editar_retalhista():
  try:
    dbConn = psycopg2.connect(DB_CONNECTION_STRING)
    cursor = dbConn.cursor(cursor_factory = psycopg2.extras.DictCursor)
    query = "SELECT * FROM retalhista;"
    cursor.execute(query)
    return render_template('retalhista.html', cursor = cursor)
  except Exception as e:
    return redirect(url_for('erro'))
  finally:
    dbConn.commit()
    cursor.close()
    dbConn.close()




@app.route('/ivm', methods=["POST", "GET"])
def editar_ivm():
  dbConn=None
  cursor=None
  if ("Listar" in request.form and request.method == "POST"):
    try:
      dbConn = psycopg2.connect(DB_CONNECTION_STRING)
      cursor = dbConn.cursor(cursor_factory = psycopg2.extras.DictCursor)
      query = "SELECT * FROM evento_reposicao WHERE (num_serie = %s AND fabricante = %s);"
      data = (request.form["num_serie"],request.form["fabricante"],)
      cursor.execute(query,data)
      return render_template('ivm.html', cursor = cursor)
    except Exception as e:
      return redirect(url_for('erro'))
    finally:
      dbConn.commit()
      cursor.close()
      dbConn.close()
  else:
    dbConn = psycopg2.connect(DB_CONNECTION_STRING)
    cursor = dbConn.cursor(cursor_factory = psycopg2.extras.DictCursor)
    query = "SELECT * FROM IVM;"
    cursor.execute(query)
    return render_template('ivm.html', cursor = cursor, test=True)    


@app.route('/categoria/inserir')
def inserir_categoria():
  try:
    return render_template("inserir_categoria.html", params=request.args)
  except Exception as e:
    return str(e)

@app.route('/retalhista/inserir')
def inserir_retalhista():
  try:
    return render_template("inserir_retalhista.html", params=request.args)
  except Exception as e:
    return str(e)

@app.route('/retalhista/remover')
def remover_retalhista():
  try:
    return render_template("remover_retalhista.html", params=request.args)
  except Exception as e:
    return str(e)

@app.route('/categoria/remover')
def remover_categoria():
  try:
    return render_template("remover_categoria.html", params=request.args)
  except Exception as e:
    return str(e)


@app.route('/retalhista/perform_delete', methods=["POST"])
def delete_retalhista_fromDB():
  dbConn=None
  cursor=None
  try:
    dbConn = psycopg2.connect(DB_CONNECTION_STRING)
    cursor = dbConn.cursor(cursor_factory = psycopg2.extras.DictCursor)
    query = "DELETE FROM evento_reposicao WHERE tin=%s;"
    data = (request.form["tin"])
    cursor.execute(query,[data])
    query = "DELETE FROM responsavel_por WHERE tin=%s;"
    cursor.execute(query,[data])
    query = "DELETE FROM retalhista WHERE tin=%s;"
    cursor.execute(query,[data])


    return redirect(url_for('editar_retalhista'))
  except Exception as e:
    return str(e) 
  finally:
    dbConn.commit()
    cursor.close()
    dbConn.close()




@app.route('/categoria/perform_delete', methods=["POST"])
def delete_categoria_fromDB():
  dbConn=None
  cursor=None
  try:
    dbConn = psycopg2.connect(DB_CONNECTION_STRING)
    cursor = dbConn.cursor(cursor_factory = psycopg2.extras.DictCursor)
    query = "DELETE FROM categoria WHERE nome_categoria=%s ;"
    data = (request.form["nome_categoria"])
    cursor.execute(query,[data])
  
    return redirect(url_for('editar_categoria'))
  except Exception as e:
    return str(e) 
  finally:
    dbConn.commit()
    cursor.close()
    dbConn.close()



@app.route('/categoria/execute_insert', methods=["POST"])
def insert_categoria_intoDB():
  dbConn=None
  cursor=None
  try:
    dbConn = psycopg2.connect(DB_CONNECTION_STRING)
    cursor = dbConn.cursor(cursor_factory = psycopg2.extras.DictCursor)
    query = "INSERT INTO categoria VALUES (%s);"
    data = (request.form["nome_categoria"],)
    cursor.execute(query,data)
    query = "INSERT INTO categoria_simples VALUES (%s);"
    cursor.execute(query,data)

    return redirect(url_for('editar_categoria'))
  except Exception as e:
    return redirect(url_for('erro'))
  finally:
    dbConn.commit()
    cursor.close()
    dbConn.close()



@app.route('/retalhista/execute_insert', methods=["POST"])
def insert_retalhista_intoDB():
  dbConn=None
  cursor=None
  try:
    dbConn = psycopg2.connect(DB_CONNECTION_STRING)
    cursor = dbConn.cursor(cursor_factory = psycopg2.extras.DictCursor)
    query = "INSERT INTO retalhista VALUES (%s,%s);"
    data = (request.form["tin"],request.form["nome_retalhista"],)
    cursor.execute(query,data)
    return redirect(url_for('editar_retalhista'))
  except Exception as e:
    return redirect(url_for('erro'))
  finally:
    dbConn.commit()
    cursor.close()
    dbConn.close()


  
@app.route('/ivm/execute_list', methods=["POST"])
def show_replenisment_events():
  dbConn=None
  cursor=None
  try:
    dbConn = psycopg2.connect(DB_CONNECTION_STRING)
    cursor = dbConn.cursor(cursor_factory = psycopg2.extras.DictCursor)
    query = "SELECT * FROM evento_reposicao WHERE (num_serie = %s AND fabricante = %s);"
    data = (request.form["num_serie"],request.form["fabricante"],)
    cursor.execute(query,data)
    return redirect(url_for('editar_ivm'))
  except Exception as e:
    return redirect(url_for('erro'))
  finally:
    dbConn.commit()
    cursor.close()
    dbConn.close()


@app.route('/categoria/listar',  methods=["POST", "GET"])
def listar_categoria():
  dbConn=None
  cursor=None
  if ("Listar" in request.form and request.method == "POST"):
    try:
      dbConn = psycopg2.connect(DB_CONNECTION_STRING)
      cursor = dbConn.cursor(cursor_factory = psycopg2.extras.DictCursor)
      query = "SELECT * FROM categoria;"
      #data = (request.form["categoria"],)
      cursor.execute(query)
      return render_template('listar_categorias.html', cursor = cursor)
    except Exception as e:
      return redirect(url_for('erro'))
    finally:
      dbConn.commit()
      cursor.close()
      dbConn.close()
  return render_template('listar_categorias.html')



CGIHandler().run(app)
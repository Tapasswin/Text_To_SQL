import MySQLdb
from flask import Flask, jsonify, render_template, request
import datetime
import mysql.connector
import json
import torch
from transformers import T5Tokenizer, T5ForConditionalGeneration
import datasets
from datasets import Dataset,load_metric
import pandas as pd
import time

# Creating connection object
mydb = mysql.connector.connect(
    host = "localhost",
    user = "root",
    password = "Tapasswin@999",
    database = "AI"
)

# load Modules
trained_tokenizer = T5Tokenizer.from_pretrained("trained-tokenizer")
trianed_model = T5ForConditionalGeneration.from_pretrained("trained-model")

# Convert text to SQL query
def generate_sql(question):

    schema = "CREATE TABLE master_table (master_id int, account_number int, transaction_id int, transaction_type VARCHAR, transaction_amount float, denomination_id int, denomination_type int, Total_amount float ,atm_model_name varchar, Date Date);"

    input_prompt = """tables: \n {schema} \nquery for: {query}""".format(schema = schema, query=question)

    # Tokenize the input prompt
    inputs = trained_tokenizer(input_prompt, padding=True, truncation=True, return_tensors="pt")
    
    # Forward pass
    with torch.no_grad():
        outputs = trianed_model.generate(**inputs, max_length=512)
    
    # Decode the output IDs to a string (SQL query in this case)
    generated_sql = trained_tokenizer.decode(outputs[0], skip_special_tokens=True)
    
    if str(generated_sql[-1])!=';':
        generated_sql = generated_sql+';'
        return generated_sql

    return generated_sql

# Query will be Executed and return JSON.
def query_to_json(query):
    cursor = mydb.cursor() 
    
    try:
        print("Executer")
        cursor.execute(query)
        print("Done Executer")
    except Exception as e:
        print("Exception Occur: ",e)
        result = []
        r = json.dumps(result)
        return r

    # Fetch all rows and convert to a list of dictionaries
    print("fetching")
    rows = cursor.fetchall()
    print("rows ",rows)
    result = []
    for row in rows:
        d = {}
        for i, col in enumerate(cursor.description):
            if type(row[i]) == datetime.date:
                d[col[0]] = row[i].strftime("%Y-%m-%d")
                continue
            elif type(row[i]) == datetime.datetime:
                d[col[0]] = row[i].strftime("%Y-%m-%d %H:%M:%S")
                continue
            d[col[0]] = row[i]
        result.append(d)
            
    # Convert the list of dictionaries to JSON and print it
    json_result = json.dumps(result)
    return json_result

app = Flask(__name__)

@app.route('/') 
def Home(): 
    return render_template('Home.html')

@app.route('/answer', methods = ['POST'])
def answer():
    question = request.form.get("question")

    start_time = time.time()

    generated_sql = generate_sql(question)

    end = time.time()
    
    time_taken = "{s:.2f} sec".format(s = end - start_time)

    response = query_to_json(generated_sql)

    return render_template("Home.html", time = time_taken, query = generated_sql, answer=response)


@app.route('/askai', methods = ['GET'])
def askai():
    question = request.args.get('question')
    print("QUE:",question)
    start_time = time.time()

    generated_sql = generate_sql(question)

    end = time.time()
    
    time_taken = "{s:.2f} sec".format(s = end - start_time)

    response = query_to_json(generated_sql)
    print(response)
    return response



if __name__ == "__main__":
    app.run(debug=True)



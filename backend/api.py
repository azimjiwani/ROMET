from flask import Flask, jsonify, request
from flask_cors import CORS
import pymongo
import config
import json
import requests
from pymongo.mongo_client import MongoClient
from pymongo.server_api import ServerApi

app = Flask(__name__)
app.config["DEBUG"] = True

username = "azimjiwani"
password = "oZscwEbpBFXPKkFu"

connection_url = "mongodb+srv://{}:{}@projectdata.0iwnpaz.mongodb.net/?retryWrites=true&w=majority".format(username, password)
client = pymongo.MongoClient(connection_url)
database = client.get_database('ProjectData')

# Get list of all exercises
@app.route('/get-all-exercises/', methods=['GET'])
def get_exercises():
    db_exercises = database.ValidExercises
    output = []
    for exercise in db_exercises.find():
        data = {
            key: exercise[key] if exercise[key] is not None else -1000
            for key in [
                'exerciseName', 'description', 'hand', 'reps', 'sets'
            ]
        }
        output.append(data)

    return jsonify({'result': output})

# Create user

# Prescribe exercise to user

# user get prescribed exercises

# user upload completed exercise


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8000, debug=True)
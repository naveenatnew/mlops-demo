from fastapi import FastAPI
from pydantic import BaseModel
import joblib

app = FastAPI()

model = joblib.load("saved_model/model.pkl")

class IrisRequest(BaseModel):
    sepal_length: float
    sepal_width: float
    petal_length: float
    petal_width: float

@app.get("/")
def home():
    return {"message": "ML Prediction API is running"}

@app.post("/predict")
def predict(request: IrisRequest):
    features = [[
        request.sepal_length,
        request.sepal_width,
        request.petal_length,
        request.petal_width
    ]]

    prediction = model.predict(features)

    return {
        "prediction": int(prediction[0])
    }
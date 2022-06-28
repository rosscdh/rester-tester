import os
from pathlib import Path
from typing import List, Optional

from fastapi import FastAPI

#
# Setup the FastApi App
#
app = FastAPI()



@app.api_route("/*", methods=["GET", "POST", "PUT", "OPTIONS", "DELETE"])
async def index(request: Request):
    return {"method": request.method}
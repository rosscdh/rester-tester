import os
from pathlib import Path
from typing import List, Optional

from fastapi import FastAPI, Request

#
# Setup the FastApi App
#
app = FastAPI()



@app.api_route("/{full_path:path}", methods=["GET", "POST", "PUT", "OPTIONS", "DELETE"])
async def index(request: Request, full_path: str):
    return {"method": request.method, "full_path": full_path}
#!/usr/bin/env python
# coding: utf-8

# In[ ]:


from typing import List, Optional
from fastapi import FastAPI
import os 
import asyncio
import uvicorn

app = FastAPI()


# In[ ]:


# Define a dummy population dataset
population_data = {
    "USA": 328_200_000,
    "China": 1_398_500_000,
    "India": 1_366_400_000,
    "Brazil": 210_000_000,
    "Pakistan": 220_892_340
}

@app.get(os.path.join("/",os.environ.get("REPORT_URL"),"info"))
def info():
    return population_data

@app.get(os.path.join("/",os.environ.get("REPORT_URL"),"population","{country_name}"))
def get_population2(country_name: str):
    if country_name in population_data:
        return {"country": country_name, "population": population_data[country_name]}
    else:
        return {"error": f"Country '{country_name}' not found."}

loop = asyncio.get_event_loop()

# In[ ]:

async def do_serve(server):
    print("Launch server")
    await asyncio.run(server.serve())
    print("DSDS")

async def main():    
    pass

if __name__ == "__main__":
    config = uvicorn.Config(app)
    config.port = int(os.environ.get("REPORT_PORT"))
    config.host = "0.0.0.0" #os.environ.get("SERVERNAME")
    #config.root_path = "/" + os.environ.get("REPORT_URL")
    server = uvicorn.Server(config)
    do_serve(server)
    #await server.serve()


# ![](data/chatgpt-1.png)

# ![](data/chatgpt-2.png)

# In[ ]:





from fastapi import FastAPI, status,Depends,Response
from sqlalchemy.orm import Session
import MiniProjectSql2 as sql

app = FastAPI()


@app.get("/AllUsers")
async def GetAllUser(response: Response,db:Session = Depends(sql.get_db)):
    response.status_code = status.HTTP_200_OK
    return sql.GetAllUser(db)

@app.post("/AddUsers")
async def AddUsers(user:sql.User,response: Response,db:Session = Depends(sql.get_db)):
    sql.AddUser(user,db)
    response.status_code = status.HTTP_201_CREATED
    return {"Message":"Created Successfully"}

@app.get("/ValidateUser")
async def ValidateUser(Name:str,Password:str,response: Response,db:Session = Depends(sql.get_db)):
    result =  sql.ValidateUser(Name,Password,db)
    if result:
        user = sql.GetUser(name=Name,db=db)
        response.status_code = status.HTTP_200_OK
        return {"Message":"Valid User","User":user}
    else:
        response.status_code = status.HTTP_404_NOT_FOUND
        return {"Message":"Not Found"}

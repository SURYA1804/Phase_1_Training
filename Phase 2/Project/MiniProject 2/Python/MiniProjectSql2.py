import os
from typing import Optional
from dotenv import load_dotenv
from fastapi import Depends, HTTPException
from pydantic import BaseModel
from sqlalchemy import create_engine, func
from sqlalchemy.dialects.sqlite import *
from sqlalchemy.orm import sessionmaker,declarative_base,Session
from passlib.context import CryptContext

load_dotenv()
url = os.getenv("my_db_database")
engine = create_engine(url,connect_args={"check_same_thread":False})
session = sessionmaker(autocommit=False,autoflush=False,bind=engine)
Base = declarative_base()

from sqlalchemy import Column,Integer,String

class Users(Base):
    __tablename__ = "User"
    ID = Column(Integer,primary_key=True,index = True)
    Name = Column(String(50),nullable = False)
    Password = Column(String(50),nullable = False)
    Role = Column(String(50),nullable = False)

Base.metadata.create_all(bind=engine)

class User(BaseModel):
    Name: str
    Role: str
    class Config:
        orm_mode = True
        from_attributes=True

def get_db():
    db = session()
    try:
        yield db        
    finally:
        db.close()

pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

def hash_password(raw_password: str) -> str:
    return pwd_context.hash(raw_password)

def verify_password(raw_password: str, hashed: str) -> bool:
    return pwd_context.verify(raw_password, hashed)

def AddUser(user:User,db:Session):
    hwp = hash_password(user.Password)
    us = Users(Name = user.Name,Password = hwp,Role = user.Role )
    db.add(us)
    db.commit()
    db.refresh(us)

def GetAllUser(db:Session):
    UserList =  db.query(Users).all()
    users = [User.model_validate(stud) for stud in UserList]
    return users

def ValidateUser(name : str,password : str,db:Session):
    user_row: Optional[Users] = db.query(Users).filter(Users.Name == name).first()
    if not user_row:
        return False

    return verify_password(password, user_row.Password)

def GetUser(name:str,db:Session):
    user_row: Optional[Users] = db.query(Users).filter(Users.Name == name).first()
    return User.model_validate(user_row)
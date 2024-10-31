from datetime import datetime
from uuid import UUID, uuid4

import sqlalchemy.dialects.postgresql as pg
from sqlmodel import Column, Field, SQLModel


class TableInSchema(SQLModel, table=False):
    """So we do not need to repeat the schema for every table"""

    __table_args__ = {"schema": "libapi"}


class Book(TableInSchema, table=True):
    """
    This class represents a book in the database
    """

    __tablename__ = "books"

    uid: UUID = Field(
        sa_column=Column(pg.UUID, primary_key=True, unique=True, default=uuid4)
    )
    title: str
    author: str
    isbn: str
    description: str
    created_at: datetime = Field(sa_column=Column(pg.TIMESTAMP, default=datetime.now))
    updated_at: datetime = Field(sa_column=Column(pg.TIMESTAMP, default=datetime.now))

    def __repr__(self) -> str:
        return f"Book => {self.title}"

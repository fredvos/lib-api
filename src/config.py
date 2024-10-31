from dotenv import dotenv_values
from pydantic import BaseModel


class Settings(BaseModel):
    """
    This class defines the settings for the app
    """
    postgres_host: str
    postgres_user: str
    postgres_password: str
    postgres_database: str
    postgres_schema: str
    
    def get_postgres_url(self) ->  str:
        return f"postgresql+asyncpg://{self.postgres_user}:{self.postgres_password}@{self.postgres_host}/{self.postgres_database}"


envdict = dotenv_values(".env")
print("envdict =", envdict)
settings = Settings(
    postgres_host=str(envdict.get("POSTGRES_HOST")),
    postgres_user=str(envdict.get("POSTGRES_USER")),
    postgres_password=str(envdict.get("POSTGRES_PASSWORD")),
    postgres_database=str(envdict.get("POSTGRES_DATABASE")),
    postgres_schema=str(envdict.get("POSTGRES_SCHEMA"))
)

print("postgres_url =", settings.get_postgres_url())

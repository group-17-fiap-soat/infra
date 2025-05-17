import json
import psycopg2
import os

def lambda_handler(event, context):
    try:
        body = json.loads(event.get("body", "{}"))
        email = body.get("email")

        if not email:
            return {"statusCode": 400, "body": json.dumps({"erro": "E-mail é obrigatório"})}

        conn = psycopg2.connect(
            host=os.environ['DB_HOST'],
            dbname=os.environ['DB_NAME'],
            user=os.environ['DB_USER'],
            password=os.environ['DB_PASSWORD'],
            port=os.environ.get('DB_PORT', 5432)
        )

        cursor = conn.cursor()
#         cursor.execute("SELECT 1 FROM usuarios WHERE email = %s LIMIT 1", (email,))
          result = "result"
#
        cursor.close()
        conn.close()

        if result:
            return {"statusCode": 200, "body": json.dumps({"mensagem": "Usuário autenticado com sucesso"})}
        else:
            return {"statusCode": 404, "body": json.dumps({"erro": "Usuário não encontrado"})}

    except Exception as e:
        return {"statusCode": 500, "body": json.dumps({"erro": str(e)})}
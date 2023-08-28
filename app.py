import json
import psycopg2
from os import environ as env
from urllib.parse import quote_plus, urlencode
from authlib.integrations.flask_client import OAuth
from dotenv import find_dotenv, load_dotenv
from flask import Flask, redirect, render_template, session, url_for

ENV_FILE = find_dotenv()
if ENV_FILE:
    load_dotenv(ENV_FILE)

app = Flask(__name__)
app.secret_key = env.get("APP_SECRET_KEY")

oauth = OAuth(app)

oauth.register(
    "auth0",
    client_id=env.get("AUTH0_CLIENT_ID"),
    client_secret=env.get("AUTH0_CLIENT_SECRET"),
    client_kwargs={
        "scope": "openid profile email",
    },
    server_metadata_url=f'https://{env.get("AUTH0_DOMAIN")}/.well-known/openid-configuration'
)

@app.route("/login")
def login():
    return oauth.auth0.authorize_redirect(
        redirect_uri=url_for("callback", _external=True)
    )

@app.route("/callback", methods=["GET", "POST"])
def callback():
    token = oauth.auth0.authorize_access_token()
    session["user"] = token
    return redirect("/")

@app.route("/logout")
def logout():
    session.clear()
    return redirect(
        "https://" + env.get("AUTH0_DOMAIN") + "/v2/logout?" + urlencode(
            {
                "returnTo": url_for("home", _external=True),
                "client_id": env.get("AUTH0_CLIENT_ID"),
            },
            quote_via=quote_plus,
        )
    )

@app.route("/")
def home():
    return render_template("home.html", session=session.get('user'), pretty=json.dumps(session.get('user'), indent=4))

@app.route("/issues")
def issues():
    conn = psycopg2.connect(database=env.get("DATABASE"), user=env.get("USER"), password=env.get("PASSWORD"), host=env.get("HOST"), port=env.get("PORT"))
    cur = conn.cursor()
    cur.execute(''' SELECT issues.id, projects.name, issues.title, issues.status, issues.priority, issues.date, issues.target_date, E1.name,
                        E2.name
                    FROM issues, projects, employees E1, employees E2
                    WHERE issues.project_id = projects.id
                    AND issues.developer_id = E1.id
                    AND issues.tester_id = E2.id''')
    data = cur.fetchall()
    cur.close()
    conn.close()
    return render_template("issues.html", session=session.get('user'), pretty=json.dumps(session.get('user'), indent=4), data=data)

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=env.get("PORT", 3000))
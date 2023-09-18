import json
import psycopg2
import requests
import http.client
from os import environ as env
from urllib.parse import quote_plus, urlencode
from authlib.integrations.flask_client import OAuth
from dotenv import find_dotenv, load_dotenv
from flask import Flask, redirect, render_template, session, url_for, request

# APP CONFIG -----------------------------------------------------------------------------------------------------
ENV_FILE = find_dotenv()
if ENV_FILE:
    load_dotenv(ENV_FILE)
clientID = env.get("AUTH0_CLIENT_ID")
clientSecret = env.get("AUTH0_CLIENT_SECRET")
domain = env.get("AUTH0_DOMAIN")
secretKey = env.get("APP_SECRET_KEY")
audience = env.get("AUTH0_API_IDENTIFIER")

app = Flask(__name__)
app.secret_key = secretKey
oauth = OAuth(app)
oauth.register(
    "auth0",
    client_id = clientID,
    client_secret = clientSecret,
    client_kwargs =
    {
        "scope": "openid profile email",
    },
    server_metadata_url = f'https://{domain}/.well-known/openid-configuration'
)

dbName = env.get("DATABASE")
dbUser = env.get("USER")
dbPassword = env.get("PASSWORD")
dbHost = env.get("HOST")
dbPort = env.get("PORT")

# GET API ACCESS TOKEN -------------------------------------------------------------------------------------------
tokenConnection = http.client.HTTPSConnection(domain)
tokenPayload = "{\"client_id\":\"" + clientID + "\",\"client_secret\":\"" + clientSecret + "\",\"audience\":\"" + audience + "\",\"grant_type\":\"client_credentials\"}"
tokenHeaders = { 'content-type': "application/json" }
tokenConnection.request("POST", "/" + domain + "/oauth/token", tokenPayload, tokenHeaders)
accessToken = tokenConnection.getresponse().read()

# GLOBALS --------------------------------------------------------------------------------------------------------
orderBy = "" # Used in /issues to store the column to sort the issues by
ascending = True # Used in /issues to store whether the orderBy column should ascend or descend

# LOGIN/LOGOUT FLOW ----------------------------------------------------------------------------------------------
@app.route("/login")
def login():
    return oauth.auth0.authorize_redirect(
        redirect_uri = url_for("callback", _external = True)
    )

@app.route("/callback", methods = ["GET", "POST"])
def callback():
    token = oauth.auth0.authorize_access_token()
    session["user"] = token
    return redirect("/")

@app.route("/logout")
def logout():
    session.clear()
    return redirect(
        "https://" + domain + "/v2/logout?" + urlencode(
            {
                "returnTo": url_for("home", _external = True),
                "client_id": clientID,
            },
            quote_via = quote_plus,
        )
    )

# APP PAGES ------------------------------------------------------------------------------------------------------
@app.route("/")
def home():
    return render_template("home.html", session = session.get('user'), pretty = json.dumps(session.get('user'), indent = 4))

@app.route("/issues", methods = ['GET', 'POST'])
def issues():
    global orderBy
    global ascending

    # How Asc and Desc sort is determined:
    #   Clicking the same column repeatedly will loop the sort through these options: Asc > Desc > Default
    #       Default sorts the ID column by Asc. This allows the user to remove their customised sort on a column

    orderByWhitelist = ["issues.id", "projects.name", "issues.title", "issues.status", "issues.priority", "issues.date", "issues.target_date", "developers.name", "testers.name", "issues.id"]
    if orderBy not in orderByWhitelist: # User-input sanity check against a whitelist. Default sort if there is no match
        orderBy = "issues.id" 
    else:
        if orderBy != request.form.get("orderByTextField"): # If a new column is clicked
            ascending = True
        else: # If the same column was clicked
            if not ascending: # If this same column is already Desc, revert to default sort
                orderBy = "issues.id"
        orderBy = request.form.get("orderByTextField") # Get the new orderBy value in the request
        if orderBy == None: # Catches when the site is first entered and there is no data in the request
            orderBy = "issues.id"

    query = ''' SELECT issues.id, projects.name, issues.title, issues.status, issues.priority, issues.date, issues.target_date, developers.name, testers.name
                FROM issues, projects, employees developers, employees testers
                WHERE issues.project_id = projects.id
                AND issues.tester_id = testers.id
                AND issues.developer_id = developers.id
                ORDER BY {0} {1} '''
    if ascending: # Edit query to sort by Asc and then set the value to Desc for next time
        query = query.format(orderBy, "Asc")
        ascending = False
    else: # Edit query to sort by Desc and then set the value to Asc for next time
        query = query.format(orderBy, "Desc")
        ascending = True

    dbConnection = psycopg2.connect(database = dbName, user = dbUser, password = dbPassword, host = dbHost, port = dbPort)
    dbCursor = dbConnection.cursor()
    dbCursor.execute(query)
    issuesTableData =dbCursor.fetchall()
    dbCursor.close()
    dbConnection.close()

    return render_template("issues.html", session = session.get('user'), pretty = json.dumps(session.get('user'), indent = 4), issuesTableData = issuesTableData)

@app.route("/issue", methods = ['GET', 'POST'])
def issue():
    issueId = request.form.get("issueIdTextField")
    query = ''' SELECT issues.id, issues.title, issues.description, issues.date, testers.name, developers.name, projects.name, issues.status, issues.priority, issues.target_date, issues.end_date, issues.solution
                FROM issues, employees testers, employees developers, projects
                WHERE issues.id = {0}
                AND issues.tester_id = testers.id
                AND issues.developer_id = developers.id
                AND issues.id = projects.id'''
    query = query.format(issueId)
    
    dbConnection = psycopg2.connect(database = dbName, user = dbUser, password = dbPassword, host = dbHost, port = dbPort)
    dbCursor = dbConnection.cursor()
    dbCursor.execute(query)
    issueData = dbCursor.fetchall()
    dbCursor.close()
    dbConnection.close()
    
    return render_template("issue.html", session = session.get('user'), pretty = json.dumps(session.get('user'), indent = 4), issueData = issueData)

# MAIN -----------------------------------------------------------------------------------------------------------
if __name__ == "__main__":
    app.run(host = "0.0.0.0", port = env.get("PORT", 3000))
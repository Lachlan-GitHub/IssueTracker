# IssueTracker
## Design
![Design Image](https://github.com/Lachlan-GitHub/IssueTracker/blob/main/documentation/DesignImage.png?raw=true)


## Installation - Windows
1. [Prerequisites](https://code.visualstudio.com/docs/python/tutorial-flask#:~:text=Q%26A.-,Prerequisites,-To%20successfully%20complete).
2. Clone this repository and open it inside VS Code.
3. In VS Code, Navigate: View > Command Palette. Select 'Python: Create Environment'. Select 'Venv' and the Python environment you want to use. Select requirements.txt.
4. Navigate: View > Command Palette. Select 'Terminal: Create New Terminal'. If the .venv terminal ever disapears, then you can re-open it with the same steps.
5. Sign up for an Okta Auth0 developer account [here](https://developer.okta.com/signup/) (the free Customer Identity Cloud option) or log into an existing Okta Auth0 account [here](https://auth0.com).
6. Once logged into Auth0, click on Applications on the left bar and create a new Regular Web Application. Click on the Python option when you are shown the different technologies.
7. Scroll down to 'Configure your .env file' and copy the text into a file named '.env' in your project repository.
8. Generate a secret key with [this code](https://stackoverflow.com/questions/60738514/openssl-rand-base64-32-what-is-the-equivalent-in-python#:~:text=11-,In%20python%203.6%2B%3A,-from%20secrets%20import) and paste it into the .env file next to ```APP_SECRET_KEY=```.
9. Navigate to the 'Settings' tab and paste ```http://127.0.0.1:5000/callback``` into the 'Allowed Callback URLs' box, as well as ```http://127.0.0.1:5000``` into the 'Allowed Logout URLs' box. Save the changes.
10. Setup the PostgreSQL server by following [this guide](https://www.postgresqltutorial.com/postgresql-getting-started/install-postgresql/).
11. Open pgAdmin and connect to the PostgreSQL server. If the connection times out then you may need to open a cmd window as and administrator and enter ```net start postgresql-x64-15```.
12. Right click 'Databases' and create a new database named 'issuetracker'.
13. Right click the new database and click 'Restore'. Load ```/documentation/TestData.sql```. You may need to right click the database and refresh it after it restores to see the data.
14. Open the .env file, paste the following text, and edit it if your values differ:
```
DATABASE=issuetracker
USER=postgres
PASSWORD=password
HOST=localhost
PORT=5432

AUTH0_API_IDENTIFIER=
```
15. Back in the Auth0 dashboard:
    - Applications > APIs > Copy the audience value and past it next to ```AUTH0_API_IDENTIFIER=```
    - Auth0 Management API > Machine to Machine Applications > Enable IssueTracker
16. Account setup for testing:
    - Applications > Applications > IssueTracker > Connections > Disable 'google-oauth2'
    - Authentication > Database > Username-Password-Authentication > Disable Sign Ups
    - User Management > Users > Create User > Create 4 users with the details from ```/documentation/TestUsers.txt```
17. Return to the console in VS code and run the website with: ```python -m flask run```.

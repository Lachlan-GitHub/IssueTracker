# IssueTracker
Info here

## Installation
The following guide is pulled from:
- https://code.visualstudio.com/docs/python/tutorial-flask
- https://auth0.com/docs/quickstart/webapp/python/interactive

To run this website locally:
1. Follow these [prerequisites](https://code.visualstudio.com/docs/python/tutorial-flask#:~:text=Q%26A.-,Prerequisites,-To%20successfully%20complete).
2. Clone this repository and open it inside [VS Code](https://code.visualstudio.com/).
3. In VS Code, open the Command Palette (View > Command Palette). Then select the 'Python: Create Environment' command to create a virtual environment in your workspace. Select venv and then the Python environment you want to use to create it. Also select requirements.txt once it asks you if you want to install other dependencies.
4. After your virtual environment creation has been completed, open the the Command Palette again and run 'Terminal: Create New Terminal', which creates a terminal and automatically activates the virtual environment by running its activation script.
5. Sign up for an Okta Auth0 developer account [here](https://developer.okta.com/signup/) (the free Customer Identity Cloud option) or log into an existing Okta Auth0 account [here](https://auth0.com).
6. Once logged into Auth0, click on Applications on the left bar and create a new Regular Web Application. Click on the Python option when you are shown the different technologies.
7. Scroll down to the 'Configure your .env file' heading and copy the code into a file named '.env' in your project repository.
8. Generate a secret key with [this](https://stackoverflow.com/questions/60738514/openssl-rand-base64-32-what-is-the-equivalent-in-python#:~:text=11-,In%20python%203.6%2B%3A,-from%20secrets%20import) code and paste it into the .env file.
9. Navigate to the 'Settings' tab and paste ```http://127.0.0.1:5000/callback``` into the 'Allowed Callback URLs' box, as well as ```http://127.0.0.1:5000``` into the 'Allowed Logout URLs' box. Save the changes.
10. Setup the PostgreSQL server by following [this](https://www.postgresqltutorial.com/postgresql-getting-started/install-postgresql/) guide.
11. Open pgAdmin, expand the tabs on the left until you see 'databases, right click it and create a new database named 'issuetracker'. Under the SQL tab, paste all the text from /documentation/1-TestData.sql.
------------- UNFINISHED
13. Return to the console in VS code and run the website with: ```python -m flask run```.

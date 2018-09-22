# Issue tracker v2

## Overview

The idea behind the task is to implement an issue tracker like JIRA, Zendesk, or Trello. It should be very simple with only few features.

The goal is to show working example. Precise implementation of a particular feature is not that important as long as you can explain difficulties you face or a better approach.

The following description doesn’t cover all the details, so you are free to make decisions about the features on your own. 

Also please ask questions if something is not clear. Any questions are welcome. My email is kostya@studytube.nl.

## Description

**The application should implement only REST API**

As a regular user you should:
- be able to log into the system
- be able to create/update/delete **only your** issues
- see the list of **only your** issues (most recent at the top)
- **not** be able to update the status of your issues
- **not** be able to update the assignend manager of your issues

As a manager you should:
- be able to log into the system
- be able to see the list of **all** issues
- be able to assign an issue to only **yourself** and only if it is **not already assigned** to somebody else
- be able to unassign an issue from **yourself**
- be able to change the status of the issue **only** if the issue is assigned to you
- **not** be able to assign an issue to somebody else
- **not** be able to change the status of an issue **unless** it is assigned to you

### Notes
- issue statuses: “pending”, “in progress”, “resolved”. Default: “pending”
- if the issue has “in progress”, or “resolved” status the assignee is required. It can’t be unassigned in these two statuses
- users and managers should be able to filter by “status”
- pagination should be implemented, 25 issues in the response.
- if you use JSON, please make sure the error responses for 500, 400, 422, etc, are also in JSON format

## Running locally using docker

`docker-compose up` should run the project with all the necessary service like postgres server.
Visit [http://localhost:3000](http://localhost:3000)

## Authentication and registration
The API authentication was implemented using [devise_token_auth](https://github.com/lynndylanhurley/devise_token_auth).
To check routes to register, login or logout you can read the [devise_token_auth documentation](https://github.com/lynndylanhurley/devise_token_auth/blob/master/docs/usage/README.md).
Once you start the project the shell will give 2 users (emails and password) for you to test the API.

## Documentation
The API has his own documentation you can consume in the route [`/documentation`](http://localhost:3000/documentation)

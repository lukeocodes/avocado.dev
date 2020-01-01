---
layout: auth0
title: "Manage Secure Endpoints with Postman"
description: "Learn how to use Postman to manage a collection of public and secure API endpoints."
categories: [postman, tutorial]
tags: [auth0, postman, tutorial]
cover: manage-a-collection-of-secure-api-endpoints-with-postman.png
cover_bg: 4F485D
author: luke
canonical_url: https://auth0.com/blog/manage-a-collection-of-secure-api-endpoints-with-postman/
---

I'm going to show you how to use Postman to interact with an API for both public and secure API endpoints. Check out the [Express API on GitHub](https://github.com/auth0-blog/auth0-postman-express), or [check out the API in Postman](https://documenter.getpostman.com/view/3232248/RWgtTce3).

[Postman](https://www.getpostman.com/) is an API development environment that helps you develop your APIs. It can be used to streamline the development process and creates a single source of truth for an organization's APIs with rich documentation produced from the very tool you use to manage and test your API.

## Postman Is the First ADE

If you're a programmer or software engineer, you'll be familiar with an integrated development environment (or IDE). [Postman](https://www.getpostman.com/) is the first example of an API development environment (or ADE).

Used by over 5 million developers to access over 130 million APIs every month, Postman started as a simple Chrome browser plugin in 2012 and quickly grew to become a familiar friend to developers all over the world.

> "Over 5 million developers use @postmanclient to access over 130 million APIs every month."

> *"The Postman toolchain can help to build software that is useful across various use cases ranging from a single developer to an enterprise. We are building for the future where everything is going to be connected."*

It's 2018 and Postman has already grown to such a size it launched both an enterprise SaaS offering and a conference, POST/CON 2018. Not to mention, it knocked Google Analytics off of the top spot of "Top Utility Tool" by [StackShare](https://twitter.com/stackshareio).

Postman contains tools to design, debug, test, and monitor APIs as well as develop and publish documentation. It's an entire platform that supports and enhances API development. It streamlines the development process, creates a single source of truth for an organization's APIs, and enhances collaboration on APIs across an organization.

![Postman is an ADE, essential to your API development](https://cdn.auth0.com/blog/build-a-secure-express-api-using-postman-and-auth0/postman-ade.png)

## Pre-Requisites

### Node & NPM

To get started, check if node and npm are already installed by running:

    node --version
    

    npm --version
    

If `node` and `npm` aren't installed, check out [nodejs.org](https://nodejs.org/) and install the correct version for your operating system.

> *Note:* Demos in this article were developed using Node 8 and NPM 6.

### Git

[Install Git](https://linode.com/docs/development/version-control/how-to-install-git-on-linux-mac-and-windows/) so you can clone our code.

### Postman

[Install Postman](https://www.getpostman.com/apps) as this will be key in following this guide.

## Clone Our Demo API

For this article, there is a demo application specifically built for you to interact with. Clone it using the `git clone` command.

    git clone https://github.com/auth0-blog/auth0-postman-express.git
    

Change into your demo app directory.

    cd auth0-postman-express
    

Make sure you run `npm install` to pull down all our node dependencies.

    npm install
    

### Connect to Our Demo Database

Create a new `.env` file from our existing `.env.example`. It already contains the demo connection details required to connect to our database.

    cp .env.example .env
    

You could [install and connect to a local MongoDB as well](https://docs.mongodb.com/manual/administration/install-community/). As the data is modelled all you would need to do is create a database and change the connection string in the `.env` file.

## Making Requests with Postman

First, run the API using the `start` script included in our `package.json`.

    npm start
    

You should be able to start the application with no problems.

Now, open Postman, and create a new *Untitled Request* by pressing CMD/CTRL + T.

![New untitled request](new-untitled-request.png)

On your *Untitled Request* tab enter the URL of `http://localhost:3000/`, leaving the *request type* as GET and click *SEND*.

Everything being correct, the response will return as JSON containing a *\_links.self* object with a *href* of `/`.

> *Note:* These self-links are defined as part of the [HATEOAS constraint of REST](https://spring.io/guides/gs/rest-hateoas/). You can read more about how this fits into REST on Martin Fowler's blog about the [Richardson Maturity Model](https://martinfowler.com/articles/richardsonMaturityModel.html).

![Root request returns](root-request.png)

### Create a Collection

So, now that you've got your first Request working, you should save it to a Postman Collection so you can reuse it. To do that, first, create a Collection with CMD/CTRL + N and selecting *Collection* or from the New drop-down menu, or by clicking on Create a Collection on the Collection tab of the side menu.

In the box that pops up, name your Collection and click on *Create*.

![Create a new collection](create-collection.png)

### Configure a Postman Environment

Before you start saving your requests, set up a Postman Environment to store some environment variables. You can create an Environment with CMD/CTRL + N and selecting *Environment* or from the New drop-down menu.

Name your new environment *Local* and add a variable named `domain` with the initial value of `http://localhost:3000`. The current value will update to match, automatically.

![Create a new environment](create-environment.png)

Now click Add and close the *Manage Environments* tab.

Select your new *Local* environment from the environment tab.

![Select an environment](select-environment.png)

Now update the request you've already to the URL of `{{domain}}/` and click *SEND* again.

![Update root request with environment](root-request-w-environment.png)

### Save Your Requests

You have a request to save, so now you can save it. CMD/CTRL + S (or CMD/CTRL + SHIFT + S if you're modifying an existing request) will open up a *Save Request* dialogue box. Give it a useful name (in the above case, I'd call it root) and select the collection you created. Then click on the big orange Save to {collection name} button.

![Save root request](save-root-request.png)

Now, you'll see how to create the other requests you can make to the application.

#### List Request

On a new request tab, enter the URL of `{{domain}}/haiku` and *request type* as `GET`.

Save the request to your collection with CMD/CTRL + S (or CMD/CTRL + SHIFT + S).

![List haiku](list-haiku.png)

#### Create Request

On a new request tab, enter the URL of `{{domain}}/haiku`, *request type* as `POST` and the following request body with a type of raw (application/json):

    {
      "line1": "An old silent pond...",
      "line2": "A frog jumps into the pond,",
      "line3": "splash! Silence again."
    }
    

Save the request to your collection with CMD/CTRL + S (or CMD/CTRL + SHIFT + S).

This will error with a `No authorization token was found` message until you follow the authorization steps.

![Create haiku](create-haiku.png)

#### Read Request

On a new request tab, enter the URL of `{{domain}}/haiku/[haiku_id]` (replacing \[haiku\_id\] with an ID you got from the list request) and *request type* as `GET`.

Save the request to your collection with CMD/CTRL + S (or CMD/CTRL + SHIFT + S).

![Get haiku](get-haiku.png)

#### Update Request

On a new request tab, enter the URL of `{{domain}}/haiku/[haiku_id]` (replacing \[haiku\_id\] with a Mongo database ID), *request type* as `PUT` and request body with a type of raw (application/json):

    {
      "line3": "Splish! Silent again."
    }
    

Only include the fields you want to update.

Save the request to your collection with CMD/CTRL + S (or CMD/CTRL + SHIFT + S).

> *Note:* This will also error with a `No authorization token was found` message until you follow the authorization steps or if you try and update a resource that doesn't belong to you.

![Get haiku](update-haiku.png)

#### Delete Request

On a new request tab, enter the URL of `{{domain}}/haiku/[haiku_id]` (replacing \[haiku\_id\] with a Mongo database ID) and *request type* as `DELETE`.

Save the request to your collection with CMD/CTRL + S (or CMD/CTRL + SHIFT + S).

> *Note:* This will also error with a `No authorization token was found` message until you follow the authorization steps or if you try and delete a resource that doesn't belong to you.

![Get haiku](delete-haiku.png)

## Share Your Collection

Once your requests have been created and saved to a Collection, you can share it.

![Review created requests](requests-created.png)

Clicking the share button allows you to share it in a few ways, including sharing it to a team Postman Workspace, a way to store and collaborate on Postman Collections in a team. Otherwise, you can create a "Run in Postman" button or get a link to the collection.

<a href="https://app.getpostman.com/run-collection/02c0cf63f6b4702d6fce"><img src="postman_button.svg" alt="Run in Postman"/></a>

## Authorization in Postman

Recent versions of Postman have support for OAuth 2.0 (and other authorization protocols) built in. Configured properly, you can use Postman to fulfil the role of a client application, resulting in an access token you can pass to your API.

Postman is going to be acting like a regular web application for the purposes of this guide. Authorization will be done using the [Authorization Code Grant Flow](https://auth0.com/docs/api-auth/tutorials/authorization-code-grant), but Postman could just as well allow for us to act as another client type, like taking the place of a single-page application using the [Implicit Grant Flow](https://auth0.com/docs/api-auth/tutorials/implicit-grant).

![Auth0 login screen](authorization.png)

### Sign Up for Auth0

You'll need an [Auth0](https://auth0.com/) account to manage authentication. You can [sign up for a free Auth0 account here](https://auth0.com/signup). Next, set up an Auth0 Client and API so Auth0 can interface with your app and API.

### Set Up an Auth0 Application

1.  Go to your [Auth0 Dashboard](https://manage.auth0.com/#/) and click the "[Create Application](https://manage.auth0.com/#/applications/create)" button.
2.  Name your new app, select "Regular Web App" and click the "Create" button.
3.  In the Settings for your new Auth0 app, add `https://www.getpostman.com/oauth2/callback` to the Allowed Callback URLs.
4.  Click the "Save Changes" button.

### Set Up an Auth0 API

1.  Go to [APIs](https://manage.auth0.com/#/apis) in your dashboard and click on the "Create API" button.
2.  Enter a name for the API. Set the Identifier to your API's URL. In this example, this is `http://express-api/`. It doesn't need to be a live web address, it just needs to be unique for this API. The Signing Algorithm should be `RS256`.

### Get an Access Token in Postman

Before Postman can get an access token for you, there are some configuration you need to do and some information you need from the Auth0 application and API you've just created. These details can be found on your [Auth0 Dashboard](https://manage.auth0.com/#/).

Open your new Application found on your [Auth0 Applications](https://manage.auth0.com/#/applications) page for the following details.

-   `auth0_domain`: Copy from the Domain field.
-   `auth0_client_id`: Copy from the Client ID field.
-   `auth0_client_secret`: Copy from the Client Secret field.

The API audience you need can be found on your [Auth0 APIs](https://manage.auth0.com/#/apis) page. Open your new API for the following details.

-   `auth0_audience`: Copy from the Identifier field, (NOT ID field). Our example was `http://express-api/`.

Add these details to the Postman environment you created to store reusable [environment variables](https://www.getpostman.com/docs/v6/postman/environments_and_globals/variables).

![Auth0 environment variables](auth0-environment-variables.png)

Now, edit your Postman collection.

![Edit your Postman collection](edit-collection.png)

Click on the *Authorization* tab. For *Type* pick `OAuth 2.0` and for *Add auth data to* pick `Request Headers`.

![Select OAuth 2.0 and Request Headers](request-headers.png)

Now click on *Get New Access Token* and complete the form shown here.

> *Note:* Postman [doesn’t support an audience](https://github.com/postmanlabs/postman-app-support/issues/2934), so we need to append it to our authorize endpoint.

| Form Field | Value |
| --- | --- |
| Token Name | `Any name you like` |
| Grant Type | `Authorization Code` |
| Callback URL | `https://www.getpostman.com/oauth2/callback` |
| Auth URL | `https://{{auth0_domain}}/authorize?audience={{auth0_audience}}` |
| Access Token URL | `https://{{auth0_domain}}/oauth/token` |
| Client ID | `{{auth0_client_id}}` |
| Client Secret | `{{auth0_client_secret}}` |
| Scope | `openid profile email` |
| State | `Some random string of your choosing` |
| Client Authentication | `Send client credentials in body` |

![Complete the token request form](request-form.png)

Now click on Request Token and log in (or sign-up) to your application.

![Auth0 login screen](authorization.png)

On successful login, you'll see a new access token. Scroll down and click on Use Token.

![Receive and use the access token](access-token.png)

Your collection edit screen will now have the correct access token selected, but if it doesn't, click on the Available Tokens drop-down and select the correct one. Click on Update.

![Select the right access token](token-selected.png)

This has now updated the collection (or request, if you edited authorization there) with the appropriate `Authorization=Bearer <an_access_token_here>` header, which you'll see on the Header tab of your requests.

### Access Token to Call Protected Endpoints

All your saved requests will default to Authorization Type Inherit auth from parent. You can see this on the Authorization tab of your requests. In this case, your requests will inherit from the collection. But, you can also organise your requests into folders and configure Authorization Type at a folder level.

This is where you could also choose to add Authorization to your individual requests.

![Select inherit auth from parent](inherit-auth-from-parent.png)

Now you have an access token, you need to make a small change to our application so it can verify our access.

Edit the `.env` file. Update the `AUTH0_DOMAIN` and `AUTH0_AUDIENCE` variables with the values used above.

    MONGO=mongodb://demo:password1@ds163103.mlab.com:63103/auth0-postman-express
    DEBUG=auth0-postman-express:*
    AUTH0_DOMAIN=your-auth0-domain.auth0.com
    AUTH0_AUDIENCE=http://express-api/
    

Once modified, run the API again using the same `start` script from before. If npm is still running from before, you will need to stop it and start it again. Stop it with *CTRL + C*.

So run the start script:

    npm start
    

Now our API will be able to verify our token, run the *create haiku* request again.

> *Note:* You'll need to running this request from your saved collection, for the authorization configuration to *inherit from parent* properly.

![Successful authorized request](authorized-request-success.png)

## Using a Postman Collection to Publish API Docs

The last thing anyone ever thinks of is writing their docs (rightly or wrongly). For your ease of development, you've created this great collection of all your resources and requests. Postman will do the legwork from here.

From your collection menu, click Publish Docs

![From your collection menu click Publish Docs](publish-docs.png)

Log into Postman and follow the instructions on the web and click on Publish Collection

Your collection is now published!

![Collection published](published.png)

> "You can take the pain out of developing APIs with @postmanclient"

## Conclusion

Writing docs and testing APIs can be a real pain. But Postman has helped take the pain out of that development. Additional features like automated testing and [command line tools](https://github.com/postmanlabs/newman) make it even more powerful.

I strongly recommend taking some time to get to know your friendly [Postman](https://getpostman.com/).

Check out [my published collection here](https://documenter.getpostman.com/view/3232248/RzZFDcda).

![Express API docs for Postman](view-collection.png)
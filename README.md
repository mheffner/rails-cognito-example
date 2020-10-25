# Rails AWS Cognito User Pool Example

This is a Rails application that demonstrates an AWS Cognito User Pool
server-side authentication flow using the Cognito Hosted UI. This was
extracted from another application that leveraged the Cognito User
Pools for minimal user authentication management.

User Sign Up, Sign In, and Sign Out are handled directly with Cognito
and the [Hosted
UI](https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-pools-app-integration.html)
auth forms. The Rails application simply extracts the authentication
data from the redirect after an authentication action is
performed. Server-side session keys track the Cognito tokens and
automatically refresh expired tokens.

There's a demo of this application running at
[https://cognito-rails-example.herokuapp.com/](https://cognito-rails-example.herokuapp.com/).

# Setup

## Create a Cognito User Pool

Create a new Cognito User Pool in the AWS console. The following
screenshots show the non-default settings I used to create this
pool. This is just a minimal example, so you will want to change the
settings to match your preferences.

![Pool Creation](/contrib/screenshots/screenshot_1.png?raw=true "Pool Creation")

Password policy for this pool is minimally restrictive, match your security org requirements.

![Password Policy](/contrib/screenshots/screenshot_2.png?raw=true "Password Policy")

We want minimal friction in our sign up form, so we will only collect
an email + password for now. You can include any number of attributes
in the sign up form. The email will act as the username in our setup.

![User Attributes](/contrib/screenshots/screenshot_3.png?raw=true "User Attributes")

We need at least one app client for our web app to talk to the
API. We'll need to lookup auth codes so enable 'Generate client
secret'. The name doesn't really matter so pick anything.

![App Client](/contrib/screenshots/screenshot_4.png?raw=true "App Client")

With the app client created, you need to set the app client
settings. Set the callback and sign out URLs to match your
application. These URLs must match the same redirect URLs used in the
application. Also, ensure the *authorization code grant* is selected
and *email* is in the allowed oauth scopes.

![App Client Settings](/contrib/screenshots/screenshot_5.png?raw=true "App Client Settings")

Finally, after the pool is created we will set the domain name that is
used for the hosted UI. If this were a production application you
would probably want to use your own full domain name instead.

![Domain Name](/contrib/screenshots/screenshot_6.png?raw=true "Domain Name")

## Configure the app

These are the required environment variables for this app:

* `AWS_COGNITO_APP_CLIENT_ID`
* `AWS_COGNITO_APP_CLIENT_SECRET`
* `AWS_COGNITO_DOMAIN`
* `AWS_COGNITO_POOL_ID`
* `AWS_COGNITO_REGION`

# TODO

* Track a user session through signup/signin for funnel analytics.
* Multiple identify providers (Facebook, Google, etc)
* Expire old sessions
  [periodically](https://github.com/rails/activerecord-session_store#installation)
* Refresh active Cognito sessions ahead of their expiration to avoid
  blocking on the next request

# Alternatives

The
[omniauth-cognito-idp](https://github.com/Sage/omniauth-cognito-idp/blob/master/README.md)
provides an alternative approach that leverages the
[OmniAuth](https://github.com/omniauth/omniauth) framework to build a
Cognito aware oauth2 middleware.

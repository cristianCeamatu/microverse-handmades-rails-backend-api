![Hireable](https://img.shields.io/badge/Hireable-yes-success) ![](https://img.shields.io/badge/Mobile--responsive-yes-green) ![](https://img.shields.io/badge/-Microverse%20projects-blueviolet)

# Ruby on Rails Backend API for the mobile web app <b>Crafts</b>

## We recommend visiting the frontend web app from a mobile device, where not possible you can use the mobile view in your browser

> The <b>Crafts</b> mobile web app presents the world's finest Crafts from all around the world. All users can create an account and add their creations, view/like other user's crafts, and contact the creators if interested in their work.
> <br>
> The API is created with the latest industry standards using Ruby and Rails API template and `devise_token_auth` gem
> <br>
> React Frontend used for API requests: [Crafts](https://handmades-react-redux-toolkit.herokuapp.com/) <br>
> The API is tested using RSPEC.
> <br>

## App functionality - base uri: https://handmades-rails-api-backend.herokuapp.com

#### Current working endpoints for items

- `GET /items` - all items from the database.
- `GET /items/:id` - get items details by id.
- `POST /items/` - create a new item
- `POST /items/:id/favorite` - to favorite/unfavorite and item
- `DELETE /items/:id` - find the item by id and delete it from the database

#### Current working endpoints for sessions and registrations

- `POST /api/v1/auth` - Create a new user
- `POST /api/v1/auth/sign_in` - Login the user

## This web app is live, you can check it here: [Live demo](https://handmades-rails-api-backend.herokuapp.com/)

## React Frontend [live demo](https://handmades-react-redux-toolkit.herokuapp.com/)

## React Frontend [github link](https://github.com/cristianCeamatu/microverse-handmades-react-redux-toolkit)

## Built With

- Ruby on Rails for the Backend API
- devise_token_auth for the login functionality
- Using AWS S3 with Active Storage for storing item images

## Testing

- Rspec
- Shoulda Matchers gem

## You can check other rails that I built:

- [Bible Talks](https://rails-bible-talks.herokuapp.com/)

## Prerequisities

To get this project up and running locally, you must have [node](https://nodejs.org/en/) and [yarn](https://yarnpkg.com/) installed locally.

## Getting Started

**To get this project set up on your local machine, follow these simple steps:**

**Step 1**<br>
Navigate through the local folder where you want to clone the repository and run
`git clone https://github.com/cristianCeamatu/microverse-handmades-rails-backend-api`.<br>
**Step 2**<br>
Run `cd microverse-handmades-rails-backend-api`<br>
**Step 3**<br>
Run `bundle install` to install the gems from the `Gemfile`.<br>
**Step 4**<br>
Run `yarn install` to install the npm packages from the `package.json` file.<br>
**Step 5**<br>
Run `bundle exec figaro install`, this will create a file called `application.yml` in the `config` folder.<br>
**Step 6**<br>
Open `config/application.yml` and add your credenatials for your postgres/[AWS S3](https://aws.amazon.com/console/) accounts like this (click on the above links to find out how to get a key):<br>
`PG_DATABASE_USER: example` <br>
`PG_DATABASE_PASSWORD: password`<br>
`BUCKETEER_AWS_ACCESS_KEY_ID: key`<br>
`BUCKETEER_AWS_SECRET_ACCESS_KEY: key`<br>
`BUCKETEER_AWS_REGION: key-zone`<br>
`BUCKETEER_BUCKET_NAME: key-bucket`<br>
**Step 7**<br>
Run `rails db:create` and `rails db:migrate` to create and migrate the database tabels and associations.<br>
**Step 8**<br>
Run `rails s` to start the rails server.<br>
**Step 9**<br>
You can visit the app at `http://localhost:3000`. Enjoy!<br>

## Tests

1. Open Terminal

2. Migrate the test database:

   `rails db:migrate RAILS_ENV=test`

3. Run the tests with the command:

   `rspec`

## Authors

👤 **Cristian Viorel Ceamatu**

- Email: [cristian.ceamatu@gmail.com](cristian.ceamatu@gmail.com)
- Github: [https://github.com/cristianCeamatu](https://github.com/cristianCeamatu)
- Twitter: [https://twitter.com/CristianCeamatu](https://twitter.com/CristianCeamatu)
- Linkedin: [https://www.linkedin.com/in/ceamatu-cristian/](https://www.linkedin.com/in/ceamatu-cristian/)

## 🤝 Contributing

Our favourite contributions are those that help us improve the project, whether with a contribution, an issue, or a feature request!

## Show your support

If you've read this far....give us a ⭐️!

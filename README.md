# Parting

> Parting is a task management tool where you can share the tasks you've completed within groups of your teammates, allowing better control over who did waht and when. 

![main-screen](./main-screen.jpeg)

Using parting, you can create a user to track all the tasks you've completed, append them to a group or team and see what others have done in the same group. Create new groups and add tasks to them, search your tasks, manage your team assignments and more( in development c:).

## Built With

- Ruby on Rails
- HTML/SASS
- JQuery
- Postgresql
- Heroku

## Live Demo

[Start using Parting](https://parting-mvp.herokuapp.com)


## Getting Started

To get a local copy up and running follow these simple steps.

### Prerequisites

  - Ruby on Rails >= 6.0.1
  - A local Postgres server
  - git
  - Nodejs >= 12.0

### Setup

First, clone the repository from github with:
```bash
  git clone https://github.com/Chincoya/parting.git
```
Then change into the repo's directory with:

```bash
  cd parting
```
 You can then proceed to installation.

### Install

You will need to have a local postgres server to be able to use Parting. If you don't know how, refer to [this tutorial](https://linoxide.com/linux-how-to/install-postgresql-10-linux-unix/). After you installed -and started- your postgres server, if your user is not authenticated, you will have to set up an environmental variable. Create a .env file in the App's root dir using:

```bash
  touch .env
```

That file will contain all the env. variables you'll need to properly setup and deply this app. For now, you'll only need -if that auth is required- one line:

```bash
  DBLOCALPASSWORD=YourLocalPassword
```

Once you've reached this point, run the following commands:

```bash
  bundle install
  rails db:setup
  rails db:migrate
```

These commands will:
  - Install all the packages needed for Parting to run
  - Create the database
  - Create and migrate the tables needed

If everything went right you should be able to run the test suit. And you should. Run: 

```bash
  rails spec
```

To do so. 

### Usage

For a local environment -which, admittedly, I don't know what you'll want it for- you should run: 
```bash
rails server
```
Or:

```bash
  rails s
```

To start a local server. **Remember**, you'll need an active postgres server to run this App. To check your postgres status, you can run:

```bash
  systemctl status postgresql
```

### Run tests

As was already pointed out, both the commands:

```bash
  rails spec
  rspec
```

Will run the test suite. You can check out the tests -and add more if you want- under the ./spec directory.

### Deployment

I decided to deploy the App on Heroku, but there's more options. If using Heroku, you'll need to follow the next steps.

First, [create a Heroku account](https://signup.heroku.com/login). Then follow [this](https://devcenter.heroku.com/articles/heroku-cli) instructions to download and set up the Heroku CLI -**C**ommand **L**ine **I**nterface. You'll have to setup some ssh credentials unless you want to type them every time you do any heroku command.

After installing the Heroku CLI, navigate to Parting's root folder and run:

```bash
  heroku create the-name-you-want-to-use
```

Heroku will create an app in their servers, and wait for you to push your code into it. Run:

```bash
  git push heroku current-published-branch:master
```

**Replacing** *'current-published-branch'* with the name of the main branch of the App. At the end of this Readme you'll find which branch it is.

Heroku will output their wholle process in your command prompt. This can take a while, specially the first time. In heroku your app will be built, compress and minified for production environment.

If this step goes right, Heroku will provide you, near the end of the output of the previus command, with the link to your deployed App. **There's still one step you need to take**

### AWS 

This app is configured to use an Amazon S3 bucket to store the uploaded icons. This configuration need to be done manually by you. To create and set up an Amazon S3 bucket, refer to [this](https://medium.com/alturasoluciones/setting-up-rails-5-active-storage-with-amazon-s3-3d158cf021ff) tutorial. Now you're ready to share your projects and tasks with the world, and manage collaborative work with others.


## Notes

### On the state of the project.
  Currently, the project is still under heavy developement. Many features are bound to change, and there's still many waiting to be implemented. Refer to the **Contributing** section for more information.


## Author

**Daniel Chincoya**

- Github: [@chincoya](https://github.com/chincoya)
- Twitter: [@chincoya7](https://twitter.com/chincoya7)
- Linkedin: [linkedin](https://linkedin.com/in/daniel-chincoya/)

## 🤝 Contributing

Contributions, issues and feature requests are welcome! But, know in advance, this is a work in progress. I plan to add many features myself in the coming months, and the code base will chnage a lot. Hit me up at Twitter if you want to contribute, or start developing and make a Pull Request. Many things a left to do, for example:

  - Constructing Private Teams for management, with team leaders that can request groups to be created and tasks to be performed. 
  - Task Validation, meaning more users can validate the tasks you submit.
  - Group Privacy. 
  - Group Channels to leave messages.
  - Team Channels to ...
  - And much more

Feel free to check the [issues page](issues/). Anything there is free reign.

## Show your support

Give a ⭐️ if you like this project!
Or, even better, make a feature request!

## Acknowledgments

 -  Front End design verbatim-ed from [Gregoire Vella](https://www.behance.net/gregoirevella) and can be checked [here](https://www.behance.net/gallery/19759151/Snapscan-iOs-design-and-branding?tracking_source=).
 -  Initially an idea for a Project for [Microverse](https://www.microverse.org/)

Additional Icons fetched from [flaticon.com](https://www.flaticon.com/), authored by:
  - Pixel Perfect
  - Freelk
  - Ddara

## License

This project is [MIT](lic.url) licensed.

### CURRENT WORKING BRANCH:

## app-features
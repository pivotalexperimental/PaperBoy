PaperBoy
========

## Testing

### Frank

Frank depends on the ability to hit the Paperboy-web project. To setup the application and the database follow the instructions for Paperboy-web (https://github.com/pivotal/paperboy-web), then load the database in a known good state:

    rake db:load_known_good

Then to start the server run

    rails s

The server will be available on http://localhost:3000

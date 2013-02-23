Comedie-Francaise Registers Project

## Creating User Accounts On The Command-line

On live production:

    $ RAILS_ENV=production bundle exec rails c

Create new user, and save--and you're done:

    $ @l = User.new(email: 'someone@somedomain.com', shortname: 'someone', first_name: 'Some', last_name: 'One', password: 'password')
    $ @l.save

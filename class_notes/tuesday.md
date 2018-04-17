Create the database (once per project)
    $ rails db:create


Generate the model (once per project)
    $ rails generate model book      title:string author:string

Run migrations
    $ rails db:migrate

Realize we need another column
Create another migration
    $ rails generate migration add_description_to_books

Edit the migration, add the 'add_column' method call

migrate again
    $ rails db:migrate


How to get someone else's Rails project up and running
    $ git clone <html URL>
    $ cd <folder>
    $ bundle install      # install gems
    $ rails db:create     # create the DB
    $ rails db:migrate    # run all migrations
    $ rails server      # start the server


How to delete your controller
    $ rails delete controller task
    $ rails generate controller task

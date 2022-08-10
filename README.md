# Deviser Club : A Multi Blogging Platform with Ruby On Rails

[Deviser Club](http://deviser.club/) is developed with the heart of publishers
freedom and author's authority, with better audience experience. No overly complexified stuff here, simple is better than complex. 

Ruby on `Rails 7` is used to develop this blogging platform. It is still
on development mode, any one who is willing to contribute is welcomed.

## Installation
You can install **Deviser Club** in two main ways; Straight Forward 
Installation and Docker Installation.
I am still figuring out the docker part. So, I will make a straight
forward installation guide for now.

### Straight Forward Installation
To install Deviser Club, you need to have `Ruby 2.7` installed. `Ruby 2.7` is the default version of Ruby.

```bash
sudo apt-get install ruby
```

Now you have to install  a dependency for OG Image generation Deviser Club.

```bash
sudo apt install ruby-rmagick
```

Now you call install `Rails 7.0.3` and other essential gems by using `bundle install`

```bash
$ bundle install
```

#### Development Essentials
To start the development, you need to create a `development` database.

```bash
rails db:create
```

Then, you need to migrate the database.

```bash
rails db:migrate
```

For mailing in development, our Deviser Club uses `mailcatcher`, which
will automatically get 
install while doing `bundle install`

Start the server
    
```bash
./bin/dev
```

#### Production Essentials and Deployment
For production, you need to create a `production` database, manage some paths 
and you're good to go.

##### Git Clone
Go to `cd ~/` and then `git clone https://github.com/Bishwas-py/deviser-club.git`,
and then cd inside the folder.
```bash
cd ~/deviser-club
```

##### Database
Create a postgresql (or any well functioning database you want) user and database

```bash
sudo -u postgres psql postgres
create database deviser_club_database_name;
create user deviser_club_database_username with encrypted password 'deviser_club_database_password';
grant all privileges on database deviser_club_database_name to deviser_club_database_username;
```

Now, copy the `database.yml.sample` to `database.yml`

```bash
cp config/database.yml.sample config/database.yml
```

And then, inside your `database.yml` edit the given credentials 
for the database. You have to replace
database name, username and password with `deviser_club_database_name`,
`deviser_club_database_username` and `deviser_club_database_password`
respectively.

```bash
default: &default
  adapter: sqlite3
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
  timeout: 5000
...
production:
  adapter: postgresql
  encoding: unicode
  host: localhost
  pool: 5
  database: deviser_club_database_name
  username: deviser_club_database_username
  password: deviser_club_database_password
```


##### Run migration
Now, you need to migrate the database explicitly for production.

```bash
RAILS_ENV=production bundle exec rails db:migrate
```
##### Email Setup
Edit your `~/.bash_profile` for setting environment variable for email.

For that, type following commands
```shell
nano ~/.bash_profile
# probably you might need sudo authority
```
Now, add the following data below of the file according to your choice.
```bash
export FROM_EMAIL='Platform Name <no-reply@platform.club>' 
# replace `platform` with your platform name
export HOST_NAME='platform.club'
export SMTP_ADDRESS='host.ip.address'
export DOMAIN='platform.club'
export SMTP_USERNAME='smtp_username'
export SMTP_PASSWORD='smtp_password'
```

##### Check server
Allow port `3000` by `ufw` or equivalent, and
go to `http://SERVER.PUBLIC.IP.ADDRESS:3000`, and it'll show your webapp,
which is the sign of good installation.
```shell
RAILS_ENV=production bundle exec rails s -p 3000
```
##### Deployment
To deploy your app, you need to install `capistrano` and `capistrano-rails` must of the
time. If you want that you can do that too but for me, I like doing things manually.

###### Make `assets`
```shell
RAILS_ENV=production bundle exec rails assets:precompile
```

###### Setup Nginx
Make a file in `/etc/nginx/sites-enabled` called `deviser-club`.

```bash
server {
  listen 80;
  listen [::]:80;
 
  server_name example.com; # your site domain like: deviser.club
  root /home/server_user/deviser-club/public;

  passenger_enabled on;
  passenger_app_env production;

  location /cable {
    passenger_app_group_name deviser-club_websocket;
    passenger_force_max_concurrent_requests_per_process 0;
  }

  # Allow uploads up to 100MB in size
  client_max_body_size 100m;

  location ~ ^/(assets|packs) {
    expires max;
    gzip_static on;
  }
}
```
Now, restart nginx.
```shell
sudo service nginx restart
```

Check, nginx status.
```shell
sudo service nginx status

● nginx.service - A high performance web server and a reverse proxy server
     Loaded: loaded (/lib/systemd/system/nginx.service; enabled; vendor preset: en>
     Active: active (running) since Sun 2022-08-07 19:09:01 UTC; 7h ago
```

### Hooray! You have successfully installed Deviser Club
Congratulations! You have successfully installed Deviser Club. Now, you can go to your
domain url and start serving the world through Deviser Club.


## Preview
Here are some screenshots of deviser club
![home](https://user-images.githubusercontent.com/42182303/183409826-bbed839c-93f7-4db6-8c96-f245683bfad0.png)
![bookmarks](https://user-images.githubusercontent.com/42182303/183409854-5001ebdb-fc32-4979-98df-0614ecb9d429.png)
![post page](https://user-images.githubusercontent.com/42182303/183409868-15624423-d255-4a43-b8e8-eaefbdbaab4f.png)
![comments in posts](https://user-images.githubusercontent.com/42182303/183409883-f07c18fd-e8d6-435c-a6c0-414e4b2f789e.png)
![quick tweets](https://user-images.githubusercontent.com/42182303/183409916-f15c4c61-543c-4255-a20b-be651dbd556d.png)
![comment in quick tweets](https://user-images.githubusercontent.com/42182303/183409928-d2e61f03-d0e2-47db-bc78-18753b815463.png)
![writing a post](https://user-images.githubusercontent.com/42182303/183409938-9f3e6992-4acf-4198-bf23-da9c8f57dfc4.png)


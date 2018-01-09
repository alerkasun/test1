#Requirements
 - PostgreSQL
 - Redis
 - imagemagick
 - nginx
 - git
 - nodejs

# Set up environment

## On server:

First of all install soft from requirements above.

Create user to deploy application `sudo adduser prayer_deployer --disabled-password` with empty password.

Checkout that user `sudo su prayer_deployer` and install rmv.

- Install ruby  `rvm install ruby-2.3.0`
- create gemset  `rvm gemset create prayer-app`
- checkout to installed environment `rvm use ruby-2.3.0` and `rvm gemset use prayer-app`
- install bundler `gem install bundler`

Create file `~/.rvmrc` with content:
```
rvm_trust_rvmrcs_flag=1
```

Create rvm alias, be sure that alias name is the same as mentioned in Procfile:
```sh
rvm alias create prayer-app ruby-2.3.0@prayer-app
```

Allow prayer_deployer user some sudo commands : `sudo visudo`
```
prayer_deployer ALL=NOPASSWD: /usr/sbin/service, /bin/ln, /bin/rm, /bin/mv, /sbin/start, /sbin/stop, /sbin/restart, /sbin/status
```

### Postgres preparation:
Switch to user postgres `sudo su postgres` and create database user `createuser -P -s -e ror_tpl`
Next step is to allow user connect with password, so open `pb_hba.conf`. To get location login `psql` and execute `SHOW hba_file;`

```
sudo vim /etc/postgresql/9.3/main/pg_hba.conf
```

and change:

```
local   all     all    peer
```
to:

```
local   all     all    md5
```
and restar postgres:

```
sudo /etc/init.d/postgresql restart
```

Create authorized key on server for access to gitlab repository at a deployer user home directory:
```
mkdir ~/.ssh
chmod 700 ~/.ssh
ssh-keygen -t rsa
```
Add generated id_rsa.pub to bitbucket account.

Add your local id_rsa.pub to `authorized_keys` for prayer_deployer user on server:
```
touch ~/.ssh/authorized_keys
echo "your_publick_key_here" >> ~/.ssh/authorized_keys
```

## Local
With first deploy we need to configure application `.env` and nginx, setup database, generate upstart scripts

```
cap dev deploy:setup
```

Enjoy!

Requirements
===========

## memcached

```
brew install memcached
```

```
memcached -d
```

## Redis


```
brew install redis
```

```
redis-server

# Ctrl + C to stop
```

## PostgreSql

### Installation

```
brew install postgresql
brew unlink postgresql
brew link postgresql
ARCHFLAGS="-arch x86_64" gem install pg
```

- goto https://postgresapp.com/ download and start it.

### Set root password

```
psql
```

- replace your_name & your_password

```
CREATE USER your_name WITH PASSWORD 'your_password';
CREATE DATABASE "your_name";
GRANT ALL PRIVILEGES ON DATABASE "your_name" to "your_name";
ALTER USER "your_name" WITH SUPERUSER;
```

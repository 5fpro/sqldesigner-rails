Requirements
==========

See [Requirements](REQUIREMENTS.md) to install required programs in your MAC.

## Git clone

```
git clone git@github.com:5fpro/rails-template.git
cd norn
git submodule add -f git@github.com:5fpro/tyr.git
git clone git@github.com:5fpro/rails-template.git -b gh-pages --single-branch api-doc
```

Build
==========


```
bundle install
```

```
cp .env.example .env
cp config/application.yml.example config/application.yml
```

```
bundle exec rake dev:build
```

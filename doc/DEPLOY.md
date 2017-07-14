Stages
==========

- `config/deploy/{stage}.rb`
- Currently we have production and staging.

Download / Upload Config files
==========

File list configured in `CAP_CONFIG_FILES` of `lib/capistrano/tasks/config.rake`.

- Donwload from server.

```
cap {stage} config:download
```

- YAML files' naming would be `xxxxx.{stage}.yml`. For example, `config/application.production.yml`.
- Other files' naming would be `xxxx.oo.{stage}`. For example, `.env.staging`.

Note: DO NOT commit server config files to git repo. Makesure `.gitignore` to skip these files.

- Upload to servers.

```
cap {stage} config:upload
```

- Before modify, you should run download command.


Deploy
=============

```
cap {stage} deploy
```

## First deploy

For running db:create on server, uncomment codes in `lib/capistrano/tasks/first.rake` (don't commit it), then run `cap {stage} deploy`.

After deploy success, you can re-comment again codes in `lib/capistrano/tasks/first.rake`.


Sidekiq
=============

```
cap {stage} sidekiq:stop
cap {stage} sidekiq:start
cap {stage} sidekiq:restart
```

Unicorn
=============

```
cap {stage} unicorn:stop
cap {stage} unicorn:start
cap {stage} unicorn:restart
```

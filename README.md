# Project 17 — Server Configuration Management with Puppet

A small Puppet configuration-management lab that provisions a deploy user and an Nginx web server declaratively.

## What it demonstrates

- Puppet classes and modules
- Package management
- File and directory management
- Managed configuration templates
- Service enablement and state management
- Resource dependencies and notifications
- Idempotent configuration
- Local `puppet apply` workflow
- Syntax validation and puppet-lint in GitHub Actions

## Structure

```text
.
├── manifests/
│   └── site.pp
├── modules/
│   ├── users/
│   │   ├── manifests/init.pp
│   │   └── metadata.json
│   └── webserver/
│       ├── files/index.html
│       ├── manifests/init.pp
│       ├── metadata.json
│       └── templates/nginx.conf.erb
├── tests/
│   ├── apply_local.sh
│   ├── check_nginx.sh
│   └── validate_structure.sh
├── .github/workflows/puppet.yml
├── .puppet-lint.rc
├── .gitignore
└── LICENSE
```

## Apply locally

> Run this on a disposable Debian/Ubuntu VM or test host. It installs Nginx and creates the `deploy` user.

```bash
chmod +x tests/apply_local.sh tests/check_nginx.sh
tests/apply_local.sh
tests/check_nginx.sh
```

## What Puppet manages

The `webserver` module installs Nginx, creates `/var/www/myapp`, deploys the managed HTML page and Nginx virtual-host configuration, enables the site, and ensures Nginx is running.

The `users` module manages a local `deploy` account with a home directory and Bash shell.

## Validation

GitHub Actions runs:

```bash
puppet parser validate manifests/site.pp modules/*/manifests/*.pp
puppet-lint --config .puppet-lint.rc modules
bash tests/validate_structure.sh
```

The local structural test does not require Puppet to be installed. A real Puppet apply should be performed on a disposable VM when validating the full runtime behavior.

## Safety

Do not run `tests/apply_local.sh` on a production server without reviewing the manifest first. Puppet will make the declared configuration changes to the target machine.

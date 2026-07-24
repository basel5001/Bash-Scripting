![Lint](https://github.com/basel5001/Bash-Scripting/actions/workflows/lint.yml/badge.svg)
![ShellCheck](https://github.com/basel5001/Bash-Scripting/actions/workflows/shellcheck.yml/badge.svg)

# Bash Scripting

Interactive bash script for managing Linux users and groups.

## Features

- Add/delete/disable/enable user accounts
- Get user details
- Add/delete/modify groups
- Add/remove users from groups

## Usage

```bash
chmod +x project
sudo ./project
```

> Requires root privileges for user/group management operations.

## Script Index

See [SCRIPTS.md](SCRIPTS.md) for a full index of all scripts with descriptions.

To regenerate the index:

```bash
./scripts/generate-index.sh
```

## CI/CD

- **ShellCheck** — All `.sh` files are linted on push/PR via [ShellCheck](https://www.shellcheck.net/)

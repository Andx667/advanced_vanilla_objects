# Contributing

## Setting up the development environment

1. Clone the repository from GitHub.
2. Install [HEMTT](https://hemtt.dev/):

    ```cmd
    winget install hemtt
    ```

3. Build the mod with `hemtt build`, or validate it without building via `hemtt check`.
4. `hemtt launch` starts Arma 3 with the mod and the test mission `.hemtt/missions/test.VR`, `hemtt launch acre` and `hemtt launch bwa3` also load ACRE2 or BWA3.

## Coding guidelines

This mod follows the same [coding guidelines as the ACE3 mod](https://ace3.acemod.org/wiki/development/coding-guidelines) — naming conventions, function headers, bracket/spacing style, and the general avoidance of scheduled space (`spawn`/`execVM`) and magic numbers.

## Validating changes

Before opening a PR, run:

```cmd
hemtt check
python tools/stringtable_validator.py
python tools/config_style_checker.py
```

These mirror the checks run in CI (`.github/workflows/check.yml` and `validate.yml`).

## Documentation

The documentation is built with [MkDocs Material](https://squidfunk.github.io/mkdocs-material/) from the `docs` folder:

```cmd
pip install -r docs/requirements.txt
mkdocs serve
```

Add a new object with its classnames to the page of its addon in `docs/objects/`, and a new event to [Scripting & API](scripting.md#events).

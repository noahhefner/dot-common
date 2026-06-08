# Templater

Utility to substitute values from a `.env` file into any configuration file using [Jinja2 templates](https://jinja.palletsprojects.com/en/stable/templates/).

## Usage

```
usage: templater.py [-h] -t TEMPLATE -e ENV_FILE -o OUTPUT

Render a Jinja2 template using variables from a .env file.

options:
  -h, --help            show this help message and exit
  -t, --template TEMPLATE
                        Path to the Jinja2 template file.
  -e, --env-file ENV_FILE
                        Path to the .env file containing variable definitions.
  -o, --output OUTPUT   Path to the output file where rendered content will be written.
```
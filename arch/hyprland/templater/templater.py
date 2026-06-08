from __future__ import annotations

import argparse
from pathlib import Path
from typing import Any, Dict

from dotenv import dotenv_values
from jinja2 import Environment, FileSystemLoader, Template


def load_env_vars(env_path: Path) -> Dict[str, str | None]:
    """
    Load key-value pairs from a .env file.

    Args:
        env_path (Path): The path to the .env file containing variable definitions.

    Returns:
        Dict[str, str| None]: Dictionary mapping environment variable names to their values.
    """
    return dotenv_values(str(env_path))


def render_template(template_path: Path, context: Dict[str, Any]) -> str:
    """
    Render a Jinja2 template with the given context.

    Args:
        template_path (Path): The file path of the Jinja2 template to render.
        context (Dict[str, Any]): A dictionary of variables to substitute into the template.

    Returns:
        str: The rendered template as a string.
    """
    env = Environment(
        loader=FileSystemLoader(template_path.parent),
        autoescape=False,
    )
    template: Template = env.get_template(template_path.name)
    return template.render(**context)


def main() -> None:
    """
    Parse command-line arguments, load variables from a .env file,
    render a Jinja2 template using those variables, and write the output to a file.

    Args:
        None

    Returns:
        None
    """
    parser = argparse.ArgumentParser(
        description="Render a Jinja2 template using variables from a .env file."
    )
    parser.add_argument(
        "-t",
        "--template",
        required=True,
        type=Path,
        help="Path to the Jinja2 template file.",
    )
    parser.add_argument(
        "-e",
        "--env-file",
        required=True,
        type=Path,
        help="Path to the .env file containing variable definitions.",
    )
    parser.add_argument(
        "-o",
        "--output",
        required=True,
        type=Path,
        help="Path to the output file where rendered content will be written.",
    )

    args = parser.parse_args()

    # Load environment variables and render
    context = load_env_vars(args.env_file)
    rendered = render_template(args.template, context)

    # Write output
    args.output.write_text(rendered)
    print(f"Rendered template saved to: {args.output}")


if __name__ == "__main__":
    main()

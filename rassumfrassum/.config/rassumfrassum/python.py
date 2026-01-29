import pathlib


THIS_DIR = pathlib.Path(__file__).parent


def servers():
    return [
        ["ty", "server"],
        ["ruff", "--config", (THIS_DIR / "default-ruff.toml").as_posix(), "server"],
        ["codebook-lsp", "serve"],
    ]

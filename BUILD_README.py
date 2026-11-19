#!/usr/bin/env -S uv run --script
# /// script
# requires-python = ">=3.14"
# ///
"""Generate README.md for the jftuga homebrew tap.

Scans formula files in the repository root and cask files in Casks/, extracts each
package's description, homepage, and version, and renders them as a markdown table
sorted by name. The "last updated" column is the date of the last git commit that
touched each package file. Output goes to stdout unless --write is given.
"""

import argparse
import re
import subprocess
from dataclasses import dataclass
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parent
CASKS_DIR = REPO_ROOT / "Casks"
OUTPUT_FILE = REPO_ROOT / "README.md"
UNCOMMITTED = "uncommitted"

MARKDOWN_HEADER = """# homebrew-tap
Homebrew tap for jftuga command-line tools

## Install
```shell
brew install jftuga/tap/<name>
```

Where `<name>` is from the table below. This works for both formulae and casks, and taps the repository automatically.

To upgrade later: `brew upgrade <name>`

## Programs
"""

TABLE_HEADER = "| name | version | last updated | description |\n|---|---|---|---|"

# Matches the release tag segment of a GitHub release download URL, e.g.
# ".../releases/download/v0.2.1/..." -> "0.2.1". An optional leading "v" is dropped;
# the capture group takes everything up to the next "/".
URL_VERSION_RE = re.compile(r"/releases/download/v?([^/]+)/")


@dataclass(frozen=True)
class Package:
    """Metadata for one formula or cask shown in the README table.

    Attributes:
        name: Install name, taken from the .rb filename stem.
        version: Package version string.
        last_updated: Date (YYYY-MM-DD) of the last commit touching the file.
        description: Short description from the desc stanza.
        homepage: Project homepage URL.
        is_cask: True if the package is a cask rather than a formula.
    """

    name: str
    version: str
    last_updated: str
    description: str
    homepage: str
    is_cask: bool


def quoted_value(line: str) -> str:
    """Return the text between the first and last double quote on a line.

    Args:
        line: A stanza line such as `desc "some text"`.

    Returns:
        The quoted text, or an empty string if the line has no quoted value.
    """
    start = line.find('"')
    end = line.rfind('"')
    if start == -1 or end <= start:
        return ""
    return line[start + 1 : end]


def parse_stanzas(text: str) -> dict[str, str]:
    """Extract the first desc, homepage, version, and url stanza values from a .rb file.

    Args:
        text: Full contents of a formula or cask file.

    Returns:
        A mapping of stanza name to its quoted value for each stanza found.
    """
    wanted = ("desc", "homepage", "version", "url")
    found: dict[str, str] = {}
    for raw_line in text.splitlines():
        line = raw_line.strip()
        for key in wanted:
            if key not in found and line.startswith(f'{key} "'):
                found[key] = quoted_value(line)
    return found


def version_from_url(url: str) -> str:
    """Derive a version from a GitHub release download URL.

    Args:
        url: A release asset URL.

    Returns:
        The version string, or an empty string if the URL has no release tag.
    """
    match = URL_VERSION_RE.search(url)
    return match.group(1) if match else ""


def last_commit_date(path: Path) -> str:
    """Return the date of the last git commit that touched a file.

    Args:
        path: File to look up.

    Returns:
        The committer date as YYYY-MM-DD, or UNCOMMITTED if the file has no commits.

    Raises:
        RuntimeError: If the git command fails.
    """
    result = subprocess.run(["git", "log", "-1", "--format=%cs", "--", str(path)], cwd=REPO_ROOT, capture_output=True, text=True)
    if result.returncode != 0:
        raise RuntimeError(f"git log failed for {path}: {result.stderr.strip()}")
    return result.stdout.strip() or UNCOMMITTED


def load_package(path: Path, is_cask: bool) -> Package:
    """Build a Package from a formula or cask file.

    Args:
        path: Path to the .rb file.
        is_cask: True if the file is a cask.

    Returns:
        The parsed Package.

    Raises:
        ValueError: If desc, homepage, or a version cannot be determined.
    """
    stanzas = parse_stanzas(path.read_text(encoding="utf-8"))
    version = stanzas.get("version") or version_from_url(stanzas.get("url", ""))
    missing = [key for key, value in (("desc", stanzas.get("desc")), ("homepage", stanzas.get("homepage")), ("version", version)) if not value]
    if missing:
        raise ValueError(f"{path.relative_to(REPO_ROOT)}: missing {', '.join(missing)}")
    return Package(name=path.stem, version=version, last_updated=last_commit_date(path), description=stanzas["desc"].strip(), homepage=stanzas["homepage"], is_cask=is_cask)


def collect_packages() -> list[Package]:
    """Load all formulae and casks in the tap, sorted by name.

    Returns:
        Packages sorted case-insensitively by name.
    """
    formulae = [load_package(path, is_cask=False) for path in REPO_ROOT.glob("*.rb")]
    casks = [load_package(path, is_cask=True) for path in CASKS_DIR.glob("*.rb")]
    return sorted(formulae + casks, key=lambda pkg: pkg.name.lower())


def escape_cell(text: str) -> str:
    """Escape characters that would break a markdown table cell.

    Args:
        text: Raw cell text.

    Returns:
        The text with pipe characters escaped.
    """
    return text.replace("|", r"\|")


def table_row(pkg: Package) -> str:
    """Render one package as a markdown table row.

    Args:
        pkg: The package to render.

    Returns:
        A markdown table row string.
    """
    suffix = " (cask)" if pkg.is_cask else ""
    name = f"[{pkg.name}]({pkg.homepage}){suffix}"
    cells = (name, pkg.version, pkg.last_updated, escape_cell(pkg.description))
    return "| " + " | ".join(cells) + " |"


def render_readme(packages: list[Package]) -> str:
    """Render the full README markdown.

    Args:
        packages: Packages to include, already sorted.

    Returns:
        The README contents.
    """
    rows = "\n".join(table_row(pkg) for pkg in packages)
    return f"{MARKDOWN_HEADER}\n{TABLE_HEADER}\n{rows}\n"


def parse_args() -> argparse.Namespace:
    """Parse command line arguments.

    Returns:
        The parsed arguments.
    """
    parser = argparse.ArgumentParser(description="Generate README.md for the jftuga homebrew tap.")
    parser.add_argument("-w", "--write", action="store_true", help=f"write output to {OUTPUT_FILE.name} instead of stdout")
    return parser.parse_args()


def main() -> None:
    """Generate the README and print it or write it to disk."""
    args = parse_args()
    readme = render_readme(collect_packages())
    if args.write:
        OUTPUT_FILE.write_text(readme, encoding="utf-8")
        print(f"Wrote {OUTPUT_FILE.name}")
    else:
        print(readme, end="")


if __name__ == "__main__":
    main()

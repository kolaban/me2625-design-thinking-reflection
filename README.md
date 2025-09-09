# Rmarkdown Template

This is a template repository structure to help setup a repo to write a document using Rmarkdown. The project uses Pixi for dependency management and task running, replacing any conda/mamba workflow.

## Structure

The basic template directory structure is the following:

```
.
├── .gitignore
├── Justfile # Contains build scripts
├── README.md
├── build # Where compiled files will be found (created on first build)
├── pixi.toml # Pixi environment + tasks
├── pixi.lock # Pixi lockfile
├── lua-filters # Contains lua scripts to help make nice docs
├── support-docs # Any supporting documents e.g. templates for word compilation
│   └── doc_base.docx # Basic docx file for templating of .docx output
└── content.Rmd # Rmarkdown source file
```

### Justfile

The `Justfile` provides convenient commands. Once `just` is installed you can compile the Rmarkdown file by running:

```
$ just # This will build the files and put them in ./build/
```

Under the hood this invokes `pixi run render` defined in `pixi.toml`.

More information on just can be found at https://github.com/casey/just.

### Lua Filters

These filters come from the Lua-filters [github repository](https://github.com/pandoc/lua-filters) that is currently decommissioned. They are copied here due to some issues with the scholar filters on the current version of pandoc. They may be removed in the future.

### Rmarkdown source file

By default `content.Rmd` compiles to `.pdf` and `.docx`. This can be expanded to other formats (e.g., `.html`) if needed.

Some aspects have been commented out but are likely to be needed, these include:

- `authors`
  - Shows authors of the document
- `insitute`
  - Shows any affiliations of the authors
- `header-includes` (these work for pdf not for word docs)
  - `\usepackage{setspace}`
    - Imports the setspace package
  - `\doublespacing`
    - Causes pdfs to use double space
  - `\usepackage[left]{lineno}`
    - Imports the lineno package and tell its to
  - `\linenumbers`
    - Add linenumbers to the pdf
- `bibliography`
  - Location where bibliography file is stored
- `csl`
  - Citation style to utilize
- `output`
  - What file types should be compiled to and any associated configurations for those file types e.g. a template file for `.docx` compilation or latex_engine for `.pdf` documents

## Required Packages

The two core programs that are needed are LaTeX and Pandoc. These are expected to be installed on your system (global), and are not included in the Pixi environment.

Important: the current setup expects Pandoc < 3.0.0 (as noted in `Justfile`). Ensure your Pandoc version matches this requirement.

## Using Pixi (dependency management)

Pixi manages the R dependencies and provides a reproducible environment and task runner.

1) Install Pixi (see https://pixi.sh)

2) Build with Pixi

- Quick build: `just`
- Or directly: `pixi run render`
- With custom args: `pixi run render --input ./content.Rmd --output ./build/`

3) Interactive shell (optional)

- Enter the environment: `pixi shell`
- Then run R or helper commands inside the environment.



### Non-Pixi packages

In addition to the packages specified in `pixi.toml`, you may want to install the following manually to provide optional functionality.

Note that downloading some of these means that environment management becomes a bit harder.

#### `wordcountaddin`

An R add-in that, at the time of writing, is not provided by conda channels. Install it inside the Pixi environment:

```Bash
# Open the Pixi environment and install from GitHub using remotes
pixi run Rscript -e "remotes::install_github('benmarwick/wordcountaddin')"
```

This can take a bit of time and may update some of the R-related packages already present.

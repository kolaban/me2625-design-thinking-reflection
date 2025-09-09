# Rmarkdown Template

This is a template repository structure to help setup a repo to write a document using Rmarkdown. This template is loaded with everything so in many cases you will want to remove aspects that you don't want.

## Structure

The basic template directory structure is the following:

```
.
├── .gitignore
├── Justfile # Contains build scripts
├── README.md
├── build # Where compiled files will be found
├── environment.yml # Conda environment for Rmarkdown
├── lua-filters # Contains lua scripts to help make nice docs
├── revisions # Location for compiled file revisions
├── support-docs # Any supporting documents e.g. templates for word compilation
│   └── idp_doc_base.docx # Basic docx file for templating of .docx output
└── template_file.Rmd # Rmarkdown template file
```

### Justfile

The `justfile` functions as an easy way to hold scripts that you will be running a lot. Once installed you can compile the rmarkdown file by running:

```
$ just # This will build the files and put them in ./build/
```

More information on just can be found [here](https://github.com/casey/just).

### Lua Filters

These filters come from the Lua-filters [github repository](https://github.com/pandoc/lua-filters) that is currently decommissioned. They are copied here due to some issues with the scholar filters on the current version of pandoc. They may be removed in the future.

### Rmarkdown template file

By default `template_file.Rmd` will only compile to `.pdf` and `.docx` however this can be expanded if to other formats e.g. `.html` if the need arises.

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

The two core programs that are needed are latex and Pandoc, these are expected to be downloaded globally so they are not included in the environment.yml file.

The `environment.yml` file contains a list of packages required in order to build the document, you can create the associated environment directly from it by using the following command:

```Bash
mamba env create -f environment.yaml
```

If you do not specify a environment name the environment will be called `rmarkdown-template-env`.

### Non-Conda packages

In addition to the packages in environment.yml you may want to download the following packages manually in order to provide some of the functions displayed in the template.

Note that downloading some of these means that environment management becomes a bit harder.

#### `wordcountaddin`

An R program that, at the time of writing, requires a manual download since it is not available via Conda repositories. To do this you will run the following two commands:

```Bash
# Note that this uses the latest version of the wordcountaddin package
# based on the contents of the github
Rscript -e "remotes::install_github('benmarwick/wordcountaddin')"
```

This can take a bit of time and may update some of the R related packages already present.

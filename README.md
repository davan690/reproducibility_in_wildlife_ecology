# reproducibility_in_wildlife_ecology

Results from a review of the reproducibility of wildlife ecology studies from the following repository `aaarchmiller/reproducibility_in_wildlife_ecology`. 

I have added my notes and some additional ideas for collaboration for part of the first chapter of my PhD thesis. [only bad ideas currently]. Here is a short list of the modifications I have made so far:

1. Turned the repository into a gitbook [doing]
2. Sort and add comments into text for the analysis and results already done [coming]
3. Add my ideas, introduction and notes [coming]



## Repo structure

This is the readme but I am unsure how this works with `gitbook` rendering and automatically building websites from the `README.md` file.

```sh
.
├── _bookdown.yml
├── data
|   └── members.yml
├── _output.yml
├── html
└── index.Rmd
```

## Tools

I have build this manuscript using a combination of computational methods in Ecology. In short I have compiled this book using `bookdown`. Here is the minimal example of a book based on R Markdown and **bookdown** (https://github.com/rstudio/bookdown). 

### Template structure

For this template I have divided the "chapters" into key sections needed to build and troubleshoot bookdown for graduate research projects.

You can reference chapters like so:

##### Contents \@ref(contents): page here 

##### Short summary *coming*

##### Chapter \@ref(status): An overview of the project files.

##### Chapter \@ref(intro): Manuscript introduction.

##### Chapter \@ref(method): Manuscript methods using Bayesian Models.

##### Chapter \@ref(results): Publication results for `wildlife research` journal.

##### Chapter \@ref(discussion): Results in context of pest management in NZ.

##### References \@ref(refs): All references for this work.

The aim of this bookdown is to provide a working archive of code for the `bookdown` package use with the statistics network.

## Additional notes

Check out the website for more resources and my working notes [here](https://www.ssnhub.com).
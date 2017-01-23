# Convert HTML+RDFa to Turtle

This repository contains a simple pipeline
that extracts HTML+RDFa data from webpages
and combines them into a single Turtle file from it.
Semantic gaps are filled by reasoning.

As a result, your website's data can be queried with SPARQL
at 100% completeness
and without worrying about vocabularies.

The article [“Piecing the puzzle – Self-publishing queryable research data on the Web”](https://ruben.verborgh.org/articles/queryable-research-data/)
explains in detail what the pipeline does and how it works.

## Requirements
- [RDFLib](https://github.com/RDFLib/rdflib)
- [Serd](https://github.com/drobilla/serd)
- [EYE](https://github.com/josd/eye) (with [CTurtle](https://github.com/melgi/cturtle/))

## Running the pipeline
```bash
$ ./extract-website-data https://example.org/ /var/www/example.org/
```
where `https://example.org/` is the URL of your homepage and `/var/www/example.org/` the location of its HTML files.

## Customizing the pipeline
Place the ontologies you want to reason on in the `ontologies` folder.

Rules for common RDFS and OWL constructs are available [at the EYE website](http://eulersharp.sourceforge.net/#theories).

## License
©2017 [Ruben Verborgh](http://ruben.verborgh.org/) – [MIT License](https://github.com/RubenVerborgh/WebsiteToRDF/blob/master/LICENCE.md).

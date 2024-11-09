# Makefile

.PHONY: help clean html latexpdf

help:
	@echo "Available commands:"
	@echo "  make html       Build the HTML documentation"
	@echo "  make latexpdf   Build the LaTeX and PDF documentation"
	@echo "  make clean      Clean build directories"

html:
	sphinx-build -b html docs/source docs/build/html

latexpdf:
	sphinx-build -b latex docs/source docs/build/latex
	cd docs/build/latex && latexmk -xelatex -quiet -interaction=nonstopmode -f *.tex || true

clean:
	rm -rf docs/build/*


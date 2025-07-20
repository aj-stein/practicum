LATEXMK := latexmk
RM := rm -
CSL_STYLE := vendor/csl/apa-6th-edition.csl
FEDRAMP_DATA := vendor/fedramp_marketplace_data/data.json

$(CSL_STYLE):
	git submodule update --init --recursive

$(FEDRAMP_DATA):
	git submodule update --init --recursive

%.pdf: %.md
	pandoc $< -o $@ \
		--bibliography references.bib --citeproc \
		--csl $(CSL_STYLE)

%.pdf: %.tex
	$(LATEXMK) -pdf -M -MP -MF $*.d $*

%.pdf: %.md $(MARP_EXE)
	$(NPX) $(MARP_PKG) $(MARP_ARGS) $< -o $@ --pdf-outlines

mostlyclean:
	$(LATEXMK) -silent -c
	$(RM) *.bbl
	$(RM) *.pdf

clean: mostlyclean
	$(LATEXMK) -silent -C
	$(RM) *.run.xml *.synctex.gz
	$(RM) *.d

# Include auto-generated dependencies
-include *.d


all: $(CSL_STYLE) $(FEDRAMP_DATA) clean notes.pdf paper.pdf

clean:
	$(RM) *.pdf

.PHONY: all clean doc mostlyclean pdf

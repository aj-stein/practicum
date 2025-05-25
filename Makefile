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

all: $(CSL_STYLE) $(FEDRAMP_DATA) clean notes.pdf

clean:
	$(RM) *.pdf

.PHONY: all clean

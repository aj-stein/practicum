CSL_STYLE := vendor/csl/apa-6th-edition.csl

$(CSL_STYLE):
	git submodule update --init --recursive

%.pdf: %.md
	pandoc $< -o $@ \
		--bibliography references.bib --citeproc \
		--csl $(CSL_STYLE)

all: $(CSL_STYLE) clean notes.pdf

clean:
	$(RM) *.pdf

.PHONY: all clean

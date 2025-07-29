MAIN = main
NAME = chdthesis
CLSFILES = $(NAME).cls
BSTFILES = $(NAME)-numerical.bst $(NAME)-authoryear.bst

SHELL = bash
LATEXMK = latexmk -xelatex
VERSION = $(shell cat $(NAME).dtx | egrep -o "\[\d\d\d\d/\d\d\/\d\d v.+\]" \
	  | egrep -o "v\S+")
TEXMF = $(shell kpsewhich --var-value TEXMFHOME)

.PHONY : main cls doc test save clean all install distclean zip FORCE_MAKE

main : $(MAIN).pdf

all : main doc

cls : $(CLSFILES) $(BSTFILES)

doc : $(NAME).pdf

$(MAIN).pdf : $(MAIN).tex $(CLSFILES) $(BSTFILES) FORCE_MAKE
	$(LATEXMK) $<

$(NAME).cls : $(NAME).dtx
	xetex $<

$(NAME).pdf : $(NAME).dtx FORCE_MAKE
	$(LATEXMK) $<

test:
	texlua test/build.lua check --quiet
	texlua test/build-toc.lua check --quiet
	texlua test/build-bib.lua check --quiet
	texlua test/build-nomencl.lua check --quiet

save:
	texlua test/build.lua save --quiet titlepage
	texlua test/build.lua save --quiet titlepage-master
	texlua test/build.lua save --quiet titlepage-secret
	texlua test/build.lua save --quiet titlepage-bachelor
	texlua test/build.lua save --quiet statement
	texlua test/build.lua save --quiet statement-secret
	texlua test/build.lua save --quiet package-siunitx
	texlua test/build-toc.lua save --quiet main
	texlua test/build-toc.lua save --quiet main-english
	texlua test/build-bib.lua save --quiet bib-super
	texlua test/build-bib.lua save --quiet bib-numbers
	texlua test/build-bib.lua save --quiet bib-authoryear
	texlua test/build-nomencl.lua save --quiet package-nomencl

clean :
	$(LATEXMK) -c $(MAIN).tex
	$(LATEXMK) -c $(NAME).dtx
	rm -rf build

distclean :
	$(LATEXMK) -C $(MAIN).tex
	$(LATEXMK) -C $(NAME).dtx
	rm -rf build

install : cls doc
	mkdir -p $(TEXMF)/{doc,source,tex}/latex/$(NAME)
	mkdir -p $(TEXMF)/bibtex/bst/$(NAME)
	cp $(BSTFILES) $(TEXMF)/bibtex/bst/$(NAME)
	cp $(NAME).pdf $(TEXMF)/doc/latex/$(NAME)
	cp $(NAME).dtx $(TEXMF)/source/latex/$(NAME)
	cp $(CLSFILES) $(TEXMF)/tex/latex/$(NAME)

zip : main doc
	ln -sf . $(NAME)
	zip -r ../$(NAME)-$(VERSION).zip $(NAME)/{README.md,LICENSE,\
	$(NAME).dtx,$(NAME).pdf,$(NAME).cls,$(NAME)-*.bst,figures,\
	$(MAIN).tex,chapters,bibs,$(MAIN).pdf,\
	latexmkrc,Makefile}
	rm $(NAME)

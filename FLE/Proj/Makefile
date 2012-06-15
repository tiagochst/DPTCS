file=proj

make:

	latex $(file).tex
	bibtex $(file)
	latex $(file).tex
	latex $(file).tex
	dvips $(file).dvi -o
	ps2pdf13 -sPAPERSIZE=a4 $(file).ps
show:
	evince $(file).pdf
clean:
	rm *.dvi *.aux *.out *.log

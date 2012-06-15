file=clustering

make:
	latex $(file).tex
	latex $(file).tex
	dvips $(file).dvi -o
	ps2pdf13 -sPAPERSIZE=a4 $(file).ps
	make clean
show:
	evince $(file).pdf
clean:
	rm *.dvi *.aux *.out *.log

file=lettre
output=ChedraouiSilvaTiago_ProjectSummary

make:
	latex $(file).tex
	latex $(file).tex
	dvips $(file).dvi -o
	ps2pdf13 $(file).ps
	make clean
	cp $(file).pdf $(output).pdf
show:
	evince $(file).pdf
clean:
	rm *.dvi *.aux *.out *.log *.ps *.toc 

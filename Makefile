.PHONY: all examples clean myCV

CC = lualatex
EXAMPLES_DIR = examples
RESUME_DIR = examples/resume
CV_DIR = examples/cv
RESUME_SRCS = $(shell find $(RESUME_DIR) -name '*.tex')
CV_SRCS = $(shell find $(CV_DIR) -name '*.tex')

MYCV_DIR = myCV
MYCV_SRCS = $(shell find $(MYCV_DIR) -name '*.tex')
MYCV_BIB = $(MYCV_DIR)/publications.bib
MYCV_AUX = myCV.aux myCV.log myCV.out myCV.bcf myCV.blg myCV.run.xml myCV.bbl

all: myCV.pdf

myCV.pdf: myCV.tex awesome-cv.cls $(MYCV_SRCS) $(MYCV_BIB)
	$(CC) -interaction=nonstopmode myCV.tex
	biber myCV
	$(CC) -interaction=nonstopmode myCV.tex
	$(CC) -interaction=nonstopmode myCV.tex

examples: $(foreach x, coverletter cv resume, $x.pdf)

resume.pdf: $(EXAMPLES_DIR)/resume.tex $(RESUME_SRCS)
	$(CC) -output-directory=$(EXAMPLES_DIR) $<

cv.pdf: $(EXAMPLES_DIR)/cv.tex $(CV_SRCS)
	$(CC) -output-directory=$(EXAMPLES_DIR) $<

coverletter.pdf: $(EXAMPLES_DIR)/coverletter.tex
	$(CC) -output-directory=$(EXAMPLES_DIR) $<

clean:
	rm -rf $(EXAMPLES_DIR)/*.pdf myCV.pdf $(MYCV_AUX)

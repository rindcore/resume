# -*- mode: makefile; coding: utf-8 -*-
# A sample Makefile for building your résumé using the
# xml-resume-library.  Requirements: xsltproc, xmlto, xmltex
# Copyright © 2002 Colin Walters <walters@debian.org>
# Copyright © 2008 Francesco Poli <frx@firenze.linux.it>

# This should be the name of your résumé file, but without the .xml
# extension.
resume    ?= resume_of_warren

# Parametric country and papersize values
country   ?= us
papersize ?= letter

# The styles you want to use, for your country and papersize.
FO_STYLE   = ./xml-resume-lib/xsl/output/${country}-${papersize}.xsl
HTML_STYLE = ./xml-resume-lib/xsl/output/${country}-html.xsl
TXT_STYLE  = ./xml-resume-lib/xsl/output/${country}-text.xsl

.PHONY: all clean check
.SUFFIXES: .html .fo .pdf .xml .xsl .txt

all:	$(resume).html $(resume).txt $(resume).pdf

clean:
	-rm -f $(resume).html $(resume).pdf $(resume).txt $(resume).fo *~

$(resume).html: $(resume).xml
	xsltproc $(HTML_STYLE) $(resume).xml > $(resume).html

$(resume).txt: $(resume).xml
	xsltproc $(TXT_STYLE) $(resume).xml > $(resume).txt

$(resume).fo: $(resume).xml
	xsltproc $(FO_STYLE) $(resume).xml > $(resume).fo

$(resume).pdf: $(resume).fo
	fop $(resume).fo -pdf $(resume).pdf


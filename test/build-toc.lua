#!/usr/bin/env texlua

module = "chinathesis"

testfiledir = "./test/testfiles-toc"

demofiles = {"main.tex", "bib", "chapters"}
installfiles = {"*.cls", "figures"}
sourcefiles = {"*.dtx", "figures"}
unpackfiles = {"*.dtx"}

checkengines = {"xetex"}
stdengine = "xetex"

typesetexe = "xelatex"
unpackexe = "xetex"

checkopts = "-file-line-error -halt-on-error -interaction=nonstopmode"

checkruns = 2

kpse.set_program_name("kpsewhich")
dofile(kpse.lookup("l3build.lua"))

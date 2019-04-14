#!/usr/bin/env texlua

module = "chinathesis"

testfiledir = "./test/testfiles-bib"

demofiles = {"main.tex", "bib", "chapters"}
installfiles = {"*.cls", "*.bst"}
sourcefiles = {"*.dtx", "*.bst"}
unpackfiles = {"*.dtx"}

checkengines = {"xetex"}
stdengine = "xetex"

typesetexe = "xelatex"
unpackexe = "xetex"

checkopts = "-file-line-error -halt-on-error -interaction=nonstopmode"

checkruns = 3

function runtest_tasks(name)
    return "bibtex -terse " .. name
end

kpse.set_program_name("kpsewhich")
dofile(kpse.lookup("l3build.lua"))

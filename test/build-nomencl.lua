#!/usr/bin/env texlua

module = "chinathesis"

testfiledir = "./test/testfiles-nomencl"

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

function runtest_tasks(name)
    return "makeindex -s nomencl.ist -o " .. name .. ".nls " .. name .. ".nlo"
end

kpse.set_program_name("kpsewhich")
dofile(kpse.lookup("l3build.lua"))

# -*- coding: utf-8 -*-
"""
Created on Fri Apr 24 12:32:43 2015

@author: ClNovak
"""

fl = open('markov_gambling.jl')
fo = open('test.md', 'w')


in_code_block  = False

for line in fl.readlines():

    line = line.strip()

    if line.startswith("#"):
        # a comment line starts

        if in_code_block == True:
            # we are in a code block -> close the code block first
            #print "~~~~~~~~~~~~"
            fo.write("\n~~~~~~~~~~~~\n")
            in_code_block = False

        # remove comment and output line
        #print line[2:]
        fo.write(line[1:] + "\n")

    elif(len(line)==0):
        fo.write("\n")
    else:
        if in_code_block == False:
            #print "~~~~~~~~~~~~"
            fo.write("\n\n~~~~~~~~~~~~\n")
            in_code_block = True

        #print line
        fo.write(line)
if in_code_block == True:
    fo.write("\n~~~~~~~~~~~~\n")

fo.close()


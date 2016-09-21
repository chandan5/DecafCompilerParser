# DecafCompilerParser

Specifications of Grammer can be seen in Compilers 2016 Assignment 2.pdf

Assignment2.l contails tokenizer and Assignment2.y contails grammer for C-lite/Decaf Programming Language.

To compile => Enter `make -B` in terminal

To run => Enter `./a.out <inputFileName>`

After running you will see "Success" or "Syntax Error" as output.

If you see "Success" `bison_output.txt` will contain the order in which non-terminals were found.

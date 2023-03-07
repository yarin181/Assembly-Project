# String Manipulation in Assembly 📟

This project is a program written in the assembly language, that allows users to make some manipulation strings. The program provides various string manipulation functions such as concatenation, substring, and comparison.

## Getting Started

To get started with this project, you will need to have a Linux-based operating system installed on your computer, as well as the `gcc` compiler and `make` build tool.

1.  Clone the repository to your local machine.
 2.  Navigate to the project directory.
 3. Build the project using the Makefile.
4.  Run the program.
 `./a.out`
## Program Flow

When the program is run, it follows the following flow:

1.  The program prompts the user to enter the length of the first pstring (a positive integer).
2.  The user enters a positive integer, which represents the length of the first pstring.
3.  The program prompts the user to enter the first pstring (a string of characters).
4.  The user enters a string of characters that has the same length as the specified length.
5.  The program prompts the user to enter the length of the second pstring (a positive integer).
6.  The user enters a positive integer, which represents the length of the second pstring.
7.  The program prompts the user to enter the second pstring (a string of characters).
8.  The user enters a string of characters that has the same length as the specified length.
9.  The program prompts the user to specify which manipulation function they want to use (length calculation, character replacement, substring copy, case swapping, or lexicographic comparison).
10.  The user enters a number corresponding to the desired manipulation function.
11.  The program performs the specified manipulation function on the input pstrings and outputs the result.

If the user enters invalid input, the program will display an error message and prompt the user to re-enter the information.

## Available Manipulations

The program provides the following string manipulation functions:

-   Length Calculation: Calculates the length of an input pstring and prints the result. (type 31)
-   Character Replacement: Replaces all occurrences of a given character in both input pstrings with another character and prints the result.(type 32 or 33)
-   Substring Copy: Copies a specified portion of the first input pstring to the second input pstring and prints the result. (type 35)
-   Case Swapping: Swaps the case of all characters in both input pstrings (lowercase to uppercase and vice versa) and prints the result. (type 36)
-   Lexicographic Comparison: Compares the lexicographic value of a specified portion of both input pstrings and prints the result.(type 37)

To use any of these functions, follow the prompts in the program. The program will ask for user input for the two pstrings that will be manipulated, and will then output the result of the operation.

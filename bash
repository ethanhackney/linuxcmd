======================================
This file summarizes the bash man page
======================================

simple commands
===============
a simple command is a sequence of optional variable assignments followed
by blank-separated words and redirections, and terminated by a control
operator

pipelines
=========
a pipeline is a sequence of one or more commands separated by one of the
control operators | or |&

lists
=====
a list is a sequence of one or more pipelines separated by one of the
operators ;, &, && or ||, and optionally terminated by one of ;, &, or
<newline>

compound commands
=================

(list)
------
list is executed in a subshell environment

{ list; }
---------
list is simply executed in the current shell environment

((expression))
--------------
the expression is evaluated according to the arithmetic rules

[[ expression ]]
----------------
return a status of 0 or 1 depending on the evaluation of the conditional
expression 'expression'

( expression )
--------------
this may be used to override the normal precedence or operators

! expression
------------
true if expression is false

expression1 && expression2
--------------------------
true if both expression1 and expression2 are true (short circuit)

expression1 || expression2
--------------------------
true if either expression1 or expression2 is true (short circuit)

for name [ [ in [ word ... ] ] ; ] do list ; done
-------------------------------------------------
the list of words following in is expanded, generating a list of items. if
the in word is omitted, the for command executes list once for each
positional parameter that is set

for (( expr1 ; expr2 ; expr3 )) ; do list ; done
------------------------------------------------
regular for loop with arithmetic evaluation on expressions

select name [ in word ] ; do list ; done
----------------------------------------
the list of words following in is expanded, generating a list of items. The
set of expanded words is printed on the standard error, each preceded by
a number. If the in word is omitted, the positional parameters are printed

case word in [ [(] pattern [ | pattern ] ... ) list ;;  ] ... esac
------------------------------------------------------------------
a case command first expands word, and tries to match it against each
pattern in turn

if list; then list; [ elif list; then list; ] ... [ else list; ] fi
-------------------------------------------------------------------
if statement

while list-1; do list-2; done
-----------------------------
the while command continously executes the list list-2 as long as the
last command in the list list-1 returns an exit status of zero

until list-1; do list-2; done
-----------------------------
the until command is identical to the while command, except that the test
is negated: list-2 is executed as long as the last command in list-1 returns
a non-zero exit status

shell function definitions
==========================
a shell function is an object that is called like a simple command and
executes a compound command with a new set of positional parameters. Shell
functions are declared as follows:

        fname () compound-command [redirection]
        function fname [()] compound-command [redirection]

comments
========
a word beginning with # causes that word and all remaining characters on
that line to be ignored

quoting
=======
quoting is used to remove the special meaning of certain characters or
words to the shell. Each metacharacter has special meaning to the shell
and must be quoted if it is to represent itself. There are three quoting
mechanisms: the escape character, single quotes, and double quotes. A non-
quoted backslash is the escape character. Enclosing characters in single
quotes preserves the literal value of each character within the quotes.
Enclosing characters in double quotes preserves the literal value of all
characters within the quotes, with the exception of $, `, \, and when
history expansion is enabled, !. The special parameters * and @ have
special meaning when in double quotes. Words of the form $'string' are
treated specially. The word expands to string, with backslash-escaped
characters replaced as specified by the ANSI C standard. For instance,
$'\n' results in a literal newline. A double-quoted string preceded by a
dollar sign $"string" will cause the string to be translated according to
the current locale.

Parameters
==========
a parameter is an entity that stores values. It can be a name, a number,
or one of the special characters, such as * or @. A parameter is set if
it has been assigned a value. the null string is a valid value. a variable
may be assigned to by a statement of the form
        
        name=[value]

If value is not given, the variable is assigned the null string. All values
undergo tilde expansion, parameter and variable expansion, command
substitution, arithmetic expansion, and quote removal. If the variable
has its integer attribute set, then value is evaluated as an arithmetic
expression even if the $(( ... )) expansion is not used. Word splitting
is not performed with the exception of "$@". Pathname expansion is not
performed. In the context where an assignment statement is assigned a value
to a shell variable or array index, the += operator can be used to append
to or add to the variable's previous value

Positional parameters
=====================
A positional parameter is a parameter denoted by one or more digits, other
than the single digit 0. Positional parameters are assigned from the shell's
arguments when it is invoked, and may be reassigned using the set builtin
command.

Special parameters
==================
* expands to the positional parameters, starting from one. when the
expansion is not within double quotes, each positional parameter expands
to a separate word. In contexts where it is performed, those words are
subject to further word splitting and pathname expansion. When the
expansion occurs within double quotes, it expands to a single word with the
value of each parameter separated by the first character of the IFS special
variable

@ expands to the positional parameters, starting from one. In contexts
where word splitting is performed, this expands each positional parameter
to a separate word; if not within double quotes, these words are subject
to word splitting. In contexts where word splitting is not performed, this
expands to a single word with each positional parameter separated by a
space. When the expansion occurs within double quotes, each parameter
expands to a separate word

# expands to the number of positionoal parameters in decimal

? expands to the exit status of the most recently executed forground
pipeline

- expands to the current option flags as specified upon invocation, by the
set builtin command, or those set by the shell itself

$ expands to the process ID of the shell. In a () subshell, it expands
to the process ID of the current shell, not the subshell

! expands to the process ID of the job most recently placed into the
background, whether executed as an asynchronous command or using the bg
builtin

0 expands to the name of the shell or shell script

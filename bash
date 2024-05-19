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

Arrays
======
bash provides one-dimensional indexed and associative array variables. Any
variable may be used as an indexed array; the declare builtin will
explicitly declare an array. There is no maximum limit on the size of an
array, nor any requirement that members be indexed or assigned contiguously.
Indexed arrays are referenced using integers and are zero based; associative
arrays are referenced using arbitrary strings. An indexed array is created
automatically if any variable is assigned to using the syntax

        name[subscript]=value

the subscript is treated as an arithmetic expression that must evaluate to
a number. Arrays are assigned to using compound assignments of the form

        name=(value1 ... valuen)

where each value may be of the form [subscript]=string. Indexed array
assignments do not require anything but string. Each value in the list is
expanded using all the shell expansions. When assigning to an associative
array, the words in a compound assignment may be either assignment statements,
for which the subscript is required, or a list of words that is interpreted as
a sequence of alternating keys and values

        name=(key1 value1 key2 value2)
        name=([key1]=value1 [key2]=value)

if an array is subscripted by a negative number, that number is interpreted as
relative to one greater than the maximum index of the array, so negative
indices count back from the end of the array, and an index of -1 references
the last element

any element of an array may be referenced using

        ${name[subscript]}

the braces are required to avoid conflicts with pathname expansion. If
subscript is @ or *, the word expands to all members of the array. These
subscripts differ only when the word appears within double quotes. If the word
is double-quoted, ${name[*]} expands to a single word with the value of each
array member separated by the first character of the IFS special variable, and
${name[@]} expands each element of array to a separate word. to get the length
of an array, use:

        ${#name[*]}
        ${#name[@]}

it is possible to obtain the keys (indices) of an array as well as the values.

        ${!name[@]}
        ${!name[*]}

expands to the indices assigned in array variable name. the unset builtin is
used to destroy arrays. unset name[subscript] destroys the array element at
index subscript, for both indexed and associative arrays.

Expansion
=========
expansion is performed on the command line after it has been split into words.
There are seven kinds of expansion performed: brace expansion, tilde expansion,
parameter and variable expansion, command substitution, arithmetic expansion,
word splitting, and pathname expansion

the order of expansions is: brace expansion, tilde expansion, parameter and
variable expasion, arithmetic expansion, and command substitution, word
splitting, and pathname expansion

after these expansions are performed, quote characters present in the original
word are removed unless they have been quoted themselves

only brace expansion, word splitting, and pathname expansion can increase the
number of words of the expansion; other expansions expand a single word to
a single word. the only exceptions to this are the expansions of "$@" and
"${name[@]}", and, in most cases, $* and ${name[*]}

brace expansion
===============
brace expansion is a mechanism by which arbitrary strings may be generated. This
mechanism is similar to pathname expansion, but the filenames generated need not
exist. Patterns to be brace expanded take the form of an optional preamble,
followed by either a series of comma-separated strings or a sequence expression
between a pair of braces, followed by an optional postscript. Brace expansions
may be nested

        a{d,c,b}e

expands into ade, ace, and abe

a sequence expression takes the form {x..y[..incr]}, where x and y are either
integers or single characters, and incr, an optional increment, is an integer.
more examples include:

        mkdir /usr/local/src/bash/{old,new,dist,bugs}
        chown root /usr/{ucb/{ex,edit},lib/{ex?.?*,how_ex}}

tilde expansion
===============
if a word begins with an unquoted tilde character, all of the characters
preceding the first unquoted slash (or all characters, if there is no
unquoted slash) are considered a tilde-prefix. If none of the characters
in the tilde-prefix are quoted, the characters in the tilde-prefix following
the tilde are treated as a possible login name. If this login name is the
null string, the tilde is replaced with the value of the shell parameter
HOME. If HOME is unset, the home directory of the user executing the
shell is substituted instead.

if the tilde prefix is a ~+, the value of the shell variable PWD is used. If
the tilde prefix is a ~-, the value of the shell variable OLDPWD is used. If
the characters following the tilde in the tilde consist of a number N,
optionally prefixed by a + or a -, the tilde prefix is replaced with the
corresponding element from the directory stack, as it would be displayed
by the dirs builtin invoked with the tild-prefix as an argument. If the
tilde expansion fails, the word is unchanged

parameter expansion
===================
the '$' character introduces parameter expansion, command substitution, or
arithmetic expansion. the parameter name or symbol to be expanded may be
enclosed in braces, which are optional but serve to protect the variable
to be expanded from characters immediately following it which could be
interpreted as part of the name

${parameter}
------------
the value of parameter is substituted

        name=me
        echo ${name} # me

${!name}
--------
if the first character of parameter is a !, and parameter is not a nameref, it
introduces a level of indirection, except with arrays and associative arrays
where it expands to the indices or keys

        name=me
        ref=name
        echo ${!ref} # me

in each of the cases below, word is subject to tilde expansion, parameter
expansion, command substitution, and arithmetic expansion

${parameter:-word}
------------------
use default values. if parameter is unset or null, the expansion of word is
substituted. otherwise, the value of parameter is substituted

        param=echo
        ${param:-$(date)} hello # expands to 'echo hello'
        param=
        param=${param:-$(date)}
        echo $param # result of date

${parameter:=word}
------------------
assign default values. if the parameter is unset or null, the expansion of
word is assigned to parameter. the value of parameter is then substituted.
positional parameters and special parameters may not be assigned to in this
way

        echo ${param:=$(echo hello}} # hello
        echo $param # hello

${parameter:?word}
------------------
display error if null or unset. if parameter is null or unset, the expansion of
word (or a error message) is written to the standard error

        ${param:?$(echo unset)} # -base: param: unset

${parameter:+word}
------------------
use alternate value. if the parameter is null or unset, nothing is substituted,
otherwise, the expansion of word is substituted

        param='hello world'
        echo ${param:+goodbye world} # goodbye world

${parameter:offset}
${parameter:offset:length}
--------------------------
substring expansiono. expands to up to length characters of the value of
parameter starting at the character specified by offset. If length is
omitted, expands to the substring of the value of parameter starting at
the character specified by offset and extending to the end of the value.
length and offset are arithmetic expressions

        name='ethan andrew hackney'
        echo ${name:0:5} # ethan
        echo ${name:12}  # hackney

if offset evaluates to a number less than zero, the value is used as an
offset in characters from the end of the value of parameter
if length evaluates to a number less than zero, the value is used as an
offset in characters from the end of the value of parameter. note that
a negative offset must be separated from the colon by at least one space
to avoid being confused with the :- expansion

        echo ${name:0:-2}  # ethan andrew hackn
        echo ${name: -2:2} # ey NOTE the space between : and -2

if parameter is @, the result is length positional parameters, beginning at
offset. if parameter is an indexed array name subscripted by @ or *, the result
is the length members of the array beginning with ${parameter[offset]}

        peeps=(chris sonny rich jon pat)
        echo ${peeps[@]:0:2}   # chris sonny
        echo ${peeps[@]: -2:2} # jon pat
        echo ${peeps[@]:2}    # rich jon pat

substring expansion applied to an associative array produces undefined results

${!prefix*}
${!prefix@}
-----------
names matching prefix. expands to the names of variables whose name begin with
prefix, separated by the first character of the IFS special variable. When @
is used and the expansion apperas within double quotes, each variable name
expands to a separate word

        name=ethan
        n=28
        echo ${!n*} # n name
        echo ${!n@} # n name

${!name[@]}
${!name[*]}
-----------
list of array keys. if name is an array variable, expands to the list of array
indices (keys) assigned in name. if name is not an array, expands to 0 if name
is set and null otherwise. when @ is used and the expansion appears within
double quotes, each key expands to a separate word

        declare -A ages
        ages[chris]=28
        ages[ethan]=27
        ages[sonny]=26
        echo ${!ages[@]} # chris sonny ethan

        peeps=(chris sonny rich jon pat)
        echo ${!peeps[@]} # 0 1 2 3 4

${#parameter}
-------------
parameter length. the length in characters of the value of parameter is
substituted. if parameter is * or @, the value substituted is the number of
positional parameters. if parameter is an array name subscripted by * or @,
the value substituted is the number of elements in the array.

        name=ethan
        echo ${#name} # 5
        peeps=(chris sonny rich jon pat)
        echo ${#peeps[@]} # 5

${parameter#word}
${parameter##word}
------------------
remove matching prefix pattern. the word is expanded to produce a pattern just
as in pathname expansion, and matched against the expanded value of parameter
using the rules described by Pattern Matching below. if # is used than the
shortest matching prefix is removed and if ## is used than the longest matching
prefix is removed. If parameter is @ or *, the pattern removal operation
operation is applied to each positional parameter in turn, and the expansion
is the resultant list. if parameter is an array variable subscripted with @
or *, the pattern removal operation is applied to each member of the array

        name=ethanethan
        echo ${name#ethan*}  # ethan
        echo ${name##ethan*} # nothing

        jobs=('title: programmer', 'title: professor')
        echo ${jobs[@]#title:} # programmer, professor

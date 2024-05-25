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

${parameter%word}
${parameter%%word}
------------------
remove matching suffix pattern. the word is expanded to produce a
pattern just as in pathname expansion, and matching against the expanded
value of paramter using the rules described in pattern matching. If the
pattern matches a trailing portion of the expanded value of parameter, then
the result of the expansion is the expanded value of paramater with the
shortest matching pattern with % or the longest matching pattern with %%. If
parameter is an array variable subscripted with @ or *, the pattern is
performed on each entry of array

        name=ethanethan
        echo ${name%ethan*}  # ethan
        echo ${name%%ethan*} # nothing
        ages=('chris 28', 'sonny 26' 'ethan 27')
        echo ${ages[@]%%[0-9]*} # chris sonny ethan

${parameter/pattern/string}
---------------------------
pattern substitution. the pattern is expanded to produce a pattern just as
in pathname expansion. parameter is expanded and the longest match of pattern
against its value is replaced with string. if pattern beings with /, all
matches of the pattern are replaced with string. normally only the first
match is replaced. if pattern begins with #, it must match at the beginning
of the expanded value of parameter. If pattern begins with %, it must match
at the end of the expanded value of parameter. if string is null, matches
of pattern are deleted and the / following the pattern may be omitted. If
parameter is @ or *, the substitutioin operation is applied to each
positional parameter. the same is done for arrays

        name='ethan andrew hackney'
        echo ${name/ andrew / } # ethan hackney

        name='andrew ethan'
        echo ${name/#ethan}  # andrew ethan
        name='andrew ethan'
        echo ${namm/#andrew} # ethan

        name='ethan andrew andrew'
        echo ${name/%andrew} # ethan andrew

        name='ethan andrew andrew andrew hackney'
        echo ${name//andrew/ } # ethan hackney

        ages=('chris 28' 'sonny 26' 'ethan 27')
        echo ${ages[@]/% [0-9]*} # chris sonny ethan

${parameter^pattern}
${parameter^^pattern}
${parameter,pattern}
${parameter,,pattern}
---------------------
case modification. this expansion modifies the case of alphabetic characters
in parameter. the pattern is expanded to produce a pattern just as in pathname
expansion. each character in the expanded value of parameter is tested against
pattern, and, if it matches the pattern its case is converted. the pattern
should not attempt to match more than one character. the ^ operator converts
lowercase letters matching pattern to uppercase; the , operator converts
matching uppercase letters to lowercase. the ^^ and ,, expansions convert
each matched character in the expanded value. if pattern is omitted, it is
treated like a ?, which matches every character. if parameter is @ or *, the
case modification operation is applied to each positional parameter. the same
is done if parameter is an array

        name='Ethan Andrew Hackney'
        echo ${name^^} # ETHAN ANDREW HACKNEY
        echo ${name,,} # ethan andrew hackney

        peeps=(Chris Sonny Rich Jon Pat Luke)
        echo ${peeps[@],,} # chris sonnyy rich jon pat luke

command substitution
====================
command substitution allows the output of a command to replace the command
name. There are two forms

        $(command) or `command`

bash performs the expansion by executing command in a subshell environment and
replacing the command substitution with the standard output of the command,
with any trailing newlines deleted. Embedded newlines are not deleted, but
they may be removed during word splitting. the command substitution $(cat file)
can be replaced by the equivalent but faster $(<file)

when the old-style backquote form of substitution is used, backslash retains
its literal meaning except when followed by $, `, or \. the first backquote
not preceded by a backslash terminates the command substitution.

command substitution may be nested. to nest when using the backquoted form,
escape the inner backquotes with backslashes

if the substitution appears within double quotes, word splitting and pathname
expansion are not performed on the results

arithmetic expansion
====================
arithmetic expansion allows the evaluation of an arithmetic expression and
the substitution of the result. the format for arithmetic espansion is:

        $((expression))

the expression is treated as if it were within double quotes, but a double
quote inside the parentheses is not treated specially. all tokens in th
expression undergo parameter and variable expansion, command substitution,
and quote removal. the result is treated as the arithmetic expression to
be evaluated. arithmetic expansion may be nested

process substitution
====================
process substitution allows a process's input or output to be referred to using
a filename. it takes the form of <(list) or >(list). the process list is
run asynchronously, and its input or output appears as a filename. This
filename is passed as an argument to the current command as the result of the
expansion. if the >(list) form is used, writing to the file will provide input
for list. if the <(list) form is used, the file passed as an argument should be
read to obtain the output of list. process substitution is supported on systems
that support named pipes (FIFOs) or the /dev/fd method of naming open files

word splitting
==============
the shell scans the results of parameter expansion, command substitution, and
arithmetic expansion that did not occur within double quotes for word
splitting

the shell treats each character of IFS as a delimiter, and splits the
results of the other expansions into words using these characters as field
terminators. if IFS is unset, or its value is exactly <space><tab><newline>,
the default, then sequence of <space>, <tab>, and <newline> is used.

explicit null arguments ("" or '') are retained and passed to commands as
empty strings

note that if no expansion occurs, no splitting is performed

pathname expansion
==================
after word splitting, unless the -f option has been set, bash scans each
word for the characters *, ?, and [. if one of these characters appears,
and is not quoted, then the word is regarded as a pattern, and replaced with
an alphabetically sorted list of filenames matching the pattern.

pattern matching
================
any character that appears in a pattern, other than the special pattern
characters described below, matches itself. the NUL character may not occur
in a pattern. a backslash escapes the following character; the escaping
backslash is discarded when matching. The special pattern characters must be
quoted if they are to be matched literally

the special pattern characters having the following meanings:

*:     matches any string, including the null string
?:     matches any single character
[...]: matches any one of the enclosed characters

redirection
===========
before a command is executed, its input and output may be redirected using a
special notation interpreted by the shell. redirection allos commands' file
handles to be duplicated, opened, closed, made to refer to different files, and
can change the files the command reads from and writes to. redirections are
processed in the order they appear, from left to right

each redirection that may be preceded by a file descriptor number may instead
by preceded by a word of the form {varname}. In this case, for each
redirection operator except >&- and <&-, the shell will allocate a file
descriptor greater than or equal to 10 and assign it to varname. If >&- or
<&- is preceded by {varname}, the value of varname defines the file descriptor
to close. If {varname} is supplied, the redirection persists beyond the scope
of the command, allowing the shell programmer to manage the file descriptor
himself

if the file descriptor is omitted, and the first character of the redirection is
<, the redirection refers to the standard input (file descriptor 0). If the
first character of the redirection operator is >, the redirection refers to the
standard output (file descriptor 1)

the word following the redirection operator in the following descriptions,
unless otherwise noted, is subjected to brace expansion, tilde expansion,
parameter and variable expansion, command substitution, arithmetic expansion,
quote removal, pathname expansion, and word splitting. If it expands to more
than one word, bash reports an error

note that the order of redirection is significant. for example, the command

        ls > dirlist 2>&1

directs both standard output and standard error to the file 'dirlist', while the
command

        ls 2>&1 >dirlist

directs only the standard output to file dirlist, because the standard error was
duplicated from the standard output before the standard output was redirected
to dirlist

bash handles several filenames specially when they are used in redirections, as
described in the following table. If the operating system on which bash is
running provides these special files, bash will use them; otherwise it will
emulate them internally with the behavior described below

        /dev/fd/fd
                if fd is a valid integer, file descriptor fd is duplicated

        /dev/stdin
                file descriptor 0 is duplicated

        /dev/stdout
                file descriptor 1 is duplicated

        /dev/stderr
                file descriptor 2 is duplicated

        /dev/tcp/host/port
                if host is a valid hostname or internet address, and port is an
                integer port number of service name, bash attemps to open the
                corresponding TCP socket

        /dev/udp/host/port
                if host is a valid hostname or internet address, and port is an
                integer port number of service name, bash attemps to open the
                corresponding UDP socket

redirecting input
=================
redirection of input causes the file whose name results from the expansion of
word to be opened for reading on file descriptor n, or the standard input if
n is not specified

        [n]<word

redirecting output
------------------
redirection of output causes the file whose name results from the expansion of
word to be opened for writing on file descriptor n, or the standard output if
n is not specified. if the file does not exist it is created; if it does exist
it is truncated to zero size

        [n]>word

appending redirected output
---------------------------
redirection of output in this fashion causes the file whose name results from
the expansion of word to be opened for appending on file descriptor n, or the
standard output is n is not specified. if the file does not exist it is created

        [n]>>word

redirecting standard output and standard error
----------------------------------------------
this construct allows both the standard output and the standard error output to
be redirected to the file whose name is the expansion of word. there are two
formats for redirecting standard output and standard error

        &>word
        >&word

of the two forms, the first is preferred. this is semantically equivalent to

        >word 2>&1

appending standard output and standard error
--------------------------------------------
this construct allows both the standard output and the standard error output
to be appended to the file whose name is the expansion of word. the format for
appending standard output and standard error is:

        &>>word

this is semantically equivalent to

        >>word 2>&1

here documents
--------------
this type of redirection instructs the shell to read input from the current
source until a line containing only delimiter is seen. all of the lines read
up to that point are then used as the standard input (or descriptor n if n
is specified) for a command. the format of here-documents is:

        [n]<<[-]word
                here document
        delimiter

no parameter and variable expansion, command substitution, arithmetic expansion,
or pathname expansion is performed on word. If the redirection operator is <<-,
then all leading tab characters are stripped from input lines and the line
containing delimiter. this allows here-documents within shell scripts to be
indented in a natural fashion

here strings
------------
a variant of here documents, the format is:

        [n]<<<word

the word undergoes tilde expansion, parameter and variable expansion, command
substitution, arithmetic expansion, and quote removal. pathname expansion and
word splitting are not performed. the result is supplied as a single string,
with a newline append, to the command on its standard input

duplicating file descriptors
----------------------------
the redirection operator

        [n]<&word

is used to duplicate input file descriptors. if word expands to one or more
digits, the file descriptor denoted by n is made to be a copy of that file
descriptor. if the digits in word do not specify a file descriptor open for
input, a redirection error occurs. if word evaluates to -, the file descriptor
n is closed. if n is not specified, the standard input is used

        [n]>&word

is used similarly to duplicate output file descriptors

moving file descriptors
-----------------------
the redirection operator

        [n]<&digit-

moves the file descriptor digit to file descriptor n, or the standard input if
n is not specified. digit is closed after being duplicated to n

similarly, the redirection operator

        [n]>&digit-

moves the file descriptor digit to file descriptor n, or the standard output if
n is not specified

opening file descriptor for reading and writing
-----------------------------------------------
the redirection operator

        [n]<>word

causes the file whose name is the expansion of word to be opened for both
reading and writing on file descriptor n, or on file descriptor 0 if n is
not specified

functions
=========
a shell function stores a series of commands for later execution. when the
name of a shell function is used as a simple command name, the list of
commands associated with the function name is executed. functions are
executed in the context of the current shell; no new process is created to
interpret them (contrast this with the execution of a shell script). When a
function is executed, the arguments to the function become positional
parameters during its execution

variables local to the function may be declared with the local builtin command.
Ordinarily, variables and their values are shared between the function and
its caller. if a variable is declared local, the variable's visible scope is
restricted to that function and its children (including the functions it
calls). local variables shadow variables with the same name declared at
previous scopes

the shell uses dynamic scoping to control a variable's visibility within
functions. with dynamic scoping, visible variables and their values are a
result of the sequence of function calls that caused execution to reach
the current function. the value of a variable that a function sees depends
on its value within its caller, if any, whether that caller is the global
scope or another shell function. this is also the value that a local variable
declaration shadows, and the value that is restored when the function returns

if the builtin command return is executed in a function, the function completes
and execution resumes with the next command after the function call

functions may be recursive.

arithmetic evaluation
=====================
the shell allows arithmetic expressions to be evaluated, under certain
circumstances. evaluation is done in fixed-width integers with no check for
overflow, though division by 0 is trapped and flagged as an error. the
operators and their precedence, associativity, and values are the same as in
the C language

        id++ id--
                variable post-increment and post-decrement
        - +
                unary minus and plus
        ++id --id
                variable pre-increment and pre-decrement
        ! ~
                logical and bitwise negation
        **
                exponentiation
        * / %
                multiplication, division, remainder
        + -
                addition, subtraction
        << >>
                left and right bitwise shifts
        <= >= < >
                comparison
        == !=
                equality and inequality
        &
                bitwise AND
        ^
                bitwise XOR
        |
                bitwise OR
        &&
                logical AND
        ||
                logical OR
        expr?expr:expr
                conditional operator
        = *= /= %= += -= <<= >>= &= ^= |=
                assignment
        expr1, expr2
                comma

shell variables are allowed as operands; parameter expansion is performed
before the expression is evaluated. within an expression, shell variables may
also be referenced by name without using the parameter expansion syntax. A
shell variable that is null or unset evaluates to 0 when referenced by name
without using the parameter expansion syntax.

integer constants follow the C language definition, without suffixes or
character constants. constants with a leading 0 are interpreted as octal
numbers. A leading 0x or 0X denotes hexadecimal. otherwise, numbers take
the form [base#]n, where the optional base is a decimal number between 2
and 64 representing the arithmetic base, and n is a number in that base.
If base# is omitted, then base 10 is used

conditional expressions
=======================
conditional expressions are used by the [[ compound command and the test and [
builtin commands to test file attributes and perform string and arithmetic
comparisons

when used with [[, the < and > operators sort lexicographically using the
current locale

        -a file
                true if file exists
        -b file
                true if file exists and is a block special file
        -c file
                true if file exists and is a character special file
        -d file
                true if file exists and is a directory
        -e file
                true if file exists
        -f file
                true if file exists and is a regular file
        -g file
                true if file exists and is set-group-id
        -h file
                true if file exists and is a symbolic link
        -k file
                true if file exists and its sticky bit is set
        -p file
                true if file exists and is a named pipe (FIFO)
        -r file
                true if file exists and is readable
        -s file
                true if file exists and has a size greater than zero
        -t fd
                true if file descriptor fd is open and refers to a terminal
        -u file
                true if file exists and its set-user-id bit is set
        -w file
                true if file exists and is writable
        -x file
                true if file exists and is executable
        -G file
                true if file exists and is owned by the effective group id
        -L file
                true if file exists and is a symbolic link
        -N file
                true if file exists and has been modified since it was last read
        -O file
                true if file exists and is owned by the effective user id
        -S file
                true if file exists and is a socket
        file1 -ef file2
                true if file1 and file2 refer to the same device and
                inode numbers
        file1 -nt file2
                true if file1 is newer then file2 or if file1 exists and file2
                does not
        file1 -ot file2
                true if file1 is older than file2, or if file2 exists and file1
                does not
        -o optname
                true if the shell option optname is enable
        -v varname
                true if the shell variable varname is set
        -R varname
                true if the shell variable varname is set and is a name
                reference
        -z string
                true if the length of string is zero
        string
        -n string
                true if the length of string is non-zero
        string1 == string2
        string1 = string2
                true if the strings are equal. = should be used with the test
                command for POSIX conformance. when used with the [[ command,
                this performs pattern matching
        string1 != string2
                true if the strings are not equal
        string1 < string2
                true if string1 sorts before string2 lexicographically
        string1 > string2
                true if string1 sorts after string2 lexicographically
        arg1 OP arg2
                OP is one of -eq, -ne, -lt, -le, -gt, or -ge. These
                arithmetic binary operators return true if arg1 OP arg2
                returns true

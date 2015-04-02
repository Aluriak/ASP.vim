" Vim Syntax File
"
" Language:    ASP
" Maintainers: Lucas Bourneuf <lucas.bourneuf@openmailbox.org>
" Created:     Jul 31st, 2008
" Changed:     Wed Apr 1 2015

if version < 600
   syn clear
elseif exists("b:current_syntax")
  finish
endif

syntax case match

syntax keyword aspISOBuiltIn   var nonvar integer float number atom string 
			\atomic compound unify_with_occurs_check fail false true repeat call once 
			\catch throw abolish retract asserta assertz current_predicate clause open 
			\close stream_property set_stream_position set_input set_output current_ouput 
			\nl put_byte put_char put_code flush_output get_byte get_code get_char 
			\peek_byte peek_code peek_char at_end_of_stream write_term write_canonical 
			\write writeq read read_term functor arg copy_term atom_codes atom_chars 
			\char_code number_chars number_codes atom_length sub_atom op current_op 
			\char_conversion current_char_conversion is mod rem div round float 
			\float_fractional_part float_integer_part truncate floor ceiling sqrt sin cos 
			\atan log findall bagof setof sub_atom

syntax keyword aspSWIBuiltIn   rational callable ground cyclic_term subsumes subsumes_chk 
			\unifiable use_module compare apply not ignore call_with_depth_limit call_cleanup 
			\print_message print_message_lines message_hook on_signal current_signal block exit 
			\term_hash redefine_system_predicate retractall assert recorda recordz recorded 
			\erase flag compile_predicates index current_atom 
			\current_blob current_functor current_flag current_key dwim_predicate nth_clause 
			\predicate_property open_null_stream current_stream is_stream stream_position_data 
			\seek set_stream see tell append seeing telling seen set_asp_IO told 
			\wait_for_input byte_count character_count line_count line_position read_clause 
			\put tab ttyflush get0 get skip get_single_char copy_stream_data print portray 
			\read_history prompt setarg nb_setarg nb_linkarg duplicate_term numbervars 
			\term_variables atom_number name term_to_atom atom_to_term atom_concat 
			\concat_atom atom_prefix normalize_space collation_key char_type string_to_list
			\code_type downcase_atom upcase_atom collation_key locale_sort string_to_atom 
			\string_length string_concat sub_string between succ plus rdiv max min random 
			\integer rationalize ceil xor tan asin acos pi e cputime eval msb lsb popcount 
			\powm arithmetic_function current_arithmetic_function is_list memberchk length 
			\sort msort keysort predsort merge merge_set maplist forall writeln writef 
			\swritef format format_predicate current_format_predicate tty_get_capability 
			\tty_goto tty_put set_tty tty_size shell win_exec win_shell win_folder 
			\win_registry_get_value getenv setenv unsetenv setlocale unix date time 
			\get_time stamp_date_time date_time_stamp date_time_value format_time 
			\parse_time window_title win_window_pos win_has_menu win_insert_menu 
			\win_insert_menu_item access_file exists_file file_directory_name file_base_name 
			\same_file exists_directory delete_file rename_file size_file time_file 
			\absolute_file_name is_absolute_file_name file_name_extension expand_file_name 
			\asp_to_os_filename read_link tmp_file make_directory working_directory chdir 
			\garbage_collect garbage_collect_atoms trim_stacks stack_parameter dwim_match 
			\wildcard_match sleep qcompile portray_clause acyclic_term clause_property 
			\setup_and_call_cleanup message_to_string phrase hash with_output_to fileerrors 
			\read_pending_input prompt1 same_term sub_string merge_set 

syntax cluster aspBuiltIn      contains=aspSWIBuiltIn,aspISOBuiltIn

syntax match   aspArithmetic   /\*\*\?\|+\|\/\/\?\|\/\\\|<<\|>>\|\\\/\?\|\^/ 
			\contained containedin=aspBody

syntax match   aspRelations    /=\.\.\|!\|=:=\|=\?<\|=@=\|=\\=\|>=\?\|@=\?<\|@>=\?\|\\+\|\\\?=\?=\|\\\?=@=\|=/ 
			\contained containedin=aspBody

syntax region  aspCComment     fold start=/%\*/ end=/\*%/ contains=aspTODO,@Spell
syntax match   aspComment      /%.*/ contains=aspTODO,@Spell
syntax region  aspCommentFold  fold start=/^\zs\s*%/ skip=/^\s*%/ end=/^\ze\s*\([^%]\|$\)/ contains=aspComment
syntax keyword aspTODO         FIXME TODO fixme todo Fixme FixMe Todo ToDo XXX xxx contained
syntax cluster aspComments     contains=aspCComment,aspComment,aspCommentFold

syntax region  aspBody         fold start=/\(:-\|?-\)/ end=/\./ 
			\contains=@aspAll,aspPredicateWithArity
syntax region  aspDCGBody      fold start=/-->/ end=/\./ 
			\contains=@aspAll,aspDCGSpecials

syntax match   aspNumber       /\<\d\+\>/ contained
syntax match   aspNumber       /\<\d\+\.\d\+\>/ contained
syntax match   aspAtom         /\<\l\w*\>\ze\([^(]\|$\)/ contained
syntax match   aspVariable     /\<\(_\|\u\)\w*\>/ contained
syntax match   aspChar         /\<\0'\(\\\)\?.\>/ contained

syntax match   aspHead         /\<\l\w*\>/ nextgroup=aspBody,aspDCGBody skipwhite
syntax region  aspHeadWithArgs start=/\<\l\w*\>(/ end=/)/ nextgroup=aspBody,aspDCGBody contains=@aspAll

syntax match  aspOpStatement   /indexed\|discontiguous\|dynamic\|module_transparent\|multifile\|volatile\|initialization/ 
			\containedin=aspBody contained

syntax region  aspDCGSpecials  start=/{/ end=/}/ contained contains=@aspAll

syntax region  aspTuple        fold start=/\W\zs(/ end=/)/ contained containedin=aspPredicate,aspBody contains=@aspAll
syntax region  aspPredicate    start=/\<\l\w*\>\ze(/ end=/)/ contains=@aspAll
syntax match   aspPredicateWithArity /\<\l\w*\>\/\d\+/ contains=@aspBuiltIn,aspArity
syntax match   aspArity        contained /\/\d\+/
syntax cluster aspPredicates   contains=aspPredicate,aspPredicateWithArity

syntax region  aspList         start=/\[/ end=/\]/ contains=aspListDelimiters,@aspAll,aspPredicateWithArity contained
syntax match   aspListDelimiters /[,|]/ contained

syntax cluster aspAll          contains=aspList,aspPredicate,aspTuple,@aspTerms,@aspComments,aspQuoted,@aspBuiltIn,aspRelations,aspArithmetic,aspDiffList
syntax cluster aspTerms        contains=aspVariable,aspAtom,aspList,
			\aspNumber,aspErrorTerm,aspChar

syntax match   aspQuotedFormat /\~\(\d*[acd\~DeEgfGiknNpqrR@st\|+wW]\|`.t\)/ contained
syntax region  aspQuoted       start=/'/ end=/'/ contains=aspQuotedFormat,@Spell

syntax match   aspErrorVariable /\<\(_\|\u\)\w*\>/
syntax region  aspErrorTerm    start=/\<\(_\|\u\)\w*\>(/ end=/)/

"""" Highlights

highlight link aspErrorVariable Error
highlight link aspErrorTerm     Error

highlight link aspOpStatement  Preproc
highlight link aspComment      Comment
highlight link aspCComment     Comment
highlight link aspTODO         TODO

highlight link aspAtom         Constant
highlight link aspChar         Constant
highlight link aspVariable     Identifier
highlight link aspNumber       Number

highlight link aspISOBuiltIn   Keyword
highlight link aspSWIBuiltIn   Keyword

highlight link aspRelations    Statement

highlight link aspQuotedFormat Special
highlight link aspQuoted       String

highlight link aspPredicate    Normal
highlight link aspPredicateWithArity Normal
highlight link aspHead         Constant
highlight link aspHeadWithArgs Normal

highlight link aspBody         Statement
highlight link aspDCGBody      Statement

highlight link aspList         Type
highlight link aspListDelimiters Type
highlight link aspArity        Type
highlight link aspDCGSpecials  Type
highlight link aspTuple        Type
highlight link aspDiffList     Type

syn sync minlines=20 maxlines=50

let b:current_syntax = "asp"

% Derived from junsrt.bst for the SICE SSI template format.
% JP article: 著者：論文題目，雑誌名，\textbf{巻}-号，始/終（年）
% JP book: 著者：書名，始/終，出版社（年）
% JP inproceedings: 著者：題目，予稿集名，\textbf{巻}，始/終（年）
% JP misc: 著者：題目，\url{URL}（note）
% EN article: J. Smith and A. Lee: Title, Journal, \textbf{12}-3, 45/56 (2020)
% EN inproceedings: J. MacQueen: Some methods ..., Proceedings of ..., \textbf{1}, 281/297 (1967)
% EN book: J. Smith: Title, Publisher (2018)
% EN misc: Author: Title, \url{URL} (note)

% version 0.30 for JBibTeX versions 0.30 or later, LaTeX version 2.09.
	% Copyright (C) 1990, all rights reserved.
	%
	% This file is derived from btxbst.doc of BibTeX 0.99c
	%
	% Copying of this file is authorized only if either
	% (1) you make absolutely no changes to your copy, including name, or
	% (2) if you do make changes, you name it something other than
	% jbtxbst.doc, jplain.bst, junsrt.bst, jalpha.bst, jabbrv.bst,
	% tipsj.bst, jipsj.bst, tieice.bst, jname.bst, jorsj.bst
	%
	% This restriction helps ensure that all standard styles are identical.
	% The file jbtxbst.doc has the documentation for this style.
	%
	% Please notify Shouichi MATSUI(matsui@denken.or.jp) of any bugs in
	% these standard styles or in this documentation file.
	% 松井 正一  (財) 電力中央研究所　情報システム部

ENTRY
  { address
    author
    booktitle
    chapter
    edition
    editor
    howpublished
    institution
    journal
    key
    month
    note
    number
    organization
    pages
    publisher
    school
    series
    title
    type
    volume
    url
    year
    yomi
  }
  {is.kanji.entry}

  { label }


STRINGS { s t }
INTEGERS { nameptr namesleft numnames }

FUNCTION {not}
{ { #0 } { #1 } if$ }

FUNCTION {or}
{ { pop$ #1 } 'skip$ if$ }

FUNCTION {field.or.null}
{ duplicate$ empty$ { pop$ "" } 'skip$ if$ }

FUNCTION {comma}
{ is.kanji.entry { "，" } { ", " } if$ }

FUNCTION {colon}
{ is.kanji.entry { "：" } { ": " } if$ }

FUNCTION {output.nonnull}
{ 's :=
  duplicate$ empty$
    'skip$
    { comma * }
  if$
  s *
}

FUNCTION {output}
{ duplicate$ empty$ 'pop$ 'output.nonnull if$ }

FUNCTION {output.check}
{ 't :=
  duplicate$ empty$
    { pop$ "empty " t * " in " * cite$ * warning$ }
    'output.nonnull
  if$
}

FUNCTION {output.title}
{ title empty$
    { "empty title in " cite$ * warning$ }
    { duplicate$ empty$
        'skip$
        { colon * }
      if$
      title *
    }
  if$
}

FUNCTION {output.parentheses}
{ duplicate$ empty$
    'pop$
    { 's :=
      is.kanji.entry
        { "（" * s * "）" * }
        { duplicate$ empty$
            { pop$ "(" }
            { " (" * }
          if$
          s * ")" *
        }
      if$
    }
  if$
}

FUNCTION {output.bibitem}
{ newline$
  "\bibitem{" write$
  cite$ write$
  "}" write$
  newline$
  ""
}

FUNCTION {fin.entry}
{ write$ newline$ }

FUNCTION {format.names}
{ 's :=
  #1 'nameptr :=
  s num.names$ 'numnames :=
  numnames 'namesleft :=
  { namesleft #0 > }
  { s nameptr "{ff}{ll}" format.name$ is.kanji.str$
      { s nameptr "{ff}{ll}" format.name$ 't := }
      { s nameptr "{f. }{vv }{ll}{, jj}" format.name$ 't := }
    if$
    nameptr #1 >
      { s is.kanji.str$
          { "，" * t * }
          { namesleft #1 =
              { " and " * t * }
              { ", " * t * }
            if$
          }
        if$
      }
      't
    if$
    nameptr #1 + 'nameptr :=
    namesleft #1 - 'namesleft :=
  }
  while$
}

FUNCTION {format.authors}
{ author empty$ { "" } { author format.names } if$ }

FUNCTION {format.book.authors}
{ author empty$
    { editor empty$ { "" } { editor format.names } if$ }
    'format.authors
  if$
}

FUNCTION {format.volume}
{ volume empty$
    { "" }
    { "\textbf{" volume * "}" *
      number empty$ 'skip$ { "-" * number * } if$
    }
  if$
}

FUNCTION {n.dashify}
{ 't :=
  ""
  { t empty$ not }
  { t #1 #1 substring$ "-" =
      { "/" *
        { t #1 #1 substring$ "-" = }
        { t #2 global.max$ substring$ 't := }
        while$
      }
      { t #1 #1 substring$ *
        t #2 global.max$ substring$ 't :=
      }
    if$
  }
  while$
}

FUNCTION {format.pages}
{ pages empty$ { "" } { pages n.dashify } if$ }

FUNCTION {format.url}
{ url empty$ { "" } { "\url{" url * "}" * } if$ }

FUNCTION {article}
{ output.bibitem
  format.authors "author" output.check
  output.title
  journal "journal" output.check
  format.volume output
  format.pages output
  year output.parentheses
  fin.entry
}

FUNCTION {book}
{ output.bibitem
  format.book.authors output
  output.title
  format.pages output
  publisher output
  year output.parentheses
  fin.entry
}

FUNCTION {inproceedings}
{ output.bibitem
  format.authors "author" output.check
  output.title
  booktitle "booktitle" output.check
  format.volume output
  format.pages output
  year output.parentheses
  fin.entry
}

FUNCTION {misc}
{ output.bibitem
  format.authors output
  output.title
  format.url output
  note output.parentheses
  fin.entry
}

FUNCTION {techreport}
{ output.bibitem
  format.authors "author" output.check
  output.title
  format.pages output
  institution output
  year output.parentheses
  fin.entry
}

FUNCTION {mastersthesis}
{ output.bibitem
  format.authors "author" output.check
  output.title
  format.pages output
  school output
  year output.parentheses
  fin.entry
}

FUNCTION {phdthesis} { mastersthesis }
FUNCTION {incollection} { inproceedings }
FUNCTION {conference} { inproceedings }
FUNCTION {inbook} { book }

FUNCTION {manual}
{ output.bibitem
  format.book.authors output
  output.title
  format.pages output
  publisher empty$ { organization output } { publisher output } if$
  year output.parentheses
  fin.entry
}

FUNCTION {booklet}
{ output.bibitem
  format.authors output
  output.title
  format.pages output
  howpublished output
  year output.parentheses
  fin.entry
}

FUNCTION {proceedings}
{ output.bibitem
  editor empty$ { organization output } { editor format.names output } if$
  output.title
  format.volume output
  format.pages output
  publisher output
  year output.parentheses
  fin.entry
}

FUNCTION {unpublished}
{ output.bibitem
  format.authors output
  output.title
  note output
  year output.parentheses
  fin.entry
}

FUNCTION {default.type} { misc }

MACRO {jan} {"January"}
MACRO {feb} {"February"}
MACRO {mar} {"March"}
MACRO {apr} {"April"}
MACRO {may} {"May"}
MACRO {jun} {"June"}
MACRO {jul} {"July"}
MACRO {aug} {"August"}
MACRO {sep} {"September"}
MACRO {oct} {"October"}
MACRO {nov} {"November"}
MACRO {dec} {"December"}


MACRO {acmcs} {"ACM Computing Surveys"}
MACRO {acta} {"Acta Informatica"}
MACRO {cacm} {"Communications of the ACM"}
MACRO {ibmjrd} {"IBM Journal of Research and Development"}
MACRO {ibmsj} {"IBM Systems Journal"}
MACRO {ieeese} {"IEEE Transactions on Software Engineering"}
MACRO {ieeetc} {"IEEE Transactions on Computers"}
MACRO {ieeetcad}
 {"IEEE Transactions on Computer-Aided Design of Integrated Circuits"}
MACRO {ipl} {"Information Processing Letters"}
MACRO {jacm} {"Journal of the ACM"}
MACRO {jcss} {"Journal of Computer and System Sciences"}
MACRO {scp} {"Science of Computer Programming"}
MACRO {sicomp} {"SIAM Journal on Computing"}
MACRO {tocs} {"ACM Transactions on Computer Systems"}
MACRO {tods} {"ACM Transactions on Database Systems"}
MACRO {tog} {"ACM Transactions on Graphics"}
MACRO {toms} {"ACM Transactions on Mathematical Software"}
MACRO {toois} {"ACM Transactions on Office Information Systems"}
MACRO {toplas} {"ACM Transactions on Programming Languages and Systems"}
MACRO {tcs} {"Theoretical Computer Science"}
MACRO {tieice} {"電子情報通信学会論文誌"}
MACRO {tipsj}  {"情報処理学会論文誌"}
MACRO {jipsj}  {"Journal of Informatin Processing Society of Japan"}
MACRO {jorsj}  {"Journal of the Operations Research Society of Japan"}

READ
FUNCTION {set.is.kanji.entry}
{
  author    field.or.null is.kanji.str$
  title     field.or.null is.kanji.str$ or
  'is.kanji.entry :=
}
ITERATE {set.is.kanji.entry}






STRINGS { longest.label }
INTEGERS { number.label longest.label.width }
FUNCTION {initialize.longest.label}
{ "" 'longest.label :=
  #1 'number.label :=
  #0 'longest.label.width :=
}
FUNCTION {longest.label.pass}
{ number.label int.to.str$ 'label :=
  number.label #1 + 'number.label :=
  label width$ longest.label.width >
    { label 'longest.label :=
      label width$ 'longest.label.width :=
    }
    'skip$
  if$
}
EXECUTE {initialize.longest.label}
ITERATE {longest.label.pass}

FUNCTION {begin.bib}

{ preamble$ empty$

    'skip$
    { preamble$ write$ newline$ }
  if$
  "\begin{thebibliography}{"  longest.label  * "}" * write$ newline$
}
EXECUTE {begin.bib}
ITERATE {call.type$}
FUNCTION {end.bib}
{ newline$
  "\end{thebibliography}" write$ newline$
}
EXECUTE {end.bib}

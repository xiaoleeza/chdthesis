%%
%% This is file `chinathesis.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% chinathesis.dtx  (with options: `class')
%% 
%% Copyright (C) 2015-2018 by Zeping Lee <zepinglee AT gmail.com>
%% 
%% This file may be distributed and/or modified under the
%% conditions of the LaTeX Project Public License, either version 1.3c
%% of this license or (at your option) any later version.
%% The latest version of this license is in
%%    https://www.latex-project.org/lppl.txt
%% and version 1.3c or later is part of all distributions of LaTeX
%% version 2005/12/01 or later.
%% 
\NeedsTeXFormat{LaTeX2e}[1999/12/01]
\ProvidesClass{chinathesis}
  [2018/10/27 v1.0 A template framework for Chinese dissertations]
\newif\ifustc@doctor
\newif\ifustc@master
\newif\ifustc@bachelor
\newif\ifustc@chinese
\newif\ifustc@numerical
\newif\ifustc@super
\newif\ifustc@pdf
\DeclareOption{doctor}{\ustc@doctortrue\ustc@masterfalse\ustc@bachelorfalse}
\DeclareOption{master}{\ustc@doctorfalse\ustc@mastertrue\ustc@bachelorfalse}
\DeclareOption{bachelor}{\ustc@doctorfalse\ustc@masterfalse\ustc@bachelortrue}
\DeclareOption{chinese}{\ustc@chinesetrue}
\DeclareOption{english}{\ustc@chinesefalse}
\DeclareOption{print}{\ustc@pdffalse}
\DeclareOption{pdf}{\ustc@pdftrue}
\DeclareOption{super}{\ustc@numericaltrue\ustc@supertrue}
\DeclareOption{numbers}{\ustc@numericaltrue\ustc@superfalse}
\DeclareOption{authoryear}{\ustc@numericalfalse}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{ctexbook}}
\ExecuteOptions{doctor,chinese,print,super}
\ProcessOptions\relax
\ifustc@chinese
  \PassOptionsToClass{scheme=chinese}{ctexbook}
\else
  \PassOptionsToClass{scheme=plain}{ctexbook}
\fi

\PassOptionsToPackage{quiet}{xeCJK}
\LoadClass[UTF8,a4paper,openright,zihao=-4]{ctexbook}[2016/05/16]
\@ifclasslater{ctexbook}{2016/05/16}{}{
  \ClassError{chinathesis}{%
    This template requires TeX Live\MessageBreak 2016 or later version}{}
}
\RequirePackage{amsmath}
\RequirePackage{unicode-math}
\RequirePackage{geometry}
\RequirePackage{graphicx}
\RequirePackage{titletoc}
\RequirePackage{caption}
\RequirePackage[perpage]{footmisc}
\RequirePackage{url}
\RequirePackage{calc}
\RequirePackage{amsthm}
\ifustc@numerical
  \PassOptionsToPackage{sort&compress}{natbib}
\fi
\RequirePackage{natbib}
\newcommand\ustc@strifeq{\csname str_if_eq_x:nnTF\endcsname}
\newcommand\ustc@fontset{\csname g__ctex_fontset_tl\endcsname}
\ustc@strifeq{\ustc@fontset}{fandol}{
  \setmainfont[
    Extension      = .otf,
    UprightFont    = *-regular,
    BoldFont       = *-bold,
    ItalicFont     = *-italic,
    BoldItalicFont = *-bolditalic,
  ]{texgyretermes}
  \setsansfont[
    Extension      = .otf,
    UprightFont    = *-regular,
    BoldFont       = *-bold,
    ItalicFont     = *-italic,
    BoldItalicFont = *-bolditalic,
  ]{texgyreheros}
  \setmonofont[
    Extension      = .otf,
    UprightFont    = *-regular,
    BoldFont       = *-bold,
    ItalicFont     = *-italic,
    BoldItalicFont = *-bolditalic,
    Scale          = MatchLowercase,
  ]{texgyrecursor}
  \ClassWarningNoLine{chinathesis}{%
    You are using Fandol font family.\MessageBreak
    Some glyphs may be missing.\MessageBreak
    Please switch to a high-quality font set
  }
}{
  \setmainfont{Times New Roman}
  \setsansfont{Arial}
  \ustc@strifeq{\ustc@fontset}{mac}{
    \setmonofont[Scale=MatchLowercase]{Menlo}
  }{
    \setmonofont[Scale=MatchLowercase]{Courier New}
  }
}
\ustc@strifeq{\ustc@fontset}{mac}{
  \setCJKmainfont[
       UprightFont = * Light,
          BoldFont = * Bold,
        ItalicFont = Kaiti SC,
    BoldItalicFont = Kaiti SC Bold,
  ]{Songti SC}
  \setCJKsansfont[BoldFont=* Medium]{Heiti SC}
  \setCJKfamilyfont{zhsong}[
       UprightFont = * Light,
          BoldFont = * Bold,
  ]{Songti SC}
  \setCJKfamilyfont{zhhei}[BoldFont=* Medium]{Heiti SC}
  \setCJKfamilyfont{zhkai}[BoldFont=* Bold]{Kaiti SC}
  \xeCJKsetwidth{‘’“”}{1em}
}{
  \xeCJKsetup{EmboldenFactor=2}
  \ustc@strifeq{\ustc@fontset}{windows}{
    \IfFileExists{C:/bootfont.bin}{
      \setCJKmainfont[AutoFakeBold,ItalicFont=KaiTi_GB2312]{SimSun}
      \setCJKfamilyfont{zhkai}[AutoFakeBold]{KaiTi_GB2312}
      \setCJKfamilyfont{cusong}{STZhongsong}
      %\newcommand{\cusong}{\CJKfamily{cusong}} 
    }{
      \setCJKmainfont[AutoFakeBold,ItalicFont=KaiTi]{SimSun}
      \setCJKfamilyfont{zhkai}[AutoFakeBold]{KaiTi}
      \setCJKfamilyfont{cusong}{STZhongsong}
      %\newcommand{\cusong}{\CJKfamily{cusong}} 
    }
    \setCJKsansfont[AutoFakeBold]{SimHei}
    \setCJKfamilyfont{zhsong}[AutoFakeBold]{SimSun}
    \setCJKfamilyfont{zhhei}{SimHei}
    \setCJKfamilyfont{cusong}{STZhongsong}
    %\newcommand{\cusong}{\CJKfamily{cusong}} 
  }{
    \ustc@strifeq{\ustc@fontset}{adobe}{
      \setCJKmainfont[
        AutoFakeBold = true,
        ItalicFont   = AdobeKaitiStd-Regular,
      ]{AdobeSongStd-Light}
      \setCJKsansfont[AutoFakeBold]{AdobeHeitiStd-Regular}
      \setCJKfamilyfont{zhsong}[AutoFakeBold]{AdobeSongStd-Light}
      \setCJKfamilyfont{zhhei}[AutoFakeBold]{AdobeHeitiStd-Regular}
      \setCJKfamilyfont{zhkai}[AutoFakeBold]{AdobeKaitiStd-Regular}
    }{}
  }
}
\unimathsetup{
  math-style = ISO,
  bold-style = ISO,
  nabla      = upright,
  partial    = upright,
}
\newif\ifustc@stixtwo
\newif\ifustc@xitsnew
\@ifpackagelater{fontspec}{2017/01/20}{
  \IfFontExistsTF{STIX2Math.otf}{
    \ustc@stixtwotrue
  }{}
  \IfFontExistsTF{XITS-Regular.otf}{
    \ustc@xitsnewtrue
  }{}
}{}
\ifustc@stixtwo
  \setmathfont[StylisticSet=8]{STIX2Math.otf}
  \setmathfont[range={scr,bfscr},StylisticSet=1]{STIX2Math.otf}
  \ifustc@xitsnew
    \setmathfont[range={\partial,\lbrace,\rbrace}]{XITSMath-Regular.otf}
  \else
    \setmathfont[range={\partial,\lbrace,\rbrace}]{xits-math.otf}
  \fi
\else
  \ifustc@xitsnew
    \setmathfont[
      Extension    = .otf,
      BoldFont     = XITSMath-Bold,
      StylisticSet = 8,
    ]{XITSMath-Regular}
    \setmathfont[range={cal,bfcal},StylisticSet=1]{XITSMath-Regular.otf}
  \else
    \setmathfont[
      Extension    = .otf,
      BoldFont     = *bold,
      StylisticSet = 8,
    ]{xits-math}
    \setmathfont[range={cal,bfcal},StylisticSet=1]{xits-math.otf}
  \fi
\fi
\ustc@strifeq{\ustc@fontset}{mac}{
  \newfontfamily\ustc@circlefont{Songti SC Light}
}{
  \ustc@strifeq{\ustc@fontset}{windows}{
    \newfontfamily\ustc@circlefont{SimSun}
  }{
    \ifustc@xitsnew
      \newfontfamily\ustc@circlefont{XITS-Regular.otf}
    \else
      \newfontfamily\ustc@circlefont{xits-regular.otf}
    \fi
  }
}
\newdimen\bp@
\bp@=1bp
\renewcommand\normalsize{%
  \@setfontsize\normalsize{12\bp@}{24\bp@}%
  \abovedisplayskip 12\bp@ \@plus3\bp@ \@minus7\bp@
  \abovedisplayshortskip \z@ \@plus3\bp@
  \belowdisplayshortskip 6.5\bp@ \@plus3.5\bp@ \@minus3\bp@
  \belowdisplayskip \abovedisplayskip
  \let\@listi\@listI}
\normalsize
\renewcommand\small{%
  \@setfontsize\small{10.5\bp@}{17.5\bp@}%
  \abovedisplayskip 10.5\bp@ \@plus3\bp@ \@minus6\bp@
  \abovedisplayshortskip \z@ \@plus3\bp@
  \belowdisplayshortskip 6.5\bp@ \@plus3.5\bp@ \@minus3\bp@
  \belowdisplayskip \abovedisplayskip
}
\renewcommand\footnotesize{%
  \@setfontsize\footnotesize{9\bp@}{15\bp@}%
  \abovedisplayskip 9\bp@ \@plus2\bp@ \@minus5\bp@
  \abovedisplayshortskip \z@ \@plus3\bp@
  \belowdisplayshortskip 6\bp@ \@plus3\bp@ \@minus3\bp@
  \belowdisplayskip \abovedisplayskip
}
\renewcommand\scriptsize{\@setfontsize\scriptsize{7.5\bp@}{12.5\bp@}}
\renewcommand\tiny{\@setfontsize\tiny{6.5\bp@}{10.83\bp@}}
\renewcommand\large{\@setfontsize\large{15\bp@}{25\bp@}}
\renewcommand\Large{\@setfontsize\Large{18\bp@}{30\bp@}}
\renewcommand\LARGE{\@setfontsize\LARGE{22\bp@}{36.67\bp@}}
\renewcommand\huge{\@setfontsize\huge{24\bp@}{40\bp@}}
\renewcommand\Huge{\@setfontsize\Huge{26\bp@}{43.33\bp@}}
\linespread{1}\selectfont
\newcommand\ustc@setchinese{%
  \xeCJKResetPunctClass
}
\newcommand\ustc@setenglish{%
  \xeCJKDeclareCharClass{HalfLeft}{"2018, "201C}%
  \xeCJKDeclareCharClass{HalfRight}{%
    "00B7, "2019, "201D, "2013, "2014, "2025, "2026, "2E3A%
  }%
}
\newcommand\ustc@setdefaultlanguage{%
  \ifustc@chinese
    \ustc@setchinese
  \else
    \ustc@setenglish
  \fi
}
\newcommand\ustc@universityname{长安大学}
\newcommand\ustc@enuniversityname{Chang'an University}
\ifustc@chinese
  \renewcommand\listfigurename{插图清单}
  \renewcommand\listtablename{表格清单}
  \newcommand\ustc@acknowledgementsname{致谢}
  \newcommand\ustc@publicationsname{攻读学位期间取得的研究成果}
  \newcommand\ustc@notationname{符号说明}
\else
  \renewcommand\figurename{Fig.}
  \newcommand\ustc@acknowledgementsname{Acknowledgements}
  \newcommand\ustc@publicationsname{Publications}
  \newcommand\ustc@notationname{Notation}
\fi
\geometry{
  paper      = a4paper,
  %vmargin    = 2.65cm, 
  top=26.5mm, 
  bottom=27.2mm,
  hmargin    = {3cm,2cm},
  headheight = 1.61cm, 
  headsep    = -0.49cm,
  footskip   = 0.79cm,
}
\newcommand\ustc@header@font{\fontsize{10.5\bp@}{12\bp@}\selectfont}
\newcommand\ustc@header{\leftmark}
\newcommand\ustc@right@header{长安大学%
\ifustc@doctor
  博士学位论文
\else
  \ifustc@master
    硕士学位论文
  \else
    学士学位论文
  \fi%
\fi%
}
\newcommand\ustc@head{%
  \vbox to\headheight{%
    \hfil\ustc@header@font\ustc@header\strut\hfil
    \hrule\@height 0.4\p@\@width\textwidth
    \vfil
  }%
}
\newcommand\ustc@right@head{%
  \vbox to\headheight{%
    \hfil\ustc@header@font\ustc@right@header\strut\hfil
    \hrule\@height 0.4\p@\@width\textwidth
    \vfil
  }%
}
\newcommand\ustc@foot{\hfil\ustc@header@font\thepage\hfil}
\ifustc@pdf
  \PassOptionsToClass{oneside}{book}
  \def\ps@plain{%
      \def\@oddhead{\ustc@head}%
      \def\@oddfoot{\ustc@foot}%
      \def\@evenhead{\ustc@right@head}
      \let\@evenfoot\@oddfoot
      \let\@mkboth\markboth
    }
  \def\cleardoublepage{\clearpage}   
\else
  \def\ps@plain{%
    \def\@oddhead{\ustc@head}%
    \def\@oddfoot{\ustc@foot}%
    \def\@evenhead{\ustc@right@head}
    \let\@evenfoot\@oddfoot
    \let\@mkboth\markboth
  }
  \def\cleardoublepage{\clearpage\if@twoside \ifodd\c@page\else
    \hbox{}\thispagestyle{empty}\newpage\if@twocolumn\hbox{}\newpage\fi\fi\fi}
\fi

\@ifclasslater{ctexbook}{2016/09/21}{
  \def\chaptermark#1{%
    \markboth{%
      \CTEXifname{\CTEXthechapter\CTEX@chapter@aftername}{}%
      \ustc@spacetitle{#1}%
    }{}%
  }
}{
  \def\chaptermark#1{%
    \markboth{%
      \ifnum \c@secnumdepth >\m@ne
        \if@mainmatter
          \ifodd\CTEX@chapter@numbering
            \CTEXthechapter\CTEX@chapter@aftername
          \fi
        \fi
      \fi
      \ustc@spacetitle{#1}%
    }{}%
  }
}
\let\sectionmark\@gobble
\pagestyle{plain}
\def\ps@none{}
\ctexset{chapter/pagestyle=none}

\renewcommand\frontmatter{%
  \cleardoublepage
  \@mainmatterfalse
  \pagenumbering{Roman}%
  \pagestyle{plain}%
}
\def\ustc@define@term#1#2{%
  \expandafter\gdef\csname #1\endcsname##1{%
    \expandafter\gdef\csname ustc@#1\endcsname{##1}%
  }%
  \csname #1\endcsname{#2}%
}
\ustc@define@term{title}{论文题目}
\ustc@define@term{classnumber}{TP396.4}
\ustc@define@term{studentid}{2019124000}
\ustc@define@term{author}{XXX}
\ustc@define@term{major}{XXX}
\ustc@define@term{supervisor}{XXX\quad 教授}
\ustc@define@term{cosupervisor}{}
\ustc@define@term{date}{\zhnumsetup{time=Chinese}\zhtoday}
\ustc@define@term{professionaltype}{专业学位类型}
\ustc@define@term{secretlevel}{}
\ustc@define@term{secretyear}{}
\ustc@define@term{entitle}{Title}
\ustc@define@term{enauthor}{XXX}
\ustc@define@term{enmajor}{XXX}
\ustc@define@term{ensupervisor}{Prof. XXX}
\ustc@define@term{encosupervisor}{}
\ustc@define@term{endate}{\CTEX@todayold}
\ustc@define@term{enprofessionaltype}{Professional degree type}
\ustc@define@term{ensecretlevel}{}
\ustc@define@term{keywords}{}
\ustc@define@term{enkeywords}{}
\ifustc@doctor
  \newcommand\ustc@thesisname{\CJKfamily{cusong}博\hspace{0.62cm}士\hspace{0.62cm}学\hspace{0.62cm}位\hspace{0.62cm}论\hspace{0.62cm}文}
  \newcommand\ustc@enthesisname{A Dissertation Submitted for the Degree of Doctor}
\else
  \ifustc@master
    \newcommand\ustc@thesisname{\CJKfamily{cusong}硕\hspace{0.62cm}士\hspace{0.62cm}学\hspace{0.62cm}位\hspace{0.62cm}论\hspace{0.62cm}文}
    \newcommand\ustc@enthesisname{A Dissertation Submitted for the Degree of Master}
  \else
    \newcommand\ustc@thesisname{学士学位论文}
    \newcommand\ustc@enthesisname{A dissertation for bachelor's degree}
  \fi
\fi
\newcommand\ustc@pdfbookmark{\@gobble}
\renewenvironment{titlepage}{%
  \cleardoublepage
  \if@twocolumn
    \@restonecoltrue\onecolumn
  \else
    \@restonecolfalse\newpage
  \fi
  \thispagestyle{empty}%
}{%
  \if@restonecol\twocolumn \else \newpage \fi
}
\usepackage{multirow}
\newcommand\ustc@makezhtitle{%
  \ustc@setchinese
  \begin{titlepage}%
    \ustc@pdfbookmark{封面}%
    {\centering\fontsize{14\bp@}{31\bp@}\selectfont
    \begin{tabular}{p{13.17cm}r}
    分类号:  \ustc@classnumber & \multirow{2}[0]{*}{\includegraphics[height=1.9cm]{figures/chdredlogo.eps}} \\
    10710-\ustc@studentid &  \\
    \end{tabular}}\\
    \vskip 1.1cm%
   \centering\includegraphics[width=5.41cm]{figures/name.jpg} \\
    \vskip 0.41cm%
    {\fontsize{45\bp@}{45\bp@}\selectfont
      \ustc@thesisname\par}%
    \vskip -0.11cm%
    \parbox[t][3.5cm][c]{\textwidth}{%
      \centering\fontsize{18\bp@}{18\bp@}\selectfont
      \ustc@title\par}\par
      {\fontsize{14\bp@}{31\bp@}\selectfont\ustc@author}\\
    \vskip 4.03cm%
    {\fontsize{14\bp@}{31\bp@}\selectfont
      \begin{tabular}{lp{8em}rp{8em}}
     导师姓名职称 & \multicolumn{3}{c}{\ustc@supervisor} \\\cline{2-4}    
     申请学位级别 &  \multicolumn{1}{c}{\ustc@professionaltype} &学科专业名称 &  \multicolumn{1}{c}{\ustc@major}\\\cline{2-2}\cline{4-4}
     论文提交日期 & \multicolumn{1}{c}{\ustc@date} & 论文答辩日期 &\multicolumn{1}{c}{\ustc@date} \\\cline{2-2}\cline{4-4}    
     学位授予单位 & \multicolumn{3}{c}{长安大学} \\\cline{2-4}    
     \end{tabular}\par}%
  \end{titlepage}%
  \ustc@setdefaultlanguage
}
\newcommand\ustc@supervisorline{%
  \ifx\ustc@encosupervisor\@empty
    Supervisor: \ustc@ensupervisor
  \else
    Supervisors: \ustc@ensupervisor, \ustc@encosupervisor
  \fi
}
\newcommand\ustc@makeentitle{%
  \ustc@setenglish
  \begin{titlepage}%
    \ustc@pdfbookmark{Title page}%
    \centering
    \vskip 1.18cm%
    \parbox[t][4.5cm][c]{\textwidth}{%
      \centering\rmfamily\bfseries\fontsize{18\bp@}{30\bp@}\selectfont
      \ustc@entitle\par}\par
    \vskip 2.14cm%
    {\rmfamily\fontsize{14\bp@}{30\bp@}\selectfont
      \ustc@enthesisname\par}%
    \vskip 3.64cm%
    {\rmfamily\bfseries\fontsize{15\bp@}{30\bp@}\selectfont
      \begin{tabular}{@{}ll@{}}%
        Candidate: & \ustc@enauthor \\[1.11cm]
       Supervisor: & \ustc@ensupervisor \\
      \end{tabular}\par}%
       \vskip 5.35cm%
      {\fontsize{15\bp@}{30\bp@}\selectfont \ustc@enuniversityname, Xi’an, China}
  \end{titlepage}%
  \ustc@setdefaultlanguage
}
\renewcommand\maketitle{%
  \pagenumbering{Alph}%
  \pagestyle{empty}%
  \ustc@makezhtitle
  \ustc@makeentitle
  \pagestyle{plain}%
}
\newcommand\ustc@originality{%
  \fontsize{14\bp@}{31\bp@}\selectfont 本人声明：本人所呈交的学位论文是在导师的指导下,独立进行研究工作所取%
  得的成果。除论文中已经注明引用的内容外，对论文的研究做出重要贡献的个%
  人和集体，均已在文中以明确方式标明。本论文中不包含任何未加明确注明的%
  其他个人或集体已经公开发表的成果。\par
  本声明的法律责任由本人承担。}
\newcommand\ustc@authorization{%
 \fontsize{14\bp@}{31\bp@}\selectfont 本人在导师指导下所完成的论文及相关的职务作品，知识产权归属学校。学校%
 享有以任何方式发表、复制、公开阅览、借阅以及申请专利等权利。本人离校%
 后发表或使用学位论文或与该论文直接相关的学术论文或成果时，署名单位仍%
 然为\ustc@universityname{}。\par
  （保密的论文在解密后应遵守此规定）}
\newcommand\ustc@underline[2][3.2cm]{\underline{\hb@xt@ #1{\hss#2\hss}}}
\newcommand\ustc@checkbox{%
  \makebox[\z@][l]{$\square$}%
  \raisebox{-0.2ex}{\hspace{0.1em}$\checkmark$}%
}
\newcommand\makestatement{%
  \begin{titlepage}%
    \ustc@pdfbookmark{原创性和授权使用声明}%
    \null
    \vskip -0.8cm% 
    {\centering\CJKfamily{cusong}\fontsize{18\bp@}{32\bp@}\selectfont
      \ustc@universityname{}论文独创性声明\par}%
    \vskip 0.33cm%
    \ustc@originality\par
    \vskip 1.3cm%
    {\centering\rmfamily\fontsize{14\bp@}{31\bp@}\selectfont
      \begin{tabular}{@{}ll@{}}%
        论文作者签名： \hspace{10em} & 年\hspace{2em}月\hspace{2em}日\hspace{2em}
      \end{tabular}\par}%
    \vskip 2.56cm%
    {\centering\CJKfamily{cusong}\fontsize{18\bp@}{32\bp@}\selectfont
      \ustc@universityname{}论文知识产权权属声明\par}%
    \vskip 0.33cm%
    \ustc@authorization\par
    \vskip 1.6cm%
    {\centering\rmfamily\fontsize{14\bp@}{31\bp@}\selectfont
      \begin{tabular}{@{}ll@{}}%
        论文作者签名： \hspace{10em} & 年\hspace{2em}月\hspace{2em}日\hspace{2em}\\[0.56cm]
       导师签名： & 年\hspace{2em}月\hspace{2em}日\hspace{2em} \\
      \end{tabular}\par}%
  \end{titlepage}%
}
\setcounter{secnumdepth}{5}
\newcount\ustc@titlelength
\DeclareRobustCommand\ustc@spacetitle[1]{%
  \ustc@titlelength=\csname str_count:N\endcsname{#1}%
  \begingroup
    \ifcase\ustc@titlelength
    \or%\or
%      \ziju{2}%
    \or
      \ziju{1}%
%    \or
%      \ziju{0.5}%
    \fi
    #1%
  \endgroup
}
\newcommand\ustc@textcircled[1]{%
  \ifnum\value{#1}<21\relax
    {\ustc@circlefont\symbol{\numexpr\value{#1} + "245F\relax}}%
  \else
    \ClassError{chinathesis}{Cannot display more than 10 footnotes}{}%
  \fi
}
\ctexset{
  chapter = {
    format      = \centering\CJKfamily{zhhei}\fontsize{16\bp@}{26.67\bp@}\selectfont,
    nameformat  = {},
    titleformat = \ustc@spacetitle,
    number      = \chinese{chapter},
    aftername   = \hspace{\ccwd},
  },
}
\@ifclasslater{ctexbook}{2016/09/21}{
  \ctexset{
    chapter = {
      beforeskip = 22\bp@,
      afterskip  = 22\bp@,
      fixskip    = true,
    },
  }
}{
  \ctexset{
    chapter = {
      beforeskip = -7\bp@,  % 24bp - 31bp
      afterskip  =  8\bp@,  % 18bp - 10bp
    },
  }
}
\ctexset{
  section = {
    format     = \CJKfamily{zhhei}\fontsize{14\bp@}{23.33\bp@}\selectfont,
    aftername  = \hspace{\ccwd},
    beforeskip = 10\bp@,
    afterskip  = 10\bp@,
  },
  subsection = {
    format     = \CJKfamily{zhhei}\fontsize{12\bp@}{22\bp@}\selectfont,
    aftername  = \hspace{\ccwd},
    %indent     = 2\ccwd,
    beforeskip = 3\bp@,
    afterskip  = 3\bp@,
  },
  subsubsection = {
    format     = \CJKfamily{zhhei}\fontsize{12\bp@}{22\bp@}\selectfont,
    number     = \arabic{subsubsection},
    aftername  = .\hspace{0.5\ccwd},
    %indent     = 2\ccwd,
    beforeskip = 3\bp@,
    afterskip  = 3\bp@,
  },
  paragraph = {
    format     = \rmfamily\fontsize{12\bp@}{20\bp@}\selectfont,
    number     = (\arabic{paragraph}),
    aftername  = \hspace{0.5\ccwd},
    indent     = 2\ccwd,
    beforeskip = \z@,
    afterskip  = \z@,
    runin      = false,
  },
  subparagraph = {
    format     = \rmfamily\fontsize{12\bp@}{20\bp@}\selectfont,
    number     = \ustc@textcircled{subparagraph},
    aftername  = \hspace{0.5\ccwd},
    indent     = 2\ccwd,
    beforeskip = \z@,
    afterskip  = \z@,
    runin      = false,
  },
}
\NewDocumentCommand\ustc@chapter{o m}{%
  \if@openright\cleardoublepage\else\clearpage\fi
  \IfValueTF{#1}{%
    \ustc@pdfbookmark{#1}%
    \chaptermark{#1}%
  }{%
    \ustc@pdfbookmark{#2}%
    \chaptermark{#2}%
  }%
  \chapter*{#2}}
\newenvironment{abstract}{%
  \ustc@setchinese
  \ustc@chapter{摘要}%
}{
  \par\null\par\noindent\hangindent=4\ccwd\relax
  \textbf{关键词}：\ustc@keywords
  \ustc@setdefaultlanguage
}
\newenvironment{enabstract}{%
  \@openrightfalse
  \ustc@setenglish
  \ustc@chapter{\rmfamily Abstract}%
  \@openrighttrue
}{
  \par\null\par\noindent\hangindent=5.3em\relax
  \textbf{Key Words}: \ustc@enkeywords
  \ustc@setdefaultlanguage
}
\renewcommand\tableofcontents{%
  \ustc@chapter{\contentsname}%
  \@starttoc{toc}%
}
\newcommand\ustc@leaders{\titlerule*[9\bp@]{\textperiodcentered}}
\titlecontents{chapter}
  [\z@]{\addvspace{6\bp@}\CJKfamily{zhhei}\fontsize{12\bp@}{24\bp@}\selectfont}
  {\contentspush{\thecontentslabel\unskip\hspace{\ccwd}}}{}
  {\fontsize{12\bp@}{24\bp@}\selectfont\ustc@leaders\contentspage}
\titlecontents{section}
  [\ccwd]{\fontsize{12\bp@}{24\bp@}\selectfont}
  {\contentspush{\thecontentslabel\hspace{\ccwd}}}{}
  {\fontsize{12\bp@}{24\bp@}\selectfont\ustc@leaders\contentspage}
\titlecontents{subsection}
  [2\ccwd]{\fontsize{12\bp@}{24\bp@}\selectfont}
  {\contentspush{\thecontentslabel\hspace{\ccwd}}}{}
  {\fontsize{12\bp@}{24\bp@}\selectfont\ustc@leaders\contentspage}
\renewcommand\listoffigures{%
  \ustc@chapter{\listfigurename}%
  \@starttoc{lof}%
}
\titlecontents{figure}
  [2.3em]{\normalsize}
  {\contentslabel{2.3em}}{}
  {\ustc@leaders\contentspage}
\renewcommand\listoftables{%
  \ustc@chapter{\listtablename}%
  \@starttoc{lot}%
}
\titlecontents{table}
  [2.3em]{\normalsize}
  {\contentslabel{2.3em}}{}
  {\ustc@leaders\contentspage}
\newenvironment{notation}{%
  \ustc@chapter{\ustc@notationname}%
}{}%
\newcommand*\notationlabel[1]{#1\hfil}%
\newenvironment{notationlist}[1]{%
  \list{}{%
    \itemsep 3pt%
    \labelwidth #1\relax%
    \labelsep 1em%
    \leftmargin\labelwidth
    \advance\leftmargin\labelsep
    \advance\leftmargin 3em%
    \rightmargin 3em%
    \let\makelabel\notationlabel
  }%
}{%
  \endlist
}
\setlength{\parskip}{0\p@ \@plus .2\p@}
\let\@afterindentfalse\@afterindenttrue
\@afterindenttrue
\urlstyle{same}
\def\UrlBreaks{%
  \do\/%
  \do\a\do\b\do\c\do\d\do\e\do\f\do\g\do\h\do\i\do\j\do\k\do\l%
     \do\m\do\n\do\o\do\p\do\q\do\r\do\s\do\t\do\u\do\v\do\w\do\x\do\y\do\z%
  \do\A\do\B\do\C\do\D\do\E\do\F\do\G\do\H\do\I\do\J\do\K\do\L%
     \do\M\do\N\do\O\do\P\do\Q\do\R\do\S\do\T\do\U\do\V\do\W\do\X\do\Y\do\Z%
  \do0\do1\do2\do3\do4\do5\do6\do7\do8\do9\do=\do/\do.\do:%
  \do\*\do\-\do\~\do\'\do\"\do\-}
\Urlmuskip=0mu plus 0.1mu
\renewcommand\thefootnote{\ustc@textcircled{footnote}}
\renewcommand\footnoterule{%
  \kern-3\p@
  \hrule\@width.25\textwidth
  \kern2.6\p@}
\renewcommand\@makefntext[1]{%
  \parindent 2\ccwd\relax
  \noindent
  \hb@xt@2\ccwd{\hss\@makefnmark}#1}
\setlength\partopsep{\z@}
\newcommand\ustc@nolistsep{%
  \parsep 0\p@ \@plus.2\p@
  \topsep 0\p@ \@plus.2\p@
  \itemsep0\p@ \@plus.2\p@
}
\def\@listi{\leftmargin\leftmargini
            \ustc@nolistsep}
\let\@listI\@listi
\@listi
\def\@listii {\leftmargin\leftmarginii
              \labelwidth\leftmarginii
              \advance\labelwidth-\labelsep
              \ustc@nolistsep}
\def\@listiii{\leftmargin\leftmarginiii
              \labelwidth\leftmarginiii
              \advance\labelwidth-\labelsep
              \ustc@nolistsep}
\renewcommand\topfraction{.85}
\renewcommand\bottomfraction{.7}
\renewcommand\textfraction{.15}
\renewcommand\floatpagefraction{.66}
\renewcommand\dbltopfraction{.66}
\renewcommand\dblfloatpagefraction{.66}
\setcounter{topnumber}{9}
\setcounter{bottomnumber}{9}
\setcounter{totalnumber}{20}
\setcounter{dbltopnumber}{9}
\def\fps@figure{htb}
\def\fps@table{htb}
\DeclareCaptionLabelSeparator{zhspace}{\hspace{\ccwd}}
\captionsetup{
  format    = hang,
  font      = small,
  labelfont = bf,
  textfont = bf,
  labelsep  = zhspace,
}
\captionsetup[figure]{
  aboveskip = 6\bp@,
  belowskip = {12\bp@-\intextsep},
}
\captionsetup[table]{
  aboveskip = 6\bp@,
  belowskip = 6\bp@,
}
\newcommand\note[1]{%
  \begingroup
  \captionsetup{
    format        = plain,
    font          = small,
    justification = justified,
    margin        = 2\ccwd,
    position      = bottom,
  }%
  \caption*{#1}%
  \endgroup
}
\ifustc@chinese
  \def\mathellipsis{\cdots}
\fi
\protected\def\le{\leqslant}
\protected\def\ge{\geqslant}
\AtBeginDocument{%
  \renewcommand\leq{\leqslant}%
  \renewcommand\geq{\geqslant}%
}
\removenolimits{%
  \int\iint\iiint\iiiint\oint\oiint\oiiint
  \intclockwise\varointclockwise\ointctrclockwise\sumint
  \intbar\intBar\fint\cirfnint\awint\rppolint
  \scpolint\npolint\pointint\sqint\intlarhk\intx
  \intcap\intcup\upint\lowint
}
\AtBeginDocument{%
  \renewcommand\Re{\operatorname{Re}}%
  \renewcommand\Im{\operatorname{Im}}%
}
\AtBeginDocument{%
  \renewcommand\nabla{\mbfnabla}%
}
\newcommand\bm{\symbf}
\renewcommand\boldsymbol{\symbf}
\newcommand\square{\mdlgwhtsquare}
\newcommand\upe{\symup{e}}
\newcommand\upi{\symup{i}}
\newcommand\dif{\mathop{}\!\mathrm{d}}
\DeclareMathOperator*{\argmax}{arg\,max}
\DeclareMathOperator*{\argmin}{arg\,min}
\newcommand\bibstyle@super{\bibpunct{[}{]}{,}{s}{,}{\textsuperscript{,}}}
\newcommand\bibstyle@numbers{\bibpunct{[}{]}{,}{n}{,}{,}}
\newcommand\bibstyle@authoryear{\bibpunct{(}{)}{;}{a}{,}{,}}
\ifustc@numerical
  \ifustc@super
    \citestyle{super}
  \else
    \citestyle{numbers}
  \fi
  \bibliographystyle{chinathesis-numerical}
\else
  \citestyle{authoryear}
  \bibliographystyle{chinathesis-authoryear}
\fi
\newcommand\ustc@patchcmd{\csname ctex_patch_cmd:Nnn\endcsname}
\ustc@patchcmd{\NAT@citexnum}{%
  \@ifnum{\NAT@ctype=\z@}{%
    \if*#2*\else\NAT@cmt#2\fi
  }{}%
  \NAT@mbox{\NAT@@close}%
}{%
  \NAT@mbox{\NAT@@close}%
  \@ifnum{\NAT@ctype=\z@}{%
    \if*#2*\else\textsuperscript{#2}\fi
  }{}%
}
\renewcommand\NAT@citesuper[3]{\ifNAT@swa
\if*#2*\else#2\NAT@spacechar\fi
\unskip\kern\p@\textsuperscript{\NAT@@open#1\NAT@@close\if*#3*\else#3\fi}%
   \else #1\fi\endgroup}
\renewcommand\NAT@citenum%
    [3]{\ifNAT@swa\NAT@@open\if*#2*\else#2\NAT@spacechar\fi
        #1\NAT@@close\if*#3*\else\textsuperscript{#3}\fi\else#1\fi\endgroup}
\ustc@patchcmd{\NAT@citex}{%
  \if*#2*\else\NAT@cmt#2\fi
  \if\relax\NAT@date\relax\else\NAT@@close\fi
}{%
  \if\relax\NAT@date\relax\else\NAT@@close\fi
  \if*#2*\else\textsuperscript{#2}\fi
}
\renewcommand\NAT@cite%
    [3]{\ifNAT@swa\NAT@@open\if*#2*\else#2\NAT@spacechar\fi
        #1\NAT@@close\if*#3*\else\textsuperscript{#3}\fi\else#1\fi\endgroup}
\ustc@patchcmd{\NAT@citexnum}{%
  \ifx\NAT@last@yr\relax
    \def@NAT@last@yr{\@citea}%
  \else
    \def@NAT@last@yr{--\NAT@penalty}%
  \fi
}{%
  \def@NAT@last@yr{-\NAT@penalty}%
}
\DeclareRobustCommand\inlinecite{\@inlinecite}
\def\@inlinecite#1{\begingroup\let\@cite\NAT@citenum\citep{#1}\endgroup}
\renewcommand\bibfont{\fontsize{10.5\bp@}{20\bp@}\selectfont}
\setlength{\bibsep}{0\p@ \@plus.2\p@}
\setlength{\bibhang}{2\ccwd}
\renewcommand\@biblabel[1]{[#1]\hfill}
\renewcommand\bibsection{%
  \@mainmatterfalse
  \chapter{\bibname}%
  \@mainmattertrue
}
\newenvironment{acknowledgements}{%
  \chapter{\ustc@acknowledgementsname}%
}{}
\newenvironment{publications}{\chapter{\ustc@publicationsname}}{}
\newcommand\ustc@atendpackage{\csname ctex_at_end_package:nn\endcsname}
\ustc@atendpackage{hyperref}{
  \hypersetup{
    bookmarksnumbered  = true,
    bookmarksopen      = true,
    bookmarksopenlevel = 1,
    linktoc            = all,
  }
  \ifustc@pdf
    \hypersetup{
      %colorlinks = true,
      %allcolors  = blue,
	  hidelinks
    }
  \else
    \hypersetup{hidelinks}
  \fi
  \AtBeginDocument{%
    \ifustc@chinese
      \hypersetup{
        pdftitle  = \ustc@title,
        pdfauthor = \ustc@author,
      }%
    \else
      \hypersetup{
        pdftitle  = \ustc@entitle,
        pdfauthor = \ustc@enauthor,
      }%
    \fi
  }
  \newcounter{ustc@bookmarknumber}
  \renewcommand\ustc@pdfbookmark[1]{%
    \phantomsection
    \stepcounter{ustc@bookmarknumber}%
    \pdfbookmark[0]{#1}{ustcchapter.\theustc@bookmarknumber}%
  }
  \pdfstringdefDisableCommands{
    \let\\\@empty
    \let\hspace\@gobble
  }
  \ifustc@chinese
    \def\equationautorefname~#1\null{公式~(#1)\null}
    \def\footnoteautorefname{脚注}
    \def\itemautorefname~#1\null{第~#1~项\null}
    \def\figureautorefname{图}
    \def\tableautorefname{表}
    \def\partautorefname~#1\null{第~#1~部分\null}
    \def\appendixautorefname{附录}
    \def\chapterautorefname~#1\null{第~#1~章\null}
    \def\sectionautorefname~#1\null{第~#1~节\null}
    \def\subsectionautorefname~#1\null{第~#1~小节\null}
    \def\subsubsectionautorefname~#1\null{第~#1~小小节\null}
    \def\paragraphautorefname~#1\null{第~#1~段\null}
    \def\subparagraphautorefname~#1\null{第~#1~小段\null}
    \def\theoremautorefname{定理}
    \def\HyRef@autopageref#1{\hyperref[{#1}]{第~\pageref*{#1} 页}}
  \fi
}
\ustc@atendpackage{amsthm}{
  \newtheoremstyle{ustcplain}
    {}{}
    {}{2\ccwd}
    {\bfseries}{}
    {\ccwd}{}
  \theoremstyle{ustcplain}
  \ifustc@chinese
    \newcommand\ustc@assertionname{断言}
    \newcommand\ustc@axiomname{公理}
    \newcommand\ustc@corollaryname{推论}
    \newcommand\ustc@definitionname{定义}
    \newcommand\ustc@examplename{例}
    \newcommand\ustc@lemmaname{引理}
    \newcommand\ustc@proofname{证明}
    \newcommand\ustc@propositionname{命题}
    \newcommand\ustc@remarkname{注}
    \newcommand\ustc@theoremname{定理}
  \else
    \newcommand\ustc@assertionname{Assertion}
    \newcommand\ustc@axiomname{Axiom}
    \newcommand\ustc@corollaryname{Corollary}
    \newcommand\ustc@definitionname{Definition}
    \newcommand\ustc@examplename{Example}
    \newcommand\ustc@lemmaname{Lemma}
    \newcommand\ustc@proofname{Proof}
    \newcommand\ustc@propositionname{Proposition}
    \newcommand\ustc@remarkname{Remark}
    \newcommand\ustc@theoremname{Theorem}
  \fi
  \newtheorem{theorem}                {\ustc@theoremname}     [chapter]
  \newtheorem{assertion}  [theorem]   {\ustc@assertionname}
  \newtheorem{axiom}      [theorem]   {\ustc@axiomname}
  \newtheorem{corollary}  [theorem]   {\ustc@corollaryname}
  \newtheorem{lemma}      [theorem]   {\ustc@lemmaname}
  \newtheorem{proposition}[theorem]   {\ustc@propositionname}
  \newtheorem{definition}             {\ustc@definitionname}  [chapter]
  \newtheorem{example}                {\ustc@examplename}     [chapter]
  \newtheorem*{remark}                {\ustc@remarkname}
  \renewenvironment{proof}[1][\proofname]{\par
    \pushQED{\qed}%
    \normalfont \topsep6\p@\@plus6\p@\relax
    \trivlist
      \item\relax\hskip2\ccwd
      \textbf{#1}
      \hskip\ccwd\ignorespaces
    }{%
    \popQED\endtrivlist\@endpefalse
  }
  \renewcommand\proofname\ustc@proofname
}
\PassOptionsToPackage{algochapter}{algorithm2e}
\ustc@atendpackage{algorithm2e}{
  \ifustc@chinese
    \SetAlgorithmName{算法}{算法}{算法清单}
  \else
    \SetAlgorithmName{Algorithm}{Algorithm}{List of Algorithms}
  \fi
  \SetAlCapSkip{6\bp@}
  \SetAlCapFnt{\small}
  \SetAlCapNameFnt{\small}
  \SetAlgoCaptionSeparator{\unskip\hspace*{\ccwd}}
  \renewcommand\listofalgocfs{%
    \cleardoublepage
    \ustc@chapter{\listalgorithmcfname}%
    \@starttoc{loa}%
  }
  \titlecontents{algocf}
    [2.3em]{\normalsize}
    {\contentslabel{2.3em}}{}
    {\ustc@leaders\contentspage}
  \contentsuse{algocf}{loa}
}
\ustc@atendpackage{nomencl}{
  \let\nomname\ustc@notationname
  \def\thenomenclature{%
    \ustc@chapter{\ustc@notationname}%
    \nompreamble
    \list{}{%
      \labelwidth\nom@tempdim
      \leftmargin\labelwidth
      \advance\leftmargin\labelsep
      \itemsep\nomitemsep
      \let\makelabel\nomlabel}}
  \def\endthenomenclature{%
    \endlist
    \nompostamble
  }
}
\ustc@atendpackage{siunitx}{
  \sisetup{
    group-minimum-digits = 4,
    separate-uncertainty = true,
    inter-unit-product   = \ensuremath{{}\cdot{}},
  }
  \ifustc@chinese
    \sisetup{
      list-final-separator = { 和 },
      list-pair-separator  = { 和 },
      range-phrase         = {～},
    }
  \fi
}

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
%% TODO: 修改打印版封皮，修改表格字号
\NeedsTeXFormat{LaTeX2e}[1999/12/01]
\ProvidesClass{chinathesis}
  [2018/10/27 v1.0 A template framework for Chinese dissertations]
\newif\ifustc@doctor
\newif\ifustc@master
\newif\ifustc@profmaster
\newif\ifustc@bachelor
\newif\ifustc@chinese
\newif\ifustc@numerical
\newif\ifustc@super
\newif\ifustc@pdf
\DeclareOption{doctor}{\ustc@doctortrue\ustc@masterfalse\ustc@profmasterfalse\ustc@bachelorfalse}
\DeclareOption{master}{\ustc@doctorfalse\ustc@mastertrue\ustc@profmasterfalse\ustc@bachelorfalse}
\DeclareOption{profmaster}{\ustc@doctorfalse\ustc@masterfalse\ustc@profmastertrue\ustc@bachelorfalse}
\DeclareOption{bachelor}{\ustc@doctorfalse\ustc@masterfalse\ustc@profmasterfalse\ustc@bachelortrue}
\DeclareOption{chinese}{\ustc@chinesetrue}
\DeclareOption{english}{\ustc@chinesefalse}
\DeclareOption{print}{\ustc@pdffalse}
\DeclareOption{pdf}{\ustc@pdftrue}
\DeclareOption{super}{\ustc@numericaltrue\ustc@supertrue}
\DeclareOption{numbers}{\ustc@numericaltrue\ustc@superfalse}
\DeclareOption{authoryear}{\ustc@numericalfalse}

% 载入 \cls{ctexbook}。
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{ctexbook}}
\ExecuteOptions{doctor,chinese,print,super}
\ProcessOptions\relax


% \subsection{加载文档类和宏包}

\ifustc@chinese
  \PassOptionsToClass{scheme=chinese}{ctexbook}
\else
  \PassOptionsToClass{scheme=plain}{ctexbook}
\fi

\PassOptionsToPackage{quiet}{xeCJK}
% 载入 \cls{ctexbook} 文档类，注意要求为 2.4.9 或更高的版本。
\LoadClass[UTF8,a4paper,openright,zihao=-4]{ctexbook}[2016/05/16]
\@ifclasslater{ctexbook}{2016/05/16}{}{
  \ClassError{chinathesis}{%
    This template requires TeX Live\MessageBreak 2016 or later version}{}
}

% 建议在模板开始处载入全部宏包，不要轻易改变加载顺序。
% \pkg{hyperref} 一般在最后加载。
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
\newcommand\ustc@strifeq{\csname str_if_eq:eeTF\endcsname}
\newcommand\ustc@fontset{\csname g__ctex_fontset_tl\endcsname}


% \subsection{字体}

% 处理 \opt{fontset}
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

% 目前最广泛使用的印刷的长度单位点（磅）通常指 PostScript point
% \footnote{\url{https://en.wikipedia.org/wiki/Point_(typography)}}，
% 在 \LaTeX{} 中是 bp，比默认的 pt 略大。
% 这里保存起来可以节约编译时间。
\newdimen\bp@
\bp@=1bp

% 下面设置字号。正文字号12bp，研究生行距20bp，本科生行距22bp；
% 其他命令的行距按照相同的的比例设置，如表~\ref{tab:fontsize}。
% \begin{table}[htb]
%   \centering
%   \caption{标准字体命令与字号、行距的对应}
%   \label{tab:fontsize}
%   \begin{tabular}{lllll}
%     \toprule
%     字体命令          & 字号 & bp   & 研究生行距 & 本科生行距 \\
%     \midrule
%     \cs{tiny}         & 小六 & 6.5  & 10.83      & 11.92      \\
%     \cs{scriptsize}   & 六号 & 7.5  & 12.5       & 13.75      \\
%     \cs{footnotesize} & 小五 & 9    & 15         & 16.5       \\
%     \cs{small}        & 五号 & 10.5 & 17.5       & 19.25      \\
%     \cs{normalsize}   & 小四 & 12   & 20         & 22         \\
%     \cs{large}        & 小三 & 15   & 25         & 27.5       \\
%     \cs{Large}        & 小二 & 18   & 30         & 33         \\
%     \cs{LARGE}        & 二号 & 22   & 36.67      & 40.33      \\
%     \cs{huge}         & 小一 & 24   & 40         & 44         \\
%     \cs{Huge}         & 一号 & 26   & 43.33      & 47.67      \\
%     \bottomrule
%   \end{tabular}
% \end{table}
\renewcommand\normalsize{%
  \@setfontsize\normalsize{12\bp@}{24.46\bp@}%
  \abovedisplayskip 12\bp@ \@plus3\bp@ \@minus7\bp@
  \abovedisplayshortskip \z@ \@plus3\bp@
  \belowdisplayshortskip 6.5\bp@ \@plus3.5\bp@ \@minus3\bp@
  \belowdisplayskip \abovedisplayskip
  \let\@listi\@listI}
\normalsize
%
% 注意第~\ref{sec:list} 节去掉了列表的间距，所以不再修改 \cs{@listi}。
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

% 设置行距的倍数为 1。
\linespread{1}\selectfont


% \subsection{处理语言}

% 由于 Unicode 的一些标点符号是中西文混用的：
% \unicodechar{00B7}、
% \unicodechar{2013}、
% \unicodechar{2014}、
% \unicodechar{2018}、
% \unicodechar{2019}、
% \unicodechar{201C}、
% \unicodechar{201D}、
% \unicodechar{2025}、
% \unicodechar{2026}、
% \unicodechar{2E3A}，
% 所以要根据语言设置正确的字体。
% \footnote{\url{https://github.com/CTeX-org/ctex-kit/issues/389}}
% 所以要根据语言设置正确的字体。
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

% 这里设置了中英文的各种名字。

\newcommand\ustc@universityname{长安大学}
\newcommand\ustc@enuniversityname{Chang'an University}
\ifustc@chinese
  \renewcommand\listfigurename{插图清单}
  \renewcommand\listtablename{表格清单}
  \newcommand\ustc@acknowledgementsname{致谢}
  \newcommand\ustc@publicationsname{攻读学位期间取得的研究成果}
  \newcommand\ustc@notationname{符号说明}
  \newcommand\ustc@summaryname{结论与展望}
\else
  \renewcommand\figurename{Fig.}
  \newcommand\ustc@acknowledgementsname{Acknowledgements}
  \newcommand\ustc@publicationsname{Publications}
  \newcommand\ustc@notationname{Notation}
  \newcommand\ustc@summaryname{Summary}
\fi


% \subsection{纸张和页面}
% 使用 \pkg{geometry} 宏包设置纸张和页面。

% 纸张：A4；

% 页面设置：上、下 2.54 cm，左、右 3.17 cm，页眉 1.5 cm，页脚 1.75 cm。

% 注意这里指的是页眉顶部到纸张顶部的距离为 1.5 cm，
% 所以应该是 2.54cm - 0.8cm - 0.24cm = 1.5cm
% 此处值为实际测量

\geometry{
  paper      = a4paper,
  %vmargin    = 2.65cm, 
  top=26.5mm, 
  bottom=25.13mm,
  hmargin    = {3cm,2cm},
  headheight = 0.75cm, 
  headsep    = 0.29cm,
  footskip   = 1.00cm,
}

% 页眉页脚设计
\newcommand\ustc@header@font{\fontsize{10.5\bp@}{12\bp@}\selectfont}
\newcommand\ustc@header{\leftmark}
\newcommand\ustc@right@header{长安大学%
\ifustc@doctor
  博士学位论文
\else
  \ifustc@master
    硕士学位论文
  \else
    \ifustc@profmaster
    硕士学位论文
    \else
      学士学位论文
    \fi%
  \fi%
\fi%
}
\newcommand\ustc@head{%
  \vbox to\headheight{%
    \hfil\ustc@header@font\ustc@header\strut
    \vspace{2.1mm}
    \hrule\@height 0.4\p@\@width\textwidth\hfil
    \vfil
  }%
}
\newcommand\ustc@right@head{%
  \vbox to\headheight{%
    \hfil\ustc@header@font\ustc@right@header\strut
    \vspace{2.1mm}
    \hrule\@height 0.4\p@\@width\textwidth\hfil
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

% 每章第一页默认会设置特殊的 page style，我们希望它不改变页眉页脚，
% 所以定义一个 |none|。
\def\ps@none{}
\ctexset{chapter/pagestyle=none}

% 研究生要求从“中文摘要”开始页码用大写罗马数字，
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

% 定义一些常量。
\ustc@define@term{title}{论文题目}
\ustc@define@term{classnumber}{TP396.4}
\ustc@define@term{studentid}{2019124000}
\ustc@define@term{author}{XXX}
\ustc@define@term{major}{XXX}
\ustc@define@term{supervisor}{XXX\quad 教授}
\ustc@define@term{cosupervisor}{}
\ustc@define@term{submissiondate}{\zhnumsetup{time=Arabic}\zhtoday}
\ustc@define@term{defensedate}{\zhnumsetup{time=Arabic}\zhtoday}
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
\newcommand\@sbf[1]{\renewcommand{\CJKglue}{\hskip 0.79cm}\scalebox{0.8}[1]{#1}}
\newcommand\@sbfp[1]{\scalebox{0.8}[1]{#1}}
\ifustc@doctor
  \newcommand\ustc@thesisname{\CJKfamily{cusong}\@sbf{博士学位论文}}
  \newcommand\ustc@enthesisname{A Dissertation Submitted for the Degree of Doctor}
\else
  \ifustc@master
    \newcommand\ustc@thesisname{\CJKfamily{cusong}\@sbf{硕士学位论文}}
    \newcommand\ustc@enthesisname{A Thesis Submitted for the Degree of Master}
  \else
    \ifustc@profmaster
      \newcommand\ustc@thesisname{\CJKfamily{cusong}\@sbfp{专业硕士学位论文}}
      \newcommand\ustc@enthesisname{A Thesis Submitted for the Degree of Master}
    \else
      \newcommand\ustc@thesisname{学士学位论文}
      \newcommand\ustc@enthesisname{A dissertation for bachelor's degree}
    \fi
  \fi
\fi

% 添加 PDF 书签，在 \pkg{hyperref} 载入后才有效。
\newcommand\ustc@pdfbookmark{\@gobble}

% 重定义 \env{titlepage} 环境，不修改页码。
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

% 中文封面：
% 密级仿宋 14 磅；
% 论文类型黑体 56 磅；
% 论文题目黑体 26 磅加粗居中，单倍行距；
% 作者姓名宋体 16 磅，单倍行距；
% 注意这里的“单倍行距”的地方开启了“对齐到网格”，所以实际行距有所偏差，
% 所以只能使用直尺测量。
\usepackage{multirow}
\newcommand\ustc@makezhtitle{%
  \ustc@setchinese
  \begin{titlepage}%
    \ustc@pdfbookmark{封面}%
    {\centering\fontsize{14\bp@}{31\bp@}\selectfont
    \hspace{3mm}
    \begin{tabular}{p{12.42cm}r}
    分类号:  \ustc@classnumber & \multirow{2}{18mm}[-1.8mm]{\includegraphics[height=1.78cm]{figures/chdredlogo.eps}} \\
    10710-\ustc@studentid &  \\
    \end{tabular}}\\
    \vskip 1.1cm%
   \centering\includegraphics[width=5.41cm]{figures/name.jpg} \\
    \vskip 0.38cm%
    {\fontsize{45\bp@}{45\bp@}\selectfont
      \ustc@thesisname\par}%
    \vskip -0.11cm%
    \parbox[t][3.5cm][c]{\textwidth}{%
      \centering\fontsize{22\bp@}{22\bp@}\selectfont
      \ustc@title\par}\par
      {\fontsize{14\bp@}{31\bp@}\selectfont\ustc@author}\\
    \vskip 3.4cm%
    {\fontsize{14\bp@}{31\bp@}\selectfont
      \begin{tabular}{lp{8em}rp{8em}}
     导师姓名职称 & \multicolumn{3}{c}{\ustc@supervisor} \\\cline{2-4}    
     申请学位级别 &  \multicolumn{1}{c}{\ustc@professionaltype} &学科专业名称 &  \multicolumn{1}{c}{\ustc@major}\\\cline{2-2}\cline{4-4}
     论文提交日期 & \multicolumn{1}{c}{\ustc@submissiondate} & 论文答辩日期 &\multicolumn{1}{c}{\ustc@defensedate} \\\cline{2-2}\cline{4-4}    
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

% 英文封面
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

% 重新定义 \cs{maketitle}，调用 \cs{ustc@makezhtitle}, \cs{ustc@makeentitle}
% 分别生成中、英文封面。
\renewcommand\maketitle{%
  \ifustc@pdf%将打印版和pdf版封面边距分别设置
    \newgeometry{margin=2.54cm}%
    \else
    \newgeometry{left=3cm,right=2cm}%
  \fi
  \pagenumbering{Alph}%
  \pagestyle{empty}%
  \ustc@makezhtitle
  \ustc@makeentitle
  \restoregeometry
  \pagestyle{plain}%
}


% \subsection{原创性声明}

% 定义原创性声明
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
%
% 生成空的下划线
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


% \subsection{章节标题}

% 标题最多允许使用五级。
\setcounter{secnumdepth}{5}

% 研究生规定章题为两字时中间空两字，三字时空一字，四字时空半字，四字以上不空。
% 这里用 \LaTeX3 的 \cs{str\_count:N} 判断字数。
% 注意，\pkg{stringstrings} 宏包会导致范数命令 \verb+\|+ 被修改。
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

% 五级节标题和脚注需要使用带圈的数字，这里使用 \cs{ustc@circlefont} 
\newcommand\ustc@textcircled[1]{%
  \ifnum\value{#1}<21\relax
    {\ustc@circlefont\symbol{\numexpr\value{#1} + "245F\relax}}%
  \else
    \ClassError{chinathesis}{Cannot display more than 10 footnotes}{}%
  \fi
}

% 用 \pkg{ctex} 的接口设置全部章节标题格式。

% 各章标题：黑体 16 磅加粗居中，单倍行距，段前 24 磅，段后 18 磅，
% 章序号与章名间空一字。

% 由于 Word 模板中使用“单倍行距”，还“对齐到网格”，这在 TeX 中不容易实现。
% 所以目前按照默认的行距。

% 注意 \pkg{ctex} v2.4.3 以下版本的bug会导致章节标题前后的距离的实际值偏大。
% 另外 \pkg{ctex} v2.2 前的beforeskip的符号有特殊意义。
\ctexset{
  chapter = {
    format      = \centering\CJKfamily{zhhei}\fontsize{15.96\bp@}{26.67\bp@}\selectfont,
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

% 一级节标题：黑体 14 磅左顶格，单倍行距，段前 24 磅，段后 6 磅，
% 序号与题名间空一字。
\ctexset{
  section = {
    format     = \CJKfamily{zhhei}\fontsize{14\bp@}{23.33\bp@}\selectfont,
    aftername  = \hspace{\ccwd},
    beforeskip = 10\bp@,
    afterskip  = 10\bp@,
  },
  %
  % 二级节标题：黑体 12 磅，单倍行距，段前 12 磅，段后 6 磅，
  % 序号与题名间空一字。
  subsection = {
    format     = \CJKfamily{zhhei}\fontsize{12\bp@}{20\bp@}\selectfont,
    aftername  = \hspace{\ccwd},
    %indent     = 2\ccwd,
    beforeskip = 8\bp@,
    afterskip  = 3\bp@,
  },
  %
  % 三级及以下节标题的格式没有具体规定，按照 Word 模板的格式：
  % 使用黑体 12 磅，左缩进两字，行距 20 磅，段前段后 0 磅，序号与题名间空半字宽。
  % 序号使用全宽括号
  subsubsection = {
    format     = \CJKfamily{zhsong}\fontsize{12\bp@}{20\bp@}\selectfont,
    number     = （\arabic{subsubsection}）,
    aftername  = \hspace{0.5\ccwd},
    indent     = 2\ccwd,
    beforeskip = \z@,
    afterskip  = \z@,
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

% 默认的 \cs{chapter*} 生成的章标题没有编号、不更改页眉，
% 也不添加进目录或 PDF 书签。
% 然而像摘要、目录、符号说明这样的章节，它们不需要编号、不加入目录，
% 但是需要修改页眉，并且加入 PDF 标签。
% 所以我们新定义 \cs{ustc@chapter} 用于处理这些章节。%
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
  %
  %
  % \subsection{摘要}
  %
  % 中文摘要环境。
  % 判断 \cs{ustc@tocloaded} 是为了防止本科生未调整摘要位置时的目录页码缺失。
\newenvironment{abstract}{%
  \ustc@setchinese
  \ustc@chapter{摘要}%
}{
  \par\null\par\noindent\hangindent=4\ccwd\relax
  \textbf{关键词}：\ustc@keywords
  \ustc@setdefaultlanguage
}

% 英文摘要环境
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


% \subsection{目录}

% 研究生规定目录另面起；
\renewcommand\tableofcontents{%
  \ustc@chapter{\contentsname}%
  \@starttoc{toc}%
}

% 下面用 \pkg{titletoc} 宏包设置目录内容的格式。
% 先定义目录线：
\newcommand\ustc@leaders{\titlerule*[9\bp@]{\textperiodcentered}}

% 各章目录要求黑体 12 磅，单倍行距，段前 6 磅，段后 0 磅，两端对齐，
% 页码右对齐，章序号与章名间空一字。
% 但是 Word 模板中实际是行距 20 磅。

% 另外 \pkg{ctex} 在章目录的序号后加 |\hspace{.3em}|，所以用 \cs{unskip} 修正。
\titlecontents{chapter}
  [\z@]{\addvspace{6\bp@}\CJKfamily{zhhei}\fontsize{12\bp@}{24\bp@}\selectfont}
  {\contentspush{\thecontentslabel\unskip\hspace{\ccwd}}}{}
  {\fontsize{12\bp@}{24\bp@}\selectfont\ustc@leaders\contentspage}
%
% 一级节标题目录要求宋体 12 磅，单倍行距，左缩进一字，段前 6 磅，段后 0 磅，
% 两端对齐，页码右对齐，序号与题名间空一字。
% Word 模板中实际是行距 20 磅，段前 0 磅。
\titlecontents{section}
  [\ccwd]{\fontsize{12\bp@}{24\bp@}\selectfont}
  {\contentspush{\thecontentslabel\hspace{\ccwd}}}{}
  {\fontsize{12\bp@}{24\bp@}\selectfont\ustc@leaders\contentspage}
%
% 二级节标题目录要求宋体 12 磅，单倍行距，左缩进两字，段前 6 磅，段后 0 磅，
% 两端对齐，页码右对齐，序号与题名间空一字。
% Word 模板中实际是行距 20 磅，段前 0 磅。
\titlecontents{subsection}
  [2\ccwd]{\fontsize{12\bp@}{24\bp@}\selectfont}
  {\contentspush{\thecontentslabel\hspace{\ccwd}}}{}
  {\fontsize{12\bp@}{24\bp@}\selectfont\ustc@leaders\contentspage}

% 研究生要求图、表的清单须另页起。
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
  %
  %
  % \subsection{符号说明}
  %
  % 研究生规定符号说明另页起，标题字体字号等同论文正文，
  % 《撰写手册》第 9 页 1.10(2) 还规定“符号说明不加页码”。
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

% \subsection{正文}

% \cs{sloppy} 可以减少“overfull boxes”。
\sloppy

% 禁止扩大段间距。（\href{https://github.com/ustctug/ustcthesis/issues/209}{
%   ustctug/ustcthesis\#209}）
\raggedbottom

% 段间距 0 磅。
\setlength{\parskip}{\z@}

% 在 \opt{scheme=plain} 时也首段缩进。
\let\@afterindentfalse\@afterindenttrue
\@afterindenttrue

% URL 的字体设为保持原样。
\urlstyle{same}

% 使用 \pkg{xurl} 宏包的方法，增加 URL 可断行的位置。
\def\UrlBreaks{%
  \do\/%
  \do\a\do\b\do\c\do\d\do\e\do\f\do\g\do\h\do\i\do\j\do\k\do\l%
     \do\m\do\n\do\o\do\p\do\q\do\r\do\s\do\t\do\u\do\v\do\w\do\x\do\y\do\z%
  \do\A\do\B\do\C\do\D\do\E\do\F\do\G\do\H\do\I\do\J\do\K\do\L%
     \do\M\do\N\do\O\do\P\do\Q\do\R\do\S\do\T\do\U\do\V\do\W\do\X\do\Y\do\Z%
  \do0\do1\do2\do3\do4\do5\do6\do7\do8\do9\do=\do/\do.\do:%
  \do\*\do\-\do\~\do\'\do\"\do\-}
\Urlmuskip=0mu plus 0.1mu

% 脚注用带圈的数字：
\renewcommand\thefootnote{\ustc@textcircled{footnote}}

% LaTeX 默认脚注按章计数，即每章的开始才重置脚注计数器；我们修改为按页计数。
% 简单的|\@addtoreset{footnote}{page}|并不可靠，
% \footnote{\url{https://texfaq.org/FAQ-footnpp.html}}
% 所以我们使用 \pkg{footmisc} 宏包。

% 脚注线长为版心宽度的四分之一：
\renewcommand\footnoterule{%
  \kern-3\p@
  \hrule\@width.25\textwidth
  \kern2.6\p@}
  %
  % 注文缩进两字：
\renewcommand\@makefntext[1]{%
  \parindent 2\ccwd\relax
  \noindent
  \hb@xt@2\ccwd{\hss\@makefnmark}#1}


% \subsection{列表}
% \label{sec:list}

% 调整列表中各项之间过大的间距。
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

% \subsection{浮动体}

% \LaTeX{} 对放置浮动体的要求比较强，这里按照 UK TeX FAQ 的建议
% \footnote{\url{https://texfaq.org/FAQ-floats}} 对其适当放宽。
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

% 修改默认的浮动体描述符为 |htb|。
\def\fps@figure{htb}
\def\fps@table{htb}

% 用 \pkg{caption} 宏包设置图、表的格式：

% 图号、图题置于图的下方，宋体 10.5 磅居中，单倍行距，段前 6 磅，段后 12 磅，
% 图号与图题文字之间空一字，图号、图题加粗。
% 图注位于图的下方，左缩进两字，续行悬挂缩进左对齐，两端对齐。

% 表号、表题置于表的上方，宋体 10.5 磅居中，单倍行距，段前 6 磅，段后 6 磅，
% 表号与表题文字之间空一字，表号、表题加粗。
% 表注左缩进两字，续行悬挂缩进左对齐，两端对齐。
\setlength{\floatsep}{6\bp@}
\setlength{\textfloatsep}{6\bp@}
\setlength{\intextsep}{6\bp@}
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

% 新定义了 \cs{note} 来生成图表的附注。
% 如果用 \cs{caption} 生成图表的附注会导致图表的序号有误；
% 如果用 \cs{bicaption} 会导致表注无法置于表后，而且对齐方式不对。
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

% \subsection{数学符号}

% 根据中文的数学排印习惯进行设置：

% 省略号一律居中，所以 \cs{ldots} 不再居于底部。
\ifustc@chinese
  \def\mathellipsis{\cdots}
\fi

% 小于等于号、大于等于号要使用倾斜的字形。
\protected\def\le{\leqslant}
\protected\def\ge{\geqslant}
\AtBeginDocument{%
  \renewcommand\leq{\leqslant}%
  \renewcommand\geq{\geqslant}%
}

% 积分号的上下限默认置于上下两侧。
\removenolimits{%
  \int\iint\iiint\iiiint\oint\oiint\oiiint
  \intclockwise\varointclockwise\ointctrclockwise\sumint
  \intbar\intBar\fint\cirfnint\awint\rppolint
  \scpolint\npolint\pointint\sqint\intlarhk\intx
  \intcap\intcup\upint\lowint
}

% 实部、虚部操作符使用罗马体 $\mathrm{Re}$、$\mathrm{Im}$ 而不是 fraktur 体
% $\Re$、$\Im$。
\AtBeginDocument{%
  \renewcommand\Re{\operatorname{Re}}%
  \renewcommand\Im{\operatorname{Im}}%
}

% \cs{nabla} 使用粗正体。
\AtBeginDocument{%
  \renewcommand\nabla{\mbfnabla}%
}

\newcommand\bm{\symbf}
\renewcommand\boldsymbol{\symbf}

% 兼容 \pkg{amssymb} 中的命令。
\newcommand\square{\mdlgwhtsquare}

% 提供一些方便的命令：
\newcommand\upe{\symup{e}}
\newcommand\upi{\symup{i}}
\newcommand\dif{\mathop{}\!\mathrm{d}}
\DeclareMathOperator*{\argmax}{arg\,max}
\DeclareMathOperator*{\argmin}{arg\,min}


% \subsection{参考文献}

% 定义几种引用文献的标注法。
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

% 下面修改引用标注的格式，主要是将页码写在上标位置。
% Numerical 模式的 \cs{citet} 的页码：
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

% Numerical 模式的 \cs{citep} 的页码：
\renewcommand\NAT@citesuper[3]{\ifNAT@swa
\if*#2*\else#2\NAT@spacechar\fi
\unskip\kern\p@\textsuperscript{\NAT@@open#1\NAT@@close\if*#3*\else#3\fi}%
   \else #1\fi\endgroup}
\renewcommand\NAT@citenum%
    [3]{\ifNAT@swa\NAT@@open\if*#2*\else#2\NAT@spacechar\fi
        #1\NAT@@close\if*#3*\else\textsuperscript{#3}\fi\else#1\fi\endgroup}
        %
        % Author-year 模式的 \cs{citet} 的页码：
\ustc@patchcmd{\NAT@citex}{%
  \if*#2*\else\NAT@cmt#2\fi
  \if\relax\NAT@date\relax\else\NAT@@close\fi
}{%
  \if\relax\NAT@date\relax\else\NAT@@close\fi
  \if*#2*\else\textsuperscript{#2}\fi
}

% Author-year 模式的 \cs{citep} 的页码：
\renewcommand\NAT@cite%
    [3]{\ifNAT@swa\NAT@@open\if*#2*\else#2\NAT@spacechar\fi
        #1\NAT@@close\if*#3*\else\textsuperscript{#3}\fi\else#1\fi\endgroup}
        %
        % 在顺序编码制下，\pkg{natbib} 只有在三个以上连续文献引用才会使用连接号，
        % 这里修改为允许两个引用使用连接号。
        % \footnote{\url{https://tex.stackexchange.com/a/86991/82731}}
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

% 参考文献列表格式：宋体 10.5 磅，行距 20 磅，续行缩进两字，左对齐。
% 本科生依然是小四宋体。
\renewcommand\bibfont{\fontsize{10.5\bp@}{20\bp@}\selectfont}
\setlength{\bibsep}{0\p@ \@plus.2\p@}
\setlength{\bibhang}{2\ccwd}
\renewcommand\@biblabel[1]{[#1]\hfill}

% 为了将参考文献加入目录和 pdf 书签，重新定义 \pkg{natbib} 的 \cmd{bibsection}
\renewcommand\bibsection{%
  \@mainmatterfalse
  \chapter{\bibname}%
  \@mainmattertrue
}

% BibTeX 生成参考文献表的样式在 \file{bst} 文件中提供。


% \subsection{附录}

% 定义了一个满足要求的总结环境：
\newenvironment{summary}{%
  \chapter*{\ustc@summaryname}%
  \addcontentsline{toc}{chapter}{\ustc@summaryname}
  \markboth{\ustc@summaryname}{\ustc@summaryname}
}{}
% 定义了一个满足要求的致谢环境：
\newenvironment{acknowledgements}{%
  \chapter{\ustc@acknowledgementsname}%
}{}
% 发表成果环境：
\newenvironment{publications}{\chapter{\ustc@publicationsname}}{}


% \subsection{其他宏包的设置}

% 这些宏包并非格式要求，但是为了方便同学们使用，在这里进行简单设置。


% \subsubsection{\pkg{hyperref} 宏包}
\newcommand\ustc@atendpackage{\csname ctex_at_end_package:nn\endcsname}
\ustc@atendpackage{hyperref}{
  \hypersetup{
    bookmarksnumbered  = true,
    bookmarksopen      = true,
    bookmarksopenlevel = 1,
    linktoc            = all,
  }
  %
  % 如果为 \opt{pdf} 样式，设置 hyperlink 颜色
  \ifustc@pdf
    \hypersetup{
      %colorlinks = true,
      %allcolors  = blue,
	  hidelinks
    }
  \else
    \hypersetup{hidelinks}
  \fi
  %
  % 填写 PDF 元信息
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
  %
  % 添加 PDF 书签
  %
  \newcounter{ustc@bookmarknumber}
  \renewcommand\ustc@pdfbookmark[1]{%
    \phantomsection
    \stepcounter{ustc@bookmarknumber}%
    \pdfbookmark[0]{#1}{ustcchapter.\theustc@bookmarknumber}%
  }
  %
  % 在 PDF 字符串中去掉换行，以减少 \pkg{hyperref} 的警告信息。
  \pdfstringdefDisableCommands{
    \let\\\@empty
    \let\hspace\@gobble
  }
  %
  % \pkg{hyperref} 与 \pkg{unicode-math} 存在一些兼容性问题，见
  % \href{https://github.com/ustctug/ustcthesis/issues/223}{%
  %   ustctug/ustcthesis\#223}，
  % \href{https://github.com/ho-tex/hyperref/pull/90}{ho-tex/hyperref\#90} 和
  % \href{https://github.com/ustctug/ustcthesis/issues/235}{%
  %   ustctug/ustcthesis/\#235}。
  \@ifpackagelater{hyperref}{2019/04/27}{}{%
    \g@addto@macro\psdmapshortnames{\let\mu\textmu}%
  }
  %
  % 设置中文的 \cs{autoref}。
  % \footnote{\url{https://tex.stackexchange.com/a/66150/82731}}
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


% \subsubsection{\pkg{amsthm} 宏包}

\ustc@atendpackage{amsthm}{
  \newtheoremstyle{ustcplain}
    {}{}
    {}{2\ccwd}
    {\bfseries}{}
    {\ccwd}{}
  \theoremstyle{ustcplain}
  % 定义新的定理
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
  % \pkg{amsthm} 单独定义了 proof 环境，这里重新定义以满足格式要求。
  % 原本模仿 \pkg{amsthm} 写成 |\item[\hskip\labelsep\hskip2\ccwd #1\hskip\ccwd]|，
  % 但是却会多出一些间隙。
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


% \subsubsection{\pkg{algorithm2e} 宏包}

% 按章节编号。
\PassOptionsToPackage{algochapter}{algorithm2e}

\ustc@atendpackage{algorithm2e}{
  \ifustc@chinese
    \SetAlgorithmName{算法}{算法}{算法清单}
  \else
    \SetAlgorithmName{Algorithm}{Algorithm}{List of Algorithms}
  \fi
  %
  % 设置算法环境的格式。
  \SetAlCapSkip{6\bp@}
  \SetAlCapFnt{\small}
  \SetAlCapNameFnt{\small}
  \SetAlCapNameSty{textbf}
  \SetAlgoCaptionSeparator{\unskip\hspace*{\ccwd}}
  %
  % 设置算法清单的格式
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

% \subsubsection{\pkg{nomencl} 宏包}

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


% \subsubsection{\pkg{siunitx} 宏包}

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

% \subsubsection{\pkg{chapterbib} 宏包}

% \AtEndOfPackageFile*{chapterbib}{
%   \renewcommand\bibsection{%
%     \ctexset{section/numbering=false}%
%     \section{\bibname}%
%     \ctexset{section/numbering=true}%
%   }
% }

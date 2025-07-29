%
% Copyright (C) 2015-2024 by chd TeX Users Group <https://github.com/chdtug>
%
% This file may be distributed and/or modified under the
% conditions of the LaTeX Project Public License, either version 1.3c
% of this license or (at your option) any later version.
% The latest version of this license is in
%    https://www.latex-project.org/lppl.txt
% and version 1.3c or later is part of all distributions of LaTeX
% version 2008 or later.
%

\NeedsTeXFormat{LaTeX2e}[2017/04/15]
\newcommand\chdthesisversion{1.0.0}
\ProvidesClass{chdthesis}[2021/03/01 \space v\chdthesisversion \space CHD thesis template]

% 报错和警告
\newcommand\chd@error[1]{%
  \ClassError{chdthesis}{#1}{}%
}
\newcommand\chd@warning[1]{%
  \ClassWarning{chdthesis}{#1}%
}

% 检查 \LaTeXe{} kernel 版本
\@ifl@t@r\fmtversion{2017/04/15}{}{
  \chd@error{%
    TeX Live 2017 or later version is required to compile this document%
  }
}

% 检查编译引擎，要求使用 XeLaTeX 或 LuaLaTeX。
\RequirePackage{iftex}
\ifXeTeX\else
  \ifLuaTeX\else
    \chd@error{XeLaTeX or LuaLaTeX is required to compile this document}
  \fi
\fi

% \subsection{处理选项}

\RequirePackage{kvdefinekeys}
\RequirePackage{kvsetkeys}
\RequirePackage{kvoptions}

% 提供一个 \cs{chdsetup} 命令支持 \emph{key-value} 的方式来设置。
\let\chd@setup@hook\@empty
\newcommand\chdsetup[1]{%
  \let\chd@setup@hook\@empty
  \kvsetkeys{chd}{#1}%
  \chd@setup@hook
}

% 同时用 \emph{key-value} 的方式来定义这些接口：
% \begin{latex}
%   \chd@define@key{
%     <key> = {
%       name = <name>,
%       choices = {
%         <choice1>,
%         <choice2>,
%       },
%       default = <default>,
%       code = <code>,
%     },
%   }
% \end{latex}

% 其中 |choices| 设置允许使用的值，默认为第一个（或者 \meta{default}）；
% \meta{code} 是相应的内容被设置时执行的代码。

\newcommand\chd@define@key[1]{%
  \kvsetkeys{chd@key}{#1}%
}
\kv@set@family@handler{chd@key}{%
%
% \cs{chdsetup} 会将 \meta{value} 存到 \cs{chd@\meta{key}}，
% 但是宏的名字包含 “-” 这样的特殊字符时不方便直接调用，比如 |key = math-style|，
% 这时可以用 |name| 设置 \meta{key} 的别称，比如 |key = math@style|，
% 这样就可以通过 \cs{chd@math@style} 来引用。
% |default| 是定义该 \meta{key} 时默认的值，缺省为空。
%
  \@namedef{chd@#1@@name}{#1}%
  \def\chd@@default{}%
  \def\chd@@choices{}%
  \kv@define@key{chd@value}{name}{%
    \@namedef{chd@#1@@name}{##1}%
  }%
  %
  % 由于在定义接口时，\cs{chd@\meta{key}@@code} 不一定有定义，
  % 而且在文档类/宏包中还有可能对该 |key| 的 |code| 进行添加。
  % 所以 \cs{chd@\meta{key}@@code} 会检查如果在定义文档类/宏包时则推迟执行，否则立即执行。
  %
  \@namedef{chd@#1@@check}{}%
  \@namedef{chd@#1@@code}{}%
  %
  % 保存下 |choices = {}| 定义的内容，在定义 \cs{chd@\meta{name}} 后再执行。
  %
  \kv@define@key{chd@value}{choices}{%
    \def\chd@@choices{##1}%
    \@namedef{chd@#1@@reset}{}%
    %
    % \cs{chd@\meta{key}@check} 检查 |value| 是否有效，
    % 并设置 \cs{ifchd@\meta{name}@\meta{value}}。
    %
    \@namedef{chd@#1@@check}{%
      \@ifundefined{%
        ifchd@\@nameuse{chd@#1@@name}@\@nameuse{chd@\@nameuse{chd@#1@@name}}%
      }{%
        \chd@error{Invalid value "#1 = \@nameuse{chd@\@nameuse{chd@#1@@name}}"}%
      }%
      \@nameuse{chd@#1@@reset}%
      \@nameuse{chd@\@nameuse{chd@#1@@name}@\@nameuse{chd@\@nameuse{chd@#1@@name}}true}%
    }%
  }%
  \kv@define@key{chd@value}{default}{%
    \def\chd@@default{##1}%
  }%
  \kvsetkeys{chd@value}{#2}%
  \@namedef{chd@\@nameuse{chd@#1@@name}}{}%
  %
  % 第一个 \meta{choice} 设为 \meta{default}，
  % 并且对每个 \meta{choice} 定义 \cs{ifchd@\meta{name}@\meta{choice}}。
  %
  \kv@set@family@handler{chd@choice}{%
    \ifx\chd@@default\@empty
      \def\chd@@default{##1}%
    \fi
    \expandafter\newif\csname ifchd@\@nameuse{chd@#1@@name}@##1\endcsname
    \expandafter\g@addto@macro\csname chd@#1@@reset\endcsname{%
      \@nameuse{chd@\@nameuse{chd@#1@@name}@##1false}%
    }%
  }%
  \kvsetkeys@expandafter{chd@choice}{\chd@@choices}%
  %
  % 将 \meta{default} 赋值到 \cs{chd@\meta{name}}，如果非空则执行相应的代码。
  %
  \expandafter\let\csname chd@\@nameuse{chd@#1@@name}\endcsname\chd@@default
  \expandafter\ifx\csname chd@\@nameuse{chd@#1@@name}\endcsname\@empty\else
    \@nameuse{chd@#1@@check}%
  \fi
  %
  % 定义 \cs{chdsetup} 接口。
  %
  \kv@define@key{chd}{#1}{%
    \@namedef{chd@\@nameuse{chd@#1@@name}}{##1}%
    \@nameuse{chd@#1@@check}%
    \@nameuse{chd@#1@@code}%
  }%
}

% 定义接口向 |key| 添加 |code|：

\newcommand\chd@option@hook[2]{%
  \expandafter\g@addto@macro\csname chd@#1@@code\endcsname{#2}%
}

\chd@define@key{
  degree = {
    choices = {
      doctor,
      master,
      bachelor,
    },
    default = doctor,
  },
  degree-type = {
    name = degree@type,
    choices = {
      academic,
      professional,
    },
    default = academic,
  },
  main-language = {
    name = main@language,
    choices = {
      chinese,
      english,
    },
    default = chinese,
  },
  language = {
    choices = {
      chinese,
      english,
    },
    default = chinese,
  },
  system = {
    choices = {
      auto,
      mac,
      unix,
      windows,
    },
    default = auto,
  },
  fontset = {
    choices = {
      auto,
      windows,
      mac,
      ubuntu,
      fandol,
      none,
    },
    default = auto,
  },
  font = {
    choices = {
      auto,
      times,
      termes,
      stix,
      xits,
      libertinus,
      newcm,
      lm,
      newtx,
      none,
    },
    default = auto,
  },
  cjk-font = {
    name = cjk@font,
    choices = {
      auto,
      windows,
      mac,
      noto,
      fandol,
      none,
    },
    default = auto,
  },
  math-font = {
    name = math@font,
    choices = {
      auto,
      stix,
      xits,
      libertinus,
      newcm,
      cm,
      lm,
      newtx,
      none,
    },
    default = auto,
  },
  math-style = {
    name = math@style,
    choices = {
      GB,
      ISO,
      TeX,
    },
  },
  uppercase-greek = {
    name = uppercase@greek,
    choices = {
      italic,
      upright,
    },
  },
  less-than-or-equal = {
    name = leq,
    choices = {
      slanted,
      horizontal,
    },
  },
  integral = {
    choices = {
      upright,
      slanted,
    },
  },
  integral-limits = {
    name = integral@limits,
    choices = {
      true,
      false,
    },
  },
  partial = {
    choices = {
      upright,
      italic,
    },
  },
  math-ellipsis = {
    name = math@ellipsis,
    choices = {
      centered,
      lower,
      AMS,
    },
  },
  real-part = {
    name = real@part,
    choices = {
      roman,
      fraktur,
    },
  },
  cite-style = {
    name = cite@style,
    choices = {
      super,
      inline,
      authoryear,
    },
  },
  output = {
    choices = {
      print,
      electronic,
    },
    default = print,
  },
  section-style = {
    name = section@style,
    choices = {
      chinese,
      arabic,
    },
    default = chinese,
  },
  badge-color = {
    name = badge@color,
    choices = {
      red,
      black,
    },
    default = red,
  },
  reviewer = {
    choices = {
      true,
      false,
    },
    default = false,
  },
}

% 将 \chd@cite@style 置空方便后续进行判断。
\def\chd@cite@style{}

\newif\ifchd@degree@graduate
\newcommand\chd@set@graduate{%
  \ifchd@degree@bachelor
    \chd@degree@graduatefalse
  \else
    \chd@degree@graduatetrue
  \fi
}
\chd@set@graduate
\chd@option@hook{degree}{%
  \chd@set@graduate
}

% 使用 \pkg{kvoptions} 提供的 key-value 接口，
\SetupKeyvalOptions{
  family  = chd,
  prefix  = chd@,
  setkeys = \kvsetkeys,
}

% 设置默认 \option{openany}。
\DeclareBoolOption[false]{openright}
\DeclareComplementaryOption{openany}{openright}

% 兼容旧版本的文档类选项。
% Reserved for compatibility until 2020-07-01.
\DeclareVoidOption{doctor}{\chdsetup{degree=doctor}}
\DeclareVoidOption{master}{\chdsetup{degree=master}}
\DeclareVoidOption{bachelor}{\chdsetup{degree=bachelor}}
\DeclareVoidOption{chinese}{\chdsetup{language=chinese}}
\DeclareVoidOption{english}{\chdsetup{language=english}}
\DeclareVoidOption{academic}{\chdsetup{degree-type=academic}}
\DeclareVoidOption{professional}{\chdsetup{degree-type=professional}}
\DeclareVoidOption{print}{\chdsetup{output=print}}
\DeclareVoidOption{pdf}{\chdsetup{output=electronic}}
\newif\ifchd@legacy@cite@style
\DeclareVoidOption{super}{\chdsetup{cite-style=super}\chd@legacy@cite@styletrue}
\DeclareVoidOption{numbers}{\chdsetup{cite-style=inline}\chd@legacy@cite@styletrue}
\DeclareVoidOption{authoryear}{\chdsetup{cite-style=authoryear}\chd@legacy@cite@styletrue}
\DeclareVoidOption{arabic}{\chdsetup{section-style=arabic}}
\DeclareVoidOption{colorlogo}{\chdsetup{badge-color=blue}}
\DeclareVoidOption{bwlogo}{\chdsetup{badge-color=black}}

% 载入 \cls{ctexbook}。
\DeclareDefaultOption{\PassOptionsToClass{\CurrentOption}{ctexbook}}
\ProcessKeyvalOptions*

% \subsection{加载文档类和宏包}

\ifchd@openright
  \PassOptionsToClass{openright}{book}
\else
  \PassOptionsToClass{openany}{book}
\fi

\ifchd@output@electronic
  \PassOptionsToClass{oneside}{book}
\fi
\PassOptionsToPackage{no-math}{fontspec}

% 载入 \cls{ctexbook} 文档类，注意要求为 2.4.9 或更高的版本。
\LoadClass[UTF8,a4paper,scheme=plain,zihao=-4,fontset=none]{ctexbook}[2017/04/01]

% 建议在模板开始处载入全部宏包，不要轻易改变加载顺序。
% \pkg{hyperref} 一般在最后加载。
\RequirePackage{etoolbox}
\RequirePackage{amsmath}
\RequirePackage{fontspec}[2017/03/31]
\RequirePackage{geometry}
\RequirePackage{graphicx}
\RequirePackage{fancyhdr}
\RequirePackage{color}
\RequirePackage{titletoc}
\RequirePackage{caption}
\RequirePackage[perpage]{footmisc}
\RequirePackage{url}
\RequirePackage{notoccite}
\RequirePackage{multirow}
\RequirePackage{makecell}

% 如果用户在导言区未调用 \pkg{biblatex}，则自动调用 \pkg{natbib}。
\AtEndPreamble{
  \@ifpackageloaded{biblatex}{}{
    \RequirePackage{natbib}
  }
}

% 对冲突的宏包报错。
\RequirePackage{filehook}
\newcommand\chd@package@conflict[2]{
  \AtEndOfPackageFile*{#1}{%
    \AtBeginOfPackageFile*{#2}{%
      \chd@error{The "#2" package is incompatible with "#1"}%
    }%
  }%
}

\chd@package@conflict{biblatex}{bibunits}
\chd@package@conflict{biblatex}{chapterbib}
\chd@package@conflict{biblatex}{cite}
\chd@package@conflict{biblatex}{multibib}
\chd@package@conflict{biblatex}{natbib}

\chd@package@conflict{bibunits}{biblatex}
\chd@package@conflict{bibunits}{chapterbib}
\chd@package@conflict{bibunits}{multibib}

\chd@package@conflict{unicode-math}{amscd}
\chd@package@conflict{unicode-math}{amsfonts}
\chd@package@conflict{unicode-math}{amssymb}
\chd@package@conflict{unicode-math}{bbm}
\chd@package@conflict{unicode-math}{bm}
\chd@package@conflict{unicode-math}{eucal}
\chd@package@conflict{unicode-math}{eufrak}
\chd@package@conflict{unicode-math}{mathrsfs}
\chd@package@conflict{unicode-math}{newtxmath}
\chd@package@conflict{unicode-math}{upgreek}

\chd@package@conflict{natbib}{biblatex}
\chd@package@conflict{natbib}{cite}

\chd@package@conflict{newtxmath}{amsfonts}
\chd@package@conflict{newtxmath}{amssymb}
\chd@package@conflict{newtxmath}{unicode-math}
\chd@package@conflict{newtxmath}{upgreek}


% \pkg{amsthm} 需要在 \pkg{newtx} 前载入，参考 \pkg{newtx} 的文档。
\AtBeginOfPackageFile*{amsthm}{
  \@ifpackageloaded{newtxmath}{
    \chd@error{The "amsthm" package should be loaded before setting "newtxmath"}
  }{}
}%



% \subsection{处理语言}

% 定义 \cs{chd@main@language}，当在导言区修改 \option{language} 时，
% 保存为论文的主要语言；
% \cs{chd@reset@main@language} 则用于正文中恢复为主要语言。
%    \begin{macrocode}
\chdsetup{main-language=\chd@language}%
\let\chd@main@language\chd@language

\chd@option@hook{language}{%
  \ifx\@begindocumenthook\@undefined\else
    \chdsetup{main-language=\chd@language}%
    \let\chd@main@language\chd@language
  \fi
}
\newcommand\chd@reset@main@language{%
  \chdsetup{language = \chd@main@language}%
  \let\chd@language\chd@main@language
}

% 带圈数字和星号使用中文字体。
\ifLuaTeX
  % ctex 将带圈数字 U+2460–U+24FF 归入字符范围 3（ALchar），这里改回范围 6（JAchar）
  \ltjdefcharrange{3}{%
    "2000-"243F, "2500-"27BF, "2900-"29FF, "2B00-"2BFF}
  \ltjdefcharrange{6}{%
    "2460-"24FF, "2E80-"2EFF, "3000-"30FF, "3190-"319F, "31F0-"4DBF,
    "4E00-"9FFF, "F900-"FAFF, "FE10-"FE1F, "FE30-"FE6F, "FF00-"FFEF,
    "1B000-"1B16F, "1F100-"1F2FF, "20000-"3FFFF, "E0100-"E01EF}
\else
  \ifXeTeX
    \xeCJKDeclareCharClass{CJK}{"2460 -> "2473}
    \xeCJKDeclareCharClass{CJK}{"2605}
  \fi
\fi

% 由于 Unicode 的一些标点符号是中西文混用的：
% U+00B7、U+2013、U+2014、U+2018、U+2019、
% U+201C、U+201D、U+2025、U+2026、U+2E3A，
% 所以要根据语言设置正确的字体。
% https://github.com/CTeX-org/ctex-kit/issues/389
\newcommand\chd@set@punctuations{%
  \ifchd@language@chinese
    \ifLuaTeX
      \ltjsetparameter{jacharrange={+9}}
    \else
      \ifXeTeX
        \xeCJKDeclareCharClass{FullLeft}{"2018, "201C}%
        \xeCJKDeclareCharClass{FullRight}{
          "00B7, "2019, "201D, "2013, "2014, "2025, "2026, "2E3A,
        }%
      \fi
    \fi
  \else
    \ifLuaTeX
      \ltjsetparameter{jacharrange={-9}}
    \else
      \ifXeTeX
        \xeCJKDeclareCharClass{HalfLeft}{"2018, "201C}%
        \xeCJKDeclareCharClass{HalfRight}{
          "00B7, "2019, "201D, "2013, "2014, "2025, "2026, "2E3A,
        }%
      \fi
    \fi
  \fi
}
\chd@set@punctuations
\chd@option@hook{language}{\chd@set@punctuations}


% 根据语言设置各章节的名称，只有在导言区设置 \option{language} 时会修改，
% 而在正文局部切换语言时则不变。

% 由于《撰写手册》中的“speciality”一词使用的是英式拼法，
% 所以“acknowledgements”也保持一致。
\newcommand\chd@set@chapter@names{%
  \ifchd@main@language@chinese
    \def\contentsname{目录}%
    \def\listfigurename{插图清单}%
    \def\listtablename{表格清单}%
    \ctexset{
      chapter/name   = {第,章},
    }%
    \def\bibname{参考文献}%
    \def\appendixname{附录}%
    \def\chd@acknowledgements@name{致谢}%
    \def\chd@publication@name{攻读学位期间取得的研究成果}%
    \newcommand\chd@notation@name{符号说明}%
  \else
    \def\contentsname{Contents}%
    \def\listfigurename{List of Figures}%
    \def\listtablename{List of Tables}%
    \ctexset{
      chapter/name   = {\chaptername\space},
    }%
    \def\bibname{Bibliography}%
    \def\appendixname{Appendix}%
    \def\chd@acknowledgements@name{Acknowledgements}%
    \def\chd@publication@name{Publications}%
    \def\chd@notation@name{Notation}%
  \fi
}
\chd@set@chapter@names
\chd@option@hook{main-language}{\chd@set@chapter@names}

% 这部分名称在正文中局部地修改语言时会发生变化。
\newcommand\chd@set@names{%
  \ifchd@language@chinese
    \def\figurename{图}%
    \def\tablename{表}%
  \else
    \def\figurename{Figure}%
    \def\tablename{Table}%
  \fi
}
\chd@set@names
\chd@option@hook{language}{\chd@set@names}


% \subsection{字体}

% 字号

% 《规范》要求正文为小四号宋体，1.5倍行距。但在 Word 中行距自动增加了额外的行距，
% 因此手动调整为正文字号12bp，研究生行距23.3bp，本科生行距22bp；
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
%     \cs{normalsize}   & 小四 & 12   & 23.34      & 22         \\
%     \cs{large}        & 小三 & 15   & 25         & 27.5       \\
%     \cs{Large}        & 小二 & 18   & 30         & 33         \\
%     \cs{LARGE}        & 二号 & 22   & 36.67      & 40.33      \\
%     \cs{huge}         & 小一 & 24   & 40         & 44         \\
%     \cs{Huge}         & 一号 & 26   & 43.33      & 47.67      \\
%     \bottomrule
%   \end{tabular}
% \end{table}
%
% 注意重定义 \normalsize 应在 \pkg{unicode-math} 的 \cs{setmathfont} 前。
\newcommand\chd@set@font@size{%
  \ifchd@degree@graduate
    \renewcommand\normalsize{%
      \@setfontsize\normalsize{12bp}{23.34bp}%
      \abovedisplayskip 12bp \@plus3bp \@minus7bp%
      \abovedisplayshortskip \z@ \@plus3bp%
      \belowdisplayshortskip 6.5bp \@plus3.5bp \@minus3bp%
      \belowdisplayskip \abovedisplayskip
      \let\@listi\@listI}%
    %
    % 注意第~\ref{sec:list} 节去掉了列表的间距，所以不再修改 \cs{@listi}。
  \else
    \renewcommand\normalsize{%
      \@setfontsize\normalsize{12bp}{22bp}%
      \abovedisplayskip 12bp \@plus3bp \@minus7bp%
      \abovedisplayshortskip \z@ \@plus3bp%
      \belowdisplayshortskip 6.5bp \@plus3.5bp \@minus3bp%
      \belowdisplayskip \abovedisplayskip
      \let\@listi\@listI}%
  \fi
  \normalsize
  \ifx\MakeRobust\@undefined \else
      \MakeRobust\normalsize
  \fi
}
\chd@set@font@size
\chd@option@hook{degree}{\chd@set@font@size}

% 设置全局行距的倍数为 1。具体行距在字体中设置。
\linespread{1.0}\selectfont


% 检测系统
\ifchd@system@auto
  \IfFileExists{/System/Library/Fonts/Menlo.ttc}{
    \chdsetup{system = mac}
  }{
    \IfFileExists{/dev/null}{
      \IfFileExists{null:}{
        \chdsetup{system = windows}
      }{
        \chdsetup{system = unix}
      }
    }{
      \chdsetup{system = windows}
    }
  }
\fi

% 处理 \opt{fontset}
\ifchd@fontset@auto
  \ifchd@system@windows
    \chdsetup{fontset = windows}
  \else
    \IfFontExistsTF{SimSun}{
      \chdsetup{fontset = windows}
    }{
      \ifchd@system@mac
        \chdsetup{fontset = mac}
      \else
        \IfFontExistsTF{Noto Serif CJK SC}{
          \chdsetup{fontset = ubuntu}
        }{
          \chdsetup{fontset = fandol}
        }
      \fi
    }
  \fi
\fi

% 《撰写手册》要求西文字体使用 Times New Roman 和 Arial，
% 但是在 Linux 下没有这两个字体，所以使用它们的克隆版 TeX Gyre Termes 和
% TeX Gyre Heros。
\ifchd@font@auto
  \ifchd@fontset@windows
    \chdsetup{font=times}
  \else
    \ifchd@fontset@mac
      \chdsetup{font=times}
    \else
      \chdsetup{font=termes}
    \fi
  \fi
\fi

% Times New Roman + Arial
\newcommand\chd@set@font@times{%
  \setmainfont{Times New Roman}%
  \setsansfont{Arial}%
  \ifchd@system@mac
    \setmonofont{Menlo}[Scale = MatchLowercase]%
  \else
    \setmonofont{Courier New}[Scale = MatchLowercase]%
  \fi
}

% TeX Gyre Termes
\newcommand\chd@set@font@termes{%
  \setmainfont{texgyretermes}[
    Extension      = .otf,
    UprightFont    = *-regular,
    BoldFont       = *-bold,
    ItalicFont     = *-italic,
    BoldItalicFont = *-bolditalic,
  ]%
  \chd@set@texgyre@sans@mono
}

\newcommand\chd@set@texgyre@sans@mono{%
  \setsansfont{texgyreheros}[
    Extension      = .otf,
    UprightFont    = *-regular,
    BoldFont       = *-bold,
    ItalicFont     = *-italic,
    BoldItalicFont = *-bolditalic,
  ]%
  \setmonofont{texgyrecursor}[
    Extension      = .otf,
    UprightFont    = *-regular,
    BoldFont       = *-bold,
    ItalicFont     = *-italic,
    BoldItalicFont = *-bolditalic,
    Scale          = MatchLowercase,
    Ligatures      = CommonOff,
  ]%
}

% STIX Two 字体。
% STIX 文件名在 v2.10 2020-12-19 从
% \file{STIX2Text-Regular.otf}、\file{STIX2Math.otf} 分别改为
% \file{STIXTwoText-Regular.otf}、\file{STIXTwoMath-Regular.otf}。
\let\chd@font@family@stix\@empty
\newcommand\chd@set@stix@names{%
  \ifx\chd@font@family@stix\@empty
    \IfFontExistsTF{STIXTwoText-Regular.otf}{%
      \gdef\chd@font@family@stix{STIXTwoText}%
      \gdef\chd@font@name@stix@math{STIXTwoMath-Regular}%
    }{%
      \gdef\chd@font@family@stix{STIX2Text}%
      \gdef\chd@font@name@stix@math{STIX2Math}%
    }%
  \fi
}

\newcommand\chd@set@font@stix{%
  \chd@set@stix@names
  \setmainfont{\chd@font@family@stix}[
    Extension      = .otf,
    UprightFont    = *-Regular,
    BoldFont       = *-Bold,
    ItalicFont     = *-Italic,
    BoldItalicFont = *-BoldItalic,
  ]%
  \chd@set@texgyre@sans@mono
}

% XITS 字体。
% XITS 的文件名在 v1.109 2018-09-30
% 从 \file{xits-regular.otf}、\file{xits-math.otf} 分别改为
% \file{XITS-Regular.otf}、\file{XITSMath-Regular.otf}。
\let\chd@font@family@xits\@empty
\newcommand\chd@set@xits@names{%
  \ifx\chd@font@family@xits\@empty
    \IfFontExistsTF{XITSMath-Regular.otf}{%
      \gdef\chd@font@family@xits{XITS}%
      \gdef\chd@font@style@xits@rm{Regular}%
      \gdef\chd@font@style@xits@bf{Bold}%
      \gdef\chd@font@style@xits@it{Italic}%
      \gdef\chd@font@style@xits@bfit{BoldItalic}%
      \gdef\chd@font@name@xits@math{XITSMath-Regular}%
    }{%
      \gdef\chd@font@family@xits{xits}%
      \gdef\chd@font@style@xits@rm{regular}%
      \gdef\chd@font@style@xits@bf{bold}%
      \gdef\chd@font@style@xits@it{italic}%
      \gdef\chd@font@style@xits@bfit{bolditalic}%
      \gdef\chd@font@name@xits@math{xits-math}%
    }%
  \fi
}

\newcommand\chd@set@font@xits{%
  \chd@set@xits@names
  \setmainfont{\chd@font@family@xits}[
    Extension      = .otf,
    UprightFont    = *-\chd@font@style@xits@rm,
    BoldFont       = *-\chd@font@style@xits@bf,
    ItalicFont     = *-\chd@font@style@xits@it,
    BoldItalicFont = *-\chd@font@style@xits@bfit,
  ]%
  \chd@set@texgyre@sans@mono
}

% Libertinus 的文件名在 v6.7 2019-04-03 从小写改为驼峰式，
% 在大小写敏感的平台上需要进行判断。
\let\chd@font@family@libertinus\@empty
\newcommand\chd@set@libertinus@names{%
  \ifx\chd@font@family@libertinus\@empty
    \IfFontExistsTF{LibertinusSerif-Regular.otf}{%
      \gdef\chd@font@family@libertinus@serif{LibertinusSerif}%
      \gdef\chd@font@family@libertinus@sans{LibertinusSans}%
      \gdef\chd@font@name@libertinus@math{LibertinusMath-Regular}%
      \gdef\chd@font@style@libertinus@rm{Regular}%
      \gdef\chd@font@style@libertinus@bf{Bold}%
      \gdef\chd@font@style@libertinus@it{Italic}%
      \gdef\chd@font@style@libertinus@bfit{BoldItalic}%
    }{%
      \gdef\chd@font@family@libertinus@serif{libertinusserif}%
      \gdef\chd@font@family@libertinus@sans{libertinussans}%
      \gdef\chd@font@name@libertinus@math{libertinusmath-regular}%
      \gdef\chd@font@style@libertinus@rm{regular}%
      \gdef\chd@font@style@libertinus@bf{bold}%
      \gdef\chd@font@style@libertinus@it{italic}%
      \gdef\chd@font@style@libertinus@bfit{bolditalic}%
    }%
  \fi
}

\newcommand\chd@set@font@libertinus{%
  \chd@set@libertinus@names
  \setmainfont{\chd@font@family@libertinus@serif}[
    Extension      = .otf,
    UprightFont    = *-\chd@font@style@libertinus@rm,
    BoldFont       = *-\chd@font@style@libertinus@bf,
    ItalicFont     = *-\chd@font@style@libertinus@it,
    BoldItalicFont = *-\chd@font@style@libertinus@bfit,
  ]%
  \setsansfont{\chd@font@family@libertinus@sans}[
    Extension      = .otf,
    UprightFont    = *-\chd@font@style@libertinus@rm,
    BoldFont       = *-\chd@font@style@libertinus@bf,
    ItalicFont     = *-\chd@font@style@libertinus@it,
  ]%
  \setmonofont{lmmonolt10}[
    Extension      = .otf,
    UprightFont    = *-regular,
    BoldFont       = *-bold,
    ItalicFont     = *-oblique,
    BoldItalicFont = *-boldoblique,
  ]%
}

% New Computer Modern
\newcommand\chd@set@font@newcm{%
  \setmainfont{NewCM10}[
    Extension      = .otf,
    UprightFont    = *-Book,
    BoldFont       = *-Bold,
    ItalicFont     = *-BookItalic,
    BoldItalicFont = *-BoldItalic,
  ]%
  \setsansfont{NewCMSans10}[
    Extension         = .otf,
    UprightFont       = *-Book,
    BoldFont          = *-Bold,
    ItalicFont        = *-BookOblique,
    BoldItalicFont    = *-BoldOblique,
  ]%
  \setmonofont{NewCMMono10}[
    Extension           = .otf,
    UprightFont         = *-Book,
    ItalicFont          = *-BookItalic,
    BoldFont            = *-Bold,
    BoldItalicFont      = *-BoldOblique,
  ]%
}

% Latin Modern
\newcommand\chd@set@font@lm{%
  \setmainfont{lmroman10}[
    Extension      = .otf,
    UprightFont    = *-regular,
    BoldFont       = *-bold,
    ItalicFont     = *-italic,
    BoldItalicFont = *-bolditalic,
  ]%
  \setsansfont{lmsans10}[
    Extension      = .otf,
    UprightFont    = *-regular,
    BoldFont       = *-bold,
    ItalicFont     = *-oblique,
    BoldItalicFont = *-boldoblique,
  ]%
  \setmonofont{lmmonolt10}[
    Extension      = .otf,
    UprightFont    = *-regular,
    BoldFont       = *-bold,
    ItalicFont     = *-oblique,
    BoldItalicFont = *-boldoblique,
  ]%
}

\newcommand\chd@set@font@newtx{%
  \RequirePackage{newtxtext}%
}

\newcommand\chd@set@font{%
  \@nameuse{chd@set@font@\chd@font}%
}
\chd@set@font
\chd@option@hook{font}{\chd@set@font}

% 中文字体
\ifchd@cjk@font@auto
  \ifchd@fontset@mac
    \chdsetup{cjk-font = mac}
  \else
    \ifchd@fontset@windows
      \chdsetup{cjk-font = windows}
    \else
      \ifchd@fontset@ubuntu
        \chdsetup{cjk-font = noto}
      \else
        \chdsetup{cjk-font = fandol}
      \fi
    \fi
  \fi
\fi

% Windows 的中易字体。
\newcommand\chd@set@cjk@font@windows{%
  \setCJKmainfont{SimSun}[
    AutoFakeBold = 2,
    ItalicFont   = KaiTi,
  ]%
  \setCJKsansfont{SimHei}[AutoFakeBold = 2]%
  \setCJKmonofont{FangSong}%
  \setCJKfamilyfont{zhsong}{SimSun}[AutoFakeBold = 2]%
  \setCJKfamilyfont{zhhei}{SimHei}[AutoFakeBold = 2]%
  \setCJKfamilyfont{zhkai}{KaiTi}%
  \setCJKfamilyfont{zhfs}{FangSong}%
  \setCJKfamilyfont{zhzs}{STZhongsong}% 华文中宋
}

% macOS 的华文字体。
\newcommand\chd@set@cjk@font@mac{%
  \defaultCJKfontfeatures{}%
  \setCJKmainfont{Songti SC}[
    UprightFont    = * Light,
    BoldFont       = * Bold,
    ItalicFont     = Kaiti SC Regular,
    BoldItalicFont = Kaiti SC Bold,
  ]%
  \setCJKsansfont{Heiti SC}[
    UprightFont    = * Light,
    BoldFont       = * Medium,
  ]%
  \setCJKmonofont{STFangsong}
  \setCJKfamilyfont{zhsong}{Songti SC}[
    UprightFont    = * Light,
    BoldFont       = * Bold,
  ]%
  \setCJKfamilyfont{zhhei}{Heiti SC}[
    UprightFont    = * Light,
    BoldFont       = * Medium,
  ]%
  \setCJKfamilyfont{zhfs}{STFangsong}%
  \setCJKfamilyfont{zhkai}{Kaiti SC}[
    UprightFont    = * Regular,
    BoldFont       = * Bold,
  ]%
  \setCJKfamilyfont{zhli}{Baoli SC}%
  \setCJKfamilyfont{zhyuan}{Yuanyi SC}[
    UprightFont    = * Light,
    BoldFont       = * Bold,
  ]%
}

% 思源字体。
% 注意 Noto CJK 的 regular 字重名字不带“Regular”。
\newcommand\chd@set@cjk@font@noto{%
  \defaultCJKfontfeatures{}%
  \setCJKmainfont{Noto Serif CJK SC}[
    UprightFont    = * Light,
    BoldFont       = * Bold,
    ItalicFont     = FandolKai-Regular,
    ItalicFeatures = {Extension = .otf},
    Script         = CJK,
  ]%
  \setCJKsansfont{Noto Sans CJK SC}[
    BoldFont       = * Medium,
    Script         = CJK,
  ]%
  \setCJKmonofont{Noto Sans Mono CJK SC}[
    Script         = CJK,
  ]%
  \setCJKfamilyfont{zhsong}{Noto Serif CJK SC}[
    UprightFont    = * Light,
    UprightFont    = * Bold,
    Script         = CJK,
  ]%
  \setCJKfamilyfont{zhhei}{Noto Sans CJK SC}[
    BoldFont       = * Medium,
    Script         = CJK,
  ]%
  \setCJKfamilyfont{zhfs}{FandolFang}[
    Extension      = .otf,
    UprightFont    = *-Regular,
  ]%
  \setCJKfamilyfont{zhkai}{FandolKai}[
    Extension      = .otf,
    UprightFont    = *-Regular,
  ]%
}

% Fandol 字体。
\newcommand\chd@set@cjk@font@fandol{%
  \defaultCJKfontfeatures{}%
  \setCJKmainfont{FandolSong}[
    Extension   = .otf,
    UprightFont = *-Regular,
    BoldFont    = *-Bold,
    ItalicFont  = FandolKai-Regular,
    ItalicFeatures = {Extension = .otf},
  ]%
  \setCJKsansfont{FandolHei}[
    Extension   = .otf,
    UprightFont = *-Regular,
    BoldFont    = *-Bold,
  ]%
  \setCJKmonofont{FandolFang}[
    Extension   = .otf,
    UprightFont = *-Regular,
  ]%
  \setCJKfamilyfont{zhsong}{FandolSong}[
    Extension   = .otf,
    UprightFont = *-Regular,
    BoldFont    = *-Bold,
  ]%
  \setCJKfamilyfont{zhhei}{FandolHei}[
    Extension   = .otf,
    UprightFont = *-Regular,
    BoldFont    = *-Bold,
  ]%
  \setCJKfamilyfont{zhfs}{FandolFang}[
    Extension   = .otf,
    UprightFont = *-Regular,
  ]%
  \setCJKfamilyfont{zhkai}{FandolKai}[
    Extension   = .otf,
    UprightFont = *-Regular,
  ]%
}

\ifchd@cjk@font@none\else
  \providecommand\songti{\CJKfamily{zhsong}}
  \providecommand\heiti{\CJKfamily{zhhei}}
  \providecommand\fangsong{\CJKfamily{zhfs}}
  \providecommand\kaishu{\CJKfamily{zhkai}}
\fi

\newcommand\chd@set@cjk@font{%
  \@nameuse{chd@set@cjk@font@\chd@cjk@font}%
}
\chd@set@cjk@font
\chd@option@hook{cjk-font}{\chd@set@cjk@font}

% 数学字体

% 设置数学符号风格。
\newcommand\chd@set@math@style{%
  \ifchd@math@style@TeX
    \chdsetup{
      uppercase-greek    = upright,
      less-than-or-equal = horizontal,
      integral           = slanted,
      integral-limits    = false,
      partial            = italic,
      math-ellipsis      = AMS,
      real-part          = fraktur,
    }%
  \else
    \chdsetup{
      uppercase-greek = italic,
      integral        = upright,
      partial         = upright,
      real-part       = roman,
    }%
    \ifchd@math@style@ISO
      \chdsetup{
        less-than-or-equal = horizontal,
        integral-limits    = true,
        math-ellipsis      = lower,
      }%
    \else
      \ifchd@math@style@GB
        \chdsetup{
          less-than-or-equal = slanted,
          integral-limits    = false,
          math-ellipsis      = centered,
        }%
      \fi
    \fi
  \fi
}

\ifchd@main@language@chinese
  \chdsetup{math-style = GB}%
\else
  \chdsetup{math-style = TeX}%
\fi

\chd@set@math@style
\chd@option@hook{math-style}{\chd@set@math@style}
\chd@option@hook{main-language}{%
  \ifchd@main@language@chinese
    \chdsetup{math-style = GB}%
  \else
    \chdsetup{math-style = TeX}%
  \fi
}

% 针对 \pkg{unicode-math} 逐项配置数学符号。

\newcommand\chd@set@unimath@leq{%
  \ifchd@leq@horizontal
    \ifx\@begindocumenthook\@undefined
      \let\le\chd@save@leq
      \let\ge\chd@save@geq
      \let\leq\chd@save@leq
      \let\geq\chd@save@geq
    \else
      \AtBeginDocument{%
        \let\le\chd@save@leq
        \let\ge\chd@save@geq
        \let\leq\chd@save@leq
        \let\geq\chd@save@geq
      }%
    \fi
  \else
    \ifchd@leq@slanted
      \ifx\@begindocumenthook\@undefined
        \let\le\leqslant
        \let\ge\geqslant
        \let\leq\leqslant
        \let\geq\geqslant
      \else
        \AtBeginDocument{%
          \let\le\leqslant
          \let\ge\geqslant
          \let\leq\leqslant
          \let\geq\geqslant
        }%
      \fi
    \fi
  \fi
}
\newcommand\chd@set@unimath@integral@limits{%
  \ifchd@integral@limits@true
    \removenolimits{%
      \int\iint\iiint\iiiint\oint\oiint\oiiint
      \intclockwise\varointclockwise\ointctrclockwise\sumint
      \intbar\intBar\fint\cirfnint\awint\rppolint
      \scpolint\npolint\pointint\sqint\intlarhk\intx
      \intcap\intcup\upint\lowint
    }%
  \else
    \addnolimits{%
      \int\iint\iiint\iiiint\oint\oiint\oiiint
      \intclockwise\varointclockwise\ointctrclockwise\sumint
      \intbar\intBar\fint\cirfnint\awint\rppolint
      \scpolint\npolint\pointint\sqint\intlarhk\intx
      \intcap\intcup\upint\lowint
    }%
  \fi
}
\newcommand\chd@set@unimath@ellipsis{%
  \ifchd@math@ellipsis@centered
    \DeclareRobustCommand\mathellipsis{\mathinner{\unicodecdots}}%
  \else
    \DeclareRobustCommand\mathellipsis{\mathinner{\unicodeellipsis}}%
  \fi
}
\newcommand\chd@set@unimath@real@part{%
  \ifchd@real@part@roman
    \AtBeginDocument{%
      \def\Re{\operatorname{Re}}%
      \def\Im{\operatorname{Im}}%
    }%
  \else
    \AtBeginDocument{%
      \let\Re\chd@save@Re
      \let\Im\chd@save@Im
    }%
  \fi
}

\newcommand\chd@set@unimath@style{%
  \ifchd@uppercase@greek@upright
    \unimathsetup{math-style = TeX}%
  \else
    \ifchd@uppercase@greek@italic
      \unimathsetup{math-style = ISO}%
    \fi
  \fi
  \ifchd@math@style@TeX
    \unimathsetup{bold-style = TeX}%
  \else
    \unimathsetup{bold-style = ISO}%
  \fi
  \chd@set@unimath@leq
  \chd@set@unimath@integral@limits
  \ifchd@partial@upright
    \unimathsetup{partial = upright}%
  \else
    \ifchd@partial@italic
      \unimathsetup{partial = italic}%
    \fi
  \fi
  \chd@set@unimath@ellipsis
  \chd@set@unimath@real@part
}

\newcommand\chd@qed{\rule{1ex}{1ex}}
\newcommand\chd@load@unimath{%
  \@ifpackageloaded{unicode-math}{}{%
    \RequirePackage{unicode-math}%
    \AtBeginDocument{%
      \let\chd@save@leq\leq
      \let\chd@save@geq\geq
      \let\chd@save@Re\Re
      \let\chd@save@Im\Im
    }%
    %
    % 兼容旧的粗体命令：\pkg{bm} 的 \cs{bm} 和 \pkg{amsmath} 的 \cs{boldsymbol}。
    \DeclareRobustCommand\bm[1]{{\symbfit{##1}}}%
    \DeclareRobustCommand\boldsymbol[1]{{\symbfit{##1}}}%
    %
    % 兼容 \pkg{amsfonts} 和 \pkg{amssymb} 中的一些命令。
    \newcommand\square{\mdlgwhtsquare}%
    \newcommand\blacksquare{\mdlgblksquare}%
    \AtBeginDocument{%
      \renewcommand\checkmark{\ensuremath{✓}}%
    }%
    %
    % 兼容 \pkg{amsthm} 的 \cs{qedsymbol}。
    \renewcommand\chd@qed{\ensuremath{\QED}}%
  }%
}

% STIX Two Math
\newcommand\chd@set@math@font@stix{%
  \chd@load@unimath
  \chd@set@unimath@style
  \chd@set@stix@names
  \setmathfont{\chd@font@name@stix@math}[
    Extension    = .otf,
    Scale        = MatchLowercase,
    StylisticSet = \chd@xits@integral@stylistic@set,
  ]%
  \setmathfont{\chd@font@name@stix@math}[
    Extension    = .otf,
    Scale        = MatchLowercase,
    StylisticSet = 1,
    range        = {scr,bfscr},
  ]%
}

% XITS Math
\newcommand\chd@xits@integral@stylistic@set{%
  \ifchd@integral@upright
    8%
  \fi
}
\newcommand\chd@set@math@font@xits{%
  \chd@load@unimath
  \chd@set@unimath@style
  \chd@set@xits@names
  \setmathfont{\chd@font@name@xits@math}[
    Extension    = .otf,
    StylisticSet = \chd@xits@integral@stylistic@set,
  ]%
  \setmathfont{\chd@font@name@xits@math}[
    Extension    = .otf,
    StylisticSet = 1,
    range        = {cal,bfcal},
  ]%
}

% Libertinus Math
\newcommand\chd@libertinus@integral@stylistic@set{%
  \ifchd@integral@slanted
    8%
  \fi
}
\newcommand\chd@set@math@font@libertinus{%
  \chd@load@unimath
  \chd@set@unimath@style
  \chd@set@libertinus@names
  \chd@set@xits@names
  \setmathfont{\chd@font@name@libertinus@math}[
    Extension    = .otf,
    StylisticSet = \chd@libertinus@integral@stylistic@set,
  ]%
  \setmathfont{\chd@font@name@xits@math}[
    Extension    = .otf,
    range        = {\checkmark},
  ]%
}

% New Computer Modern Math
\newcommand\chd@newcm@integral@stylistic@set{%
  \ifchd@integral@upright
    2%
  \fi
}
\newcommand\chd@set@math@font@newcm{%
  \chd@load@unimath
  \chd@set@unimath@style
  \setmathfont{NewCMMath-Book}[
    Extension    = .otf,
    StylisticSet = \chd@newcm@integral@stylistic@set,
  ]%
  \setmathfont{NewCMMath-Book}[
    Extension    = .otf,
    StylisticSet = 1,
    range        = {scr,bfscr},
  ]%
  \setmathrm{NewCM10}[
    Extension      = .otf,
    UprightFont    = *-Book,
    BoldFont       = *-Bold,
    ItalicFont     = *-BookItalic,
    BoldItalicFont = *-BoldItalic,
  ]%
  \setmathsf{NewCMSans10}[
    Extension         = .otf,
    UprightFont       = *-Book,
    BoldFont          = *-Bold,
    ItalicFont        = *-BookOblique,
    BoldItalicFont    = *-BoldOblique,
  ]%
  \setmathtt{NewCMMono10}[
    Extension           = .otf,
    UprightFont         = *-Book,
    ItalicFont          = *-BookItalic,
    BoldFont            = *-Bold,
    BoldItalicFont      = *-BoldOblique,
  ]%
}

% Latin Modern Math
\newcommand\chd@set@math@font@lm{%
  \chd@load@unimath
  \chd@set@unimath@style
  \setmathfont{latinmodern-math}[Extension=.otf]%
  \setmathrm{lmroman10}[
    Extension      = .otf,
    UprightFont    = *-regular,
    BoldFont       = *-bold,
    ItalicFont     = *-italic,
    BoldItalicFont = *-bolditalic,
  ]%
  \setmathsf{lmsans10}[
    Extension      = .otf,
    UprightFont    = *-regular,
    BoldFont       = *-bold,
    ItalicFont     = *-oblique,
    BoldItalicFont = *-boldoblique,
  ]%
  \setmathtt{lmmonolt10}[
    Extension      = .otf,
    UprightFont    = *-regular,
    BoldFont       = *-bold,
    ItalicFont     = *-oblique,
    BoldItalicFont = *-boldoblique,
  ]%
}

% NewTX Math
% 注意 NewTX Math 是 Type 1 字体，如果正文西文使用了 OpenType 字体时需要小心处理。
\newcommand\chd@set@math@font@newtx{%
  \ifchd@font@newtx\else
    \let\chd@save@encodingdefault\encodingdefault
    \let\chd@save@rmdefault\rmdefault
    \let\chd@save@sfdefault\sfdefault
    \let\chd@save@ttdefault\ttdefault
    \RequirePackage[T1]{fontenc}%
    \renewcommand{\rmdefault}{ntxtlf}%
    \renewcommand{\sfdefault}{qhv}%
    \renewcommand{\ttdefault}{ntxtt}%
  \fi
  \ifchd@uppercase@greek@italic
    \PassOptionsToPackage{slantedGreek}{newtxmath}%
  \fi
  \ifchd@integral@upright
    \PassOptionsToPackage{upint}{newtxmath}%
  \fi
  \RequirePackage{newtxmath}
  \let\chd@save@leq\leq
  \let\chd@save@geq\geq
  \ifchd@leq@slanted
    \let\le\leqslant
    \let\ge\geqslant
    \let\leq\leqslant
    \let\geq\geqslant
  \fi
  \ifchd@integral@limits@true
    \let\ilimits@\displaylimits
  \fi
  \let\chd@save@partial\partial
  \ifchd@partial@upright
    \let\partial\uppartial
  \fi
  \ifchd@math@ellipsis@centered
    \DeclareRobustCommand\mathellipsis{\mathinner{\cdotp\cdotp\cdotp}}%
  \else
    \DeclareRobustCommand\mathellipsis{\mathinner{\ldotp\ldotp\ldotp}}%
  \fi
  \let\chd@save@Re\Re
  \let\chd@save@Im\Im
  \ifchd@real@part@roman
    \def\Re{\operatorname{Re}}%
    \def\Im{\operatorname{Im}}%
  \fi
  \RequirePackage{bm}%
  \ifchd@font@newtx\else
    \let\encodingdefault\chd@save@encodingdefault
    \let\rmdefault\chd@save@rmdefault
    \let\sfdefault\chd@save@sfdefault
    \let\ttdefault\chd@save@ttdefault
  \fi
  \DeclareRobustCommand\symup[1]{{\mathrm{##1}}}%
  \DeclareRobustCommand\symbf[1]{{\bm{##1}}}%
  \DeclareRobustCommand\symbfsf[1]{{\bm{##1}}}%
  \let\increment\upDelta%
  \renewcommand\chd@qed{\openbox}%
}

% Computer Modern
% 使用 LaTeX 默认的 cm 字体
\newcommand\chd@set@math@font@cm{%
  \RequirePackage{amssymb}
  \let\chd@save@leq\leq
  \let\chd@save@geq\geq
  \ifchd@leq@slanted
    \let\le\leqslant
    \let\ge\geqslant
    \let\leq\leqslant
    \let\geq\geqslant
  \fi
  \ifchd@integral@limits@true
    \let\ilimits@\displaylimits
  \fi
  \ifchd@math@ellipsis@centered
    \DeclareRobustCommand\mathellipsis{\mathinner{\cdotp\cdotp\cdotp}}%
  \else
    \DeclareRobustCommand\mathellipsis{\mathinner{\ldotp\ldotp\ldotp}}%
  \fi
  \let\chd@save@Re\Re
  \let\chd@save@Im\Im
  \ifchd@real@part@roman
    \def\Re{\operatorname{Re}}%
    \def\Im{\operatorname{Im}}%
  \fi
  \RequirePackage{bm}%
  \DeclareRobustCommand\symup[1]{{\mathrm{##1}}}%
  \DeclareRobustCommand\symbf[1]{{\bm{##1}}}%
  \DeclareRobustCommand\symbfsf[1]{{\bm{##1}}}%
  \let\increment\Delta
  \renewcommand\chd@qed{\openbox}%
  \let\uppi\pi
}

% 不设置数学字体，仅提供兼容支持。
\newcommand\chd@set@math@font@none{%
  \RequirePackage{amssymb}
  \RequirePackage{bm}%
  \DeclareRobustCommand\symup[1]{{\mathrm{##1}}}%
  \DeclareRobustCommand\symbf[1]{{\bm{##1}}}%
  \DeclareRobustCommand\symbfsf[1]{{\bm{##1}}}%
  \let\increment\Delta
  \renewcommand\chd@qed{\openbox}%
  \let\uppi\pi
}

\newcommand\chd@set@math@font{%
  \@nameuse{chd@set@math@font@\chd@math@font}%
}
\chd@option@hook{math-font}{\g@addto@macro\chd@setup@hook{\chd@set@math@font}}
\newcommand\chd@set@math@font@auto{%
  \ifchd@math@font@auto
    \chdsetup{math-font=xits}%
  \fi
}
\AtBeginOfPackageFile*{siunitx}{\chd@set@math@font@auto}
\AtEndPreamble{%
  \chd@set@math@font@auto
  \ifx\square\@undefined
    \RequirePackage{amssymb}%
  \fi
}



% \subsection{纸张和页面}
% 使用 \pkg{geometry} 宏包设置纸张和页面。

% 纸张：A4；

% 页面设置：上、下 2.5 cm，左 3cm，右 2 cm，页眉 1.5 cm，页脚 1.5 cm。

% 注意这里指的是页眉顶部到纸张顶部的距离为 1.5 cm，
% 所以应该是 2.5cm - 0.75cm - 0.25cm = 1.5cm
% 注意 Word 中页面下边距包含了页脚的空间，而 footskip 设置的是页脚到正文的距离。

\geometry{
  paper      = a4paper,
  vmargin    = {2.5cm,2.5cm},
  hmargin    = {3cm,2cm},
  headheight = 0.75cm,
  headsep    = 0.25cm,
  footskip   = 0.0cm,
}

% 使用 \pkg{fancy} 需要先调用 |\pagestyle{fancy}| 再修改 \cs{chaptermark} 和
% \cs{sectionmark}。
\pagestyle{fancy}
\let\sectionmark\@gobble

% 重定义默认的 |plain| page style，会显示页眉和页脚。
\fancypagestyle{plain}{%
  \fancyhf{}%
  %
  % 奇数页页眉与该部分的章标题相同，宋体 10.5 磅（五号）居中。
  % 偶数页页眉为“长安大学博士/硕士/学士学位论文”，宋体 10.5 磅，居中。
  % 注意只有双页打印时才有奇偶页的区别。
  % 页眉线距页眉 2.5mm，线宽 0.5pt，线长与页面齐宽。
  % 页码：宋体 10.5 磅，页面下脚居中。
  \def\chd@hf@font{\fontsize{10.5bp}{12bp}\selectfont}
  \fancyhead[CO]{\chd@hf@font\leftmark}%
  \fancyhead[CE]{\chd@hf@font 长安大学%
    \ifchd@degree@doctor
      博士学位论文
    \else
      \ifchd@degree@master
        硕士学位论文
      \else
        学士学位论文
      \fi
    \fi}%
  \fancyfoot[C]{\chd@hf@font\thepage}%
  \let\@mkboth\markboth
  \def\chaptermark##1{%
    \markboth{\CTEXifname{\CTEXthechapter\quad}{}\chd@spacetitle{##1}}{}%
  }%
  \let\sectionmark\@gobble
  \renewcommand\headruleskip{2.5mm}
  \renewcommand\headrulewidth{0.5pt}
}
\pagestyle{plain}

% |headings| 只有页眉，没有页脚，用于研究生的符号说明和本科生的 front matter。
\fancypagestyle{headings}{\fancyfoot{}}

% |footings| 只有页脚，没有页眉，用于研究生的摘要和目录。
\fancypagestyle{footings}{
  \fancyhf{}
  \fancyfoot[C]{ \thepage}
  \renewcommand\headrulewidth{0pt}
}

% 设置特殊的 page style 不改变任何内容，用于每章首页。
\def\ps@chapter{}
\ctexset{chapter/pagestyle=chapter}

% 空白页不加页眉和页码。
\def\cleardoublepage{%
  \clearpage
  \if@twoside
    \ifodd\c@page\else
      \hbox{}%
      \thispagestyle{empty}%
      \newpage
      \if@twocolumn
        \hbox{}%
        \newpage
      \fi
    \fi
  \fi
}

%
% 研究生要求正文之前无页眉
\renewcommand\frontmatter{%
  \cleardoublepage
  \@mainmatterfalse
  \pagenumbering{Roman}%
  \pagestyle{footings}%
}

% 研究生要求“第 1 章”要另页起，从“主体部分”开始，直至“致谢”结束，用阿拉伯数字连续编码。
\renewcommand\mainmatter{%
  \cleardoublepage
  \@mainmattertrue
  \pagenumbering{arabic}%
  \pagestyle{plain}%
}

% 确保附录部分被视为主要内容的一部分。
\g@addto@macro\appendix{\@mainmattertrue}%


% \subsection{封面}


% 定义用户接口：
\chd@define@key{
  title = {
    default = {论文题目},
  },
  title* = {
    default = {Title},
    name    = title@en,
  },
  author = {
    default = {作者姓名},
  },
  author* = {
    default = {Author Name},
    name    = author@en,
  },
  speciality = {
    default = {专业},
  },
  speciality* = {
    default = {Speciality},
    name    = speciality@en,
  },
  supervisor = {
    default = {导师},
  },
  supervisor* = {
    default = {Supervisor Name},
    name    = supervisor@en,
  },
  professionaltype = {
    default = {工学博士},
  },
  professionaltype* = {
    default = {Doctor of Engineering},
    name    = professionaltype@en,
  },
  advisor = {
    default = {},
  },
  advisor* = {
    default = {},
    name    = advisor@en,
  },
  date = {
    default = {\the\year-\two@digits{\month}-\two@digits{\day}},
  },
  professional-type = {
    name = professional@type,
  },
  professional-type* = {
    name = professional@type@en,
  },
  department,
  class-number = {
    default = {TP391},
    name = class@number,
  },
  student-id = {
    default = {2020xxxxxx},
    name = student@id,
  },
  secret-level = {
    name    = secret@level,
  },
  secret-level* = {
    name    = secret@level@en,
  },
  secret-year = {
    name    = secret@year,
  },
  keywords,
  keywords* = {
    name    = keywords@en,
  },
}

% 导师一栏可能有多个姓名，所以用 \opt{supervisor} 进行收集，
% 然后使用本命令来输出要求的格式，
% 类似于 \LaTeX3 的 \cs{clist\_use:Nn}。
\newcommand\chd@clist@count[1]{%
  \csname clist_count:N\endcsname{#1}%
}
\newcommand\chd@clist@use[2]{%
  \csname clist_use:Nn\endcsname{#1}{#2}%
}
\newcommand\chd@supervisor@names{%
  \chd@clist@use{\chd@supervisor}{\quad}
}
\newcommand\chd@advisor@names{%
  \chd@clist@use{\chd@advisor}{\quad}
}
\newcounter{chd@count}
\newcommand\chd@supervisor@en@line{%
  \setcounter{chd@count}{\chd@clist@count{\chd@supervisor@en}}%
  \ifnum\c@chd@count>1\relax
    Supervisors:%
  \else
    Supervisor:%
  \fi
  \space\chd@clist@use{\chd@supervisor@en}{, }%
}
\newcommand\chd@advisor@en@line{%
  \setcounter{chd@count}{\chd@clist@count{\chd@advisor@en}}%
  \ifnum\c@chd@count>1\relax
    Advisor:%
  \else
    Advisor:%
  \fi
  \space\chd@clist@use{\chd@advisor@en}{, }%
}

% 输出日期的给定格式：\cs{chd@format@date}\marg{format}\marg{date}，
% 其中格式 \meta{format} 接受三个参数分别对应年、月、日，
% \meta{date} 是 ISO 格式的日期（yyyy-mm-dd）。
\newcommand\chd@format@date[2]{%
  \edef\chd@@date{#2}%
  \def\chd@@process@date##1-##2-##3\@nil{%
    #1{##1}{##2}{##3}%
  }%
  \expandafter\chd@@process@date\chd@@date\@nil
}
\newcommand\chd@date@format@zh@small[3]{\number#1 年 \number#2 月 \number#3 日}
\newcommand\chd@date@format@zh@big[3]{\zhdigits{#1}年\zhnumber{#2}月\zhnumber{#3}日}
\newcommand\chd@date@month[1]{%
  \ifcase\number#1\or
    January\or February\or March\or April\or May\or June\or
    July\or August\or September\or October\or November\or December%
  \fi
}
\newcommand\chd@date@format@zh@short[3]{\number#1 年 \number#2 月}
\newcommand\chd@date@format@en[3]{\chd@date@month{#2} \number#3, #1}
\newcommand\chd@date@zh@small{\chd@format@date{\chd@date@format@zh@small}{\chd@date}}
\newcommand\chd@date@zh@big{\chd@format@date{\chd@date@format@zh@big}{\chd@date}}
\newcommand\chd@date@zh@short{\chd@format@date{\chd@date@format@zh@short}{\chd@date}}
\newcommand\chd@date@en{\chd@format@date{\chd@date@format@en}{\chd@date}}


% 定义一些常量。
\newcommand\@sbf[1]{\renewcommand{\CJKglue}{\hskip 0.79cm}\scalebox{0.8}[1]{#1}}
\newcommand\@sbfp[1]{\scalebox{0.8}[1]{#1}}
\newcommand\@tabincell[2]{\begin{tabular}{@{}#1@{}}#2\end{tabular}}
\ifchd@degree@doctor
  \newcommand\chd@thesis@name{\CJKfamily{zhzs}\@sbf{博士学位论文}}
  \newcommand\chd@thesis@name@en{A Dissertation Submitted for the Degree of Doctor}
\else
  \ifchd@degree@master
    \newcommand\chd@thesis@name{\CJKfamily{zhzs}\@sbf{硕士学位论文}}
    \newcommand\chd@thesis@name@en{A Thesis Submitted for the Degree of Master}
  \else
    \newcommand\chd@thesis@name{学士学位论文}
    \newcommand\chd@thesis@name@en{A dissertation for bachelor's degree}
  \fi
\fi
\ifchd@degree@type@academic
  \newcommand\chd@speciality@name{学科专业名称}
\else
  \ifchd@degree@doctor
    \renewcommand\chd@thesis@name{\CJKfamily{zhzs}\@sbfp{工程博士学位论文}}
  \else
    \renewcommand\chd@thesis@name{\CJKfamily{zhzs}\@sbfp{专业硕士学位论文}}
  \fi
  \ifchd@cjk@font@mac
    \providecommand\lishu{\CJKfamily{zhli}}
  \else
    \ifchd@cjk@font@windows
      \setCJKfamilyfont{zhli}{LiSu}
      \providecommand\lishu{\CJKfamily{zhli}}
    \else
      \chd@warning{LiShu font is required}
      \providecommand\lishu{\sffamily}
    \fi
  \fi
  \newcommand\chd@speciality@name{\fontsize{10.5bp}{16bp}\selectfont \makecell{专业学位类别\\及领域名称}}
\fi

% 添加 PDF 书签，在 \pkg{hyperref} 载入后才有效。
\newcommand\chd@pdfbookmark{\@gobble}

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
% 分类号及学号宋体 13.98 磅，单倍行距；
% 论文类型华文中宋 45 磅；
% 论文题目宋体 22.02 磅居中，单倍行距；
% 作者姓名宋体 13.98 磅，单倍行距；
% 表格中“导师姓名职称”、“申请学位类别”、“论文提交日期”、“论文答辩日期”、“学位授予单位”宋体 13.98 磅，单倍行距，右对齐；
% 学术型论文的“学科专业名称”宋体 13.98 磅，单倍行距，居中；
% 专业型论文的“专业学位类别及领域名称”宋体 10.5 磅，1.5倍行距，居中。
% 注意表格的宽度和高度根据所填内容自动调整，所以实际宽高有所偏差，
% 所以只能使用直尺测量。
%《撰写规范》中首页在标题作者和表格之间没有明确的距离，但不设置不美观，
% 所以应该根据实际情况调整。
\newcommand\chd@title@page@graduate@zh{%
  \chdsetup{language=chinese}%
  \begin{titlepage}%
    \chd@pdfbookmark{封面}%
    \centering
    {\fontsize{14bp}{31bp}\selectfont
      \begin{tabular}{p{12.42cm}r}%
        \ifx\chd@secret@level\@empty  
          分类号:  \chd@class@number
        \else
          \multicolumn{2}{r}{\chd@secret@level$\bigstar$\hspace{1.5mm}\chd@secret@year 年}\\
          分类号:  \chd@class@number
        \fi & 
        \ifchd@badge@color@red
          \multirow{2}{18mm}[-1.8mm]{\includegraphics[height=1.78cm]{figures/chd-redlogo.pdf}}
        \else
          \multirow{2}{18mm}[-1.8mm]{\includegraphics[height=1.78cm]{figures/chd-blacklogo.pdf}}
        \fi \\
        10710-\chd@student@id &  \\
      \end{tabular}}%
    \vskip 1.1cm%
    \includegraphics[width=5.41cm]{figures/chd-name.pdf}\par
    \vskip 0.38cm%
    {\fontsize{45bp}{45bp}\selectfont
      \chd@thesis@name\par}%
    \vskip -0.11cm%
    \parbox[t][3.5cm][c]{\textwidth}{%
      \centering\fontsize{22bp}{22bp}\selectfont
      \chd@title\par}\par
    {\fontsize{14bp}{31bp}\selectfont
      \chd@author\par}%
    \vskip 3.4cm% 可调节标题作者与表格间的距离使首页更美观
    {\fontsize{14bp}{31bp}\selectfont
      \hspace{3mm}
      \begin{tabular}{lp{8em}lp{8em}}%
        导师姓名职称 & \multicolumn{3}{c}{\chd@supervisor@names} \\
        \cline{2-4}
        申请学位类别 & \multicolumn{1}{c}{\chd@professionaltype} & \chd@speciality@name & \multicolumn{1}{c}{\chd@speciality}\\
        \cline{2-2}\cline{4-4}
        论文提交日期 & \multicolumn{1}{c}{\chd@date@zh@small} & 论文答辩日期 & \multicolumn{1}{c}{\chd@date@zh@small} \\
        \cline{2-2}\cline{4-4}
        学位授予单位 & \multicolumn{3}{c}{长安大学} \\
        \cline{2-4}
      \end{tabular}\par}%
  \end{titlepage}%
  \chd@reset@main@language
}

% 英文封面
\newcommand\chd@title@page@graduate@en{%
  \chdsetup{language=english}%
  \begin{titlepage}%
    \chd@pdfbookmark{Title page}%
    \centering
    \vspace*{3.15cm}%
    \parbox[t][3.3cm][t]{\textwidth}{%
      \centering\rmfamily\bfseries\fontsize{18bp}{30bp}\selectfont
      \chd@title@en\par}\par
    {\rmfamily\fontsize{14bp}{30bp}\selectfont
      \chd@thesis@name@en\par}%
    \vskip 3.06cm%
    \ifx\chd@advisor\@empty
      {\rmfamily\bfseries\fontsize{15bp}{30bp}\selectfont
        \begin{tabular}{@{}ll@{}}%
          Candidate: & \chd@author@en \\[1.11cm]
          Supervisor: & \chd@supervisor@en \\
        \end{tabular}}\par%
        \vskip 4.6cm%
    \else
      {\rmfamily\bfseries\fontsize{15bp}{30bp}\selectfont
        \begin{tabular}{@{}ll@{}}%
          Candidate: & \chd@author@en \\[1.11cm]
          Supervisor: & \chd@supervisor@en \\
          & \chd@advisor@en \\
        \end{tabular}}\par%
        \vskip 3.55cm%
    \fi
    {\fontsize{15bp}{30bp}\selectfont Chang'an University, Xi'an, China}
  \end{titlepage}%
  \chd@reset@main@language
}

% 重新定义 \cs{maketitle}，调用 \cs{chd@makezhtitle}, \cs{chd@makeentitle}
% 分别生成中、英文封面。
\renewcommand\maketitle{%
  \newgeometry{margin=2.54cm}%
  \pagenumbering{Alph}%
  \pagestyle{empty}%
  \ifchd@degree@graduate
    \chd@title@page@graduate@zh
    \chd@title@page@graduate@en
  \else
    \chd@title@page@bachelor
  \fi
  \cleardoublepage
  \restoregeometry
  \pagestyle{plain}%
}


% \subsection{原创性声明}

% 定义原创性声明
\newcommand\chd@originality{%
  \fontsize{12bp}{23.4bp}\selectfont 本人声明：本人所呈交的学位论文是在导师的指导下,独立进行研究工作所取%
  得的成果。除论文中已经注明引用的内容外，对论文的研究做出重要贡献的个%
  人和集体，均已在文中以明确方式标明。本论文中不包含任何未加明确注明的%
  其他个人或集体已经公开发表的成果。\par
  本声明的法律责任由本人承担。}
\newcommand\chd@authorization{%
  \fontsize{12bp}{23.4bp}\selectfont 本人在导师指导下所完成的论文及相关的职务作品，知识产权归属学校。学校%
  享有以任何方式发表、复制、公开阅览、借阅以及申请专利等权利。本人离校%
  后发表或使用学位论文或与该论文直接相关的学术论文或成果时，署名单位仍%
  然为长安大学。\\
  （涉密论文在解密后应遵守此规定）}%

\newcommand\copyrightpage{%
  \begin{titlepage}%
    \chd@pdfbookmark{原创性和授权使用声明}%
    \null
    \vspace*{-0.78cm}%
    {\centering\CJKfamily{zhzs}\fontsize{18bp}{32bp}\selectfont
      论文独创性声明\par}%
    \vskip 0.35cm%
    \chd@originality\par
    \vskip 0.82cm%
    \hspace{10.65mm}论文作者签名：\hspace{50.8mm}年\hspace{6.35mm}月\hspace{6.35mm}日
    \par%
    \vskip 19.1mm%
    {\centering\CJKfamily{zhzs}\fontsize{18bp}{32bp}\selectfont
      论文知识产权权属声明\par}%
    \vskip 2.68mm%
    \chd@authorization\par
    \vskip 16.5mm%
    \hspace{10.65mm}论文作者签名：\hspace{50.8mm}年\hspace{6.35mm}月\hspace{6.35mm}日
    \par%
    \vskip 5.5mm%
    \hspace{10.65mm}导\hspace{2.1125mm}师\hspace{2.1125mm}签\hspace{2.1125mm}名\hspace{2.1125mm}：\hspace{50.8mm}年\hspace{6.35mm}月\hspace{6.35mm}日
  \end{titlepage}%
}
\ifchd@degree@bachelor
  \let\copyrightpage\relax
\fi


% \subsection{章节标题}

% 标题最多允许使用五级。
\setcounter{secnumdepth}{5}

% 研究生规定没有规定章题字距，但为了美观，
% 章题为两字时中间空两字，三字时空一字，四字时空半字，四字以上不空。
% 这里用 \LaTeX3 的 \cs{\str_count:N} 判断字数。
% 注意，\pkg{stringstrings} 宏包会导致范数命令 \verb+\|+ 被修改。
\newcount\chd@titlelength
\DeclareRobustCommand\chd@spacetitle[1]{%
  \chd@titlelength=\csname str_count:N\endcsname{#1}%
  \begingroup
    \ifchd@degree@graduate
      \ifcase\chd@titlelength
      \or\or
        \ziju{2}%
      \or
        \ziju{1}%
      \or
        \ziju{0.5}%
      \fi
    \else
      \if@mainmatter\else
        \ifcase\chd@titlelength
        \or\or
          \ziju{1}%
        \or\or
          \ziju{0.5}%
        \fi
      \fi
    \fi
    #1%
  \endgroup
}

% 五级节标题和脚注需要使用带圈的数字，这里使用 \cs{chd@circlefont} ：
\newcommand\chd@textcircled[1]{%
  \ifnum\value{#1}<21\relax
    {\symbol{\numexpr\value{#1} + "245F\relax}}%
  \else
    \chd@error{Cannot display more than 20 footnotes}%
  \fi
}

% 用 \pkg{ctex} 的接口设置全部章节标题格式。

% 各章标题：黑体 16 磅加粗居中，单倍行距，段前 11 磅（0.5 行），段后 13.5 磅（0.5 行），
% 章序号与章名间空半字宽。

% 由于 Word 模板中使用“单倍行距”，还“对齐到网格”，这在 TeX 中不容易实现。
% 所以目前按照默认的行距。

% 注意 \pkg{ctex} v2.4.3 以下版本的bug会导致章节标题前后的距离的实际值偏大。
% 另外 \pkg{ctex} v2.2 前的beforeskip的符号有特殊意义。
\ctexset{
  chapter = {
    format      = \centering\heiti\bfseries\fontsize{16bp}{26.7bp}\selectfont,
    nameformat  = {},
    titleformat = \chd@spacetitle,
    number      = \chinese{chapter},
    aftername   = \hspace{0.5\ccwd},
    beforeskip  = 11bp,
    afterskip   = 13.5bp,
    fixskip     = true,
  },
}

% 一级节标题：黑体 14 磅左顶格，单倍行距，段前 10 磅，段后 0.2 磅，
% 序号与题名间空半字宽。
\ctexset{
  section = {
    format     = \vspace*{1bp}\heiti\bfseries\fontsize{14bp}{23.33bp}\selectfont,
    aftername  = \hspace{0.5\ccwd},
    beforeskip = 10bp,
    afterskip  = 0.2bp,
  },
  %
  % 二级节标题：黑体 12 磅，左缩进两字，单倍行距，段前 10 磅，段后 0.4 磅，
  % 序号与题名间空半字宽。
  subsection = {
    format     = \heiti\bfseries\fontsize{12bp}{21.67bp}\selectfont,
    aftername  = \hspace{0.5\ccwd},
    beforeskip = 10bp,
    afterskip  = 0.4bp,
  },
  %
  % 三级及以下节标题的格式没有具体规定，按照 Word 模板的格式：
  % 使用黑体 12 磅，左缩进两字，行距 20 磅，段前段后 0 磅，序号与题名间空半字宽。
  subsubsection = {
    format     = \heiti\fontsize{12bp}{20bp}\selectfont,
    number     = \arabic{subsubsection},
    aftername  = .\hspace{0.5\ccwd},
    indent     = 2\ccwd,
    beforeskip = \z@,
    afterskip  = \z@,
  },
  %
  % 按照 Word 模板的格式，四级节标题：宋体 12 磅，左缩进两字，行距 20 磅，
  % 段前段后 0 磅，序号使用全宽括号，与题名间空半字宽。
  paragraph = {
    format     = \rmfamily\fontsize{12bp}{20bp}\selectfont,
    number     = （\arabic{paragraph}）,
    aftername  = \hspace{0.5\ccwd},
    indent     = 2\ccwd,
    beforeskip = \z@,
    afterskip  = \z@,
    runin      = false,
  },
  %
  % 按照 Word 模板的格式，五级节标题：宋体 12 磅，左缩进两字，行距 20 磅，
  % 段前段后 0 磅，序号使用全宽括号，与题名间空半字宽。
  subparagraph = {
    format     = \rmfamily\fontsize{12bp}{20bp}\selectfont,
    number     = \chd@textcircled{subparagraph},
    aftername  = \hspace{0.5\ccwd},
    indent     = 2\ccwd,
    beforeskip = \z@,
    afterskip  = \z@,
    runin      = false,
  },
}

\ifchd@degree@bachelor
  \ifchd@main@language@english
    \chdsetup{section-style = arabic}
  \fi
\fi
\chd@option@hook{main-language}{%
  \ifchd@degree@bachelor
    \ifchd@main@language@english
      \chdsetup{section-style = arabic}%
    \fi
  \fi
}

% 在研究生格式的基础上再设置本科生的章节标题格式。
\ifchd@degree@bachelor
  \setcounter{secnumdepth}{4}
  \ctexset{
  %
  % 论文的致谢、目录、摘要和参考文献等标题用小二号（18 bp）黑体字，居中，
  % 这通过 \cs{if@mainmatter} 区分。
  % 正文中的标题分章、节、段三级；章、节标题居中，段标题居左，
  % 分别用三号（16 bp）黑体、小三（15 bp）黑体、四号（14 bp）黑体。
    chapter = {
      format = {
        \centering\sffamily
        \if@mainmatter
          \fontsize{16bp}{29.33bp}\selectfont
        \else
          \fontsize{18bp}{33bp}\selectfont
        \fi
      },
    },
    section = {
      format = \centering\sffamily\fontsize{15bp}{27.5bp}\selectfont,
    },
    subsection = {
      format    = \sffamily\fontsize{14bp}{25.67bp}\selectfont,
      indent    = \z@,
    },
    subsubsection = {
      format    = \rmfamily\fontsize{12bp}{22bp}\selectfont,
      indent    = \ccwd,
    },
    paragraph = {
      format    = \rmfamily\fontsize{12bp}{22bp}\selectfont,
      aftername = {},
      indent    = \ccwd,
    },
  }
  %
  % 本科生的阿拉伯数字式标题的格式与研究生几乎一致，只有中文数字式需要修改。
  \ifchd@section@style@arabic\else
    \ctexset{
      chapter = {
        number = \chinese{chapter},
      },
      section = {
        name   = {第,节},
        number = \chinese{section},
      },
      subsection = {
        number    = \chinese{subsection},
        aftername = {、},
      },
    }
  \fi
\fi

% 默认的 \cs{chapter*} 生成的章标题没有编号、不更改页眉，
% 也不添加进目录或 PDF 书签。
% 然而像摘要、目录、符号说明这样的章节，它们不需要编号、不加入目录，
% 但是需要修改页眉，并且加入 PDF 标签。
% 所以我们新定义 \cs{chd@chapter} 用于处理这些章节。%
\NewDocumentCommand\chd@chapter{o m}{%
  \if@openright\cleardoublepage\else\clearpage\fi
  \IfValueTF{#1}{%
    \chd@pdfbookmark{#1}%
    \chaptermark{#1}%
  }{%
    \chd@pdfbookmark{#2}%
    \chaptermark{#2}%
  }%
  \chapter*{#2}}

% \subsection{摘要}

% 中文摘要环境。
\newcommand\chd@keywords@text{%
  \ifchd@degree@graduate
    \chd@clist@use{\chd@keywords}{，}%
  \else
    \chd@clist@use{\chd@keywords}{；}%
  \fi
}
\newcommand\chd@keywords@en@text{%
  \ifchd@degree@graduate
    \chd@clist@use{\chd@keywords@en}{, }%
  \else
    \chd@clist@use{\chd@keywords@en}{; }%
  \fi
}
\newenvironment{abstract}{%
  \chdsetup{language=chinese}%
  \chd@chapter{摘要}%
  \addcontentsline{toc}{chapter}{摘要} % 将摘要加入目录
}{
  \par\null\par\noindent\hangindent=4\ccwd\relax
  \textbf{关键词}：\chd@keywords@text\par
  \chd@reset@main@language
}

\newbox\chd@keywords@box
\newlength\chd@keywords@width

% 英文摘要环境
\newenvironment{abstract*}{%
  \chdsetup{language=english}%
  \chd@chapter{\rmfamily\textbf{Abstract}}%
  \addcontentsline{toc}{chapter}{Abstract} % 将摘要加入目录
}{
  \par\null\par\noindent
  \savebox\chd@keywords@box{\textbf{Key Words}: }%
  \chd@keywords@width=\linewidth
  \advance\chd@keywords@width-\wd\chd@keywords@box
  \textbf{Key Words}: \parbox[t]{\chd@keywords@width}{\chd@keywords@en@text\par}\par
  \ifchd@degree@graduate
    \cleardoublepage
  \fi
  \chd@reset@main@language
}

% \subsection{目录}

% 研究生规定目录另面起；
% 本科生规定从目录开始编页码，所以必须另页起。
\renewcommand\tableofcontents{%
  \ifchd@degree@bachelor
    \cleardoublepage
    \pagenumbering{arabic}%
    \pagestyle{plain}%
  \fi
  \chd@chapter{\contentsname}%
  \vspace*{-1.5mm}%
  \@starttoc{toc}%
}

% 下面用 \pkg{titletoc} 宏包设置目录内容的格式。
% 先定义目录线：
\newcommand\chd@leaders{%
  \hspace{2bp}%
  \titlerule*[4bp]{.}%
  \hspace{2bp}%
}

\contentsmargin{0bp}

% 各章目录要求黑体加粗 12 磅（小四号），单倍行距，段前 6 磅（0.5行），段后 0 磅，两端对齐，
% 页码右对齐，章序号与章名间空半字。
% 但是 Word 模板中实际是行距 16 磅。
\ifchd@degree@graduate
  \titlecontents{chapter}
    [\z@]{\addvspace{2bp}\CJKfamily{zhhei}\fontsize{12bp}{20bp}\selectfont}
    {\contentspush{\thecontentslabel\hspace{0.5\ccwd}}}{}
    {\fontsize{12bp}{24bp}\selectfont\chd@leaders\thecontentspage}
    %
    % 一级节标题目录要求宋体 12 磅（小四号），1.5倍行距，左缩进一字，段前 0 磅，段后 0 磅，
    % 两端对齐，页码右对齐，序号与题名间空半字。
    % Word 模板中实际是行距 23.4 磅，段前 0 磅。
  \titlecontents{section}
    [2\ccwd]{\fontsize{12bp}{23.4bp}\selectfont}
    {\contentspush{\thecontentslabel\hspace{0.5\ccwd}}}{}
    {\chd@leaders\thecontentspage}
    %
    % 二级节标题目录要求宋体 12 磅（小四号），单倍行距，左缩进两字，段前 0 磅，段后 0 磅，
    % 两端对齐，页码右对齐，序号与题名间空半字。
    % Word 模板中实际是行距 23.4 磅，段前 0 磅。
  \titlecontents{subsection}
    [3\ccwd]{\fontsize{12bp}{23.4bp}\selectfont}
    {\contentspush{\thecontentslabel\hspace{0.5\ccwd}}}{}
    {\chd@leaders\thecontentspage}
    %
    % 本科生的目录使用小四宋体（同正文字体），其他同研究生的格式相近。
\else
  \titlecontents{chapter}
    [\z@]{\normalsize}
    {\contentspush{\thecontentslabel\unskip\hspace{\ccwd}}}{}
    {\chd@leaders\thecontentspage}
  \titlecontents{section}
    [\ccwd]{\normalsize}
    {\contentspush{\thecontentslabel\hspace{\ccwd}}}{}
    {\chd@leaders\thecontentspage}
  \titlecontents{subsection}
    [2\ccwd]{\normalsize}
    {\contentspush{\thecontentslabel
      \ifchd@section@style@arabic\hspace{\ccwd}\else 、\fi}}{}
    {\chd@leaders\thecontentspage}
\fi

% 本科生要求目录中正文每章前多空一行，而目录、附录等章则不需要空行，
% 所以不能简单判断 \cs{if@mainmatter}，需要重新定义 \cs{mainmatter} 等命令。
\newif\ifchd@addtocspace
\ifchd@degree@bachelor
  \chd@addtocspacetrue
  \g@addto@macro\frontmatter{\chd@addtocspacefalse}%
  \g@addto@macro\mainmatter{\chd@addtocspacetrue}%
  \g@addto@macro\backmatter{\chd@addtocspacefalse}%
  \g@addto@macro\appendix{\chd@addtocspacefalse}%
\fi

% 处理本科生在目录中添加空行。
\renewcommand\chapter{%
  \if@openright\cleardoublepage\else\clearpage\fi
  \thispagestyle{\CTEX@chapter@pagestyle}%
  \global\@topnum\z@
  \@afterindenttrue
  \ifchd@degree@bachelor
    \ifchd@addtocspace
      \addtocontents{toc}{\protect\addvspace{12bp}}%
    \fi
  \fi
  \secdef\@chapter\@schapter
}

% 研究生要求图、表的清单须另页起。
\newlength{\chd@lof@label@width}
\newcommand\chd@set@lof@format{%
  \settowidth{\chd@lof@label@width}{\figurename~9.99}%
  \addtolength{\chd@lof@label@width}{1em}%
  \titlecontents{figure}%
    [\chd@lof@label@width]{\normalsize}%
    {\contentslabel[\figurename~\thecontentslabel]{\chd@lof@label@width}}{}%
    {\chd@leaders\thecontentspage}%
  \titlecontents{table}%
    [\chd@lof@label@width]{\normalsize}%
    {\contentslabel[\tablename~\thecontentslabel]{\chd@lof@label@width}}{}%
    {\chd@leaders\thecontentspage}%
}
\chd@set@lof@format
\chd@option@hook{main-language}{\chd@set@lof@format}
\renewcommand\listoffigures{%
  \ifchd@degree@graduate
    \cleardoublepage
  \fi
  \chd@chapter{\listfigurename}%
  \@starttoc{lof}%
}
\renewcommand\listoftables{%
  \ifchd@degree@graduate
    \cleardoublepage
  \fi
  \chd@chapter{\listtablename}%
  \@starttoc{lot}%
}


% \subsection{符号说明}

% 研究生规定符号说明另页起，标题字体字号等同论文正文，
% 《撰写手册》第 9 页 1.10(2) 还规定“符号说明不加页码”。
\newenvironment{notation}{%
  \ifchd@degree@graduate
    \cleardoublepage
    \pagestyle{headings}%
  \fi
  \chd@chapter{\chd@notation@name}%
}{%
  \ifchd@degree@graduate
    \clearpage
    \pagestyle{plain}%
  \fi
}%
\newcommand*\notationlabel[1]{#1\hfil}%
\newenvironment{notationlist}[1]{%
  \list{}{%
    \itemsep 3bp%
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

% 禁止扩大段间距。（\href{https://github.com/chdtug/chdthesis/issues/209}{
%   chdtug/chdthesis\#209}）
\raggedbottom

% 段间距 0 磅。
\setlength{\parskip}{\z@}

% 首段缩进。
\ctexset{autoindent=2}

% 首段缩进。
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
\renewcommand\thefootnote{\chd@textcircled{footnote}}

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
\newcommand\chd@nolistsep{%
  \parsep 0\p@ \@plus.2\p@
  \topsep 0\p@ \@plus.2\p@
  \itemsep0\p@ \@plus.2\p@
}
\def\@listi{\leftmargin\leftmargini
            \chd@nolistsep}
\let\@listI\@listi
\@listi
\def\@listii {\leftmargin\leftmarginii
              \labelwidth\leftmarginii
              \advance\labelwidth-\labelsep
              \chd@nolistsep}
\def\@listiii{\leftmargin\leftmarginiii
              \labelwidth\leftmarginiii
              \advance\labelwidth-\labelsep
              \chd@nolistsep}


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

% 修改默认的浮动体描述符为 |h|。
\def\fps@figure{h}
\def\fps@table{h}

% 用 \pkg{caption} 宏包设置图、表的格式：

% 图号、图题置于图的下方，宋体 10.5 磅居中，单倍行距，段前 8 磅，段后 8 磅，
% 图号与图题文字之间空半角2格，图号、图题加粗。
% 图注位于图的下方，左缩进两字，续行悬挂缩进左对齐，两端对齐。

% 表号、表题置于表的上方，黑体 10.5 磅居中，单倍行距，段前 8 磅，段后 8 磅，
% 表号与表题文字之间空半角2格，表号、表题加粗。
% 表注左缩进两字，续行悬挂缩进左对齐，两端对齐。
\setlength{\floatsep}{6bp}
\setlength{\textfloatsep}{6bp}
\setlength{\intextsep}{8bp}

\DeclareCaptionFont{chd}{%
  \ifchd@language@chinese
    \fontsize{10.5bp}{13.65bp}\selectfont
  \else
    \fontsize{10.5bp}{12.075bp}\selectfont
  \fi
}

\captionsetup{
  font           = chd,
  labelsep       = quad,
  skip           = 6bp,
  figureposition = bottom,
  tableposition  = top,
}
\ifchd@degree@graduate
  \captionsetup{font+=bf}
\fi
\captionsetup[figure]{
  aboveskip = 8bp,
  belowskip = 0bp,
}
\captionsetup[table]{
  aboveskip = 0bp,
  belowskip = 4.5bp,
}

% 由于 LaTeX2e kernel 的问题，图表等浮动体与文字前后的距离不一致，需要进行 patch。
% 参考 \href{https://github.com/tuna/thuthesis/issues/614}{tuna/thuthesis/issues\#614}、
% \url{https://www.zhihu.com/question/46618031} 和
% \url{https://tex.stackexchange.com/a/40363/82731}。
%    \begin{macrocode}
\patchcmd{\@addtocurcol}%
  {\vskip \intextsep}%
  {\edef\save@first@penalty{\the\lastpenalty}\unpenalty
   \ifnum \lastpenalty = \@M  % hopefully the OR penalty
     \unpenalty
   \else
     \penalty \save@first@penalty \relax % put it back
   \fi
   \ifnum\outputpenalty <-\@Mii
     \addvspace\intextsep
     \vskip\parskip
   \else
     \addvspace\intextsep
   \fi}%
  {}{\chd@patch@error{\@addtocurcol}}
\patchcmd{\@addtocurcol}%
  {\vskip\intextsep \ifnum\outputpenalty <-\@Mii \vskip -\parskip\fi}%
  {\ifnum\outputpenalty <-\@Mii
     \aftergroup\vskip\aftergroup\intextsep
     \aftergroup\nointerlineskip
   \else
     \vskip\intextsep
   \fi}%
  {}{\chd@patch@error{\@addtocurcol}}
\patchcmd{\@getpen}{\@M}{\@Mi}
  {}{\chd@patch@error{\@getpen}}

% 新定义了 \cs{note} 来生成图表的附注。
% 如果用 \cs{caption} 生成图表的附注会导致图表的序号有误；
% 如果用 \cs{bicaption} 会导致表注无法置于表后，而且对齐方式不对。
\newcommand\note[1]{%
  \begingroup
    \captionsetup{
      font          = chd,
      margin        = 2\ccwd,
      position      = bottom,
    }%
    \caption*{#1}%
  \endgroup
}

% 表格默认字号略小
\patchcmd\@floatboxreset{%
  \normalsize
}{%
  \small
}{}{\chd@patch@error{\@floatboxreset}}

% 对 \pkg{longtable} 跨页表格进行相同的设置。
%
% 在 Word 模板中按照正确的设置（需要去掉文档网格），
% 中文模板每页能装下 1 行标题、1 行表头、30 行表身，
% 英文模板每页能装下 1 行标题、1 行表头、33 行表身。
%    \begin{macrocode}
\AtEndOfPackageFile*{longtable}{
  \AtBeginEnvironment{longtable}{%
    \ifdim\f@size pt > 12pt\relax
      \small
    \fi
  }
}

% \subsection{参考文献}

\PassOptionsToPackage{compress}{natbib}

\AtEndOfPackageFile*{natbib}{
  % 定义几种引用文献的标注样式。
  \newcommand\bibstyle@super{\bibpunct{[}{]}{,}{s}{,}{\textsuperscript{,}}}
  \newcommand\bibstyle@inline{\bibpunct{[}{]}{,}{n}{,}{,}}
  \newcommand\bibstyle@authoryear{\bibpunct{(}{)}{;}{a}{,}{,}}
  \@namedef{bibstyle@author-year}{\bibstyle@authoryear}
  %
  % 几种种引用样式，与 \file{bst} 文件名保持一致，
  % 这样在使用 \cs{bibliographystyle} 选择参考文献表的样式时也会设置对应的引用样式。
  \@namedef{bibstyle@chdthesis-numerical}{\bibstyle@super}
  \@namedef{bibstyle@chdthesis-authoryear}{\bibstyle@authoryear}
  \@namedef{bibstyle@chdthesis-bachelor}{\bibstyle@super}
  %
  % 如果载入 `natbib` 前设置了 `cite-style`，这里先进行配置。
  % https://github.com/chdtug/chdthesis/issues/327
  \ifx\chd@cite@style\@empty\else
    \citestyle{\chd@cite@style}%
  \fi
  %
  % 定义接口 cite-style 切换引用样式。
  \chd@option@hook{cite-style}{%
    \citestyle{\chd@cite@style}%
  }
  %
  % 如果文献序号作为叙述文字的一部分，需要临时将文献序号与正文平排
  \DeclareRobustCommand\inlinecite{\@inlinecite}
  \def\@inlinecite#1{\begingroup\let\@cite\NAT@citenum\citep{#1}\endgroup}
  %
  % 修改引用的样式。
  % 这里在 filehook 中无法使用 \cs{patchcmd}，所以只能手动重定义。
  %
  % 将 super 式 \cs{citep} 引用的页码置于括号外。
  \renewcommand\NAT@citesuper[3]{%
    \ifNAT@swa
      \if*#2*\else
        #2\NAT@spacechar
      \fi
      % \unskip\kern\p@\textsuperscript{\NAT@@open#1\NAT@@close}%
      %  \if*#3*\else\NAT@spacechar#3\fi\else #1\fi\endgroup}
      \unskip\kern\p@
      \textsuperscript{%
        \NAT@@open#1\NAT@@close
        \if*#3*\else#3\fi
      }%
      \kern\p@
    \else
      #1%
    \fi
    \endgroup
  }
  %
  % 将 numbers 式 \cs{citep} 引用的页码置于括号外并改为上标。
  \renewcommand\NAT@citenum[3]{%
    \ifNAT@swa
      \NAT@@open
      \if*#2*\else
        #2\NAT@spacechar
      \fi
      % #1\if*#3*\else\NAT@cmt#3\fi\NAT@@close
      #1\NAT@@close
      \if*#3*\else
        \textsuperscript{#3}%
      \fi
    \else
      #1%
    \fi
    \endgroup
  }
  %
  % 在 filehook 中无法使用 \cs{patchcmd}，所以只能手动重定义。
  \def\NAT@citexnum[#1][#2]#3{%
    \NAT@reset@parser
    \NAT@sort@cites{#3}%
    \NAT@reset@citea
    \@cite{\def\NAT@num{-1}\let\NAT@last@yr\relax\let\NAT@nm\@empty
      \@for\@citeb:=\NAT@cite@list\do
      {\@safe@activestrue
      \edef\@citeb{\expandafter\@firstofone\@citeb\@empty}%
      \@safe@activesfalse
      \@ifundefined{b@\@citeb\@extra@b@citeb}{%
        {\reset@font\bfseries?}
          \NAT@citeundefined\PackageWarning{natbib}%
        {Citation `\@citeb' on page \thepage \space undefined}}%
      {\let\NAT@last@num\NAT@num\let\NAT@last@nm\NAT@nm
        \NAT@parse{\@citeb}%
        \ifNAT@longnames\@ifundefined{bv@\@citeb\@extra@b@citeb}{%
          \let\NAT@name=\NAT@all@names
          \global\@namedef{bv@\@citeb\@extra@b@citeb}{}}{}%
        \fi
        \ifNAT@full\let\NAT@nm\NAT@all@names\else
          \let\NAT@nm\NAT@name\fi
        \ifNAT@swa
        \@ifnum{\NAT@ctype>\@ne}{%
          \@citea
          \NAT@hyper@{\@ifnum{\NAT@ctype=\tw@}{\NAT@test{\NAT@ctype}}{\NAT@alias}}%
        }{%
          \@ifnum{\NAT@cmprs>\z@}{%
          \NAT@ifcat@num\NAT@num
            {\let\NAT@nm=\NAT@num}%
            {\def\NAT@nm{-2}}%
          \NAT@ifcat@num\NAT@last@num
            {\@tempcnta=\NAT@last@num\relax}%
            {\@tempcnta\m@ne}%
          \@ifnum{\NAT@nm=\@tempcnta}{%
            \@ifnum{\NAT@merge>\@ne}{}{\NAT@last@yr@mbox}%
          }{%
            \advance\@tempcnta by\@ne
            \@ifnum{\NAT@nm=\@tempcnta}{%
              % 在顺序编码制下，\pkg{natbib} 只有在三个以上连续文献引用才会使用连接号，
              % 这里修改为允许两个引用使用连接号。
              % 参考 https://tex.stackexchange.com/a/86991/82731 。
              %
              % \ifx\NAT@last@yr\relax
              %   \def@NAT@last@yr{\@citea}%
              % \else
              %   \def@NAT@last@yr{--\NAT@penalty}%
              % \fi
              \def@NAT@last@yr{-\NAT@penalty}%
            }{%
              \NAT@last@yr@mbox
            }%
          }%
          }{%
          \@tempswatrue
          \@ifnum{\NAT@merge>\@ne}{\@ifnum{\NAT@last@num=\NAT@num\relax}{\@tempswafalse}{}}{}%
          \if@tempswa\NAT@citea@mbox\fi
          }%
        }%
        \NAT@def@citea
        \else
          \ifcase\NAT@ctype
            \ifx\NAT@last@nm\NAT@nm \NAT@yrsep\NAT@penalty\NAT@space\else
              \@citea \NAT@test{\@ne}\NAT@spacechar\NAT@mbox{\NAT@super@kern\NAT@@open}%
            \fi
            \if*#1*\else#1\NAT@spacechar\fi
            \NAT@mbox{\NAT@hyper@{{\citenumfont{\NAT@num}}}}%
            \NAT@def@citea@box
          \or
            \NAT@hyper@citea@space{\NAT@test{\NAT@ctype}}%
          \or
            \NAT@hyper@citea@space{\NAT@test{\NAT@ctype}}%
          \or
            \NAT@hyper@citea@space\NAT@alias
          \fi
        \fi
      }%
      }%
        \@ifnum{\NAT@cmprs>\z@}{\NAT@last@yr}{}%
        \ifNAT@swa\else
          % 将 numerical 式 \cs{citet} 引用的页码置于括号外并改为上标。
          %
          % \@ifnum{\NAT@ctype=\z@}{%
          %   \if*#2*\else\NAT@cmt#2\fi
          % }{}%
          \NAT@mbox{\NAT@@close}%
          \@ifnum{\NAT@ctype=\z@}{%
            \if*#2*\else
              \textsuperscript{#2}%
            \fi
          }{}%
          \NAT@super@kern
        \fi
    }{#1}{#2}%
  }%
  %
  % 将 author-year 式 \cs{citep} 引用的页码置于括号外并改为上标：
  \renewcommand\NAT@cite%
      [3]{\ifNAT@swa\NAT@@open\if*#2*\else#2\NAT@spacechar\fi
          % #1\if*#3*\else\NAT@cmt#3\fi\NAT@@close\else#1\fi\endgroup}
          #1\NAT@@close\if*#3*\else\textsuperscript{#3}\fi\else#1\fi\endgroup}
  %
  % 调整 author-year 式 \cs{citet} 引用的页码。
  \def\NAT@citex%
    [#1][#2]#3{%
    \NAT@reset@parser
    \NAT@sort@cites{#3}%
    \NAT@reset@citea
    \@cite{\let\NAT@nm\@empty\let\NAT@year\@empty
      \@for\@citeb:=\NAT@cite@list\do
      {\@safe@activestrue
      \edef\@citeb{\expandafter\@firstofone\@citeb\@empty}%
      \@safe@activesfalse
      \@ifundefined{b@\@citeb\@extra@b@citeb}{\@citea%
        {\reset@font\bfseries ?}\NAT@citeundefined
                  \PackageWarning{natbib}%
        {Citation `\@citeb' on page \thepage \space undefined}\def\NAT@date{}}%
      {\let\NAT@last@nm=\NAT@nm\let\NAT@last@yr=\NAT@year
        \NAT@parse{\@citeb}%
        \ifNAT@longnames\@ifundefined{bv@\@citeb\@extra@b@citeb}{%
          \let\NAT@name=\NAT@all@names
          \global\@namedef{bv@\@citeb\@extra@b@citeb}{}}{}%
        \fi
      \ifNAT@full\let\NAT@nm\NAT@all@names\else
        \let\NAT@nm\NAT@name\fi
      \ifNAT@swa\ifcase\NAT@ctype
        \if\relax\NAT@date\relax
          \@citea\NAT@hyper@{\NAT@nmfmt{\NAT@nm}\NAT@date}%
        \else
          \ifx\NAT@last@nm\NAT@nm\NAT@yrsep
              \ifx\NAT@last@yr\NAT@year
                \def\NAT@temp{{?}}%
                \ifx\NAT@temp\NAT@exlab\PackageWarningNoLine{natbib}%
                {Multiple citation on page \thepage: same authors and
                year\MessageBreak without distinguishing extra
                letter,\MessageBreak appears as question mark}\fi
                \NAT@hyper@{\NAT@exlab}%
              \else\unskip\NAT@spacechar
                \NAT@hyper@{\NAT@date}%
              \fi
          \else
            \@citea\NAT@hyper@{%
              \NAT@nmfmt{\NAT@nm}%
              \hyper@natlinkbreak{%
                \NAT@aysep\NAT@spacechar}{\@citeb\@extra@b@citeb
              }%
              \NAT@date
            }%
          \fi
        \fi
      \or\@citea\NAT@hyper@{\NAT@nmfmt{\NAT@nm}}%
      \or\@citea\NAT@hyper@{\NAT@date}%
      \or\@citea\NAT@hyper@{\NAT@alias}%
      \fi \NAT@def@citea
      \else
        \ifcase\NAT@ctype
          \if\relax\NAT@date\relax
            \@citea\NAT@hyper@{\NAT@nmfmt{\NAT@nm}}%
          \else
          \ifx\NAT@last@nm\NAT@nm\NAT@yrsep
              \ifx\NAT@last@yr\NAT@year
                \def\NAT@temp{{?}}%
                \ifx\NAT@temp\NAT@exlab\PackageWarningNoLine{natbib}%
                {Multiple citation on page \thepage: same authors and
                year\MessageBreak without distinguishing extra
                letter,\MessageBreak appears as question mark}\fi
                \NAT@hyper@{\NAT@exlab}%
              \else
                \unskip\NAT@spacechar
                \NAT@hyper@{\NAT@date}%
              \fi
          \else
            \@citea\NAT@hyper@{%
              \NAT@nmfmt{\NAT@nm}%
              \hyper@natlinkbreak{\NAT@spacechar\NAT@@open\if*#1*\else#1\NAT@spacechar\fi}%
                {\@citeb\@extra@b@citeb}%
              \NAT@date
            }%
          \fi
          \fi
        \or\@citea\NAT@hyper@{\NAT@nmfmt{\NAT@nm}}%
        \or\@citea\NAT@hyper@{\NAT@date}%
        \or\@citea\NAT@hyper@{\NAT@alias}%
        \fi
        \if\relax\NAT@date\relax
          \NAT@def@citea
        \else
          \NAT@def@citea@close
        \fi
      \fi
      }}\ifNAT@swa\else
        % 将 author-year 式 \cs{citet} 引用的页码置于括号外并改为上标。
        %
        % \if*#2*\else\NAT@cmt#2\fi
        \if\relax\NAT@date\relax\else\NAT@@close\fi
        \if*#2*\else\textsuperscript{#2}\fi
      \fi}{#1}{#2}}
  %
  % 为了将参考文献加入目录和 pdf 书签，重新定义 \pkg{natbib} 的 \cmd{bibsection}
  % 另外如果调用了 \pkg{chapterbib} 或者使用了 \opt{sectionbib} 参数，
  % 需要使用节标题 \cs{section}。
  \newcommand\chd@bib@chapter{%
    \@mainmatterfalse
    \chapter{\bibname}%
  }%
  \newcommand\chd@bib@section{%
    \begingroup
      \ctexset{section/numbering=false}%
      \section{\bibname}%
    \endgroup
  }%
  \@ifpackagewith{chapterbib}{sectionbib}{%
    \chd@error{The "sectionbib" option cannot be used with chaperbib if natbib loaded}%
  }{}%
  \@ifpackageloaded{chapterbib}{%
    \let\bibsection\chd@bib@section
  }{%
    \@ifxundefined\NAT@sectionbib{%
      \let\bibsection\chd@bib@chapter
    }{%
      \let\bibsection\chd@bib@section
    }%
  }%
  %
  % 参考文献列表格式：宋体 10.5 磅，行距 20 磅，续行缩进两字，左对齐。
  % 本科生依然是小四宋体。
  \renewcommand\bibfont{%
    \ifchd@degree@graduate
      \fontsize{10.5bp}{20bp}\selectfont
    \else
      \normalsize
    \fi
  }
  \setlength{\bibsep}{0\p@ \@plus.2\p@}
  \renewcommand\@biblabel[1]{[#1]\hfill}
  \setlength{\bibhang}{2\ccwd}
}


% biblatex 宏包的配置

\AtEndOfPackageFile*{biblatex}{
  \DeclareRobustCommand\inlinecite{\parencite}
  \defbibheading{bibliography}[\bibname]{%
    \@mainmatterfalse
    \chapter{\bibname}%
  }
  \renewcommand\bibfont{%
    \ifchd@degree@graduate
      \fontsize{10.5bp}{20bp}\selectfont
    \else
      \normalsize
    \fi
  }
  \setlength{\bibitemsep}{0\p@ \@plus.2\p@}
  \setlength{\bibhang}{2\ccwd}
}

% \subsection{附录}

% 定义了一个满足要求的致谢环境：
\newenvironment{acknowledgements}{%
  \@mainmatterfalse
  \chapter{\chd@acknowledgements@name}%
}{
  \ifchd@degree@bachelor
    \par
    \null\par
    \begingroup
      \raggedleft
      \chd@date@zh@short\par
    \endgroup
  \fi
}


% 发表成果环境：
\newenvironment{publications}{%
  \@mainmatterfalse
  \chapter{\chd@publication@name}%
}{}


% \subsection{其他宏包的设置}

% 这些宏包并非格式要求，但是为了方便同学们使用，在这里进行简单设置。


% \subsubsection{\pkg{hyperref} 宏包}

\AtEndOfPackageFile*{hyperref}{
  \hypersetup{
    bookmarksnumbered  = true,
    bookmarksopen      = true,
    bookmarksopenlevel = 1,
    linktoc            = all,
    unicode            = true,
    psdextra           = true,
  }
  %
  % 如果为 \opt{pdf} 样式，设置 hyperlink 颜色
  \ifchd@output@electronic
    \hypersetup{
      colorlinks = true,
      allcolors  = blue,
    }
  \else
    \hypersetup{hidelinks}
  \fi
  %
  % 填写 PDF 元信息。
  \AtBeginDocument{%
    \ifchd@main@language@chinese
      \hypersetup{
        pdftitle  = \chd@title,
        pdfauthor = \chd@author,
      }%
    \else
      \hypersetup{
        pdftitle  = \chd@title@en,
        pdfauthor = \chd@author@en,
      }%
    \fi
  }
  %
  % 添加 PDF 书签
  %
  \newcounter{chd@bookmarknumber}
  \renewcommand\chd@pdfbookmark[1]{%
    \phantomsection
    \stepcounter{chd@bookmarknumber}%
    \pdfbookmark[0]{#1}{chdchapter.\thechd@bookmarknumber}%
  }
  %
  % 在 PDF 字符串中去掉换行，以减少 \pkg{hyperref} 的警告信息。
  \pdfstringdefDisableCommands{
    \let\\\@empty
    \let\hspace\@gobble
  }
  %
  % \pkg{hyperref} 与 \pkg{unicode-math} 存在一些兼容性问题，见
  % \href{https://github.com/chdtug/chdthesis/issues/223}{%
  %   chdtug/chdthesis\#223}，
  % \href{https://github.com/ho-tex/hyperref/pull/90}{ho-tex/hyperref\#90} 和
  % \href{https://github.com/chdtug/chdthesis/issues/235}{%
  %   chdtug/chdthesis/\#235}。
  \@ifpackagelater{hyperref}{2019/04/27}{}{%
    \g@addto@macro\psdmapshortnames{\let\mu\textmu}%
  }
  %
  % 设置中文的 \cs{autoref}。
  % \footnote{\url{https://tex.stackexchange.com/a/66150/82731}}
  \ifchd@language@chinese
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
  %
  % 本科生需要在 \tableofcontents 处切换 \pagenumbering，
  % 在使用了 notoccite 后会导致 PDF 书签的页码有误（#293），
  % 所以需要补充 https://tex.stackexchange.com/a/593839/82731 的 patch。
  % LuaTeX 不需要这个 patch。
  \ifXeTeX
    \def\HyPL@StorePageLabel#1{%
      \begingroup
        \edef\Hy@tempa{\the\Hy@abspage<<#1>>}%
        \immediate\write\@mainaux{%
          \string\HyPL@Entry{\Hy@tempa}%
        }%
      \endgroup
    }
  \fi
}


% \subsubsection{\pkg{amsthm} 宏包}

\AtEndOfPackageFile*{amsthm}{
  \newtheoremstyle{chdplain}
    {}{}
    {}{2\ccwd}
    {\bfseries}{}
    {\ccwd}{}
  \theoremstyle{chdplain}
  % 定义新的定理
  \ifchd@language@chinese
    \newcommand\chd@assertion@name{断言}
    \newcommand\chd@assumption@name{假设}
    \newcommand\chd@axiom@name{公理}
    \newcommand\chd@corollary@name{推论}
    \newcommand\chd@definition@name{定义}
    \newcommand\chd@example@name{例}
    \newcommand\chd@lemma@name{引理}
    \newcommand\chd@proof@name{证明}
    \newcommand\chd@proposition@name{命题}
    \newcommand\chd@remark@name{注}
    \newcommand\chd@theorem@name{定理}
  \else
    \newcommand\chd@assertion@name{Assertion}
    \newcommand\chd@assumption@name{Assumption}
    \newcommand\chd@axiom@name{Axiom}
    \newcommand\chd@corollary@name{Corollary}
    \newcommand\chd@definition@name{Definition}
    \newcommand\chd@example@name{Example}
    \newcommand\chd@lemma@name{Lemma}
    \newcommand\chd@proof@name{Proof}
    \newcommand\chd@proposition@name{Proposition}
    \newcommand\chd@remark@name{Remark}
    \newcommand\chd@theorem@name{Theorem}
  \fi
  \newtheorem{theorem}             {\chd@theorem@name}    [chapter]
  \newtheorem{assertion}  [theorem]{\chd@assertion@name}
  \newtheorem{axiom}      [theorem]{\chd@axiom@name}
  \newtheorem{corollary}  [theorem]{\chd@corollary@name}
  \newtheorem{lemma}      [theorem]{\chd@lemma@name}
  \newtheorem{proposition}[theorem]{\chd@proposition@name}
  \newtheorem{assumption}          {\chd@assumption@name} [chapter]
  \newtheorem{definition}          {\chd@definition@name} [chapter]
  \newtheorem{example}             {\chd@example@name}    [chapter]
  \newtheorem*{remark}             {\chd@remark@name}
  % \pkg{amsthm} 单独定义了 proof 环境，这里重新定义以满足格式要求。
  % 原本模仿 \pkg{amsthm} 写成 |\item[\hskip\labelsep\hskip2\ccwd #1\hskip\ccwd]|，
  % 但是却会多出一些间隙。
  \renewenvironment{proof}[1][\chd@proof@name]{\par
    \pushQED{\qed}%
    \normalfont \topsep6\p@\@plus6\p@\relax
    \trivlist
      \item\relax\hskip2\ccwd
      \textbf{#1}
      \hskip\ccwd\ignorespaces
    }{%
    \popQED\endtrivlist\@endpefalse
  }
  \renewcommand\qedsymbol{\chd@qed}
}


% \subsubsection{\pkg{algorithm2e} 宏包}

% 按章节编号。
\PassOptionsToPackage{algochapter}{algorithm2e}

\AtEndOfPackageFile*{algorithm2e}{
  \ifchd@language@chinese
    \SetAlgorithmName{算法}{算法}{算法清单}
  \else
    \SetAlgorithmName{Algorithm}{Algorithm}{List of Algorithms}
  \fi
  %
  % 设置算法环境的格式。
  \SetAlCapSkip{6bp}
  \SetAlCapFnt{\small}
  \SetAlCapNameFnt{\small}
  \ifchd@degree@graduate
    \SetAlCapNameSty{textbf}
  \fi
  \SetAlgoCaptionSeparator{\unskip\hspace*{\ccwd}}
  %
  % 设置算法清单的格式
  \renewcommand\listofalgocfs{%
    \ifchd@degree@graduate
      \cleardoublepage
    \fi
    \chd@chapter{\listalgorithmcfname}%
    \@starttoc{loa}%
  }
  \titlecontents{algocf}
    [2.3em]{\normalsize}
    {\contentslabel{2.3em}}{}
    {\chd@leaders\contentspage}
  \contentsuse{algocf}{loa}
}


% \subsubsection{\pkg{mathtools} 宏包}

% \pkg{mathtools} 会修改 \pkg{unicode-math} 的 `\underbrace` 和 `\overbrace`，
% 需要还原为 `\LaTeXunderbrace` 和 `\LaTeXoverbrace`，
% 参考 \url{https://tex.stackexchange.com/q/521394/82731}。
\AtEndOfPackageFile*{mathtools}{
  \@ifpackageloaded{unicode-math}{
    \let\underbrace\LaTeXunderbrace
    \let\overbrace\LaTeXoverbrace
  }{}
}

% \subsubsection{\pkg{nomencl} 宏包}

\AtEndOfPackageFile*{nomencl}{
  \let\nomname\chd@notation@name
  \def\thenomenclature{%
    \ifchd@degree@graduate
      \cleardoublepage
      \pagestyle{headings}%
    \fi
    \chd@chapter{\chd@notation@name}%
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
    \ifchd@degree@graduate
      \clearpage
      \pagestyle{plain}%
    \fi
  }
}


% \subsubsection{\pkg{siunitx} 宏包}

\AtEndOfPackageFile*{siunitx}{
  \newcommand\chd@set@siunitx@language{%
    \ifchd@language@chinese
      \sisetup{
        list-final-separator = { 和~},
        list-pair-separator  = { 和 },
        range-phrase         = {～},
      }%
    \else
      \sisetup{
        list-final-separator = {, and },
        list-pair-separator  = { and },
        range-phrase         = { to },
      }%
    \fi
  }
  \chd@set@siunitx@language
  \chd@option@hook{language}{\chd@set@siunitx@language}
}

% \subsubsection{\pkg{chapterbib} 宏包}

\AtEndOfPackageFile*{chapterbib}{
  \@ifpackageloaded{natbib}{%
    \@ifpackagewith{chapterbib}{sectionbib}{%
      \chd@error{The "sectionbib" option cannot be used with chaperbib if natbib loaded}%
    }{}%
    \renewcommand\bibsection{%
      \begingroup
        \ctexset{section/numbering=false}%
        \section{\bibname}%
      \endgroup
    }
  }{}
}

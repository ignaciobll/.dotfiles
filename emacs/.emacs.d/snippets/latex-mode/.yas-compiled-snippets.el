;;; Compiled snippets and support files for `latex-mode'
;;; Snippet definitions:
;;;
(yas-define-snippets 'latex-mode
                     '(("mtitle" "\\begin{titlepage}\n  \\centering\n  \\vspace*{0.0 cm}\n  \\includegraphics[${3:width=0.3\\textwidth}]{${2:./img/logo.png}}\\\\\\\\[1.0 cm]                 % Logo Universidad\n  \\textsc{\\LARGE Universidad Politécnica de Madrid}\\\\\\\\[2.0 cm]        % Nombre Universidad\n  \\textsc{\\Large $1} \\\\\\\\[0.5 cm]                           % Asignatura / Curso\n  \\rule{\\linewidth}{0.2 mm} \\\\\\\\ [0.4 cm]\n  { \\huge \\bfseries \\thetitle}\\\\\\\\\n  \\rule{\\linewidth}{0.2 mm} \\\\\\\\[1.5 cm]\n\n  \\begin{minipage}{\\textwidth}\n    \\begin{center} \\large\n      \\theauthor\\\\\\\\\n    \\end{center}\n  \\end{minipage}\\\\\\\\[2 cm]\n\n  {\\large \\date}\\\\\\\\[2 cm]\n\n  \\vfill\n\\end{titlepage}\n" "Latex Title Page" nil
                        ("latex")
                        nil "/home/ignaciobll/.emacs.d/snippets/latex-mode/titlepage.yasnippet" nil nil)
                       ("mdoc" "\\documentclass[11pt]{article}\n\n\\usepackage[$1]{babel}\n\\usepackage[utf8]{inputenc}\n\\usepackage[a4paper]{geometry}\n\\usepackage[hidelinks=true]{hyperref}\n\n\\usepackage{graphicx}\n\n\\title{$2}\n\\author{Ignacio Ballesteros González}\n\\date{\\today}\n\n\n\\begin{document}\n\n\\maketitle\n\n$0\n\n\\end{document}\n" "Latex Common Heading" nil
                        ("latex")
                        nil "/home/ignaciobll/.emacs.d/snippets/latex-mode/Latex Common Heading" nil nil)))


;;; Do not edit! File generated at Tue Nov 27 18:38:28 2018

;;; Init.el --- Summary

;;; Commentary:

;; Use it as you wish

;;; Code:

(when (>= emacs-major-version 24)
  (require 'package)
  (add-to-list
   'package-archives
   '("melpa" . "http://melpa.org/packages/") t)
  (add-to-list
   'package-archives
   '("melpa-stable" . "http://melpa-stable.milkbox.net/packages/") t)
  (package-initialize))

(unless package-archive-contents
  (package-refresh-contents)
  (package-install 'use-package)
  )

(setq load-path (cons "~/.local/bin" load-path))
(setq exec-path (cons "~/.local/bin" exec-path))

(setq make-backup-files nil) ;; Hello GIT

(tooltip-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(global-hl-line-mode t)

(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8-unix)

(setq ring-bell-function 'ignore
      delete-old-versions t
      backup-by-copying t
      backup-directory-alist '(("." . "~/.emacs.d/backup"))
      create-lockfiles nil
      )

(put 'set-goal-column 'disabled nil)
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'erase-buffer 'disabled nil)
(put 'narrow-to-region 'disabled nil)
(put 'narrow-to-page 'disabled nil)
(put 'narrow-to-defun 'disabled nil)

(setq-default truncate-lines nil)

(add-hook 'before-save-hook 'delete-trailing-whitespace)

(use-package exec-path-from-shell
  :ensure t
  :init (exec-path-from-shell-initialize))

;;; FONTS

;; (require 'fira-code-mode)
;; (set-frame-font "Inconsolata-15")
;; (set-frame-font "Hack-13")
(add-to-list 'default-frame-alist
             '(font . "JetBrainsMono-13"))
;; '(font . "Pragmata Pro-13"))
;; '(font . "Hasklig Medium"))
;; '(font . "Hack-13"))
;; '(font . "Fira Code"))
;; (set-face-attribute 'default t :font "Hasklig Medium-13")

;; (use-package hasklig-mode
;;  :ensure t
;;  :hook 'prog-mode-hook 'rainbow-mode)

(use-package pretty-mode
  :ensure t
  :init (global-pretty-mode 0)
  )

;;; THEMES

(use-package doom-themes
  :ensure t
  ;; :init (load-theme 'doom-molokai t)
  :init (load-theme 'doom-vibrant t)
  )

(use-package darkroom
  :ensure t)

;;; ORG MODE

;; Thanks Sacha Chua

(global-set-key (kbd "C-c i") (lambda () (interactive) (find-file "~/.emacs.d/init.el")))
(global-set-key (kbd "C-c o") (lambda () (interactive) (find-file "~/base.org")))
(global-set-key (kbd "C-c C-a") 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)

(defvar (setq org-default-notes-file "~/Documents/notes.org"))

(defvar (setq org-agenda-files (list
                                "~/Documents/notes.org"
                                "~/Documents/MMMFF/agenda.org"
                                "~/Documents/UPM/UPM.org"
                                "~/Documents/General.org")))

(defvar (setq org-refile-targets '((org-agenda-files . (:maxlevel . 3)))))

(defvar (setq org-agenda-span 10
              org-agenda-start-on-weekday nil))

(use-package org
  :config (use-package ox-gfm
            :ensure t)
  )

(use-package ob-ipython
  :ensure t)

(use-package babel
  :ensure t
  :init
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((C . t) (shell . t) (python . t) (ipython . t) (haskell . t)))
  (setq org-confirm-babel-evaluate nil)
  )

(add-to-list 'load-path
             "~/.emacs.d/plugins/org-wiki")
(require 'org-wiki)

(setq org-wiki-location '"~/wiki")
(global-set-key (kbd "C-c w") 'org-wiki-index)


;;; TOOLS
;; - Doom modeline
;; - neotree
;; - company
;; - iwb
;; - rainbow mode
;; - rainbow delimiters
;; - helm
;; - ido
;; - smex
;; - multiple cursors
;; - markdown mode
;; - magit
;; - multi term
;; - yasnipet-snippets
;; - yarnippet
;; - flyckeck
;; - projectile
;; - yaml-mode

(use-package doom-modeline
  :ensure t
  :hook (after-init . doom-modeline-mode))

(setq doom-modeline-height 25)
(setq doom-modeline-buffer-file-name-style 'relative-from-project)
(setq doom-modeline-icon t)

;; (setq doom-modeline-buffer-file-name-style 'truncate-upto-project)

(use-package neotree
  :ensure t
  :bind ("<f8>" . neotree-toggle)
  :config (setq neo-theme (if (display-graphic-p) 'icons 'arrow))
  )

(use-package company
  :ensure t
  :init (global-company-mode))

(setq-default indent-tabs-mode nil)

(defun iwb ()
  "Indent whole buffer."
  (interactive)
  (delete-trailing-whitespace)
  (indent-region (point-min) (point-max) nil)
  (untabify (point-min) (point-max))
  (message "Indent buffer: Done.")
  )

(global-set-key "\M-i" 'iwb)

(use-package rainbow-mode
  :ensure t
  :init
  (add-hook 'prog-mode-hook 'rainbow-mode)
  )

(use-package rainbow-delimiters
  :ensure t
  :init
  (add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
  )

(use-package helm
  :ensure t
  ;; :bind (("M-x" . 'helm-M-x)
  ;;        ("C-x C-f" . 'helm-find-files)
  ;;        ("C-x r b" . 'helm-filtered-bookmaks)
  ;;        ("C-x C-d" . 'helm-find-files))
  :init (setq helm-split-window-inside-p t)
  :config (helm-autoresize-mode 1)
  )

(use-package ido
  :init
  (setq ido-enable-flex-matching t)
  (setq ido-everywhere t)
  (ido-mode 1)
  (setq ido-file-extensions-order '(".hs" ".org" ".tex" ".txt" ".py" ".json" ".config" ".xml" ".el" ".ini" ".cfg" ".cnf")))

(use-package ido-sort-mtime
  :ensure t)

(use-package smex
  :ensure t
  :bind ("M-x" . smex))

(use-package multiple-cursors
  :ensure t
  :bind (("C-S-c C-S-c" . mc/edit-lines)
         ("C->" . mc/mark-next-like-this)
         ("C-<" . mc/mark-previous-like-this)
         ("C-c C-<" . mc/add-cursor-on-click))
  )

(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))

(use-package magit
  :ensure t
  :bind (("C-x g" . magit-status)
         ("C-x M-g" . magit-dispatch-popup))
  )

(use-package multi-term
  :ensure t
  :config (setq multi-term-program "/bin/zsh")
  :bind (("M-s" . multi-term))
  )

(use-package yasnippet-snippets
  :ensure t)

;; (add-to-list 'load-path "~/.emacs.d/plugins/yasnippet")
;; (require 'yasnippet)
(use-package yasnippet
  :ensure t)

(yas-global-mode 1)
(define-key yas-minor-mode-map (kbd "<tab>") nil)
(define-key yas-minor-mode-map (kbd "TAB") nil)
(define-key yas-minor-mode-map (kbd "<C-tab>") 'yas-expand)



(use-package flycheck
  :ensure t
  :init (global-flycheck-mode t)
  :config
  (add-to-list 'display-buffer-alist
             `(,(rx bos "*Flycheck errors*" eos)
              (display-buffer-reuse-window
               display-buffer-in-side-window)
              (side            . bottom)
              (reusable-frames . visible)
              (window-height   . 0.33)))
)

(use-package projectile
  :ensure t
  :init  (add-hook 'prog-mode-hook 'projectile-mode))

(use-package yaml-mode
  :ensure t)

;;; LANGS

;; Haskell
(use-package haskell-mode
  :ensure t
  :mode "\\.hs\\'"
  )

(use-package flycheck-haskell
  :ensure t)

(eval-after-load 'flycheck
  '(add-hook 'flycheck-mode-hook #'flycheck-haskell-setup))

(add-hook 'haskell-mode-hook 'subword-mode)

(use-package lsp-mode
  :hook (haskell-mode . lsp)
  :commands lsp
  :config
  (setq lsp-haskell-process-path-hie "ghcide") ;; Remove to have hie
  (setq lsp-haskell-process-args-hie '())      ;;
  )

(use-package lsp-haskell
  :ensure t)

;; optionally
(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode
  :config
  (define-key lsp-ui-mode-map [remap xref-find-definitions] #'lsp-ui-peek-find-definitions)
  (define-key lsp-ui-mode-map [remap xref-find-references] #'lsp-ui-peek-find-references)
  :bind ("C-c d" . lsp-ui-doc-hide)
  :bind ("C-c i" . lsp-ui-imenu)
)

(use-package company-lsp
  :ensure t
  :commands company-lsp)
;; (use-package helm-lsp :commands helm-lsp-workspace-symbol)
;; (use-package lsp-treemacs :commands lsp-treemacs-errors-list)

(setq haskell-stylish-on-save t)
(setq haskell-tags-on-save t)

;; Agda
(load-file (let ((coding-system-for-read 'utf-8))
                (shell-command-to-string "agda-mode locate")))

;; LaTeX
(use-package company-auctex
  :ensure t)

(use-package company-math
  :ensure t)

(use-package company-reftex
  :ensure t
  :bind (
         ("C-c t" . reftex-toc)
         ("C-c l" . reftex-label)
         ("C-c r r" . reftex-reference)
         ("C-c r c" . reftex-citation)
         ("C-c v" . reftex-view-crossref)
         ("C-c s" . reftex-search-document)
         ("C-c g" . reftex-grep-document)
         )
  )

(use-package tex
  :ensure auctex
  :mode ("\\.tex\\'" . TeX-latex-mode)
  :config
  (defun my-latex-mode-setup ()
  (setq-local company-backends
              (append '((company-reftex-labels company-reftex-citations company-math-symbols-latex company-math-symbols-unicode company-auctex-macros company-auctex-environments))
                      company-backends)))
  (add-hook 'LaTeX-mode-hook 'my-latex-mode-setup)
  (add-hook 'LaTeX-mode-hook 'reftex-mode)
  (setq reftex-plug-into-AUCTeX t)
  '(TeX-command-extra-options "-shell-escape")
  )

(setq-default ispell-program-name "aspell")

(use-package flyspell
  :init (add-hook 'LaTeX-mode-hook 'flyspell-mode)
  )

;; (use-package auto-fill-mode
(add-hook 'LaTeX-mode-hook 'turn-on-auto-fill)

(use-package counsel
  :ensure t)


;; Elixir
(use-package elixir-mode
  :ensure t)

(add-to-list 'load-path "~/.emacs.d/plugins/lang/mix-format.el")
(require 'elixir-format)

(add-hook 'elixir-mode-hook
          (lambda () (add-hook 'before-save-hook 'elixir-format-before-save)))

(use-package alchemist
  :ensure t)

;; Erlang
;; EQC Emacs Mode -- Configuration Start

;; (add-to-list 'load-path "/usr/lib/erlang/lib/eqc-1.43.1/emacs/")
;; ;; (autoload 'eqc-erlang-mode-hook "eqc-ext" "EQC Mode" t)
;; (add-hook 'erlang-mode-hook 'eqc-erlang-mode-hook)
;; (defvar (setq eqc-max-menu-length 30))
;; (defvar (setq eqc-root-dir "/usr/lib/erlang/lib/eqc-1.43.1"))
;; ;; EQC Emacs Mode -- Configuration End

;; ;; Erlang Emacs Mode -- Configuration Start
;; (setq erlang-root-dir "/usr/lib/erlang")
;; (setq load-path (cons "/usr/lib/erlang/lib/tools-2.11.2/emacs" load-path))
;; (setq exec-path (cons "/usr/lib/erlang/bin" exec-path))
;; (defvar (setq erlang-indent-leve 2))
;; (require 'erlang-start)
;; ;; Erlang Emacs Mode -- Configuration End
;; (require 'eqc-mode)

;; Formal Methods
(use-package maude-mode
  :ensure t)

(use-package z3-mode
  :ensure t)

(use-package boogie-friends
  :ensure t
  :init (setq flycheck-dafny-executable "/usr/bin/dafny")
  )

(use-package minizinc-mode
  :ensure t
  :mode ("\\.mzn\\'" . minizinc-mode)
  )


;; Python
(use-package elpy
  :ensure t
  :mode "\\.py\\'"
  ;; :init (elpy-enable)
  ;; (shell-command "bash ~/.emacs.d/elpy.sh &")
  :config
  (python-mode)
  (elpy-mode)
  (setq elpy-rpc-python-command "python3")
  (setq python-shell-interpreter "python3")
  )


;; WEB
(use-package elm-mode
  :ensure t
  )

(use-package json-mode
  :ensure t
  :mode (("\\.json\\'". json-mode)("\\.jsch\\'" . json-mode))
  :config (setq js-indent-level 2)
  )

(use-package web-mode
  :ensure t
  :mode (("\\.jsx\\'" . web-mode)
         ("\\.tsx\\'" . web-mode))
  :hook (web-mode . (lambda ()
                      (when (string-equal "tsx" (file-name-extension buffer-file-name))
                        (setup-tide-mode))))
  :config (flycheck-add-mode 'javascript-eslint 'web-mode)
  )

(use-package js2-mode
  :ensure t
  :mode (("\\.js\\'" . js2-mode))
  :hook (js2-mode-hook . js2-imenu-extras-mode)
  :hook (js2-mode-hook . tern-mode)
  :hook (js2-mode-hook . company-mode)
  )

(use-package emmet-mode
  :ensure t
  )

(use-package company-tern
  :ensure t
  )

(use-package typescript-mode
  :ensure t)

(use-package tide
  :ensure t
  :after (typescript-mode company flycheck)
  :hook ((typescript-mode . tide-setup)
         (typescript-mode . tide-hl-identifier-mode)
         (before-save . tide-format-before-save))
  :config  (setq tide-format-options
                '(:tabSize 2
                  :indentSize 2
                  :baseIndentSize 0
                  :convertTabsToSpaces true
                  :insertSpaceAfterCommaDelimiter true
                  :insertSpaceAfterSemicolonInForStatements true
                  :insertSpaceBeforeAndAfterBinaryOperators true
                  :insertSpaceAfterKeywordsInControlFlowStatements true
                  :insertSpaceAfterFunctionKeywordForAnonymousFunctions true
                  ;; :insertSpaceAfterOpeningAndBeforeClosingNonemptyParenthesis false
                  ;; :insertSpaceAfterOpeningAndBeforeClosingNonemptyBrackets false
                  ;; :insertSpaceAfterOpeningAndBeforeClosingTemplateStringBraces false
                  ;; :insertSpaceBeforeFunctionParenthesis false
                  ;; :placeOpenBraceOnNewLineForFunctions false
                  ;; :placeOpenBraceOnNewLineForControlBlocks false
                  ))
  )

(setq js-indent-level 2)
(setq tab-width 2)

;; (use-package prettier-js
;;   :ensure t
;;   :hook (typescript-mode . prettier-js-mode)
;;   :config ((setq prettier-js-args
;;                  '(
;;                    "--trailing-comma" "none"
;;                    "--bracket-spacing" "true"
;;                    "--single-quote" "true"
;;                    "--no-semi" "true"
;;                    "--jsx-single-quote" "true"
;;                    "--jsx-bracket-same-line" "true"
;;                    "--print-width" "100"))
;;            )
;;   )


;; Other

(setq flymake-run-in-place nil)
(setq temporary-file-directory "~/.emacs.d/tmp/")

(defun reopen-this-file-as-sudo ()
  "Reopens this file as sudo."
  (interactive)
  (defvar file-name
  (when-let ((file-name (buffer-file-name)))
    (find-alternate-file (concat "/sudo::" file-name)))))

(provide 'init)

;; (custom-set-variables
;; '(TeX-command-extra-options "-shell-escape")
;; '(flymake-proc-ignored-file-name-regexps '(".*"))
;; '(flymake-start-on-flymake-mode nil)
;; '(flymake-start-on-save-buffer nil)
;; )

(custom-set-variables
 '(TeX-command-extra-options "-shell-escape")
 '(flymake-proc-ignored-file-name-regexps '(".*"))
 '(flymake-start-on-flymake-mode nil)
 '(flymake-start-on-save-buffer nil)
 )

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;;

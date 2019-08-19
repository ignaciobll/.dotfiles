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

;; (set-frame-font "Inconsolata-15")
;; (set-frame-font "Hack-13")
(add-to-list 'default-frame-alist
            '(font . "Hasklig Medium-13"))
             ;; '(font . "Hack-13"))
;; (set-face-attribute 'default t :font "Hasklig Medium-13")
(use-package hasklig-mode
 :ensure t
 :hook 'prog-mode-hook 'rainbow-mode)

;; (use-package leuven-theme
;;   :ensure t
;;   :init ;(load-theme 'leuven t)
;;   (load-theme 'darkokai t)
;;   )

;; (use-package rebecca-theme
;;   :ensure t
;;   :init (load-theme 'rebecca t)
;;   )

;; (use-package darkokai-theme
;;   :ensure t
;;   :init (load-theme 'darkokai t)
;;   )

;; (use-package select-themes
;;   :ensure t)

;; (load-theme 'doom-molokai)

;; Thanks Sacha Chua

(global-set-key (kbd "C-c i") (lambda () (interactive) (find-file "~/.emacs.d/init.el")))
(global-set-key (kbd "C-c o") (lambda () (interactive) (find-file "~/base.org")))
(global-set-key (kbd "C-c C-a") 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)

(defvar (setq org-default-notes-file "~/base.org"))

(defvar (setq org-agenda-files (list "~/base.org"
                             "~/Documents/UPM/UPM.org"
                             "~/Documents/General.org")))

(defvar (setq org-refile-targets '((org-agenda-files . (:maxlevel . 3)))))

(defvar (setq org-agenda-span 10
              org-agenda-start-on-weekday nil))

(use-package org
  :config (use-package ox-gfm
            :ensure t)
  )

;; (use-package spaceline
;;   :ensure t
;;   :config
;;   (setq-default mode-line-format '("%e" (:eval (spaceline-ml-main))))
;;   )

;; ;; (use-package spaceline-all-the-icons
;; ;;   :after spaceline
;; ;;   :init (spaceline-all-the-icons-theme))


;; (use-package spaceline-config
;;   :ensure spaceline
;;   :config
;;   (spaceline-emacs-theme)
;;   )


;; Spaceline

;; (use-package spaceline-all-the-icons
;;   :ensure t)
;; (require 'spaceline-all-the-icons)
;; (setq spaceline-all-the-icons-separator-type 'none)
;; (spaceline-all-the-icons-theme)


(use-package doom-modeline
  :ensure t
  :hook (after-init . doom-modeline-mode))

(setq doom-modeline-height 25)
;; (setq doom-modeline-buffer-file-name-style 'truncate-upto-project)
(setq doom-modeline-buffer-file-name-style 'relative-from-project)
(setq doom-modeline-icon t)

(use-package neotree
  :ensure t
  :bind ("<f8>" . neotree-toggle)
  :config (setq neo-theme (if (display-graphic-p) 'icons 'arrow))
  )

;; (use-package pretty-mode
;;   :ensure t
;;   :init (global-pretty-mode t)
;;   )

(use-package doom-themes
  :ensure t
  :init (load-theme 'doom-molokai t)
  )

(use-package darkroom
  :ensure t)

;; (require 'company-mode)
;; (add-hook 'after-init-hook 'global-company-mode)
(global-company-mode)


;; (global-nlinum-mode 1)
;; (defun my-nlinum-mode-hook ()
;;   (when nlinum-mode
;;     (setq-local nlinum-format
;;                 (concat "%" (number-to-string
;;                              ;; Guesstimate number of buffer lines.
;;                              (ceiling (log (max 1 (/ (buffer-size) 80)) 10)))
;;                         "d"))))
;; (add-hook 'nlinum-mode-hook #'my-nlinum-mode-hook)

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

;; Voy a instalar el paquete ido
(use-package ido
  :init
  (setq ido-enable-flex-matching t)
  (setq ido-everywhere t)
  (ido-mode 1)
  (setq ido-file-extensions-order '(".hs" ".org" ".tex" ".txt" ".py" ".json" ".config" ".xml" ".el" ".ini" ".cfg" ".cnf")))

;; Voy a instalar el paquete ido-sort-mtime
(use-package ido-sort-mtime
  :ensure t)

;; Voy a instalar el paquete smex
(use-package smex
  :ensure t
  :bind ("M-x" . smex))

;; Voy a instalar el paquete yasnippet

(add-to-list 'load-path
              "~/.emacs.d/plugins/yasnippet")
(require 'yasnippet)
(yas-global-mode 1)
(define-key yas-minor-mode-map (kbd "<tab>") nil)
(define-key yas-minor-mode-map (kbd "TAB") nil)
(define-key yas-minor-mode-map (kbd "<C-tab>") 'yas-expand)

(use-package yasnippet-snippets
  :ensure t)


(use-package aggressive-indent
  :ensure t
  ;; :init
  ;; (add-hook 'prog-mode-hook #'aggressive-indent-mode)
  )

;; (use-package ac-math
;;   :ensure t)

;; (use-package auto-complete
;;   :ensure t
;;   :config
;;   (add-to-list 'ac-modes 'latex-mode)
;;   (defun my-ac-latex-mode () ; add ac-sources for latex
;;    (setq ac-sources
;;          (append '(ac-source-math-unicode
;;            ac-source-math-latex
;;            ac-source-latex-commands)
;;                  ac-sources)))
;;   (add-hook 'LaTeX-mode-hook 'my-ac-latex-mode)
;;   ;; (setq ac-math-unicode-in-math-p t)
;;   (ac-flyspell-workaround)
;;   (ac-config-default)
;; )

(use-package haskell-mode
  :ensure t
  :mode "\\.hs\\'"
  ;; :config
  ;; (custom-set-variables
  ;;  '(haskell-process-log t))
  ;; (setq haskell-process-args-ghci
  ;;       '("-ferror-spans" "-fshow-loaded-modules"))
  ;; (setq haskell-process-args-cabal-repl
  ;;       '("--ghc-options=-ferror-spans -fshow-loaded-modules"))
  ;; (setq haskell-process-args-stack-ghci
  ;;       '("--ghci-options=-ferror-spans -fshow-loaded-modules"
  ;;         "--no-build" "--no-load"))
  ;; (setq haskell-process-args-cabal-new-repl
  ;;       '("--ghc-options=-ferror-spans -fshow-loaded-modules"))

  ;; ;; haskell/haskell-mode Issue: 1553

  ;; (add-hook 'haskell-mode-hook 'turn-on-haskell-doc)
  ;; ;; (add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
  ;; (add-hook 'haskell-mode-hook 'interactive-haskell-mode)
  ;; (add-hook 'haskell-mode-hook 'haskell-auto-insert-module-template)
  ;; (eval-after-load 'haskell-mode
  ;;   '(define-key haskell-mode-map [f8] 'haskell-navigate-imports))
  ;; (eval-after-load 'haskell-mode '(progn
  ;;       			    (define-key haskell-mode-map (kbd "C-c C-l") 'haskell-process-load-or-reload)
  ;;       			    (define-key haskell-mode-map (kbd "C-c C-z") 'haskell-interactive-switch)
  ;;       			    (define-key haskell-mode-map (kbd "C-c C-n C-t") 'haskell-process-do-type)
  ;;       			    (define-key haskell-mode-map (kbd "C-c C-n C-i") 'haskell-process-do-info)
  ;;       			    (define-key haskell-mode-map (kbd "C-c C-n C-c") 'haskell-process-cabal-build)
  ;;       			    (define-key haskell-mode-map (kbd "C-c C-n c") 'haskell-process-cabal)))
  ;; (eval-after-load 'haskell-cabal '(progn
  ;;       			     (define-key haskell-cabal-mode-map (kbd "C-c C-z") 'haskell-interactive-switch)
  ;;       			     (define-key haskell-cabal-mode-map (kbd "C-c C-k") 'haskell-interactive-mode-clear)
  ;;       			     (define-key haskell-cabal-mode-map (kbd "C-c C-c") 'haskell-process-cabal-build)
  ;;       			     (define-key haskell-cabal-mode-map (kbd "C-c c") 'haskell-process-cabal)))
  )

(use-package intero
  :ensure t
  :init (intero-global-mode))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(TeX-command-extra-options "-shell-escape")
 '(haskell-stylish-on-save t)
 '(package-selected-packages
   (quote
    (gdscript-mode company-tern emmet-mode web-mode graphviz-dot-mode dot-mode opencl-mode paredit dante hasklig-mode doom-modeline yasnippet-snippets yaml-mode xah-math-input use-package ttl-mode spaceline-all-the-icons smex select-themes restclient rainbow-mode rainbow-delimiters proof-general projectile ox-gfm ob-ipython neotree multiple-cursors multi-term meghanada markdown-mode magit json-mode intero ido-sort-mtime hindent helm groovy-mode floobits erlang ensime elpy elm-mode ein doom-themes darkroom darkokai-theme counsel company-reftex company-coq company-auctex basic-mode babel alchemist aggressive-indent))))

;; (use-package dante
;;   :ensure t
;;   :after haskell-mode
;;   :commands 'dante-mode
;;   :init
;;   (add-hook 'haskell-mode-hook 'dante-mode)

;;   (add-hook 'haskell-mode-hook 'flycheck-mode)
;;   ;; OR:
;;   ;; (add-hook 'haskell-mode-hook 'flymake-mode)
;;   )

(add-hook 'intero-mode-hook
   '(lambda () (flycheck-add-next-checker 'intero
                '(warning . haskell-hlint))))

;; (use-package hindent
;;   :ensure t
;;   :init (add-hook 'haskell-mode-hook #'hindent-mode)
;;   )

;; (require 'haskell-process)

;; ghc-mod
;; (require 'ghc)
;; (add-hook 'haskell-mode-hook (lambda () (ghc-init)))

;; haskell autocomplete
;; (require 'company)
;; (add-hook 'haskell-mode-hook 'company-mode)
(add-to-list 'company-backends 'company-ghc)


(use-package erlang
  :ensure t
  :mode "\\.erl\\'"
  :config (erlang-mode)
  )

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
(add-to-list 'load-path "~/.emacs.d/plugins/")
(require 'eqc-mode)

(use-package elixir-mode
  :ensure t)

(add-to-list 'load-path "~/.emacs.d/plugins/mix-format.el")
(require 'elixir-format)
(add-hook 'elixir-mode-hook
          (lambda () (add-hook 'before-save-hook 'elixir-format-before-save)))

(use-package alchemist
  :ensure t)

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



(use-package ensime
  :pin melpa-stable
  :ensure t
  :commands ensime ensime-mode
  :init  (add-hook 'scala-mode-hook 'ensime-mode)
  (setq
   ensime-sbt-command "/usr/bin/sbt"
   sbt:program-name "/usr/bin/sbt")
  )

(use-package elm-mode
  :ensure t
  )

(use-package json-mode
  :ensure t
  :mode (("\\.json\\'". json-mode)("\\.jsch\\'" . json-mode))
  :config (setq js-indent-level 2)
  )

(use-package multiple-cursors
  :ensure t
  :bind (("C-S-c C-S-c" . mc/edit-lines)
         ("C->" . mc/mark-next-like-this)
         ("C-<" . mc/mark-previous-like-this)
         ("C-c C-<" . mc/add-cursor-on-click))
  )

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
  )

(setq-default ispell-program-name "aspell")

(use-package flyspell
  :init (add-hook 'LaTeX-mode-hook 'flyspell-mode)
  )

;; (use-package auto-fill-mode
(add-hook 'LaTeX-mode-hook 'turn-on-auto-fill)

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

(use-package ob-ipython
  :ensure t)



(use-package babel
  :ensure t
  :init
  (org-babel-do-load-languages
   'org-babel-load-languages '(
			       (C . t)
			       (shell . t)
			       (python . t)
                               (ipython . t)
                               (haskell . t)
			       )
   )
  (setq org-confirm-babel-evaluate nil)

  )

(add-to-list 'load-path
             "~/.emacs.d/plugins/org-wiki")
(require 'org-wiki)

(setq org-wiki-location '"~/wiki")
(global-set-key (kbd "C-c w") 'org-wiki-index)

;; (use-package meghanada
;;   :ensure t
;;   :init (add-hook 'java-mode-hook
;;                   (lambda ()
;;                     (meghanada-mode t)
;;                     (flycheck-mode -1)
;;                     (setq c-basic-offset 2)
;;                     (add-hook 'before-save-hook 'meghanada-code-beautify-before-save)))
;;   (setq meghanada-java-path "java")
;;   (setq meghanada-maven-path "mvn")
;;   )


;; (use-package helm
;;   :ensure t
;;   :bind (("M-x" . 'helm-M-x)
;;          ("C-x C-f" . 'helm-find-files)
;;          ("C-x r b" . 'helm-filtered-bookmaks)
;;          ("C-x C-d" . 'helm-find-files))
;;   :init (setq helm-split-window-inside-p t)
;;   :config (helm-autoresize-mode 1)
;;   )

(use-package ivy
  :ensure t)

(use-package counsel
  :ensure t)

(use-package flycheck
  :ensure t
  :init (global-flycheck-mode)
  :config
  (add-to-list 'display-buffer-alist
             `(,(rx bos "*Flycheck errors*" eos)
              (display-buffer-reuse-window
               display-buffer-in-side-window)
              (side            . bottom)
              (reusable-frames . visible)
              (window-height   . 0.33)))
)

(add-hook 'before-save-hook 'delete-trailing-whitespace)

(use-package projectile
  :ensure t
  :init  (add-hook 'prog-mode-hook 'projectile-mode))

(use-package groovy-mode
  :ensure t
  :mode ("\\.gradle\\'" . groovy-mode))

;; (use-package proof-general
;;   :ensure t)

;; (use-package company-coq
;;   :ensure t)

(use-package opencl-mode
  :ensure t
  :mode (("\\.cl\\'" . opencl-mode))
  )

(use-package web-mode
  :ensure t
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

(provide 'init)

;;; init.el ends here

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

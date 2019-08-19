;; EQC Emacs Mode -- Configuration Start
(add-to-list 'load-path "/usr/lib/erlang/lib/eqc-1.44.1/emacs/")
(autoload 'eqc-erlang-mode-hook "eqc-ext" "EQC Mode" t)
(add-hook 'erlang-mode-hook 'eqc-erlang-mode-hook)
(setq eqc-max-menu-length 30)
(setq eqc-root-dir "/usr/lib/erlang/lib/eqc-1.44.1")
;; EQC Emacs Mode -- Configuration End

;; Erlang Emacs Mode -- Configuration Start
(setq erlang-root-dir "/usr/lib/erlang")
(setq load-path (cons "/usr/lib/erlang/lib/tools-2.11.2/emacs" load-path))
(setq exec-path (cons "/usr/lib/erlang/bin" exec-path))
(require 'erlang-start)
;; Erlang Emacs Mode -- Configuration End

(provide 'eqc-mode)

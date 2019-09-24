;; on windows, .emacs goes in $env:USERPROFILE\AppData\Roaming
;; emacs options
(menu-bar-mode -1)
(tool-bar-mode -1
; (toggle-scroll-bar -1)

;; org
(require 'org)
(setq org-directory (concat (getenv "USERPROFILE") "\\OneDrive - Microsoft\\org"))

(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))

(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)

(setq org-use-speed-commands t)


(defun org-find-file ()
  (interactive)
  (find-file org-directory))

(define-key global-map "\C-co" 'org-find-file)



;; (setq org-agenda-files (list org-directory))
;; This is supposed to be recursive.
(setq org-agenda-files (directory-files-recursively org-directory "\.org$"))
;; Reload org-agenda-files when new file is created.
(defun org-reload-agenda-files ()
  (setq org-agenda-files (directory-files-recursively org-directory "\.org$")))
(add-hook 'org-mode-hook 
          (lambda () 
             (add-hook 'after-save-hook 'org-reload-agenda-files)))

(setq-default buffer-file-coding-system 'utf-8-unix)

;; Insert code blocks
(defun org-insert-src-block (src-code-type)
  "Insert a `SRC-CODE-TYPE' type source code block in org-mode."
  (interactive
   (let ((src-code-types
          '("emacs-lisp" "python" "C" "sh" "java" "js" "clojure" "C++" "css"
            "calc" "asymptote" "dot" "gnuplot" "ledger" "lilypond" "mscgen"
            "octave" "oz" "plantuml" "R" "sass" "screen" "sql" "awk" "ditaa"
            "haskell" "latex" "lisp" "matlab" "ocaml" "org" "perl" "ruby"
            "scheme" "sqlite")))
     (list (ido-completing-read "Source code type: " src-code-types))))
  (progn
    (newline-and-indent)
    (insert (format "#+BEGIN_SRC %s\n" src-code-type))
    (newline-and-indent)
    (insert "#+END_SRC\n")
    (previous-line 2)
    (org-edit-src-code)))

(defun org-wrap-src (start end)
  (interactive "r")
    (if (use-region-p)
        (let ((regionp (buffer-substring start end)))
	  (delete-region start end)
	  ; (indent-according-to-mode)
	  (insert "#+BEGIN_SRC\n")
	  (insert regionp)
	  (newline)
	  ;(newline-and-indent)
	  (insert "#+END_SRC\n"))))

(add-hook 'org-mode-hook '(lambda ()
                            ;; turn on flyspell-mode by default
                            ; (flyspell-mode 1)
                            ;; C-TAB for expanding
                            (local-set-key (kbd "C-<tab>")
                                           'yas/expand-from-trigger-key)
                            ;; keybinding for editing source code blocks
                            (local-set-key (kbd "C-c s e")
                                           'org-edit-src-code)
                            ;; keybinding for inserting code blocks
                            (local-set-key (kbd "C-c s i")
                                           'org-insert-src-block)
			    ;; keybinding for wrapping code blocks
                            (local-set-key (kbd "C-c s w")
                                           'org-wrap-src)
                            ))
;; Highlighting in code blocks
(setq org-src-fontify-natively t)

;; Disable bell
(setq ring-bell-function 'ignore)

;; toggle search case fold
(add-hook 'isearch-mode-hook
            (function
             (lambda ()
               (define-key isearch-mode-map "\C-h" 'isearch-mode-help)
               (define-key isearch-mode-map "\C-t" 'isearch-toggle-regexp)
               (define-key isearch-mode-map "\C-c" 'isearch-toggle-case-fold)
               (define-key isearch-mode-map "\C-j" 'isearch-edit-string))))

;; Recent files
(recentf-mode 1)
(setq recentf-max-menu-items 250)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)

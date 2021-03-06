(require 'package) ;; You might already have this line
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("marmalade" . "https://marmalade-repo.org/packages/"))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize) ;; You might already have this line

(require 'epa-file)
(epa-file-enable)

(setq backup-directory-alist `(("." . "~/.saves")))

(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
;; (global-set-key (kbd "C-x g") 'magit-status)
;; (setenv "DICTIONARY" "en_US")

(global-set-key (kbd "C-x C-+") (lambda () (interactive) (zoom-in/out t)))
(global-set-key (kbd "C-x C--") (lambda () (interactive) (zoom-in/out t)))

(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

(if window-system
    (tool-bar-mode -1)
)

;; (require 'evil)
;; (evil-mode 1)

;; (define-key evil-normal-state-map "c" nil)
;; (define-key evil-motion-state-map "cu" 'universal-argument)
;; (define-key key-translation-map (kbd "ch") (kbd "C-h"))
;; (define-key key-translation-map (kbd "cx") (kbd "C-x"))

;; ;; Note: lexical-binding must be t in order for this to work correctly.
;; (defun make-conditional-key-translation (key-from key-to translate-keys-p)
;;   "Make a Key Translation such that if the translate-keys-p function returns true,
;;    key-from translates to key-to, else key-from translates to itself.  translate-keys-p
;;    takes key-from as an argument. "
;;   (define-key key-translation-map key-from
;;     (lambda (prompt)
;;       (if (funcall translate-keys-p key-from) key-to key-from))))
;; (defun my-translate-keys-p (key-from)
;;   "Returns whether conditional key translations should be active.  See make-conditional-key-translation function. "
;;   (and
;;    ;; Only allow a non identity translation if we're beginning a Key Sequence.
;;    (equal key-from (this-command-keys))
;;    (or (evil-motion-state-p) (evil-normal-state-p) (evil-visual-state-p))))
;; (define-key evil-normal-state-map "c" nil)
;; (define-key evil-motion-state-map "cu" 'universal-argument)
;; (make-conditional-key-translation (kbd "ch") (kbd "C-h") 'my-translate-keys-p)
;; (make-conditional-key-translation (kbd "g") (kbd "C-x") 'my-translate-keys-p)

;; ;; (when (fboundp 'cl-loop)
;; ;;   ;; cl-loop iterates from ASCII '!' to ASCII '~'.
;; ;;   (cl-loop for ascii-code-i from 33 to 126 by 1 do
;; ;; 	   (make-conditional-key-translation (kbd (format "c%c" ascii-code-i))
;; ;; 					     (kbd (format "C-%c" ascii-code-i))
;; ;; 					     'my-translate-keys-p)))

;; ;;; C-c as general purpose escape key sequence.
;; ;;;
;; (defun my-esc (prompt)
;;   "Functionality for escaping generally.  Includes exiting Evil insert state and C-g binding. "
;;   (cond
;;    ;; If we're in one of the Evil states that defines [escape] key, return [escape] so as
;;    ;; Key Lookup will use it.
;;    ((or (evil-insert-state-p) (evil-normal-state-p) (evil-replace-state-p) (evil-visual-state-p)) [escape])
;;    ;; This is the best way I could infer for now to have C-c work during evil-read-key.
;;    ;; Note: As long as I return [escape] in normal-state, I don't need this.
;;    ;;((eq overriding-terminal-local-map evil-read-key-map) (keyboard-quit) (kbd ""))
;;    (t (kbd "C-g"))))
;; (define-key key-translation-map (kbd "C-c") 'my-esc)
;; ;; Works around the fact that Evil uses read-event directly when in operator state, which
;; ;; doesn't use the key-translation-map.
;; (define-key evil-operator-state-map (kbd "C-c") 'keyboard-quit)
;; ;; Not sure what behavior this changes, but might as well set it, seeing the Elisp manual's
;; ;; documentation of it.
;; ;; (set-quit-char "C-c")
;; ;; (setq evil-insert-state-cursor '((bar . 5) "yellow")
;; ;;       evil-normal-state-cursor '(box "purple"))


;; ;; (setq evil-emacs-state-cursor '("red" box))
;; ;; (setq evil-motion-state-cursor '("orange" box))
;; ;; (setq evil-normal-state-cursor '("green" box))
;; ;; (setq evil-visual-state-cursor '("orange" box))
;; ;; (setq evil-insert-state-cursor '("red" bar))
;; ;; (setq evil-replace-state-cursor '("red" bar))
;; ;; (setq evil-operator-state-cursor '("red" hollow))
;; ;; ;
;; 					; change mode-line color by evil state
;; ;; (lexical-let ((default-color (cons (face-background 'mode-line)
;; ;; 				   (face-foreground 'mode-line))))
;; ;;   (add-hook 'post-command-hook
;; ;; 	    (lambda ()
;; ;; 	      (let ((color (cond ((minibufferp) default-color)
;; ;; 				 ((evil-insert-state-p) '("#e80000" . "#ffffff"))
;; ;; 				 ((evil-emacs-state-p)  '("#444488" . "#ffffff"))
;; ;; 				 ((buffer-modified-p)   '("#006fa0" . "#ffffff"))
;; ;; 				 (t default-color))))
;; ;; 		(set-face-background 'mode-line (car color))
;; ;; 		(set-face-foreground 'mode-line (cdr color))))))

;; ;; (defvar server-buffer-clients)
;; ;; (when (and (fboundp 'server-start) (string-equal (getenv "TERM") 'xterm))
;; ;;   (server-start)
;; ;;   (defun fp-kill-server-with-buffer-routine ()
;; ;;     (and server-buffer-clients (server-done)))
;; ;;   (add-hook 'kill-buffer-hook 'fp-kill-server-with-buffer-routine))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; begin restclient mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (add-to-list 'auto-mode-alist '("\\.http$" . restclient-mode))
;; (add-to-list 'auto-mode-alist '("\\.http\\'" . restclient-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; end restclient mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; begin urweb mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (add-to-list 'load-path "/usr/local/share/emacs/site-lisp/urweb-mode")
;; (load "urweb-mode-startup")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; end urweb mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Begin autocomplete and yasnippet Mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; yasnippet
;;; should be loaded before auto complete so that they can work together

(add-to-list 'load-path "~/.emacs.d/elpa/yasnippet-20151108.1505")
(require 'yasnippet)
(yas-global-mode 1)

;;; auto complete mod
;;; should be loaded after yasnippet so that they can work together
(require 'auto-complete-config)
(ac-config-default)
;; (add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(add-to-list 'ac-dictionary-directories "~/.emacs.d/elpa/auto-complete-20150618.1949/dict")

;;; set the trigger key so that it can work together with yasnippet on tab key,
;;; if the word exists in yasnippet, pressing tab will cause yasnippet to
;;; activate, otherwise, auto-complete will
(ac-set-trigger-key "TAB")
(ac-set-trigger-key "<tab>")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; End autocomplete and yasnippet Mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; begin js mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(add-to-list 'auto-mode-alist '("\\.json$" . js-mode))
(add-to-list 'load-path "/Users/nessig/.emacs.d/elpa/js2-mode-20151108.1846")
(add-hook 'js-mode-hook 'js2-minor-mode)
(add-hook 'js2-mode-hook 'ac-js2-mode)
(setq js2-highlight-level 3)

(add-hook 'js-mode-hook (lambda () (tern-mode t)))
(eval-after-load 'tern
   '(progn
      (require 'tern-auto-complete)
      (tern-ac-setup)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; End JS Mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;





(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#073642" "#dc322f" "#859900" "#b58900" "#268bd2" "#d33682" "#2aa198" "#657b83"])
 '(compilation-message-face (quote default))
 '(cua-global-mark-cursor-color "#2aa198")
 '(cua-normal-cursor-color "#839496")
 '(cua-overwrite-cursor-color "#b58900")
 '(cua-read-only-cursor-color "#859900")
 '(custom-enabled-themes nil)
 '(custom-safe-themes
   (quote
    ("8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "a8245b7cc985a0610d71f9852e9f2767ad1b852c2bdea6f4aadc12cce9c4d6d0" default)))
 '(fci-rule-color "#073642")
 '(haskell-process-auto-import-loaded-modules t)
 '(haskell-process-log t)
 '(haskell-process-suggest-remove-import-lines t)
 '(haskell-process-type (quote cabal-repl))
 '(haskell-tags-on-save t)
 '(highlight-changes-colors (quote ("#d33682" "#6c71c4")))
 '(highlight-symbol-colors
   (--map
    (solarized-color-blend it "#002b36" 0.25)
    (quote
     ("#b58900" "#2aa198" "#dc322f" "#6c71c4" "#859900" "#cb4b16" "#268bd2"))))
 '(highlight-symbol-foreground-color "#93a1a1")
 '(highlight-tail-colors
   (quote
    (("#073642" . 0)
     ("#546E00" . 20)
     ("#00736F" . 30)
     ("#00629D" . 50)
     ("#7B6000" . 60)
     ("#8B2C02" . 70)
     ("#93115C" . 85)
     ("#073642" . 100))))
 '(hl-bg-colors
   (quote
    ("#7B6000" "#8B2C02" "#990A1B" "#93115C" "#3F4D91" "#00629D" "#00736F" "#546E00")))
 '(hl-fg-colors
   (quote
    ("#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36")))
 '(magit-diff-use-overlays nil)
 '(nrepl-message-colors
   (quote
    ("#dc322f" "#cb4b16" "#b58900" "#546E00" "#B4C342" "#00629D" "#2aa198" "#d33682" "#6c71c4")))
 '(package-selected-packages
   (quote
    (clang-format julia-mode go-mode ein evil auto-complete ac-emmet elpy edit-server yaml-mode cider clojure-mode sqlplus csv-mode json-reformat tss scala-mode scala-mode2 auto-complete-clang restclient exec-path-from-shell zoom-frm w3m rainbow-delimiters haskell-mode js-comint nodejs-repl tern-auto-complete tern flycheck js2-refactor ac-js2 js2-mode magit jedi emmet-mode web-mode php-mode web-beautify solarized-theme slime)))
 '(pos-tip-background-color "#073642")
 '(pos-tip-foreground-color "#93a1a1")
 '(send-mail-function (quote mailclient-send-it))
 '(smartrep-mode-line-active-bg (solarized-color-blend "#859900" "#073642" 0.2))
 '(sql-password "123")
 '(sql-postgres-program "/Library/PostgreSQL/9.5/bin/psql")
 '(term-default-bg-color "#002b36")
 '(term-default-fg-color "#839496")
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#dc322f")
     (40 . "#c85d17")
     (60 . "#be730b")
     (80 . "#b58900")
     (100 . "#a58e00")
     (120 . "#9d9100")
     (140 . "#959300")
     (160 . "#8d9600")
     (180 . "#859900")
     (200 . "#669b32")
     (220 . "#579d4c")
     (240 . "#489e65")
     (260 . "#399f7e")
     (280 . "#2aa198")
     (300 . "#2898af")
     (320 . "#2793ba")
     (340 . "#268fc6")
     (360 . "#268bd2"))))
 '(vc-annotate-very-old-color nil)
 '(weechat-color-list
   (quote
    (unspecified "#002b36" "#073642" "#990A1B" "#dc322f" "#546E00" "#859900" "#7B6000" "#b58900" "#00629D" "#268bd2" "#93115C" "#d33682" "#00736F" "#2aa198" "#839496" "#657b83")))
 '(xterm-color-names
   ["#073642" "#dc322f" "#859900" "#b58900" "#268bd2" "#d33682" "#2aa198" "#eee8d5"])
 '(xterm-color-names-bright
   ["#002b36" "#cb4b16" "#586e75" "#657b83" "#839496" "#6c71c4" "#93a1a1" "#fdf6e3"]))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Begin Haskell Mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (let ((my-cabal-path (expand-file-name "~/.cabal/bin")))
;;   (setenv "PATH" (concat my-cabal-path path-separator (getenv "PATH")))
;;   (add-to-list 'exec-path my-cabal-path))


;; ;; (setq haskell-stylish-on-save t)

;; (require 'haskell-interactive-mode)
;; (require 'haskell-process)
;; (add-hook 'haskell-mode-hook 'interactive-haskell-mode)
;; (setq haskell-interactive-mode-eval-mode 'haskell-mode)

;; (defun haskell-interactive-toggle-print-mode ()
;;   (interactive)
;;   (setq haskell-interactive-mode-eval-mode
;;         (intern
;;          (ido-completing-read "Eval result mode: "
;;                               '("fundamental-mode"
;;                                 "haskell-mode"
;;                                 "espresso-mode"
;;                                 "ghc-core-mode"
;;                                 "org-mode")))))

;; (define-key haskell-interactive-mode-map (kbd "C-c C-v") 'haskell-interactive-toggle-print-mode)
;; ;;  (define-key haskell-mode-map (kbd "C-c C-p") 'haskell-mode-stylish-buffer)

;; (eval-after-load 'haskell-mode '(progn
;;   (define-key haskell-mode-map (kbd "C-c C-l") 'haskell-process-load-or-reload)
;;   (define-key haskell-mode-map (kbd "C-c C-z") 'haskell-interactive-switch)
;;   (define-key haskell-mode-map (kbd "C-c C-n C-t") 'haskell-process-do-type)
;;   (define-key haskell-mode-map (kbd "C-c C-n C-i") 'haskell-process-do-info)
;;   (define-key haskell-mode-map (kbd "C-c C-n C-c") 'haskell-process-cabal-build)
;;   (define-key haskell-mode-map (kbd "C-c C-n c") 'haskell-process-cabal)
;;   (define-key haskell-mode-map (kbd "C-c C-p") 'haskell-mode-stylish-buffer)
;;   (define-key haskell-mode-map (kbd "SPC") 'haskell-mode-contextual-space)))
;; (eval-after-load 'haskell-cabal '(progn
;;   (define-key haskell-cabal-mode-map (kbd "C-c C-z") 'haskell-interactive-switch)
;;   (define-key haskell-cabal-mode-map (kbd "C-c C-k") 'haskell-interactive-mode-clear)
;;   (define-key haskell-cabal-mode-map (kbd "C-c C-c") 'haskell-process-cabal-build)
;;   (define-key haskell-cabal-mode-map (kbd "C-c c") 'haskell-process-cabal)))

;; (add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)

;; (require 'w3m-haddock)
;; (add-hook 'w3m-display-hook 'w3m-haddock-display)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; End Haskell Mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Begin SQL Mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;; (add-hook 'sql-interactive-mode-hook
;;           (lambda ()
;;             (toggle-truncate-lines t)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; End SQL Mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Begin Emmet Mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun xah-syntax-color-hex ()
  "Syntax color text of the form 「#ff1100」 in current buffer.
URL `http://ergoemacs.org/emacs/emacs_CSS_colors.html'
Version 2016-03-15"
  (interactive)
  (font-lock-add-keywords
   nil
   '(("#[ABCDEFabcdef[:digit:]]\\{6\\}"
      (0 (put-text-property
          (match-beginning 0)
          (match-end 0)
          'face (list :background (match-string-no-properties 0)))))))
  (font-lock-fontify-buffer))

(add-hook 'css-mode-hook 'xah-syntax-color-hex)
(add-hook 'php-mode-hook 'xah-syntax-color-hex)
(add-hook 'html-mode-hook 'xah-syntax-color-hex)


(add-hook 'sgml-mode-hook 'emmet-mode) ;; Auto-start on any markup modes
(add-hook 'css-mode-hook  'emmet-mode) ;; enable Emmet's css abbreviation.
(add-hook 'emmet-mode-hook (lambda () (setq emmet-indent-after-insert nil)))
(add-hook 'emmet-mode-hook (lambda () (setq emmet-indentation 2))) ;; indent 2 spaces
(global-set-key (kbd "C-c p") ' emmet-prev-edit-point)
(global-set-key (kbd "C-c n") ' emmet-next-edit-point)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; End Emmet Mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Begin Elpy
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (require 'package)
;; (add-to-list 'package-archives
;;              '("elpy" . "http://jorgenschaefer.github.io/packages/"))
;; (set-face-background 'highlight-indentation-face "#e3e3d3")
;; (set-face-background 'highlight-indentation-current-column-face "#c3b3b3")

(package-initialize)
(elpy-enable)
;; (setenv "LC_CTYPE" "UTF-8")
(setq python-shell-interpreter "ipython")
(setq python-shell-completion-native-enable nil)
'(elpy-interactive-python-command "ipython")
(elpy-use-ipython)
(defadvice auto-complete-mode (around disable-auto-complete-for-python)
  (unless (eq major-mode 'python-mode) ad-do-it))

(ad-activate 'auto-complete-mode)
;; (require 'ein)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; End Elpy
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Begin Other Python
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; End Other Python
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Begin Jedi
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (add-hook 'python-mode-hook 'jedi:setup)
;; (setq jedi:complete-on-dot t)                 ; optional
;; (eval-after-load "jedi"
;;     '(setq jedi:server-command (list "/Users/nessig/anaconda/envs/emacs-jedi/bin/python" jedi:server-script)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; End Jedi
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;; Begin Web-Beautify

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(eval-after-load 'js2-mode
  '(define-key js2-mode-map (kbd "C-c b") 'web-beautify-js))
;; Or if you're using 'js-mode' (a.k.a 'javascript-mode')
(eval-after-load 'js
  '(define-key js-mode-map (kbd "C-c b") 'web-beautify-js))

(eval-after-load 'json-mode
  '(define-key json-mode-map (kbd "C-c b") 'web-beautify-js))

(eval-after-load 'sgml-mode
  '(define-key html-mode-map (kbd "C-c b") 'web-beautify-html))

(eval-after-load 'css-mode
  '(define-key css-mode-map (kbd "C-c b") 'web-beautify-css))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;; End Web-Beautify

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;; Begin C++ Mode

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; (require 'cc-mode)
;; (require 'auto-complete-clang)
;; (define-key c++-mode-map (kbd "TAB") 'ac-complete-clang)
;; (setq-default c-basic-offset 4 c-default-style "linux")
;; (setq-default tab-width 4 indent-tabs-mode t)
;; (define-key c-mode-base-map (kbd "RET") 'newline-and-indent)
(global-set-key (kbd "C-c r") 'clang-format-region)
(global-set-key (kbd "C-c b") 'clang-format-buffer)
;; (global-set-key [C-M-tab] 'clang-format-region)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;; End C++ Mode

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;; Begin PHP Mode

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;; End PHP Mode

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; (load (expand-file-name "~/quicklisp/slime-helper.el"))
;; (setq slime-contribs '(slime-fancy))
;; (setq inferior-lisp-program "/usr/local/bin/sbcl")



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;; Begin Org

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; -*- mode: elisp -*-

;; Disable the splash screen (to enable it agin, replace the t with 0)
;; (setq inhibit-splash-screen t)

;; ;; Enable transient mark mode
;; (transient-mark-mode 1)

;; ;;;;org-mode configuration
;; ;; Enable org-mode
;; (require 'org)
;; ;; Make org-mode work with files ending in .org
;; ;; (add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
;; ;; The above is the default in recent emacsen

;; (setq org-todo-keywords
;;   '((sequence "TODO" "IN-PROGRESS" "WAITING" "DONE")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;; End Org

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;





(show-paren-mode 1)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; auto close bracket insertion. New in emacs 24
(electric-pair-mode 1)


(if window-system
    (load-theme 'solarized-dark t))

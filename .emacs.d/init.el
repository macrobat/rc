;; in case of error, use (when nil ) to bisect this file

;; (check-parens)
;; (toggle-debug-on-error) ;

;; cons onto load-path list before we can load/require libs
;;(add-to-list 'load-path "~/.emacs.d/") ; warning
;; mapc is for side-effects only, it doesn't return a list like mapcar does


(mapc '(lambda (dir) (add-to-list 'load-path dir 'APPEND)) ; put it last
      '(
      ;; (load-file "~/.emacs.d/themes/color-theme.elc")
      "~/.emacs.d/themes"
      ;; if in, "~/.emacs.d/" should be last
      "~/.emacs.d/elisp" "~/.emacs.d/packages" ;))
	;; "~/.emacs.d/"
	))

;; (prefer-coding-system       'utf-8)
;; (set-default-coding-systems 'utf-8)
;; (setq buffer-file-coding-system 'utf-8)

;; put all in ~/emacs.d : init file .emacs-places .emms-cache .ido.last


;;; ==============================================================
;;; packages
;; so disappoint. ripping out the elpa system
;; something in elpa stopped working. *Warnings* has a ~7k char line
;; disable all that crap and load manually!

;; does not work. wrong-type-argument stringp nil
;; (update-directory-autoloads "~/.emacs.d/packages")
(defvar elpa-hate '(
"~/.emacs.d/packages/rainbow-delimiters.el"
"~/.emacs.d/packages/goto-last-change.el"
"~/.emacs.d/packages/rainbow-mode.el"
"~/.emacs.d/packages/smartparens.el"
"~/.emacs.d/packages/buffer-move.el"
;; "~/.emacs.d/packages/workgroups.el" ; require it or rewrite
"~/.emacs.d/packages/paredit.el"
"~/.emacs.d/packages/htmlize.el"
"~/.emacs.d/packages/popwin.el"
"~/.emacs.d/packages/dash.el"
"~/.emacs.d/packages/bm.el"
))

;; shit, closes windows
;; "~/.emacs.d/packages/browse-kill-ring+.el"
;; "~/.emacs.d/packages/browse-kill-ring.el"

;; "~/.emacs.d/packages/browse-kill-ring+-autoloads.el"
;; "~/.emacs.d/packages/browse-kill-ring-autoloads.el"

(defvar elpa-hate-autoloads '(
"~/.emacs.d/packages/rainbow-delimiters-autoloads.el"
"~/.emacs.d/packages/goto-last-change-autoloads.el"
"~/.emacs.d/packages/rainbow-mode-autoloads.el"
"~/.emacs.d/packages/smartparens-autoloads.el"
"~/.emacs.d/packages/buffer-move-autoloads.el"
"~/.emacs.d/packages/paredit-autoloads.el"
"~/.emacs.d/packages/htmlize-autoloads.el"
"~/.emacs.d/packages/dash-autoloads.el"
"~/.emacs.d/packages/bm-autoloads.el"
))
;; has no autoloads:
;; "~/.emacs.d/packages/workgroups-autoloads.el"
;; "~/.emacs.d/packages/popwin-autoloads.el"
;; undo-tree now part of emacs
;; the old edited version of rainbow-delimiters in ./elisp/
;; has better/gaudier colors

;; autoload all the crap
(mapcar (lambda (el) (load-file el)) elpa-hate-autoloads)
;; generate some files
;; (mapc (lambda (el) (byte-compile-file el)) elpa-hate)
;; resulting file doesn't have any content, just boilerplate
;;     (setq generated-autoload-file "bm-autoloads.el")
;;     (update-file-autoloads "bm.el")
;; (mapc (lambda (el)
;; 	(setq generated-autoload-file
;; 	      (concat (substring el 0 -3) "-autoloads.el"))
;; 	(update-file-autoloads el)) elpa-hate)

;; can "install" via elpa, then copy to ~/.emacs.d/packages
;; (require 'package)
;; (setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
;;                          ("marmalade" . "http://marmalade-repo.org/packages/")
;; ;;                         ("melpa" . "http://melpa.milkbox.net/packages/")
;; ))
;; elpa
;; └── archives
;;     ├── gnu
;;     │   └── archive-contents
;;     └── marmalade
;;         └── archive-contents

;; fic-mode to hilite TODO FIXME


;; http://www.emacswiki.org/emacs/PareditCheatsheet
;; straightjacket, masks many useful keybinds. (M-q)
;; this should be loaded already
;; (autoload 'paredit-mode "~/.emacs.d/packages/paredit-autoloads.el"
;;   "Minor mode for pseudo-structurally editing Lisp code." t nil)

(add-hook 'paredit-mode-on-hook
	  (lambda () (define-key paredit-mode-map
		  (kbd "C-j") 'eval-print-last-sexp))
	  (lambda () (define-key paredit-mode-map
		  (kbd "S-<backspace>") 'backward-delete-char))
	  (lambda () (message "paredit on"))
	  )

(add-hook 'paredit-mode-off-hook
	  (lambda () (message "paredit off")))

;; new rainbow parens are too subtle
;; M-x customize-group rainbow-delimiters
;; (require 'rainbow-delimiters)
;; (rainbow-delimiters-mode 1) ; needs paredit loaded
;; common-lisp-mode is an alias for lisp-mode
(mapc
 (lambda (bla-hook)
   (add-hook bla-hook
	     (lambda ()
	       ;; (paredit-mode)
	       ;; (require 'rainbow-delimiters)
	       ;; (rainbow-delimiters)
	       (require 'paredit)
               (turn-on-smartparens-mode)
               (sp-use-paredit-bindings)
               ;; doesn't work. why can I set the above things?'
               ;; (sp-local-pair bla-mode "'" nil :actions nil)
	       (rainbow-delimiters-mode 1))))
 '(emacs-lisp-mode-hook lisp-mode-hook lisp-interaction-mode-hook
                        scheme-mode-hook geiser-repl-mode-hook))

;; doesn't fucking work
(add-hook 'smartparens-mode-hook
          (lambda () (require 'smartparens-config)) ; less annoying lisp
          (lambda () (sp-pair "'" nil :actions :rem))) ; work-damnit-I-hate-you

(add-hook 'geiser-repl-mode-hook
    (lambda () (sp-pair "'" nil :actions :rem)))

;; there are no modes like that. What is it called?????
;; (sp-local-pair geiser-repl-mode "'" nil :actions nil)
;; (sp-local-pair repl-mode "'" nil :actions nil)
;; (sp-local-pair REPL-mode "'" nil :actions nil)


;; autoloads, how do they work?
;; (autoload 'lua-mode "lua-mode" "Lua editing mode." t)
;; (autoload 'buffer-move-mode "buffer-mode" "buffer mode." t)
;; (autoload '-mode "-mode" " editing mode." t)

(message "==============================================================")
(message "init: section packages end")
(message "==============================================================")


;; http://www.emacswiki.org/cgi-bin/wiki.pl?SessionManagement
;; need desktop-save-mode, and desktop-change-dir?
;; (info "(emacs)Saving Emacs Sessions")
;; session sparar inte vilka filer jag kör med. löst värde
;; (require 'session) ; se om det hjälper
;; (setq session-save-file "~/.emacs.d/session")
;; (add-hook 'after-init-hook 'session-initialize)

;;; let wg handle sessions instead?
;; does wg really handle sessions? it fails to load my buffers
(require 'desktop-menu)
(desktop-save-mode 1)
(setq desktop-load-locked-desktop t)
(desktop-read) ; gives error ; needed? the desktop wasn't read before
(setq desktop-base-file-name "desktop_savefile") ; don't want hidden files
(setq desktop-base-lock-name "desktop_lockfile")

;; old crap. want unique buffer names
;;(require 'uniquify) (setq uniquify-buffer-name-style 'forward)
(toggle-uniquify-buffer-names) ; how does this work?

;; emacsclient - tells a running Emacs to visit a file
;; you need an already running Emacs server
;; # alias em='emacsclient'
;; ec() { emacsclient --create-frame --alternate-editor="" -nw "$@"; }
(server-start)

(setq initial-scratch-message ";; This Machine Kills Text\n\n\n")
(setq inhibit-startup-message t)
(show-paren-mode 1)
(setq show-paren-style 'parenthesis) ; highlight just parens
;;(setq show-paren-style 'expression) ; highlight entire expression
;; M-x customize-face RET show-paren-match RET         byt bakgrund

;; (add-hook ... '(lambda () ...)) will work, but you shouldn't use it.
;; For reasons related to byte-compilation, (lambda () ...) is better.

;; doesn't seem to be built-in. download:
;; http://immerrr.github.io/lua-mode/
(setq auto-mode-alist (cons '("\.lua$" . lua-mode) auto-mode-alist))

;; \\' means end of string. (rx eos) => "\\'"
;; M-x unload-feature to un-require
;; (add-to-list auto-mode-alist '("\.lua\\'" . lua-mode))
;; auto-mode-alist is broken or something. using this instead
;; want c89 // comments in c and c++ mode for c and cpp headers
(add-to-list 'auto-mode-alist '("\\.c\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.hpp\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.hh\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.cl\\'" . common-lisp-mode))
(message "==============================================================")
(message "init: added to auto-mode-alist")
(message "==============================================================")
(add-hook 'c-mode-hook (lambda () (setq tab-width 4)))
(add-hook 'c++-mode-hook (lambda () (setq tab-width 4)))
(add-hook 'makefile-mode-hook 'setq indent-tabs-mode t)
;; File mode specification error: (invalid-function (setq tab-width 4)
;; not "gnu" style. c-set-style is C-c .
(setq c-default-style "linux")
(setq c-basic-offset 4)

;;; ---------------------------------------------------
;;; web

;; (setq nxml-slash-auto-complete-flag 't) ; finish a </
;; // css mode comments is illegal
;; (require 'rainbow-mode)
(add-hook 'css-mode-hook (lambda () (rainbow-mode)))
;;; ^^web
;;; ---------------------------------------------------

;; M-x set-frame-font
(when window-system
  ;; set-default-font is obsolete
  (set-frame-font
  "-unknown-DejaVu Sans Mono\
  -normal-normal-normal-*-15-*-*-*-m-0-iso10646-1")
  ;; smaller laptop fontsize
  ;; "-unknown-DejaVu Sans Mono\
  ;; -normal-normal-normal-*-12-*-*-*-m-0-iso10646-1")

  (set-frame-font "DejaVu Sans Mono")
  ;; (set-frame-font "Source Code Pro") ; too wide
  ;; (set-frame-font "Inconsolata")
  ;; (set-frame-font "Andale Mono")
  ;; (set-frame-font "Consolas")
  ;; (set-frame-font "Terminus")

  ;; (set-scroll-bar-mode 'right)

  (setq custom-safe-themes t) ; just fucking load it already!
  ;; (color-theme-initialize) ; old-old way
  ;; (load "color-theme-solarized")
  ;; (color-theme-solarized-dark)
  ;; custom-theme-load-path is (custom-theme-directory t)
  ;; finns temata i /usr/share/emacs/24.2/etc/
  ;; har lagt "color-theme" i ~/.emacs.d och temata i ~/.emacs.d/themes
  ;; themes that suck less: zenburn arjen goldenrod billw
  ;; (load-theme 'solarized-dark t) ; t consider safe
  ;; (load-theme 'grandshell t) ; load! I hate you!
  (load-file "~/.emacs.d/themes/grandshell-theme.el")

  ;; load-theme and themes in ~/.emacs.d/themes . both these work
  (setq custom-theme-directory "~/.emacs.d/themes")
  (add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
  ;; if load-path not using "~/.emacs.d/themes/"
  ;; (load-file "~/.emacs.d/themes/color-theme.elc")
  ;; (load-file "~/.emacs.d/themes/arjen-theme.elc")
  ;; (color-theme-arjen)
  ;; (color-theme-zenburn) ; (color-theme-gnome2)
  ;; region has a boring colour, change ~ line 100

  ;; nil => S-Ins wontwork. t => changes clipboard
  (setq x-select-enable-clipboard t)
  (setq interprogram-paste-function 'x-cut-buffer-or-selection-value)

  ;; browse-url       browse-url-at-point    browse-url-at-mouse
  (setq browse-url-generic-program (executable-find "firefox")
        browse-url-browser-function 'browse-url-generic)
  ;; (setq tabbar-mode t) ; have all *buffers* in a group?
  ;; bad, bad sorting of tabs. tabbar.el is from 2005. ~2000 lines.
  ;; snippets http://www.emacswiki.org/emacs/TabBarMode
  (tool-bar-mode -1)
  (menu-bar-mode -1)
  (winner-mode 1) ; undo window changes
  ;; (horizontal-scroll-bar-mode -1)
  
  ;;(speedbar t) ;; i want it in buffer mode < and narrower in awesome >

  ;; XXX
  ;; what does it bring to the table?
  ;; (require 'popwin) ; has no autoloads
  ;; (setq special-display-function
  ;;       'popwin:special-display-popup-window
  ;;       ;; 'special-display-popup-frame ; original value
  ;;       )
  ;; (setq pop-up-windows nil) ; shit, replaces buffer with popup

  ;; (setq pop-up-windows t)
  ;; (setq display-buffer-function 'popwin:display-buffer)
  ;; how do i know/control in what window a buffer will pop up in?
  ;; (info "(emacs) Force Same Window") might be useful
  ;; a variable that controls whether a new buffer should get
  ;; a different window from the current window. Non-nil means
  ;; `display-buffer' should make a new window. You can customize

  ) ; end of "when window-system"

;; maybe perspective.el instead of wg?
;; why won't it remember my windows and buffers?
;; seems to fail in a recentish emacs. symbols function definition is void
;; uses outdated flet
;; (require 'workgroups)
;;   (workgroups-mode 1)
;;   (setq wg-morph-on nil)
;;   (wg-load "~/.emacs.d/workgroups")
  
;; is wg-prefix-key set?

(put 'dired-find-alternate-file 'disabled nil) ; is 'a


(message "==============================================================")
(message "init: section keys, aliases")
(message "==============================================================")

;; the angle brackets are only used for things such as <C-backspace>
;; "The binding goes in the current buffer's local map, which in most
;; cases is shared with all other buffers in the same major mode."
;; vector syntax: (global-set-key [(meta left)] #'previous-buffer)
;; (kbd "<C-tab>") is just a macro that returns [C-tab]
;; typically you use `minor-mode-map-alist' to bind keys that you want
;;     to be active only in a certain minor mode.
;; ([]) lands you in debugger
;; [] don't work, use (kbd "C-bla") or keys spelled out [(control j)]
;; local bindings shadow global ones

(when window-system
  ;; use digit-argument when in terminal.
  ;; C-number doesn't work in term / may do other things
  ;; no need for shift M-! M-% M-& M-/ M-=
  (global-set-key (kbd "M-1") 'shell-command)
  (global-set-key (kbd "M-2") 'shell-command-on-region)
  (global-set-key (kbd "M-5") 'query-replace)
  (global-set-key (kbd "M-6") 'async-shell-command)
  (global-set-key (kbd "M-7") 'hippie-expand)
  (global-set-key (kbd "M-8") 'dabbrev-expand) ; also on C-tab
  (global-set-key (kbd "M-0") 'count-words-region))

;; handle lines conveniently
;; http://emacs-fu.blogspot.se/2009/11/copying-lines-without-selecting-them.html
(defadvice kill-ring-save (before slick-copy activate compile) "When called
  interactively with no active region, copy a single line instead."
  (interactive (if mark-active (list (region-beginning) (region-end)) (message
  "Copied line") (list (line-beginning-position) (line-beginning-position
  2)))))

(defadvice kill-region (before slick-cut activate compile)
  "When called interactively with no active region, kill a single line instead."
  (interactive
    (if mark-active (list (region-beginning) (region-end))
      (list (line-beginning-position)
        (line-beginning-position 2)))))

;; http://www.opensubscriber.com/message/emacs-devel@gnu.org/10971693.html
(defun comment-dwim-line (&optional arg)
  "Replacement comment-dwim. If no region is selected and current
  line is not blank and we are not at the end of the line, then
  comment current line. Replaces default behaviour of comment-dwim
  that inserts comment at the end of the line."
  (interactive "*P")
  (comment-normalize-vars)
  (if (and (not (region-active-p)) (not (looking-at "[ \t]*$")))
      (comment-or-uncomment-region (line-beginning-position) (line-end-position))
    (comment-dwim arg)))
(global-set-key "\M-;" 'comment-dwim-line)

;; delsel.el . built-in mode. delete selection if you insert
(delete-selection-mode t)


;; unnecessary, use M-w (global-set-key (kbd "M-e") 'copy-region-as-kill)

(global-set-key (kbd "<mode-line> <mouse-4>") 'previous-buffer)
(global-set-key (kbd "<mode-line> <mouse-5>") 'next-buffer)
;; no more unintentional mouse-delete-window:
(global-set-key (kbd "<mode-line> <mouse-3>") 'nil) ; something better

;; (global-set-key (kbd "C-'") 'dabbrev-expand)
;; (global-set-key (kbd "C-*") 'hippie-expand) ; is on M-7 M-/
(global-set-key (kbd "<C-tab>") 'dabbrev-expand) ; next-buffer?
;; vimmy normal mode m and '
(global-set-key (kbd "C-'") 'point-to-register)
(global-set-key (kbd "C-*") 'register-to-point)
(global-set-key (kbd "C-.") 'repeat) ; vimmy

;; (global-set-key (kbd "C-x C-b") (lambda () (ibuffer nil))) ; fail
;; [remap list-buffers] funkar visst inte
(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "C-h a") 'apropos)
(setq apropos-do-all t) ; search deper and slower. or use with C-u prefix
;; shift-tab inserts literal tab
(global-set-key (kbd "<backtab>") '(lambda () (interactive) (insert "\t")))
(windmove-default-keybindings) ; S-arrowkey, move to window

;; has no autoloads and we want the whole thing
;; buffermove.el has 4 ~identical functions - good candidate for a rewrite
(require 'buffer-move)
(global-set-key (kbd "<C-S-up>")     'buf-move-up)
(global-set-key (kbd "<C-S-down>")   'buf-move-down)
(global-set-key (kbd "<C-S-left>")   'buf-move-left)
(global-set-key (kbd "<C-S-right>")  'buf-move-right)

(global-set-key (kbd "<RET>") 'newline-and-indent)
;; hint: swap <RET> and C-j unless in python-mode. add-hook python-mode-hook?

;; there's no *scratch* hook. hyphen is now part of word
(add-hook 'emacs-lisp-mode-hook ; [(C-j)]
          (lambda () (local-set-key (kbd "C-j") 'eval-print-last-sexp))
          (lambda () (modify-syntax-entry ?- "w" emacs-lisp-mode-syntax-table)))

;; You add functions to the hook, not function calls, lambda doesn't need '
(global-set-key (kbd "C-S-j") (lambda () (interactive) (join-line t))) ; vimmy

;; gör ingenting, returnera ingenting, kbd macro is C-x (
(global-set-key (kbd "C-x C-k RET") 'ignore)

;; C-x v is for vc
(global-set-key (kbd "C-x ^") (lambda () (interactive)
                                (enlarge-window 3)))
(global-set-key (kbd "C-x }") (lambda () (interactive)
                                (enlarge-window-horizontally 5)))
(global-set-key (kbd "C-x {") (lambda () (interactive)
                                (shrink-window-horizontally 5)))

(global-set-key (kbd "<C-S-backspace>") 'kill-line)
(global-set-key (kbd "<C-S-k>") 'kill-line)
;; backward-kill-word är både <C-backspace> <M-backspace>
(global-set-key (kbd "<C-backspace>") 'backward-kill-sexp)
(global-set-key (kbd "M-t") 'transpose-sexps)
(global-set-key (kbd "C-M-t") 'transpose-words)
;; Put the space character in class whitespace.
;;          (modify-syntax-entry ?\s " ")
;; maybe C-S-g for (exit-minibuffer)
(global-set-key [C-S-g] 'exit-minibuffer)

(with-current-buffer "*Messages*" (local-set-key (kbd "q") 'bury-buffer))

;; FIXME Still deletes windows, disabling
;; browse-kill-ring+-autoloads
;; browse-kill-ring+ so as not to delete windows
;; (require 'browse-kill-ring+)
;; (browse-kill-ring-default-keybindings)
;; (global-set-key (kbd "C-c k") 'browse-kill-ring)
;; M-w is kill-ring-save

;; Define aliases ; use C-q C-j to /re/place a return
;; fmakunbound to unbound an alias
(defalias 'qrr 'query-replace-regexp)
(defalias 'qr  'query-replace)           ; M-%     M-5
(defalias 'rr  'replace-regexp)
(defalias 'rs  'replace-string)
;; won't leave cursor in minibuffer
(defalias 'sb  'isearch-backward-regexp) ; C-M r
(defalias 'ss  'isearch-forward-regexp)  ; C-M s
(defalias 'bb  'bury-buffer)
(defalias '\0  'bury-buffer)             ; first in suggestions, M-x RET
(defalias 'hr  'highlight-regexp)
(defalias 'rb  'revert-buffer)
(defalias 'pm  'paredit-mode)
(defalias 'yes-or-no-p 'y-or-n-p)

(message "==============================================================")
(message "init: set defaliases")
(message "==============================================================")

;; http://stackoverflow.com
(defun copy-full-path-to-kill-ring ()
  "copy buffer's full path to kill ring"
  (interactive)
  (when buffer-file-name
    (kill-new (file-truename buffer-file-name))))
(defalias 'fx 'copy-full-path-to-kill-ring) ; find a better name

;; with auto-fill-mode, breaks lines at whitespace
;(setq fill-column 79) ; doesn't ever work, even with add-hook!
;(add-hook 'lisp-mode-hook (lambda () (setq fill-column 79)))
;; exempel: (add-hook 'lisp-mode-hook (lambda () (sl_ime-mode t)))
(setq column-number-mode t) ; see column in mode-line
(setq echo-keystrokes '0.0625)

;; tab-complete when using M-:
(define-key read-expression-map (kbd "TAB") 'lisp-complete-symbol)

;; no autoload, pretty-lambdada is in ./elisp/
;; lambda won't show when printing with M-x ps-print-buffer-with-faces
(require 'pretty-lambdada)
(pretty-lambda-for-modes)

;; bm is better http://www.nongnu.org/bm/ can't jump across buffers, though
;; var är filen där allt sparas?  ~/.emacs.bmk är vanliga bookmarks
;; (setq bm-repository-file (expand-file-name "~/.emacs.d/bm-repository"))
;; :type 'string :group 'bm)

;; f10 is menu-bar-open
;;(define-key global-map [f9] 'bookmark-jump)
;;(define-key global-map [f10] 'bookmark-set)

;; there is also Bookmark+

;; won't work, use customize-group bookmark
;(setq 'bookmark-default-file "~/.emacs.d/bookmarks")
;; no autoload


;; (require 'bm)
;; toggle bookmarks by clicking in the fringe:
(global-set-key (kbd "<left-fringe> <mouse-1>")
        #'(lambda(event)
            (interactive "e")
            (save-excursion
              (mouse-set-point event)
              (bm-toggle))))


(defun smaller-text () (interactive) (text-scale-adjust -1))
(global-set-key (kbd "C-<mouse-5>") 'smaller-text)
(defun larger-text () (interactive) (text-scale-adjust +1))
(global-set-key (kbd "C-<mouse-4>") 'larger-text)

;; lower mouse scroll from 5. with shift, scroll 1 line
(setq mouse-wheel-scroll-amount
'(4
 ((shift)
  . 1)
 ;; ((control)) ; use C-<mouse-4> for fontsize dec
 ))

(setq mouse-wheel-progressive-speed nil)

;; is a toggle, use -1
(blink-cursor-mode -1)
(setq-default cursor-type '(bar . 5))
(setq-default cursor-in-non-selected-windows 'hollow)
(setq-default indent-tabs-mode nil)
;; also: C-x h M-x {un,}tabify

;; if case is important when searching:
;;(setq case-fold-search 'nil)

;; shells. apply to repl too?
;; ser t ex bara första raden filer vid ls
;; (setq comint-scroll-to-bottom-on-input t)
(setq scroll-conservatively 1)
(setq whitespace-style '(face trailing lines-tail tabs) whitespace-line-column 80)

(setq sentence-end-double-space nil) ; double space is default? really?

(setq frame-title-format '("%b")) ; no hostname

(global-set-key (kbd "C-h C-f") 'find-function) ; don't bind the emacs FAQ

;; find the bind something better
(global-set-key (kbd "M-o") 'other-window)

(message "==============================================================")
(message "init: section keys, aliases end")
(message "==============================================================")


(defun ans () (interactive) (ansi-term "/bin/zsh"))

(defun eshell/clear ()
  "http://www.khngai.com/emacs/eshell.php, to clear the eshell buffer."
  (interactive)
  (let ((inhibit-read-only t))
    (erase-buffer)))

;; less \\\\backslashes. you can set it to 'rx
;; need to load re-builder first? reb-quit
(setq reb-re-syntax 'string) ; default is 'read

(ido-mode t)
(setq ido-save-directory-list-file "~/.emacs.d/ido.last")
(setq ido-enable-flex-matching t) ; fuzzy matching
;; http://www.emacswiki.org/emacs/InteractivelyDoThings
;; http://www0.fh-trier.de/~politza/emacs/ido-hacks.el.gz
;; ido saves time http://vimeo.com/1013263

;; Display ido results vertically, rather than horizontally
;; ido-decorations in ido.el
;; Maybe "Confirm" is f ex to make a new buffer
(setq ido-decorations
      (quote
       ("\n-> " "" "\n   " "\n   ..." "[" "]" \
	" [No match]" " [Matched]" \
	" [Not readable]" " [Too big]" " [Confirm]")))

;; C-x f runs the command set-fill-column
(global-set-key (kbd "C-x f") 'ido-find-file-other-window)

(defun ido-disable-line-trucation () ; can't use a plain lambda?
  (set (make-local-variable 'truncate-lines) nil))
(add-hook 'ido-minibuffer-setup-hook 'ido-disable-line-trucation)
;; To modify the keybindings, use the ido-setup-hook.  For example:
;;(add-hook 'ido-setup-hook 'ido-my-keys)
;;(defun ido-my-keys () "Add my keybindings for ido."
;;  (define-key ido-completion-map " " 'ido-next-match))
;; <up> <down> arrows are for history, not for scrolling through matches
;; (define-key ido-completion-map (kbd "<down>") 'ido-next-match)

(require 'ido-hacks) ; M-x completion? (execute-extended-command)
;; use it with "ido-hacks-mode" how conf it? :D
(ido-hacks-mode t)
;; wontwork: (unload 'ido-hacks)

;; how do i put all #files# and files~ in ~/.emacs.d/ ?
;; http://www.emacswiki.org/emacs/BackupDirectory
;; Is there a downside to setting backup-by-copying to true?
;; it subtly affects issues wrt race conditions, journalling, hard links
(setq
 backup-by-copying t              ; don't clobber symlinks
 backup-directory-alist
 '(("." . "~/.emacs.d/backups/")) ; don't litter my fs tree
 delete-old-versions t
 kept-new-versions 3
 kept-old-versions 2
 version-control t)               ; use versioned backups
;; This will all place all auto-saves and backups in the directory?
(setq auto-save-file-name-transforms
;; match from beginning. don't try symlinks
;;         (REGEXP REPLACEMENT UNIQUIFY)
          `(("^.*/" "~/.emacs.d/autosaves/" t)))
(savehist-mode 1)

(when (file-exists-p "~/.emacs.d/zippyisms")
  (setq cookie-file "~/.emacs.d/zippyisms")) ; (message "yow")
(defalias 'yow 'cookie)

;; Is there a way to disable asking to follow symlinks into vcs?
;; setting it too early or too late
;; there is no vc-find-file-hook. not eval-after-load
;; (add-hook 'after-init-hook
;;           '(lambda () (remove-hook 'find-file-hook 'vc-find-file-hook)))
(setq vc-follow-symlinks nil) ; DO_AS_I_SAY_NOT_AS_I_DO
;; Symbol's value as variable is void: global-font-lock-mode-check-buffers
;; (setq find-file-hook
;;      global-font-lock-mode-check-buffers epa-file-find-file-hook)
;; this is too late. the hook is nil, but the question is asked
;; (add-hook 'after-init-hook
;;           '(lambda () (setq find-file-hook nil)))


;;; ==============================================================
;;; org mode
;; from David O'Toole Org tutorial
;; set this crap in the right keymap instead
;; (define-key global-map "\C-cl" 'org-store-link)
;; (define-key global-map "\C-ca" 'org-agenda)

;; (setq org-log-done t)

;;; ^^org mode
;;; ==============================================================


;; you can use slime-space instead of eldoc-mode

(defun run-slime () (interactive)
  (load (expand-file-name "~/.quicklisp/slime-helper.el"))
  ;; (setq inferior-lisp-program "clisp") ; for lol, why no slime-repl?
  ;; (setq inferior-lisp-program "/usr/bin/clisp")
  ;; (setq inferior-lisp-program "clojure")
  (setq inferior-lisp-program "sbcl")
  (require 'slime)
  (define-key lisp-mode-map [(C-j)] 'slime-eval-last-expression-in-repl)

  (add-hook
   'lisp-mode-hook
   (lambda () (local-set-key [(C-j)] 'slime-eval-last-expression-in-repl))
   (lambda () (local-set-key (kbd "<f12>") 'slime-selector)))

  (setq slime-protocol-version 'ignore)
  (setq slime-complete-symbol*-fancy t)
  (setq slime-complete-symbol-function 'slime-fuzzy-complete-symbol)
  ;; in $BROWSER "http://www.lispworks.com/reference/HyperSpec/"
  (setq common-lisp-hyperspec-root "file:/usr/share/doc/HyperSpec/")

  (slime-setup
   '(slime-repl slime-scratch slime-editing-commands
                slime-asdf slime-fancy))
  (slime)
  (slime-scratch))


;;; autoload like this. not load-file
(autoload 'geiser-mode "~/.emacs.d/elisp/geiser/elisp/geiser.el")

;; M-x run-geiser or start it and M-x geiser-connect
;; (setq geiser-repl-use-other-window  nil)
;; (setq geiser-repl-startup-time 20000) ; on slow puters
(setq geiser-impl-installed-implementations '(racket guile)) ; "mit-scheme" 
(setq geiser-repl-query-on-kill-p nil)
(setq geiser-active-implementations '(racket))
;; (setq geiser-mode-start-repl-p nil) ; to connect to a running scheme

;; TODO
;; need to know the process number to flag query-on-exit
;; (set-process-query-on-exit-flag PROCESS nil)
;; (map (lambda (p) (process-id p)) (process-list))
;; (map (lambda (p) (set-process-query-on-exit-flag (process-id p) nil)) (process-list))
;; (setq delete-exited-processes t) ; delete directly after exit

;; setup something to launch ~/.emacs.d/elisp/geiser/bin/mem-geiser-racket.sh and connect
;; ulimit -v 453084 ; 550Mb is too small
;; ./geiser-racket.sh -n localhost -p 37146
;; (geiser-repl--wait-for-prompt) ; only in the right buffer?
;; takes like 20 seconds, then there is no racket. half a gig is too small?
;; (async-shell-command "~/.emacs.d/elisp/geiser/bin/mem-geiser-racket.sh")

(defun run-geiser-limited () (interactive)
       (async-shell-command
        "ulimit -v 600000;
         ~/.emacs.d/elisp/geiser/bin/geiser-racket.sh -n localhost -p 37146"))

;; doesn't work? :/
(defun connect-to-racket-limited () (interactive)
       (connect-to-racket "localhost" 37146))
       ;; (geiser-connect 'racket "localhost" 37146)


;;; ==============================================================
;; erc, rcirc, lyskom
;; see erc-conf.el (rename to chat.el?)

(setq rcirc-default-nick "mcRibbit")
(setq rcirc-default-user-name "mcRibbit")
(setq rcirc-server-alist
      '(("irc.freenode.net" :channels
         ("#emacs" "#debian" "#archlinux"))))


;;; ==============================================================

;; Lines enabling gnuplot-mode

;; move the files gnuplot.el to someplace in your lisp load-path or
;; use a line like
;;  (setq load-path (append (list "/path/to/gnuplot") load-path))

;; these lines enable the use of gnuplot mode
;; (autoload 'gnuplot-mode "gnuplot" "gnuplot major mode" t)
;; (autoload 'gnuplot-make-buffer "gnuplot" "open a buffer in gnuplot mode" t)

;; this line automatically causes all files with the .gp extension to
;; be loaded into gnuplot mode
;; (setq auto-mode-alist (append '(("\\.gp$" . gnuplot-mode)) auto-mode-alist))

;; This line binds the function-9 key so that it opens a buffer into
;; gnuplot mode
;; (global-set-key [(f9)] 'gnuplot-make-buffer)

;; end of line for gnuplot-mode
;;; ==============================================================

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(safe-local-variable-values (quote ((geiser-scheme-implementation . racket))))
 '(tab-width 4))

;; do as I tell you!!!!!!!!!
(setq enable-local-variables :all)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; workgroups stopped working
(when window-system
  (set-frame-size (selected-frame) 110 60)) ; I thought 77 worked?
;; (set-frame-size (selected-frame) 110 72) ; for tool-bar & menu-bar

(message "==============================================================")
(message "init: reached end of file")
(message "==============================================================")


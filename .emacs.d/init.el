;; in case of error, use (when nil ) to bisect this file

;; cons onto load-path list before we can load/require libs
;;(add-to-list 'load-path "~/.emacs.d/") ; warning
;; mapc is for side-effects only, it doesn't return a list like mapcar does

(mapc '(lambda (dir) (add-to-list 'load-path dir)) ; if in, I want "~/.emacs.d/" last
      '("~/.emacs.d/elisp" "~/.emacs.d/" )) ; "~/.emacs.d/themes"

;; set up unicode
;; (prefer-coding-system       'utf-8)
;; (set-default-coding-systems 'utf-8) ; sets the next two
;; (set-terminal-coding-system 'utf-8)
;; (set-keyboard-coding-system 'utf-8)
;; obsolete. use `buffer-file-coding-system'
;; (setq default-buffer-file-coding-system 'utf-8)

;; put all in ~/emacs.d : init file .emacs-places .emms-cache .ido.last

;;; ==============================================================

;;; packages


;; TODO
;; elpa initializes after init-file is loaded, a way to conf pkgs is
;; (add-hook 'after-init-hook
;; '(lambda () (load-file "~/.emacs.d/package-init.el"))) and conf that file
;; with use-package you can defer loading until needed

;; TODO: use autoload
;; (autoload FUNCTION FILE &optional DOCSTRING INTERACTIVE TYPE)
;; Define FUNCTION to autoload from FILE.
;; FUNCTION is a symbol; FILE is a file name string to pass to `load'

;; you must not be initializing properly?
;; the variable is not autoloaded
;; if you do M-x list-packages  then you'll see it
;; and of course any customization or setting of that variable before the
;; package is loaded will persist over the package load.
;; so, (package-initialize) is done before add-list?
;; macrobat: no, you shouldn't do that
;; initializing how?
;; it should just be initialized through emacs. emacs does package init AFTER your init.el
;; One option is (eval-after-load 'package '(add-to-list 'package-archives ...))
;; dtw but you don't need to
;; just customize it
;; how then, can anyone load packages in the init file?
;; macrobat: yes... but in 24 packages are started automatically after init
;; don't get me wrong, of course you can do it. but it's not "right"
;; I shouldn't setq package-load-list?
;; I don't think so, no.

;; packages should autoload. any package that doesn't should be loaded with an
;; (eval-after-init ...) ; no such thing!!! lots of packages are modes that you
;; want to load with mode-alist... which can be done even if the package isn't
;; loaded, or done on some hook, which can be done without loading the package
;; or done on a key which can also be done without loading the package

;; where can I find this information (and more)?
;; well, the elisp manual describes the packaging startup.
;; but it's not very clear on the implications.

;; Any settings for packages sould be done with eval-after-init?
;; I don't think so, use customize if you can. If not then use a
;; package specific hook and if you can't do that then use an
;; eval-after-init, I guess.

;; package.el comes with emacs24
(load "~/.emacs.d/elpa/package_23_github.el")

;; 2013-05-28 trying default emacs24 package. vortex of fail
;; http://www.emacswiki.org/emacs/ELPA
;; have to use eval-after-load around each package use
;; and -autoloads for the minor modes
;; eval-after-load "broccoli-autoloads" ; <-- "broccoli-autoloads", not "broccoli"
;; (package-initialize) ; fails: cannot open ~/.emacs.d/elpa/archives/-pkg
;; package-initialize is run _after_ init file load and before after-init-hook
;; (require 'package) ; don't in emacs24

;; (setq package-archives
;;          '("marmalade" . "http://marmalade-repo.org/packages/"))
;; (add-to-list 'package-archives
;;   '("melpa" . "http://melpa.milkbox.net/packages/") t)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
;;                         ("melpa" . "http://melpa.milkbox.net/packages/") ; very fresh pkgs
))

;; Each element in this list should be a list (NAME VERSION)
(setq package-load-list
      '((bm "1.53") (browse-kill-ring "1.3.1") (buffer-move "0.4")
         (paredit "22") (rainbow-mode "0.1")
        (goto-last-change "1.2") (popwin "0.4")
        ))
;; (geiser "0.4") ; default wontwork
;; smartparen better than paredit? needs dash
;; (dash "20130712.2307") ; File exists: blabla dash-pkg.el
;; (smartparen "20130715.1530")
;; (workgroups "0.2.0") ; wont load, do it manually
;; (workgroups2 "20131002.1143") ; buggy
;; (htmlize "1.39")

;; Symbol's function definition is void: popwin:display-buffer
;; (popwin "0.4") ; have to load it manually
;; (eval-after-init (package-initialize) (require 'popwin)) ; there is no eval-after-init
;; (add-hook 'after-init-hook (lambda () (require 'popwin)))

;; pkgs installed by elpa will be requireable
;; (package-initialize)
;; This was installed by package-install.el. This provides support for the package system and
;; interfacing with ELPA, the package archive. Move this code earlier if you want to reference
;; packages in this file:

;; (eval-after-load 'package '(add-to-list 'package-archives ...))
;; "packages should autoload. any package that doesn't should be loaded with an (eval-after-init ...)"
;; there is no eval-after-init

;; haet. it doesn't fucking load!!!!!!!1elebenty
(when (load (expand-file-name "~/.emacs.d/elpa/package_23_github.el"))
  (package-initialize)
  (require 'popwin)
  ;; see also display-buffer-alist
  (setq special-display-function
        'popwin:special-display-popup-window))

;;; ^^packages
;;; ==============================================================

;; http://www.emacswiki.org/cgi-bin/wiki.pl?SessionManagement
;; need desktop-save-mode, and desktop-change-dir?
;; (info "(emacs)Saving Emacs Sessions")
;; session sparar inte vilka filer jag kör med. löst värde
;; (require 'session) ; se om det hjälper
;; (setq session-save-file "~/.emacs.d/session")
;; (add-hook 'after-init-hook 'session-initialize)

;;; let wg handle sessions instead?
;; (require 'desktop-menu)
;; (desktop-save-mode 1)
;; (desktop-read) ;gives error ;needed? the desktop wasn't read before

;; old crap. want unique buffer names
;;(require 'uniquify) (setq uniquify-buffer-name-style 'forward)
(toggle-uniquify-buffer-names) ; how does this work?

;; emacsclient - tells a running Emacs to visit a file
;; you need an already running Emacs server
;; ec() { emacsclient --create-frame --alternate-editor="" -nw "$@"; }
;; # alias em='emacsclient'
(server-start)

(setq initial-scratch-message ";; This Machine Kills Text\n\n")
(setq inhibit-startup-message t)
(show-paren-mode 1)
(setq show-paren-style 'parenthesis) ; highlight just parens
;;(setq show-paren-style 'expression) ; highlight entire expression
;; M-x customize-face RET show-paren-match RET         byt bakgrund

;; (add-hook ... '(lambda () ...)) will work, but you shouldn't use it.
;; For reasons related to byte-compilation, (lambda () ...) is better.

;; TODO: pkginit
;; http://www.emacswiki.org/emacs/PareditCheatsheet
;; straightjacket, masks many useful keybinds. (M-q)
;; (require 'paredit) ; don't need to enable it for rain-delim
;; require it with elpa?
;; is the first arg something in the file or the users own function?
(autoload 'paredit-mode "~/.emacs.d/elpa/paredit-22/paredit-autoloads.el"
  "Minor mode for pseudo-structurally editing Lisp code." t nil)
;; (add-hook 'emacs-lisp-mode-hook       (lambda () (paredit-mode +1)))
;; (add-hook 'lisp-mode-hook             (lambda () (paredit-mode +1)))
;; (add-hook 'lisp-interaction-mode-hook (lambda () (paredit-mode +1)))
;;(if (or (featurep emacs-lisp-mode) (featurep lisp-interaction-mode))
;; bind delete to backward-delete-char in paredit-mode
;; (with-current-buffer "*scratch*" (local-set-key
;;   (kbd "<C-j>") 'eval-print-last-sexp))
;; ,paredit-nonlisp is
;; (set (make-local-variable
;; 'paredit-space-for-delimiter-predicates)
;;  '((lambda (endp delimiter nil)))

;; (when (featurep 'paredit) <bind some keys>)
;; paredit-mode-off-hook
;; paredit-mode-on-hook
(add-hook 'paredit-mode-on-hook
;; local-set-key changes the major mode, not the minor paredit-mode
	  ;; (lambda () (local-set-key
	  ;; 	 (kbd "C-j") 'eval-print-last-sexp))
	  ;; (lambda () (local-set-key
	  ;; 	 (kbd "S-<backspace>") 'backward-delete-char))
	  (lambda () (define-key paredit-mode-map
		  (kbd "C-j") 'eval-print-last-sexp))
	  (lambda () (define-key paredit-mode-map
		  (kbd "S-<backspace>") 'backward-delete-char))
	  (lambda () (message "paredit on. no message?"))
	  )

(add-hook 'paredit-mode-off-hook
	  (lambda () (message "paredit off. message works.")))


;; (require 'rainbow-delimiters)
;; (rainbow-delimiters-mode 1) ; buffer-local
;; needs paredit loaded
(add-hook 'lisp-mode-hook
          (lambda ()
            (require 'paredit)
            (require 'rainbow-delimiters)
            (rainbow-delimiters-mode 1)))
(add-hook 'lisp-interaction-mode-hook
          (lambda ()
            (require 'paredit)
            (require 'rainbow-delimiters)
            (rainbow-delimiters-mode 1)))

;; smart-parens: no '' pair in emacs-lisp-mode
;; (sp-local-pair 'emacs-lisp-mode "'" nil :actions nil)
;; (sp-local-pair 'scheme-mode "'" nil :actions nil)
;; (sp-local-pair 'geiser-repl-mode "'" nil :actions nil)

;;; ---------------------------------------------------
;;; web stuffs

;; (setq nxml-slash-auto-complete-flag 't) ; finish a </
;; // css mode comments is illegal

;; using elpa  (load-file "~/.emacs.d/rainbow/rainbow-mode.el")
(require 'rainbow-mode)
(add-hook 'css-mode-hook (rainbow-mode))
;;; ^^web stuffs
;;; ---------------------------------------------------


;; M-x unload-feature to un-require
(setq auto-mode-alist (cons '("\.lua$" . lua-mode) auto-mode-alist))
(autoload 'lua-mode "lua-mode" "Lua editing mode." t)
;; want // comments in c and c++ mode for c and cpp headers
(add-to-list 'auto-mode-alist '("\\.c\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.hpp\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.hh\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.cl\\'" . common-lisp-mode))
(add-hook 'c-mode-hook (lambda () (setq tab-width 4)))
(add-hook 'c++-mode-hook (lambda () (setq tab-width 4)))
(add-hook 'makefile-mode-hook 'setq indent-tabs-mode t)
;; File mode specification error: (invalid-function (setq tab-width 4)
;; not "gnu" style. c-set-style is C-c .
(setq c-default-style "linux"
      c-basic-offset 4)

;; "when" has an implicit progn
(when window-system
  (set-frame-font ; set-default-font is obsolete
   ;; M-x set-frame-font
   ;; smaller laptop fontsize
;; "-unknown-DejaVu Sans Mono-normal-normal-normal-*-12-*-*-*-m-0-iso10646-1")
   "-unknown-DejaVu Sans Mono-normal-normal-normal-*-16-*-*-*-m-0-iso10646-1")
  ;; (set-frame-font "Inconsolata")
  ;; (set-frame-font "Consolas")
  ;; (set-frame-font "Andale Mono")
  ;; (set-frame-font "Terminus")

  ;; (set-scroll-bar-mode 'right)

  ;; (color-theme-initialize) ; old-old way
  ;; (load "color-theme-solarized")
  ;; (color-theme-solarized-dark)
  ;; custom-theme-load-path is (custom-theme-directory t)
  ;; finns temata i /usr/share/emacs/24.2/etc/
  ;; har lagt "color-theme" i ~/.emacs.d och temata i ~/.emacs.d/themes
  ;; themes that suck less: zenburn arjen goldenrod billw
  ;; (load-theme 'solarized-dark t) ; t consider safe
  
  ;; load-theme and themes in ~/.emacs.d/themes . both these work
  (setq custom-theme-directory "~/.emacs.d/themes")
  (add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")

  (load "color-theme")
  (load "~/.emacs.d/themes/arjen-theme")
  (color-theme-arjen)

  ;; (color-theme-zenburn) ; (color-theme-gnome2)
  ;; region has aboring colour, change ~ line 100

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
  ;;(speedbar t) ;; i want it in buffer mode < and narrower in awesome >

  ;; (setq pop-up-windows nil) ; shit, replaces shown buffer with popup
  (setq pop-up-windows t)
  ;; (setq display-buffer-function 'popwin:display-buffer)
  ;; how do i know/control in what window a buffer will pop up in?
  ;; (info "(emacs) Force Same Window") might be useful
  ;; a variable that controls whether a new buffer should get
  ;; a different window from the current window. Non-nil means
  ;; `display-buffer' should make a new window. You can customize

) ; end of "when window-system"

;; (require 'workgroups)
;; crap won't require with elpa
;; byte-compiled
(when (file-exists-p "~/.emacs.d/elpa/workgroups-0.2.0/workgroups.elc")
  (load-file "~/.emacs.d/elpa/workgroups-0.2.0/workgroups.elc"))
  (workgroups-mode 1)
  (setq wg-morph-on nil)
  (wg-load "~/.emacs.d/workgroups")  ; holds multiple wg:s
;; wg-prefix-key is a defcustom. is it set?
;; (when (featurep 'workgroups) )

(put 'dired-find-alternate-file 'disabled nil) ; is 'a

;;; ==============================================================
;;; keys, looks
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

;; no need for shift
(when window-system
  ;; use digit-argument when in terminal.
  ;; C-number doesn't work in term / may do other things
  ;; wrong(mapcar (lambda (k) (interactive) (describe-key k)) '(M-! M-% M-& M-/ M-=))
  (global-set-key (kbd "M-1") 'shell-command)
  (global-set-key (kbd "M-2") 'shell-command-on-region)
  (global-set-key (kbd "M-5") 'query-replace)
  (global-set-key (kbd "M-6") 'async-shell-command)
  (global-set-key (kbd "M-7") 'dabbrev-expand)
  (global-set-key (kbd "M-0") 'count-lines-region))

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
;; unnecessary, use M-w (global-set-key (kbd "M-e") 'copy-region-as-kill)
(global-set-key (kbd "<mode-line> <mouse-4>") 'previous-buffer)
(global-set-key (kbd "<mode-line> <mouse-5>") 'next-buffer)
;; no more unintentional mouse-delete-window:
(global-set-key (kbd "<mode-line> <mouse-3>") 'nil) ; something better
;;(global-set-key (kbd "M-n") 'dabbrev-expand) ; duplicates info buffer?
;;(global-set-key (kbd "M-p") 'hippie-expand)

;; (global-set-key (kbd "C-'") 'dabbrev-expand) is on M-7 M-/
;; (global-set-key (kbd "C-*") 'hippie-expand)
(global-set-key (kbd "<C-tab>") 'hippie-expand) ; next-buffer?
;; vimmy normal mode m and '
(global-set-key (kbd "C-'") 'point-to-register)
(global-set-key (kbd "C-*") 'register-to-point)
(global-set-key (kbd "C-.") 'repeat) ; vimmy


(global-set-key (kbd "C-x C-b") 'ibuffer) ; [remap list-buffers] funkar visst inte
(global-set-key (kbd "C-h a") 'apropos)
(setq apropos-do-all t) ; search deper and slower. or use with C-u prefix
;; literal tab
(global-set-key (kbd "<backtab>") '(lambda () (interactive) (insert "\t")))
(windmove-default-keybindings) ; S-arrowkey, move to window

(require 'buffer-move)
;; buffermove.el 4 identical functions - good candidate for a rewrite
(global-set-key (kbd "<C-S-up>")     'buf-move-up)
(global-set-key (kbd "<C-S-down>")   'buf-move-down)
(global-set-key (kbd "<C-S-left>")   'buf-move-left)
(global-set-key (kbd "<C-S-right>")  'buf-move-right)

(global-set-key (kbd "<RET>") 'newline-and-indent)
;; swap <RET> and C-j unless in python-mode. add-hook python-mode-hook?

;; there's no *scratch* hook. hyphen is now part of word
(add-hook 'emacs-lisp-mode-hook
          (lambda () (local-set-key [(C-j)] 'eval-print-last-sexp))
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

;; bind q till bury-buffer i *Messages*
;; (add-hook '    (lambda ()  (local-set-key (kbd "q") 'bury-buffer))
(with-current-buffer "*Messages*" (local-set-key (kbd "q") 'bury-buffer))
;; (with-current-buffer "*Warnings*" (local-set-key (kbd "q") 'bury-buffer))
                                        ; "no such buffer"

;; C-x C-j jump to dired. behöver inte spara på en massa dired-buffrar?
(require 'dired-x)

(browse-kill-ring-default-keybindings)
(global-set-key (kbd "C-c k") 'browse-kill-ring)
;; have downloaded browse-kill-ring+.el
;; M-w is kill-ring-save, it works

;; Define aliases ; use C-q C-j to /re/place a return
;; fmakunbound to unbound an alias
(defalias 'yes-or-no-p 'y-or-n-p)
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

;; lambda won't show when printing with M-x ps-print-buffer-with-faces
(require 'pretty-lambdada)
(pretty-lambda-for-modes)


;; bm is better http://www.nongnu.org/bm/ can't jump across buffers, though
;; (require 'bm) ; no? (file-error "Cannot open load file" "bm")
;; var är filen där allt sparas?  ~/.emacs.bmk är vanliga bookmarks
;; f10 is menu-bar-open
;;(define-key global-map [f9] 'bookmark-jump)
;;(define-key global-map [f10] 'bookmark-set)

;; TODO: pkginit
;; (load "bm-1.52") ; new version, elpa
(require 'bm)
;; toggle bookmarks by clicking in the fringe:
(global-set-key (kbd "<left-fringe> <mouse-1>")
        #'(lambda(event)
            (interactive "e")
            (save-excursion
              (mouse-set-point event)
              (bm-toggle))))
;; there is also Bookmark+

;; won't work, use customize-group bookmark
;(setq 'bookmark-default-file "~/.emacs.d/bookmarks")


(defun smaller-text () (interactive) (text-scale-adjust -1))
(global-set-key (kbd "C-<mouse-4>") 'smaller-text)
(defun larger-text () (interactive) (text-scale-adjust +1))
(global-set-key (kbd "C-<mouse-5>") 'larger-text)
;; (global-set-key (kbd "C-<mouse-5>") '(lambda (s) ((interactive) (text-scale-adjust s)) +1))
;; (global-set-key (kbd "C-<mouse-5>") '(lambda (s) ((interactive) (text-scale-adjust s)) +1))

;; lower mouse scroll from 5. also use with shift (and maybe ctrl)
(setq mouse-wheel-scroll-amount
'(4
 ((shift)
  . 1)
 ;; ((control)) ; use C-<mouse-4> for fontsize dec
 ))

(setq mouse-wheel-progressive-speed nil)

;; is a toggle
(blink-cursor-mode -1)
(setq-default cursor-type '(bar . 4)) ; globally
;; tabs are evil. C-x h M-x {un,}tabify
(setq-default indent-tabs-mode nil)

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


;;; ^^keys ^^looks
;;; ==============================================================

(defun eshell/clear ()
  "http://www.khngai.com/emacs/eshell.php, to clear the eshell buffer."
  (interactive)
  (let ((inhibit-read-only t))
    (erase-buffer)))

(setq reb-re-syntax 'string)
(require 'browse-kill-ring)

(ido-mode t)
(setq ido-save-directory-list-file "~/.emacs.d/ido.last")
(setq ido-enable-flex-matching t) ; fuzzy matching
;; http://www.emacswiki.org/emacs/InteractivelyDoThings
;; http://www0.fh-trier.de/~politza/emacs/ido-hacks.el.gz
;; ido saves time http://vimeo.com/1013263

;; Display ido results vertically, rather than horizontally
;; ido-decorations in ido.el
;; Maybe "Confirm" is f ex to make a new buffer
;; TODO: make <up> <down> arrows work
(setq ido-decorations (quote ("\n-> " "" "\n   " "\n   ..." "[" "]" " [No match]" " [Matched]" " [Not readable]" " [Too big]" " [Confirm]")))

;; C-x f runs the command set-fill-column
;; wrap in (if ( bla ido-mode) )
(global-set-key (kbd "C-x f") 'ido-find-file)

(defun ido-disable-line-trucation () ; use a lambda
  (set (make-local-variable 'truncate-lines) nil))
(add-hook 'ido-minibuffer-setup-hook 'ido-disable-line-trucation)

;; XXX ido-hacks wont work with emacs24
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
;; these is no vc-find-file-hook. not eval-after-load
;; (add-hook 'after-init-hook
;;           '(lambda () (remove-hook 'find-file-hook 'vc-find-file-hook)))
;; (setq vc-follow-symlinks nil) ; DO_AS_I_SAY_NOT_AS_I_DO
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


;; nvm, fortune won't work anyway
;;(setq fortune-dir "/usr/share/fortune/")

;; When I make a region with the mouse and press delete, it is deleted. When I
;; set a mark, move the point with keystrokes and press delete, only one char disappears.
;; (delete-selection-mode 1) ; won't be put in kill-ring



;;; ==============================================================

;; (define-key slime-mode-map [(return)] 'paredit-newline)
;; (define-key slime-mode-map [(bla ( )] (lambda () (interactive) (insert "(")))
;; (define-key slime-mode-map [(literal ) )] (lambda () (interactive) (insert ")")))

;; you can use slime-space instead of eldoc-mode
;; opens up in $BROWSER
;(setq common-lisp-hyperspec-root "http://www.lispworks.com/reference/HyperSpec/")
;; (setq common-lisp-hyperspec-root "file:/usr/share/doc/HyperSpec/")

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
  (setq common-lisp-hyperspec-root "file:/usr/share/doc/HyperSpec/")

  (slime-setup
   '(slime-repl slime-scratch slime-editing-commands
                slime-asdf slime-fancy))
  (slime)
  (slime-scratch))


;;; geiser for scheme interaction
;; (setq scheme-program-name "racket") ;"mit-scheme" "guile"
;; (setq geiser-repl-use-other-window  nil)

;; (setq geiser-repl-startup-time 20000) ; on slow puters
(load-file "~/.emacs.d/elisp/geiser/elisp/geiser.el")
(setq geiser-impl-installed-implementations '(racket guile))
(setq geiser-repl-query-on-kill-p nil)
(setq geiser-active-implementations '(racket))


;;; ==============================================================
;; erc, rcirc, lyskom
;; see erc-conf.el (rename to chat.el?)

(setq rcirc-default-nick "mcRibbit")
(setq rcirc-default-user-name "mcRibbit")
(setq rcirc-server-alist
      '(("irc.freenode.net" :channels
         ("#emacs" "#lisp" "#debian" "#archlinux"))))


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

 '(custom-safe-themes t)
 )

(custom-set-faces
 ;; custom-set-faces was added by Custom.

 )

;; (when window-system
;;   (set-frame-size (selected-frame) 110 77))
;; (set-frame-size (selected-frame) 110 72) ; for tool-bar & menu-bar


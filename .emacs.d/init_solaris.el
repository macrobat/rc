;; for debugging with binary search:
;; (when nil  );
(toggle-debug-on-error)

;; cons onto load-path list before we can load/require libs
;;(add-to-list 'load-path "~/.emacs.d/")
;; mapc is for side-effects only, it doesn't return a list like mapcar does
(mapc '(lambda (dir) (add-to-list 'load-path dir)) '("~/.emacs.d/" "~/.emacs.d/elpa"))
;; do i neeed all dirs in elpa too?

;; set up unicode
;; (prefer-coding-system       'utf-8)
;; (set-default-coding-systems 'utf-8)
;; (set-terminal-coding-system 'utf-8)
;; (set-keyboard-coding-system 'utf-8)
;; (setq default-buffer-file-coding-system 'utf-8)

;; removed these, use packages and elpa
;; "~/.emacs.d/workgroups.el/" "~/.emacs.d/slime/" "~/.emacs./rainbow"
;; "emacs-color-theme-solarized"
;; no need for special slime. works with clisp now
;; "/usr/share/emacs/site-lisp/slime/contrib/"
;; have added slime to default Info dir
;; (add-to-list 'Info-default-directory-list "~/.emacs.d/slime/doc/")

;; lägg allt i ~/emacs.d inbegriper .emacs .emacs-places .emms-cache .ido.last
;; You can use ~/.emacs.d/init.el instead of ~/.emacs with no links required
;; and you can customize the variable ido-save-directory-list-file.
;; the same with emms-directory emms-directory specifies where emms
;; puts other things. there is also, emms-cache-file.

;; package.el is put in the elpa dir or comes with emacs24
(require 'package)
(add-to-list 'package-archives
	     '("marmalade" . "http://marmalade-repo.org/packages/"))
;; Each element in this list should be a list (NAME VERSION)
;; (setq package-load-list 'all) ?
(setq package-load-list
      '((bm "1.53") (browse-kill-ring "1.3.1") (buffer-move "0.4")
	(rainbow-mode "0.1") (workgroups "0.2.0") (paredit "22")))
;;  outdated: (slime "20100404.1")

;; This was installed by package-install.el. This provides support for the package system and
;; interfacing with ELPA, the package archive. Move this code earlier if you want to reference
;; packages in this file:
(when
    (load
     (expand-file-name "~/.emacs.d/elpa/package.el"))
  (package-initialize))

(browse-kill-ring-default-keybindings) ;; M-y

;; http://www.emacswiki.org/cgi-bin/wiki.pl?SessionManagement
;; need desktop-save-mode, and desktop-change-dir?
;; (info "(emacs)Saving Emacs Sessions")
;; session sparar inte vilka filer jag kör med. löst värde
;; (require 'session) ; se om det hjälper
;; (setq session-save-file "~/.emacs.d/session")
;; (add-hook 'after-init-hook 'session-initialize)

;; problem med desktop. tdoe och eval
;; får inga fel
(require 'desktop-menu)
(desktop-save-mode 1)
;; (desktop-read) ;gives error ;needed? the desktop wasn't read before

;; old crap. want unique buffer names
;;(require 'uniquify) (setq uniquify-buffer-name-style 'forward)
(toggle-uniquify-buffer-names) ; how does this work?

;; emacsclient - tells a running Emacs to visit a file
;; you need an already running Emacs server
;; ec() { emacsclient --create-frame --alternate-editor="" -nw "$@"; }
;; # alias em='emacsclient'
(server-start)

;; DONOTWANT!! (glasses-mode) sätter visst in _ här och var
(setq inhibit-startup-message t)
(show-paren-mode 1)
(setq show-paren-style 'parenthesis) ; highlight just parens
;;(setq show-paren-style 'expression) ; highlight entire expression
;; M-x customize-face RET show-paren-match RET         byt bakgrund

;; http://www.emacswiki.org/emacs/PareditCheatsheet
;; stupid straightjacket, masks many useful keybinds. (M-q)
;; paredit is a minor mode
;; (require 'paredit)
;; (autoload 'paredit-mode "paredit"
;;   "Minor mode for pseudo-structurally editing Lisp code." t)
;;    ;; (add-hook 'emacs-lisp-mode-hook       (lambda () (paredit-mode +1)))
;; (add-hook 'lisp-mode-hook             (lambda () (paredit-mode +1)))
;; (add-hook 'lisp-interaction-mode-hook (lambda () (paredit-mode +1)))
(require 'rainbow-delimiters)
;; (rainbow-delimiters-mode)
;; maybe like this? (setq rainbow-delimiters-mode 1)

;; You don't add a hook; you hang a function on a hook.
;; using elpa now (load-file "~/.emacs.d/rainbow/rainbow-mode.el")
(require 'rainbow-mode)
(add-hook 'css-mode-hook (rainbow-mode))
(setq auto-mode-alist (cons '("\.lua$" . lua-mode) auto-mode-alist))
(autoload 'lua-mode "lua-mode" "Lua editing mode." t)
;; want // comments in c and c++ mode for c and cpp headers
(add-to-list 'auto-mode-alist '("\\.c\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.hpp\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.hh\\'" . c++-mode))
;;(add-to-list 'auto-mode-alist '("\\.cl\\'" . common-lisp-mode))
(add-to-list 'auto-mode-alist '("\\.cl\\'" . lisp-mode)) ; no ELI
(add-to-list 'auto-mode-alist '("\\.lisp\\'" . lisp-mode))
(add-hook 'c-mode-hook (lambda () (setq tab-width 4)))
(add-hook 'c++-mode-hook (lambda () (setq tab-width 4)))
;; File mode specification error: (invalid-function (setq tab-width 4)

;; glömt vad "autoload" är
;; M-x unload-feature to un-require

;; "when" has an implicit progn,  so it's just:
;; (when (condition) (do 1) (do 2) (do n))
(when window-system
  ;;(set-default-font
   ;; what fonts are there?
   ;; "-unknown-DejaVu Sans Mono-normal-normal-normal-*-12-*-*-*-m-0-iso10646-1") ; lappy
   ;; "-unknown-DejaVu Sans Mono-normal-normal-normal-*-16-*-*-*-m-0-iso10646-1") ; desktop
  (set-scroll-bar-mode 'right)
  
  ;;(color-theme-initialize) ; old way, not in new emacs
  ;; har lagt "color-theme" och temata i ~/.emacs.d
  ;; themes that suck less: zenburn arjen goldenrod billw
  ;; (load "color-theme-solarized")
  ;; (color-theme-solarized-light)
  (load "color-theme")
  (load "arjen-theme")
  (color-theme-arjen)
  ;;(color-theme-zenburn)
  ;; (color-theme-gnome2)
  ;; region är lite tråkig, försöker ändra runt rad 100

  ;; om jag stänger av, funkar inte S-Ins. om det är på ändras i clipboard
  (setq x-select-enable-clipboard t)
  (setq interprogram-paste-function 'x-cut-buffer-or-selection-value)

  ;; vill öppna länkar i conkeror/firefox
  ;; browse-url       browse-url-at-point    browse-url-at-mouse
  (setq browse-url-generic-program (executable-find "firefox")
	browse-url-browser-function 'browse-url-generic)
					;(setq tabbar-mode t) ; lägg alla *buffers* i en grupp.
  ;; är skit, dålig dålig sortering
  ;; tabbar.el är fr 2005 och är ~2000 rader. vilken tabbar är i emacs24?
  ;; finns snippets på http://www.emacswiki.org/emacs/TabBarMode
					;(require 'tabbar)
					;(tabbar-mode t)
  (tool-bar-mode -1)
  (menu-bar-mode -1)
  (winner-mode 1) ; undo window changes
  ;;(speedbar t) ;; i want it in buffer mode < and narrower in awesome >

  ;; (setq pop-up-windows nil) ; skit, ersätter bef. buffer med popup
  (setq pop-up-windows t)
  ;; how do i know/control in what window a buffer will pop up in?
  ;; (info "(emacs) Force Same Window") might be useful
  ;; a variable that controls whether a new buffer should get
  ;; a different window from the current window. Non-nil means
  ;; `display-buffer' should make a new window. You can customize
  ;; this variable.
  ;; protips: one-window-p & (length (window-list))
  ;; Defined in `/usr/share/emacs/23.1/lisp/window.elc'.

) 
;; end of "when window-system"

;;; ---------------------------------------------------
;; keys, utseende och sånt
;; the angle brackets are only used for things such as <C-backspace>
;; "The binding goes in the current buffer's local map, which in most cases is shared with all other buffers in the same major mode."
;; vector syntax: (global-set-key [(meta left)] #'previous-buffer)
;; (kbd "<C-tab>") is just a macro that returns [C-tab]
;; typically you use `minor-mode-map-alist' to bind keys that you want to be active only in a certain minor mode.

;; no need for shift
(when window-system
  ;; use digit-argument when in terminal.
  ;; C-number doesn't work in term / may do other things
  ;;wrong(mapcar (lambda (k) (interactive) (describe-key k)) '(M-! M-% M-& M-/ M-=))
  (global-set-key (kbd "M-1") 'shell-command)
  (global-set-key (kbd "M-2") 'shell-command-on-region)
  (global-set-key (kbd "M-5") 'query-replace)
  (global-set-key (kbd "M-6") 'async-shell-command)
  (global-set-key (kbd "M-7") 'dabbrev-expand)
  (global-set-key (kbd "M-0") 'count-lines-region))

;; {} <> don't work, the sexp definitions depend on mode
;; and are awfully useless
;; matching-paren doesn't highlight {} <> (unless defined in the mode?)
(defun goto-match-paren (arg)
  "Go to matching if on ()[], similar to vi %"
  (interactive "p")
  ;; first, check for "outside of bracket" positions expected by forward-sexp, etc.
  (cond ((looking-at "[\[\(\{\<]") (forward-sexp))
        ((looking-back "[\]\)\}\>]" 1) (backward-sexp))
        ;; now, try to succeed from inside of a bracket
        ((looking-at "[\]\)\}\<]") (forward-char) (backward-sexp))
        ((looking-back "[\[\(\{\>]" 1) (backward-char) (forward-sexp))
        (t nil)))
(global-set-key (kbd "C-%") 'goto-match-paren)

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

;; isf (slime-next-note) ; gå till kompileringsfel
;;(add-hook 'lisp-mode-hook (lambda ()
;;(local-set-key (kbd "M-n") 'dabbrev-expand)))
;;(add-hook 'lisp-mode-hook (lambda () (local-set-key (kbd "M-p") 'hippie-expand)))

;; has nothing to do with minibuffer M-x cycling
(global-set-key (kbd "C-x C-b") 'buffer-menu) ; nor buffer-list nor ibuffer
(global-set-key (kbd "C-h a") 'apropos)
;; literal tab
(global-set-key (kbd "<backtab>") '(lambda () (interactive) (insert "\t")))
(windmove-default-keybindings) ; S-arrowkey, move to window

(require 'buffer-move)
;; buffermove.el 4 ~ identical functions - good candidate for a rewrite
(global-set-key (kbd "<C-S-up>")     'buf-move-up)
(global-set-key (kbd "<C-S-down>")   'buf-move-down)
(global-set-key (kbd "<C-S-left>")   'buf-move-left)
(global-set-key (kbd "<C-S-right>")  'buf-move-right)

(global-set-key (kbd "<RET>") 'newline-and-indent)
;; swap <RET> and C-j unless in python-mode. add-hook python-mode-hook?

;; local-set-key changes the major mode, not the minor paredit-mode
;;(if (or (featurep emacs-lisp-mode) (featurep lisp-interaction-mode))
;; 	(local-set-key (kbd "<C-j>") 'eval-print-last-sexp)
;;   (global-set-key (kbd "<C-j>") 'newline))
;; bind delete to backward-delete-char in paredit-mode
;;(with-current-buffer "*scratch*" (local-set-key
;;				  (kbd "<C-j>") 'eval-print-last-sexp))

(when (featurep 'paredit)
  (define-key paredit-mode-map (kbd "C-j") 'eval-print-last-sexp)
  (define-key paredit-mode-map (kbd "S-<backspace>") 'backward-delete-char))

;; You add functions to the hook, not function calls, lambda doesn't need '
(global-set-key (kbd "C-S-j") (lambda () (interactive) (join-line t))) ; vimmy

;; C-x f runs the command set-fill-column
;; wrap in (if ( bla ido-mode) )
(global-set-key (kbd "C-x f") 'ido-find-file)
;; gör ingenting, returnera ingenting, kbd macro is C-x (
(global-set-key (kbd "C-x C-k RET") 'ignore)

;; C-x { runs the command shrink-window-horizontally
;; C-x } runs the command enlarge-window-horizontally
;; C-x ^ runs the command enlarge-window
;; XXX wontwork, use a loop?
;; (global-set-key (kbd "C-x {") (lambda () (interactive) '(shrink-window-horizontally 5))
;; (global-set-key (kbd "C-x }") '(digit-argument 4 (enlarge-window-horizontally))
;; (global-set-key (kbd "C-x }") '(enlarge-window-horizontally 7))
;; (enlarge-window-horizontally 3) ; detta funkar ju???

;; backward-kill-word är både <C-backspace> <M-backspace>
(global-set-key (kbd "<C-backspace>") 'backward-kill-sexp)
(global-set-key (kbd "M-t") 'transpose-sexps)
(global-set-key (kbd "C-M-t") 'transpose-words)
;; Put the space character in class whitespace.
;;          (modify-syntax-entry ?\s " ")
;; maybe C-S-g for (exit-minibuffer)
(global-set-key [C-S-g] 'exit-minibuffer)

;; bind q till bury-buffer i *Messages*
;; (add-hook '      (lambda ()  (local-set-key (kbd "q") 'bury-buffer))
(with-current-buffer "*Messages*" (local-set-key (kbd "q") 'bury-buffer))
;(with-current-buffer "*Warnings*" (local-set-key (kbd "q") 'bury-buffer)) ; "no such buffer"

;; C-x C-j jump to dired. behöver inte spara på en massa dired-buffrar?
(require 'dired-x)

;; what to bind for browse-kill-ring ?
;; M-w är kill-ring-save, funkar bra
;; Define aliases ; use C-q C-j to /re/place a return
;; fmakunbound to unbound an alias
(defalias 'qrr 'query-replace-regexp)
(defalias 'qr  'query-replace)           ; M-%     M-5
(defalias 'rr  'replace-regexp)
(defalias 'rs  'replace-string)
(defalias 'sb  'isearch-backward-regexp) ; C-M r
(defalias 'ss  'isearch-forward-regexp)  ; C-M s
(defalias 'bb  'bury-buffer)
(defalias 'hr  'highlight-regexp)
(defalias 'yes-or-no-p 'y-or-n-p)
;; wontwork?
(defalias 'ans 'ansi-term "/usr/bin/zsh")
;; (defalias 'ans '(funcall 'ansi-term (getenv "SHELL")))
;; (ansi-term zsh)

;; http://stackoverflow.com
(defun copy-full-path-to-kill-ring ()
  "copy buffer's full path to kill ring"
  (interactive)
  (when buffer-file-name
    (kill-new (file-truename buffer-file-name))))
(defalias 'fx 'copy-full-path-to-kill-ring)

;; with auto-fill-mode, breaks lines at whitespace
;(setq fill-column 79) ; doesn't ever work, even with add-hook!
;(add-hook 'lisp-mode-hook (lambda () (setq fill-column 79)))
;; exempel: (add-hook 'lisp-mode-hook (lambda () (sl_ime-mode t)))
(setq column-number-mode t) ; see column in mode-line
;; not "gnu" style. c-set-style is C-c .
(setq c-default-style "linux"
      c-basic-offset 4)
(setq echo-keystrokes '0.0625)

;; Now, (add-hook ... '(lambda () ...)) will work, but you shouldn't use it.
;; For various obscure reasons related to byte-compilation, (lambda () ...) will work better.

(require 'pretty-lambdada)
;; lambda finns inte i utskrift med M-x ps-print-buffer-with-faces
;;(pretty-lambda-for-modes)

;; wtf does this one do? useless!
;(require 'visible-mark)
;(setq visible-mode t)

;; bm is better http://www.nongnu.org/bm/ can't jump across buffers, though
;; (require 'bm) ; no? (file-error "Cannot open load file" "bm")
;; var är filen där allt sparas?  ~/.emacs.bmk är vanliga bookmarks
;; f10 is menu-bar-open
;;(define-key global-map [f9] 'bookmark-jump)
;;(define-key global-map [f10] 'bookmark-set)

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

;; lower mouse scroll from 5. also use with C and S
(setq mouse-wheel-scroll-amount
'(4
 ((shift)
  . 1)
 ((control)) ))
(setq mouse-wheel-progressive-speed nil)

(put 'dired-find-alternate-file 'disabled nil) ; är 'a

;; https://github.com/tlh/workgroups.el       spara windows, har kill ring
;; could Byte-compile workgroups.el. This isn't required, but it'll speed some things up
;; prefix key for Workgroups' cmd is C-z
;; (add-to-list 'load-path "~/.emacs.d/workgroups.el/") ; done already
(require 'workgroups)
(workgroups-mode 1)
(setq wg-morph-on nil)
(wg-load "~/.emacs.d/workgroups") ; holds multiple wg:s
;; måste skapa och spara workgroup C-z c name C-z C-s,
;; resten av buffern evalueras inte annars

;; is a toggle
(blink-cursor-mode 1)

;; if case is important when searching:
;;(setq case-fold-search 'nil)

(setq whitespace-style '(face trailing lines-tail tabs) whitespace-line-column 80)

;;; ^keys^  ^utseende^
;;; ---------------------------------------------------

;;; 

(defun eshell/clear ()
  "http://www.khngai.com/emacs/eshell.php, to clear the eshell buffer."
  (interactive)
  (let ((inhibit-read-only t))
    (erase-buffer)))

;; \\\\\\\\\\DONOTWANT\\\\\\\\\\
(setq reb-re-syntax 'string)
(require 'browse-kill-ring)

(require 'ido) ; already loaded? is part of emacs
(ido-mode t)
(setq ido-save-directory-list-file "~/.emacs.d/ido.last")
;; InteractivelyDoThings. ido (f ex find files, buffers)
;; http://www.emacswiki.org/emacs/InteractivelyDoThings
;; http://www0.fh-trier.de/~politza/emacs/ido-hacks.el.gz
;; ido sparar tid och kan mkt http://vimeo.com/1013263

;; Display ido results vertically, rather than horizontally
;; looks stupid. why "dummy"?
;; Maybe "Confirm" is needed for example to make a new buffer
(setq ido-decorations (quote ("\n-> " "" "\n   " "\n   ..." "[" "]" " [No match]" " [Matched]" " [Not readable]" " [Too big]" " [Confirm]")))

;; list of 11. from emacs24 ido.el:
;; (defcustom ido-decorations '( "{" "}" " | " " | ..." "[" "]" " [No match]" " [Matched]" " [Not readable]" " [Too big]" " [Confirm]") "")

(defun ido-disable-line-trucation () (set (make-local-variable 'truncate-lines) nil))
(add-hook 'ido-minibuffer-setup-hook 'ido-disable-line-trucation)

;; XXX ido-hacks wont work with emacs24
(require 'ido-hacks) ; M-x completion? (execute-extended-command)
;; use it with "ido-hacks-mode" how conf it? :D
(ido-hacks-mode t)
;; wontwork: (unload 'ido-hacks)

;; how do i put all #files# and files~ in ~/.emacs.d/ ?
;; http://www.emacswiki.org/emacs/BackupDirectory
(setq
 ;; Is there a downside to setting backup-by-copying to true?
 ;; it subtly affects issues wrt race conditions, journalling, hard links
 backup-by-copying t      ; don't clobber symlinks
 backup-directory-alist
 '(("." . "~/.emacs.d/backups/"))    ; don't litter my fs tree
 delete-old-versions t
 kept-new-versions 3
 kept-old-versions 2
 version-control t)       ; use versioned backups
;; This will all place all auto-saves and backups in the directory?
(setq auto-save-file-name-transforms
;; match from beginning. don't try symlinks
;;         (REGEXP REPLACEMENT UNIQUIFY)
	  `(("^.*/" "~/.emacs.d/autosaves/" t)))
(savehist-mode 1)

;;; org mode

;; from David O'Toole Org tutorial
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)



;;; end org mode
;;; ---------------------------------------------------
;;; web stuffs

(setq nxml-slash-auto-complete-flag 't) ; finish a </
;; // css mode comments is illegal

;;; end web stuffs
;;; ---------------------------------------------------

;; won't work, use customize-group bookmark
;(setq 'bookmark-default-file "~/.emacs.d/bookmarks")

;; nvm, fortune won't work anyway
;;(setq fortune-dir "/usr/share/fortune/")

;; When I make a region with the mouse and press delete, it is deleted. When I
;; set a mark, move the point with keystrokes and press delete, only one char disappears.
;; (delete-selection-mode 1) ; won't be put in kill-ring

;; /etc/emacs/ har lite skräp åxå

;;; ---------------------------------------------------
;; slime för hemmabruk

;; (define-key slime-mode-map [(return)] 'paredit-newline)
;; (define-key slime-mode-map [(bla ( )] (lambda () (interactive) (insert "(")))
;; (define-key slime-mode-map [(literal ) )] (lambda () (interactive) (insert ")")))

;; see info slime 2.5.2 Multiple Lisps
;;(setq slime-lisp-implementations
;;	  '((cmucl ("/usr/bin/cmucl" "-quiet") :init slime-init-command)
;;		(clisp ("/usr/bin/clisp" "-I") :init slime-init-command)))

;; har visst en ~/.slime/``
;; git cloned slime into .emacs.d/
;; (add-to-list 'load-path "~/.emacs.d/slime")

;; is this why i get no extra slime repl?
;; (add-hook 'lisp-mode-hook (lambda () (slime-mode t)))
;; (add-hook 'inferior-lisp-mode-hook (lambda () (inferior-slime-mode t)))

;; Optionally, specify the lisp program you are using. Default is "lisp"
;; do i have to run this? (slime-setup)
;; finns ej: (setq inferior-lisp-program "clojure")
;; i just get *inferior-lisp* no xtra repl

;; opens up in conkeror
;(setq common-lisp-hyperspec-root "http://www.lispworks.com/reference/HyperSpec/")


;; (add-to-list 'load-path "/usr/share/emacs/site-lisp/slime")
;; (require 'slime)
;; (global-set-key (kbd "<f12>") 'slime-selector)
;; ;; wontwork:
;; ;;(slime-set-default-directory "/home/occam/bin/projects/lisp")
;; (setq common-lisp-hyperspec-root "file:/usr/share/doc/HyperSpec/")
;; ;;(require 'slime-autoloads) ; what does this one do?
;; (slime-setup '(slime-fancy)) ; should be everything
;; ;; (slime-setup '(slime-repl)) ; repl only
;; ;; (slime-setup '(slime-repl slime-scratch slime-editing-commands slime-fancy))
;; ;; (setq inferior-lisp-program "sbcl")
;; (setq inferior-lisp-program "clisp") ; for lol, why no slime-repl?
;; ;; (setq inferior-lisp-program "/usr/bin/clisp")

;; (slime)

;;; ---------------------------------------------------
;; Allegro

;; inferior common lisp
;; defun insert-res .. interactive .. (insert ":res")) (bind...)

;; skiten slutar funka. testar att köra allegro med slime ist
;; http://www.franz.com/emacs/slime.lhtml

;; kör manuellt. /sw/allegro-8.2/emacs-allegro-cl funkar inte.
;;(load "/sw/allegro-8.2/local/allegro.el")
;; gå miste om help, rename-me, font, new window, frame resizing.
;; -----------------------------------------------------------------------------
;; (load "~/.emacs.d/allegro-edit.el") ; (add-hook 'kill-emacs-hook ...) -------
;; -----------------------------------------------------------------------------
;; with or without fi: ? this fails
(add-hook 'fi:inferior-common-lisp-mode-hook
	  (lambda () (local-set-key fi:inferior-common-lisp-mode-map (kbd "M-p")  fi:pop-input)))
	     ;;(local-set-key fi:inferior-common-lisp-mode-map (kbd "<Alt-p>")  fi:pop-input)
	     ;;(local-set-key fi:inferior-common-lisp-mode-map (kbd "<Alt-n>")  fi:push-input)

;; (setq inferior-common-lisp-mode-hook nil)


;; (allegro-setup-emacs-cl) ; onödigt
;; Symbol's function definition is void: allegro-setup-emacs-cl

;; in keymap (hade exempel i init.el på lappyn)
;; fi:inferior-common-lisp-mode-map
;; bind    A-p  fi:pop-input
;;      (add-hook 'texinfo-mode-hook
               ;; '(lambda ()
               ;;    (define-key texinfo-mode-map "\C-cp" 'backward-paragraph)
               ;;    (define-key texinfo-mode-map "\C-cn" 'forward-paragraph)))

;; (add-hook 'foo-mode-hook (lambda () (local-set-key (kbd "C-c h") 'some-fn)))

;; (add-hook 'inferior-common-lisp-mode-hook
;; 	  (lambda () ; no '?
;; 	     (define-key fi:inferior-common-lisp-mode-map "<Alt-p>"  fi:pop-input)
;; 	     (define-key fi:inferior-common-lisp-mode-map "<Alt-n>"  fi:push-input)))

;; ------

;; slime (atleast *inferior-lisp*) has no nice trace
;; slime from elpa is old?

;; (add-to-list 'load-path "~/sauce/lisp/slime")
;; (require 'slime)
;; ;; does this exist?
;; (require 'slime-autoloads) ; what does this button do?

;; ;; (global-set-key (kbd "<f12>") 'slime-selector) ; <SunF37>
;; (global-set-key (kbd "<SunF37>") 'slime-selector)
;; ;; (setq common-lisp-hyperspec-root "http://www.lispworks.com/reference/HyperSpec/")
;; ;; no fancy?
;; (slime-setup '(slime-repl slime-scratch slime-editing-commands slime-fancy))
;; ;;(slime-setup '(slime-fancy))
;; (setq inferior-lisp-program "alisp")
;; ;; (setq inferior-lisp-program "allegro-express")

;; ;; (slime)

;; (eval-after-load "slime"
;;   '(progn
;;      ;; (add-to-list 'load-path "~/.emacs.d/elpa/slime-20100404.1") ; already added?
;;      ;; use the cvs slime, it is newer and has contrib
;;      (add-to-list 'load-path "~/sauce/lisp/slime/contrib")
;;      (slime-setup '(slime-fancy slime-banner))
;;      (setq slime-complete-symbol*-fancy t)
;;      (setq slime-complete-symbol-function 'slime-fuzzy-complete-symbol)))

;; detta löste sig
;; error: (void-function slime-setup-contribs)
;; hittar inget slime-contribs


;; kör slime istället. #lisp tycker ingen anvÃ¤nder ELI
;; -----------------------------------------------------------------------------
;; "There is no connection to Lisp"
;; (load (expand-file-name "~/quicklisp/slime-helper.el"))
;; (setq inferior-lisp-program "/sw/allegro-8.2/alisp")
;; lägg saker i ~/.quicklisp ist? it ain't broke, don't fix!
;; funkar inte: ("quicklisp-slime-helper")
;; (slime)
;; -----------------------------------------------------------------------------



;;; ---------------------------------------------------
;; erc, rcirc, lys

(setq erc-hide-list '("JOIN" "PART" "QUIT"))
(add-hook 'window-configuration-change-hook
	  '(lambda ()
	     (setq erc-fill-column (- (window-width) 2))))

(defun chat ()
  (interactive)
  (erc :server "irc.freenode.net" :port 6667 :nick "McRibbit"))


;; Pool of colors to use when coloring IRC nicks.
(setq erc-colors-list '("green" "blue" "red"
			"dark gray" "dark orange"
			"dark magenta" "maroon"
			"indian red" "forest green"
			"midnight blue" "dark violet"))
;; special colors for some people
(setq erc-nick-color-alist '(("macrobat" ."pink")
			     ("McRibbit" . "yellow")
			     ;; ("John" . "blue")
 			     ;; ("Bob" . "red")
			     ))

(defun erc-get-color-for-nick (nick)
  "Gets a color for NICK. If NICK is in erc-nick-color-alist, use that color, else hash the nick and use a random color from the pool"
  (or (cdr (assoc nick erc-nick-color-alist))
      (nth
       (mod (string-to-number
	     (substring (md5 (downcase nick)) 0 6) 16)
	    (length erc-colors-list))
       erc-colors-list)))

(defun erc-put-color-on-nick ()
  "Modifies the color of nicks according to erc-get-color-for-nick"
  (save-excursion
    (goto-char (point-min))
    (if (looking-at "<\\([^>]*\\)>")
	(let ((nick (match-string 1)))
	  (put-text-property (match-beginning 1) (match-end 1) 'face
			     (cons 'foreground-color
				   (erc-get-color-for-nick nick)))))))

(add-hook 'erc-insert-modify-hook 'erc-put-color-on-nick)

(setq erc-autojoin-channels-alist
          '(("freenode.net" "#lisp" "#debian" "#emacs"))) ; need login for ##C

(setq erc-scrolltobottom-mode 1)

;; colorize nicks
;; timestamps (just minutes)
;; keep input line on last line
;; ; varför? (require 'rcirc)
;; finns denna funktion? :
;; får Lisp error: (wrong-type-argument number-or-marker-p nil)
;; (rcirc-omit-mode) ; för att nedanstående ska ta effekt
(setq rcirc-omit-responses '( "JOIN" "PART" "QUIT" "NICK" "AWAY"))


;;; ---------------------------------------------------

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(comment-style (quote multi-line)))
 ; end of custom-set-variables
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )

;; vill ha störrre fönsterrr, sätt den överst till vä åxå
;; funkar ju faan inte. lägger sist!
;; (append default-frame-alist '((width . 110) (height . 70)))
(when window-system
  (set-frame-size (selected-frame) 110 77)) ; om ovan vägrar
;; (set-frame-size (selected-frame) 110 72) ; för tool-br och menu-bar


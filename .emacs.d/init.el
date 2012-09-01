;; in case of error, use (when nil ) to bisect this file

;; TODO: use autoloads
;; (autoload FUNCTION FILE &optional DOCSTRING INTERACTIVE TYPE)
;; Define FUNCTION to autoload from FILE.
;; FUNCTION is a symbol; FILE is a file name string to pass to `load'

;; set up unicode
;; (prefer-coding-system       'utf-8)
;; (set-default-coding-systems 'utf-8)
;; (set-terminal-coding-system 'utf-8)
;; (set-keyboard-coding-system 'utf-8)
;; (setq default-buffer-file-coding-system 'utf-8)

;; cons onto load-path list before we can load/require libs
;;(add-to-list 'load-path "~/.emacs.d/")
;; mapc is for side-effects only, it doesn't return a list like mapcar does
(mapc '(lambda (dir) (add-to-list 'load-path dir)) '("~/.emacs.d/" "~/.emacs.d/elpa"))
;; "~/.emacs.d/elpa/paredit-22"
;; do I neeed all dirs in elpa too?

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

;;; ---------------------------------------------------

;; FIXME
;; you must not be initializing properly?
;; the variable is not autoloaded
;; if you do M-x list-packages  then you'll see it
;; and of course any customization or seting of that variable before the package is loaded will persist over the package
;; load.
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
;; packages should autoload. any package that doesn't should be loaded with an (eval-after-init ...)
;; lots of packages are modes that you want to load with mode-alist... which can be done even if the package isn't loaded,
;; or done on some hook, which can be done without loading the package or done on a key which can also be done without
;; loading the package
;; where can I find this information (and more)?
;; well, the elisp manual describes the packaging startup. but it's not very clear on the implications.

;; Any settings for packages sould be done with eval-after-init? 
;; I don't think so, use customize if you can. If not then use a
;; package specific hook and if you can't do that then use an
;; eval-after-init, I guess.

;; package.el is put in the elpa dir or comes with emacs24
(load "package_23_github.el")
;; (require 'package)
(add-to-list 'package-archives
         '("marmalade" . "http://marmalade-repo.org/packages/"))
;; Each element in this list should be a list (NAME VERSION)
(setq package-load-list
      '((bm "1.53") (browse-kill-ring "1.3.1") (buffer-move "0.4")
        (rainbow-mode "0.1") (workgroups "0.2.0") (paredit "22")
        (goto-last-change "1.2")))
;; htmlize "1.39"
;; pkgs installed by elpa will be requireable
;; (package-initialize)
;; This was installed by package-install.el. This provides support for the package system and
;; interfacing with ELPA, the package archive. Move this code earlier if you want to reference
;; packages in this file:

;; (eval-after-load 'package '(add-to-list 'package-archives ...))
;; packages should autoload. any package that doesn't should be loaded with an (eval-after-init ...)
(when
    (load
     (expand-file-name "~/.emacs.d/elpa/package_23_github.el"))
  (package-initialize))


;;; ---------------------------------------------------

;; http://www.emacswiki.org/cgi-bin/wiki.pl?SessionManagement
;; need desktop-save-mode, and desktop-change-dir?
;; (info "(emacs)Saving Emacs Sessions")
;; session sparar inte vilka filer jag kör med. löst värde
;; (require 'session) ; se om det hjälper
;; (setq session-save-file "~/.emacs.d/session")
;; (add-hook 'after-init-hook 'session-initialize)
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
;; (require 'paredit) ; don't need to enable it for rain-delim
;; require it with elpa
;; (autoload 'paredit-mode "paredit"
;;   "Minor mode for pseudo-structurally editing Lisp code." t)
;; (add-hook 'emacs-lisp-mode-hook       (lambda () (paredit-mode +1)))
;; (add-hook 'lisp-mode-hook             (lambda () (paredit-mode +1)))
;; (add-hook 'lisp-interaction-mode-hook (lambda () (paredit-mode +1)))
(require 'rainbow-delimiters)
;; (rainbow-delimiters-mode) ; buffer-local?
;; maybe like this?
;; (setq rainbow-delimiters-mode 1)
(add-hook 'lisp-mode-hook             (lambda () (rainbow-delimiters-mode)))
(add-hook 'lisp-interaction-mode-hook (lambda () (rainbow-delimiters-mode)))

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
(add-to-list 'auto-mode-alist '("\\.cl\\'" . common-lisp-mode))
(add-hook 'c-mode-hook (lambda () (setq tab-width 4)))
(add-hook 'c++-mode-hook (lambda () (setq tab-width 4)))
(add-hook 'makefile-mode-hook 'setq indent-tabs-mode t)
;; File mode specification error: (invalid-function (setq tab-width 4)

;; glömt vad "autoload" är
;; M-x unload-feature to un-require

;; "when" has an implicit progn,  so it's just:
;; (when (condition) (do 1) (do 2) (do n))
(when window-system
  (set-default-font
   ;; M-x set-frame-font
   ;; "-unknown-DejaVu Sans Mono-normal-normal-normal-*-12-*-*-*-m-0-iso10646-1") ; lappy
   "-unknown-DejaVu Sans Mono-normal-normal-normal-*-16-*-*-*-m-0-iso10646-1") ; desktop
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
;; buffermove.el 4 identical functions - good candidate for a rewrite
(global-set-key (kbd "<C-S-up>")     'buf-move-up)
(global-set-key (kbd "<C-S-down>")   'buf-move-down)
(global-set-key (kbd "<C-S-left>")   'buf-move-left)
(global-set-key (kbd "<C-S-right>")  'buf-move-right)

(global-set-key (kbd "<RET>") 'newline-and-indent)
;; swap <RET> and C-j unless in python-mode. add-hook python-mode-hook?

;; local-set-key changes the major mode, not the minor paredit-mode
;;(if (or (featurep emacs-lisp-mode) (featurep lisp-interaction-mode))
;;      (local-set-key (kbd "<C-j>") 'eval-print-last-sexp)
;;   (global-set-key (kbd "<C-j>") 'newline))
;; bind delete to backward-delete-char in paredit-mode
;;(with-current-buffer "*scratch*" (local-set-key
;;                                (kbd "<C-j>") 'eval-print-last-sexp))

(add-hook 'emacs-lisp-mode-hook
          (lambda () (local-set-key [(C-j)] 'eval-print-last-sexp)))

(when (featurep 'paredit)
  (define-key paredit-mode-map (kbd "C-j") 'eval-print-last-sexp)
  ;; stopped working in archlinux X
  (define-key paredit-mode-map (kbd "S-<backspace>") 'backward-delete-char)
;; ,paredit-nonlisp is
;; (set (make-local-variable 'paredit-space-for-delimiter-predicates)
;;  '((lambda (endp delimiter nil)))
  )

;; You add functions to the hook, not function calls, lambda doesn't need '
(global-set-key (kbd "C-S-j") (lambda () (interactive) (join-line t))) ; vimmy

;; C-x f runs the command set-fill-column
;; wrap in (if ( bla ido-mode) )
(global-set-key (kbd "C-x f") 'ido-find-file)
;; gör ingenting, returnera ingenting, kbd macro is C-x (
(global-set-key (kbd "C-x C-k RET") 'ignore)

;; C-x ^ runs the command enlarge-window
(global-set-key (kbd "C-x }") (lambda () (interactive)
                                (enlarge-window-horizontally 5)))
(global-set-key (kbd "C-x {") (lambda () (interactive)
                                (shrink-window-horizontally 5)))

;; for bubbling...
;; (beginning-of-line)(kill-line)(up)(yank)
;; (exchange-point-and-mark


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

;; what to bind for browse-kill-ring ?
(browse-kill-ring-default-keybindings)
(global-set-key (kbd "C-c k") 'browse-kill-ring)
;; M-w är kill-ring-save, funkar bra
;; Define aliases ; use C-q C-j to /re/place a return
;; fmakunbound to unbound an alias
(defalias 'yes-or-no-p 'y-or-n-p)
(defalias 'qrr 'query-replace-regexp)
(defalias 'qr  'query-replace)           ; M-%     M-5
(defalias 'rr  'replace-regexp)
(defalias 'rs  'replace-string)
(defalias 'sb  'isearch-backward-regexp) ; C-M r
(defalias 'ss  'isearch-forward-regexp)  ; C-M s
(defalias 'bb  'bury-buffer)
(defalias '\0  'bury-buffer)
(defalias 'hr  'highlight-regexp)
(defalias 'rb  'revert-buffer)
(defalias 'pm  'paredit-mode)

;; (defalias 'ans 'ansi-term "/usr/bin/zsh") ; stupid
;; (defalias 'ans '(funcall 'ansi-term (getenv "SHELL")))
;; (ansi-term zsh) ; wontwork
(defalias 'ans (save-window-excursion (ansi-term "/bin/zsh")))

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

;; lambda finns inte i utskrift med M-x ps-print-buffer-with-faces
(require 'pretty-lambdada)
(pretty-lambda-for-modes)

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

;; tabs are evil. C-x h M-x {un,}tabify
(setq-default indent-tabs-mode nil)

;; if case is important when searching:
;;(setq case-fold-search 'nil)

;; shells. repl åxå?
;; ser t ex bara första raden filer vid ls
;; (setq comint-scroll-to-bottom-on-input t)
(setq whitespace-style '(face trailing lines-tail tabs) whitespace-line-column 80)

(setq sentence-end-double-space nil)

;;; ^keys^  ^utseende^
;;; ---------------------------------------------------

(defun eshell/clear ()
  "http://www.khngai.com/emacs/eshell.php, to clear the eshell buffer."
  (interactive)
  (let ((inhibit-read-only t))
    (erase-buffer)))

;; \\\\\\\\\\DONOTWANT\\\\\\\\\\
(setq reb-re-syntax 'string)
(require 'browse-kill-ring)

;; (require 'ido) ; already loaded? is part of emacs
(ido-mode t)
(setq ido-save-directory-list-file "~/.emacs.d/ido.last")
(setq ido-enable-flex-matching t) ; fuzzy matching 
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
;;        '((cmucl ("/usr/bin/cmucl" "-quiet") :init slime-init-command)
;;              (clisp ("/usr/bin/clisp" "-I") :init slime-init-command)))

;; har visst en ~/.slime/``
;; git cloned slime into .emacs.d/
;; (add-to-list 'load-path "~/.emacs.d/slime")

;; is this why i get no extra slime repl?
;; (add-hook 'lisp-mode-hook (lambda () (slime-mode t)))
;; (add-hook 'inferior-lisp-mode-hook (lambda () (inferior-slime-mode t)))

;; Optionally, specify the lisp program you are using. Default is "lisp"
;; i just get *inferior-lisp* no xtra repl

;; opens up in $BROWSER
;(setq common-lisp-hyperspec-root "http://www.lispworks.com/reference/HyperSpec/")

;; you can use slime-space instead of eldoc-mode
;; where the OS keeps slime
(add-to-list 'load-path "/usr/share/emacs/site-lisp/slime")
(require 'slime)
;; only run slime related things on demand. M-x slime
;; (require 'slime-autoloads)

(setq inferior-lisp-program "sbcl")
;; (setq inferior-lisp-program "clisp") ; for lol, why no slime-repl?
;; (setq inferior-lisp-program "/usr/bin/clisp")
;; (setq inferior-lisp-program "clojure")

;; not global, set it in the keymap if slime is loaded
;; (global-set-key (kbd "<f12>") 'slime-selector)
;; (define-key lisp-mode-map [f12] 'slime-selector)
(define-key lisp-mode-map [(C-j)] 'slime-eval-last-expression-in-repl)
(add-hook 'lisp-mode-hook
          (lambda () (local-set-key [(C-j)] 'slime-eval-last-expression-in-repl))
          (lambda () (local-set-key (kbd "<f12>") 'slime-selector)))

;; (global-set-key [(C-j)] 'slime-eval-last-expression-in-repl)
;; (global-set-key (kbd "<C-j>") 'slime-eval-last-expression-in-repl)

;; Versions differ: 2011-03-13 (slime) vs. 2011-08-31 (swank)
(setq slime-protocol-version 'ignore)

(setq slime-complete-symbol*-fancy t)
(setq slime-complete-symbol-function 'slime-fuzzy-complete-symbol)
;; wontwork:
;;(slime-set-default-directory "/home/occam/bin/projects/lisp")
(setq common-lisp-hyperspec-root "file:/usr/share/doc/HyperSpec/")
;;(require 'slime-autoloads) ; what does this one do?
(slime-setup '(slime-repl slime-scratch slime-editing-commands
                          slime-asdf slime-fancy))
;; fancy should be everything, but isn't
;; (slime-setup '(slime-repl)) ; repl only
;; (slime-setup '(slime-repl slime-scratch
;;                slime-editing-commands slime-fancy))

(slime)
;; (slime-scratch)

;;; geiser for scheme interaction
;; how do I give emacs the path to a scheme?
;; (setq scheme-program-name "racket") ;"mit-scheme" "guile"
;; (load-file "~/bin/packages/gitclown/geiser/elisp/geiser.el")
;; (load "~/bin/packages/gitclown/geiser/build/elisp/geiser-load")
;; (setq geiser-repl-use-other-window  nil)

;; setup autoload

;;; ---------------------------------------------------
;; Allegro

;; "You have to choose: either use Allegro's REPL or Slime's REPL.
;;  If you load slime contribs, be prepared for bugs."
;; bah, på IDA använde jag quicklisp och slime-helper. funkar

;; inferior common lisp
;; defun insert-res .. interactive .. (insert ":res")) (bind...)

;; skiten slutar funka. testar att köra allegro med slime ist
;; http://www.franz.com/emacs/slime.lhtml

;; kör manuellt. /sw/allegro-8.2/emacs-allegro-cl funkar inte.
;; (load "/sw/allegro-8.2/local/allegro.el")

;; ladda ngt i /home/occam/bin/acl82express/ ?
;; ;; (load "/sw/allegro-8.2/local/allegro.el")
;; (allegro-setup-emacs-cl)
;; (setq inferior-lisp-program "alisp")
;; (setq inferior-lisp-program "/home/occam/bin/acl82express/alisp")
;; inte detta (setq inferior-lisp-program "allegro-express")


;;; ---------------------------------------------------
;; erc, rcirc, lyskom
;; see erc-conf.el


(setq rcirc-default-nick "macrobat_")
(setq rcirc-default-user-name "macrobat")
(setq rcirc-server-alist
      '(("irc.freenode.net" :channels
         ("#emacs" "#lisp" "##C" "#archlinux"))))


;;;(require lyskom)
;; (load-file "/usr/share/emacs/site-lisp/lyskom.elc")
;; (autoload 'lyskom "lyskom.elc" "Köra LysKom" t)
;; ;; Use environment variables KOMNAME and KOMSERVER
;; (add-hook 'lyskom-mode-hook 
;;   (lambda () 
;;     (set-language-environment "Latin-1")
;;     ;; changed order:
;;     (setq kom-preferred-charsets '(utf-8 latin-1 iso-8859-1))))
;; (setq kom-emacs-knows-iso-8859-1 t)
;; ;; "M-x kom" startar lyskom
;; (defun kom ()
;;   (interactive)
;;   (lyskom "kom.lysator.liu.se" "duke"))

;; (autoload 'lyskom "lyskom" "Start LysKOM" t)

;; (defvar kom-server-aliases
;;  '(("kom.lysator.liu.se" . "LysKOM")))

;; (setq-default kom-default-language 'sv)
;; (setq kom-default-server "kom.lysator.liu.se")
;; (setq kom-default-user-name "duke")

;;; ---------------------------------------------------

;;--------------------------------------------------------------------
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
;;--------------------------------------------------------------------

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.

 ; end of custom-set-variables
)
 (custom-set-faces
 )

;; (when window-system
;;   (set-frame-size (selected-frame) 110 77))
;; (set-frame-size (selected-frame) 110 72) ; för tool-br och menu-bar


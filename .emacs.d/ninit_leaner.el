;;; a leaner init file
;; emacs -q -l ~/.emacs.d/init_leaner.el

(mapc '(lambda (dir) (add-to-list 'load-path dir)) '("~/.emacs.d/" "~/.emacs.d/workgroups.el/" "~/.emacs.d/slime/" "~/.emacs./rainbow" "emacs-color-theme-solarized"))

(setq inhibit-startup-message t)
(show-paren-mode 1)
(setq show-paren-style 'parenthesis)
(setq word-wrap t)

(add-to-list 'auto-mode-alist '("\\.c\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
(add-hook 'c-mode-hook (lambda () (setq tab-width 4)))
(add-hook 'c++-mode-hook (lambda () (setq tab-width 4)))

(when window-system
  (set-default-font "-unknown-DejaVu Sans Mono-normal-normal-normal-*-16-*-*-*-m-0-iso10646-1")

  (set-scroll-bar-mode 'right)

  (load "color-theme")
  (load "arjen-theme")
  (color-theme-arjen)

  (setq x-select-enable-clipboard t)
  (setq interprogram-paste-function 'x-cut-buffer-or-selection-value)

  (tool-bar-mode -1)
  (menu-bar-mode -1)

  (global-set-key (kbd "M-1") 'shell-command)
  (global-set-key (kbd "M-2") 'shell-command-on-region)
  (global-set-key (kbd "M-5") 'query-replace)
  (global-set-key (kbd "M-6") 'async-shell-command)
  (global-set-key (kbd "M-7") 'dabbrev-expand)
  (global-set-key (kbd "M-0") 'count-lines-region)
) ; end ---when window-system---

;; http://stackoverflow.com
(defun copy-full-path-to-kill-ring ()
  "copy buffer's full path to kill ring"
  (interactive)
  (when buffer-file-name
    (kill-new (file-truename buffer-file-name))))
(defalias 'fx 'copy-full-path-to-kill-ring)

(defun comment-dwim-line (&optional arg)
  "Replacement comment-dwim. If no region is selected and current
   line is not blank and we are not at the end of the line, then comment current
   line. Replaces default behaviour of comment-dwim that inserts comment at
   the end of the line."
  (interactive "*P")
  (comment-normalize-vars)
  (if (and (not (region-active-p)) (not (looking-at "[ \t]*$")))
      (comment-or-uncomment-region (line-beginning-position) (line-end-position))
    (comment-dwim arg)))
(global-set-key "\M-;" 'comment-dwim-line)
(setq comment-style '(multi-line))

(global-set-key (kbd "<mode-line> <mouse-4>") 'previous-buffer)
(global-set-key (kbd "<mode-line> <mouse-5>") 'next-buffer)
;; no more unintentional mouse-delete-window:
(global-set-key (kbd "<mode-line> <mouse-3>") 'nil) ; something better

(global-set-key (kbd "C-'") 'dabbrev-expand)
(global-set-key (kbd "C-*") 'hippie-expand)

(global-set-key (kbd "C-x C-b") 'buffer-menu) ; nor buffer-list nor ibuffer
(global-set-key (kbd "C-h a") 'apropos)
(global-set-key (kbd "<backtab>") '(lambda () (interactive) (insert "\t")))
(windmove-default-keybindings) ; S-arrowkey, move to window

(require 'buffer-move) ; really want this
(global-set-key (kbd "<C-S-up>")     'buf-move-up)
(global-set-key (kbd "<C-S-down>")   'buf-move-down)
(global-set-key (kbd "<C-S-left>")   'buf-move-left)
(global-set-key (kbd "<C-S-right>")  'buf-move-right)

(global-set-key (kbd "<RET>") 'newline-and-indent)

(global-set-key (kbd "C-x f") 'ido-find-file)
;; gör ingenting, returnera ingenting, kbd macro is C-x (
(global-set-key (kbd "C-x C-k RET") 'ignore)

(global-set-key (kbd "<C-backspace>") 'backward-kill-sexp)
(global-set-key (kbd "M-t") 'transpose-sexps)
(global-set-key (kbd "C-M-t") 'transpose-words)

(with-current-buffer "*Messages*" (local-set-key (kbd "q") 'bury-buffer))
(require 'dired-x)

;; Define aliases ; use C-q C-j to /re/place a return
;; fmakunbound to unbound an alias
(defalias 'qrr 'query-replace-regexp)
(defalias 'qr 'query-replace)		; M-%     M-5
(defalias 'rr 'replace-regexp)
(defalias 'rs 'replace-string)
(defalias 'ss 'search-forward-regexp)
(defalias 'bb 'bury-buffer)
(defalias 'yes-or-no-p 'y-or-n-p)
(defalias 'hr 'highlight-regexp)

;; http://stackoverflow.com
(defun copy-full-path-to-kill-ring ()
  "copy buffer's full path to kill ring"
  (interactive)
  (when buffer-file-name
    (kill-new (file-truename buffer-file-name))))
(defalias 'fx 'copy-full-path-to-kill-ring)

(setq column-number-mode t)

(setq c-default-style "linux"
      c-basic-offset 4)
(setq auto-mode-alist (cons '("\.lua$" . lua-mode) auto-mode-alist))
(autoload 'lua-mode "lua-mode" "Lua editing mode." t)
(add-to-list 'auto-mode-alist '("\\.c\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
(add-hook 'c-mode-hook (lambda () (setq tab-width 4)))
(add-hook 'c++-mode-hook (lambda () (setq tab-width 4)))

(setq echo-keystrokes '0.0625)

(setq mouse-wheel-scroll-amount
      '(4
	((shift)
	 . 1)
	((control)) ))
(setq mouse-wheel-progressive-speed nil)

;;(require 'ido)
(ido-mode t)

;; Display ido results vertically, rather than horizontally
(setq ido-decorations (quote ("\n-> " "" "\n   " "\n   ..." "[" "]" " [No match]"
			      " [Matched]" " [Not readable]" " [Too big]" " [Confirm]")))

(setq ido-save-directory-list-file "~/.emacs.d/ido.last")

(defun ido-disable-line-trucation () (set (make-local-variable 'truncate-lines) nil))
(add-hook 'ido-minibuffer-setup-hook 'ido-disable-line-trucation)

;; XXX ido-hacks wont work with emacs24
;; (require 'ido-hacks) ; M-x completion (execute-extended-command)
;; (ido-hacks-mode t)

;; better to disable backups?
(setq 
 backup-by-copying t
 backup-directory-alist
 '(("." . "~/.emacs.d/backups/"))    ; don't litter my fs tree
 delete-old-versions t
 kept-new-versions 3
 kept-old-versions 2
 version-control t)

(setq auto-save-file-name-transforms
      ;; match from beginning. don't try symlinks
      ;;         REGEXP   REPLACEMENT         UNIQUIFY
	  `(("^.*/" "~/.emacs.d/autosaves/" t)))
(savehist-mode 1)


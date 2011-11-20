;;; 

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

;; Kill buffers when disconnected or parted
(setq erc-kill-buffer-on-part t
      erc-kill-queries-on-quit t
      erc-kill-server-buffer-on-quit t)

(erc-scrolltobottom-mode t)

;; Truncate buffers to stop some sluggishness
(setq erc-max-buffer-size 20000)
(erc-truncate-mode t)

;; what does this one do
;; (require 'erc-ring)
;; (erc-ring-mode t)

;; (require 'erc-netsplit)
;; (erc-netsplit-mode t)

;; customzation
 ;; moved to erc-conf.el from init.el
(custom-set-variables
 '(erc-system-name "hostia")
 '(erc-email-userid "luserid")
 '(erc-nick-uniquifier "_")
 '(erc-prompt-for-password nil)
 '(erc-try-new-nick-p t)
 '(comment-style (quote multi-line))
 '(erc-user-full-name nil))


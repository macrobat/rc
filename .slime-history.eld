;; -*- coding: utf-8-unix -*-
;; History for SLIME REPL. Automatically written.
;; Edit only if you know what you're doing
("(format* \"%(tm)s %(epoch)g\" '((\"tm\" . \"boingity\") (\"epoch\" . 252.5)))" "(cdddr '(a v g t))" "(cddr '(a v g t))" "(caddr '(a v g t))" "(defun ▲ (&optional (n 32))
  (do ((r n (1- r)))
      ((minusp r))      
    (princ (make-string (1+ r) :initial-element #\\space))
    (dotimes (c (- n r) (terpri))
      (format t \"~:[ #~; `~]\" (zerop (logand c r))))))

(▲)" "(swank:set-default-directory \"/home/occam/bin/projects/lisp/\")" "(sort (list 10 3 2 4 1 2) #'<)" "(sort (list 10 3 2 4 1 2) #'>)" "(boundp 'apa)" "(setq apa 'alsdkn)" "(first \"abcde\")" "(first  '(1 2 3))" "(first  #(1 2 3))" "#(1 2 3)" "(make-array apa)" "(make-array apa 0)" "(inc a)" "a" "(incf a)" "(1+ a)" "(setq a 3)" "(vowelp #\\ä)" "(defun vowelp (letter)
	   \"Predicate to see if letter is a vowel.\"
	   (member letter vowels))" "(setq vowels (coerce \"aeioyuüåäöAEIOYUÜÅÄÖ\" 'list))" "vowels" "(setq vowels (coerce \"aåäeioöuüyAÅÄEIOÖUÜY\" 'list))" "(member #\\'æ (coerce \"aouåeiyäöœæ\" 'list))" "(defun vowelp (letter)
	   \"Predicate to see if letter is a vowel.\"
	   (member letter (coerce \"aåäeioöuüyAÅÄEIOÖUÜY\" 'list)))" "(defun vowelp (letter)
	   (member letter (coerce \"aåäeioöuüyAÅÄEIOÖUÜY\" 'list)))" "(member #\\æ (coerce \"aouåeiyäöœæ\" 'list))" "(member #\\œ (coerce \"aouåeiyäöœ\" 'list))" "(defun vowelp (letter) 
	   (member letter (coerce \"aåäeioöuüyAÅÄEIOÖUÜY\" 'list)))" "(member #\\p (coerce \"aouåeiyäö\" 'list))" "(member #\\ä (coerce \"aouåeiyäö\" 'list))" "(member #\\a (coerce \"aouåeiyäö\" 'list))" "(let ((a 2)(b 3))
	       (f (setq b a) b))" "(let ((a 2)(b 3))
	       (f (setq b a) a))" "(f (setq x 3) x)" "(defun f (a b) b)" "(setq x 2)" "(convert-string-to-bytes \"aouåeiyäö\")" "(member #\\a (convert-string-to-bytes \"aouåeiyäö\"))" "(member #\\a \"aouåeiyäö\")" "(< 1 2 3 3)" "(<= 1 2 3 3)" "(<= 1 2 3)" "(< 1 2 3)" "most-positive-bignum" "most-positive-fixnum" "`(1 2 3 ,(+ 4 5))" "(let* ((list '(1 2 3)) (list (list list list list))) (write list :circle t) (terpri) (write list))" "(10)" "(1/10)" "(* 123450 1/10)" "(/ 22 7)" "(/ 22 3)" "(truncate (/ 22 3))" "(let (a b c) '(1 2 3))" "(let (a b c) (list 1 2 3))" "(let (a b c) (list 1 2 3) (a b c))")
(
 (plt:framework-pref:drracket:module-browser-size-percentage 1/5)
 (plt:framework-pref:drracket:logging-size-percentage 3/4)
 (plt:framework-pref:drracket:frame:initial-position #f)
 (external-browser firefox)
 (plt:framework-pref:external-browser firefox)
 (|plt:framework-pref:MacroStepper:Frame:Width| 764)
 (|plt:framework-pref:MacroStepper:Frame:Height| 1168)
 (plt:framework-pref:drracket:unit-window-width 1596)
 (plt:framework-pref:drracket:unit-window-height 1168)
 (plt:framework-pref:drracket:unit-window-max? #f)
 (plt:framework-pref:framework:exit-when-no-frames #t)
 (|plt:DrRacket-splash-max-width| 714)
 (plt:framework-pref:drracket:language-dialog:hierlist-default ("Legacy Languages" "R5RS"))
 (plt:framework-pref:drracket:language-settings ((-32768) (#6(#t print mixed-fraction-e #f #t debug) (default) #0() "#lang racket\n" #t #t)))
 (plt:framework-pref:drracket:toolbar-state (#f . left))
 (plt:framework-pref:framework:show-delegate? #t)
 (plt:framework-pref:drracket:recent-language-names (("Determine language from source" #6(#t print mixed-fraction-e #f #t debug) (default) #0() "#lang racket\n" #t #t) ("R5RS" . #7(#f trad-write mixed-fraction-e #f #t debug #t))))
 (plt:framework-pref:plt:debug-tool:stack/variable-area 9/10)
 (plt:framework-pref:drracket:unit-window-size-percentage 1297/2150)
 (plt:framework-pref:drracket:unit-window-position (0 805 489))
 (plt:framework-pref:drracket:unit-window-size (#f 1596 1168))
 (plt:framework-pref:framework:recently-opened-files/pos ((#"/home/occam/bin/projects/lisp/scheme/debut.rkt" 0 0) (#"/home/occam/bin/projects/lisp/scheme/kvadrat.ss" 0 0) (#"/home/occam/bin/projects/lisp/scheme/quick.ss" 0 0)))
 (plt:framework-pref:framework:verify-exit #f)
 (plt:framework-pref:drracket:console-previous-exprs
  (
   ("(define substring-capitalize\n  (lambda (string start end)\n    (let ((result (string-copy string)))\n      (substring-capitalize! result start end)\n      result)))\n\n(define bottle-wall\n  (lambda (max-bottles)\n    (let* ((bottles max-bottles)\n           (s (lambda () (if (= bottles 1) \"\" \"s\")))\n           (sing-count (lambda () \n                         (string-append\n                          (if (= 0 bottles) \"no more\"\n                              (number->string bottles))\n                          \" bottle\" (s) \" of beer \")))\n           (on-wall \"on the wall\"))\n      (lambda (msg . args)\n        (case msg\n          ((count) bottles)\n\n          ((sing-wall)\n           (display \n            (substring-capitalize \n             (string-append \n              (sing-count) on-wall \", \" (sing-count) \".\")\n             0 2))\n           (newline))\n\t  \n          ((sing-remove)\n           (set! bottles (modulo (- bottles 1)\n                                 (1+ max-bottles)))\n           (display (string-append\n\t\t     (if (= bottles max-bottles)\n\t\t\t \"Go to the store and buy some more, \"\n\t\t\t \"Take one down and pass it around, \")\n\t\t     (sing-count) on-wall \".\"))\n           (newline) (newline)))))))\n\n(define 99-bottles\n  (lambda ()\n    (let* ((max 99)\n           (mywall (bottle-wall max)))\n      (let loop ()\n        (mywall 'sing-wall)\n        (mywall 'sing-remove)\n        (if (not (= max (mywall 'count)))\n            (loop))))))")
   ("(define substring-capitalize\n  (lambda (string start end)\n    (let ((result (string-copy string)))\n      (substring-capitalize! result start end)\n      result)))\n\n(define bottle-wall\n  (lambda (max-bottles)\n    (let* ((bottles max-bottles)\n           (s (lambda () (if (= bottles 1) \"\" \"s\")))\n           (sing-count (lambda () \n                         (string-append\n                          (if (= 0 bottles) \"no more\"\n                              (number->string bottles))\n                          \" bottle\" (s) \" of beer \")))\n           (on-wall \"on the wall\"))\n      (lambda (msg . args)\n        (case msg\n          ((count) bottles)\n\n          ((sing-wall)\n           (display \n            (substring-capitalize \n             (string-append \n              (sing-count) on-wall \", \" (sing-count) \".\")\n             0 2))\n           (newline))\n\t  \n          ((sing-remove)\n           (set! bottles (modulo (- bottles 1)\n                                 (1+ max-bottles)))\n           (display (string-append\n\t\t     (if (= bottles max-bottles)\n\t\t\t \"Go to the store and buy some more, \"\n\t\t\t \"Take one down and pass it around, \")\n\t\t     (sing-count) on-wall \".\"))\n           (newline) (newline)))))))\n\n(define 99-bottles\n  (lambda ()\n    (let* ((max 99)\n           (mywall (bottle-wall max)))\n      (let loop ()\n        (mywall 'sing-wall)\n        (mywall 'sing-remove)\n        (if (not (= max (mywall 'count)))\n            (loop))))))")
   ("(define substring-capitalize\n  (lambda (string start end)\n    (let ((result (string-copy string)))\n      (substring-capitalize! result start end)\n      result)))\n\n(define bottle-wall\n  (lambda (max-bottles)\n    (let* ((bottles max-bottles)\n           (s (lambda () (if (= bottles 1) \"\" \"s\")))\n           (sing-count (lambda () \n                         (string-append\n                          (if (= 0 bottles) \"no more\"\n                              (number->string bottles))\n                          \" bottle\" (s) \" of beer \")))\n           (on-wall \"on the wall\"))\n      (lambda (msg . args)\n        (case msg\n          ((count) bottles)\n\n          ((sing-wall)\n           (display \n            (substring-capitalize \n             (string-append \n              (sing-count) on-wall \", \" (sing-count) \".\")\n             0 2))\n           (newline))\n\t  \n          ((sing-remove)\n           (set! bottles (modulo (- bottles 1)\n                                 (1+ max-bottles)))\n           (display (string-append\n\t\t     (if (= bottles max-bottles)\n\t\t\t \"Go to the store and buy some more, \"\n\t\t\t \"Take one down and pass it around, \")\n\t\t     (sing-count) on-wall \".\"))\n           (newline) (newline)))))))\n\n(define 99-bottles\n  (lambda ()\n    (let* ((max 99)\n           (mywall (bottle-wall max)))\n      (let loop ()\n        (mywall 'sing-wall)\n        (mywall 'sing-remove)\n        (if (not (= max (mywall 'count)))\n            (loop))))))")
   ("(99-bottles)")
   ("(99-bottles)")
   ("(99-bottles)")
   ("(eq nil false)")
   ("(eq nil false)")
   ("(eq nil false)")
   ("nil")
   ("false")
   ("true")
   ("nil")
   ("null")
   ("(eq false null)")
   ("(= false null)")
   ("(equal false null)")
   ("(= 0 0)")
   ("(= 0 0 0)")
   ("(= 0 0 0 1)")
   ("#f")
   ("(fakkul 3)")
   ("(fakkul 3)")
   ("(fakkul 31)")
   ("(expt (+ 1 (/ 1 100)) 100)")
   ("(expt (+ 1 (/ 1 1000)) 1000)")
   ("e12")
   ("1e12")
  ))
 (readline-input-history
  (
   #"(exit)"
   #",bt"
   #"ls"
   #"(getf '(:a 1 :b 2 :c 3) :b))"
   #"y"
   #",install!"
   #"ok"
   #",install"
  ))
)

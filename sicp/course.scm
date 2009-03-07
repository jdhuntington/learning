;;;
;;; Support code for SICP and T-93.210 with MzScheme
;;; $Id: course-support.scm,v 1.1 2001/08/08 15:54:51 rjs Exp $
;;;

;;;
;;; For SICP (2nd edition)
;;;

;; MzScheme has random and error as primitives

;; Some non-standard names that SICP uses
(define true #t)
(define false #f)
(define nil '())

;; runtime
;; (=user + system time consumed by the Scheme interpreter in microseconds)
(define (runtime)
  (* (current-process-milliseconds)
     1000))

;;
;; SICP streams
;;

;; The special form cons-stream

(define-macro cons-stream
  (lambda (head tail)
    `(cons ,head (delay ,tail))))

(define (stream-car stream) 
  (car stream))

(define (stream-cdr stream)
  (force (cdr stream)))

(define (stream-null? stream) 
  (null? stream))

(define the-empty-stream '())

;;
;; stream utilities
;;

(define (list->stream lista)
  (if (null? lista)
      the-empty-stream
      (cons-stream (car lista) (list->stream (cdr lista)))))

(define (stream . rest)
  (list->stream rest))

(define *stream-display-limit* 100)

(define (display-stream stream . rest)
  (define (loop s n)
    (cond ((= n 0)
	   (display "..."))
	  ((not (stream-null? s))
	   (display (stream-car s))
	   (display " ")
	   (loop (stream-cdr s) (- n 1)))))
  (loop stream
	(if (not (null? rest)) (car rest) *stream-display-limit*))
  (newline))

(define (stream-ref stream n)
  (cond ((stream-null? stream) (error "Stream-ref: stream shorter than n"))
	((= n 0) (stream-car stream))
	(else (stream-ref (stream-cdr stream) (- n 1)))))

(define (stream-append s1 s2)
  (if (stream-null? s1) 
      s2
      (cons-stream (stream-car s1) 
		   (stream-append (stream-cdr s1) s2))))

(define (stream-map proc . streams)
  (if (stream-null? (car streams))
      the-empty-stream
      (cons-stream (apply proc (map stream-car streams))
		   (apply stream-map proc (map stream-cdr streams)))))

(define (add-streams . streams)
  (apply stream-map + streams))

(define (mul-streams . streams)
  (apply stream-map * streams))

(define (stream-filter filter stream)
  (cond ((stream-null? stream)
	 the-empty-stream)
	((filter (stream-car stream))
	 (cons-stream (stream-car stream)
		      (stream-filter filter (stream-cdr stream))))
	(else
	 (stream-filter filter (stream-cdr stream)))))


;;
;; parallel-execute and friends
;;

;; This parallel-execute returns a list of the thread descriptors generated
;; (in the same order as the argument thunks).
(define (parallel-execute . args)
  (map thread args))

;; When called with the result of parallel-execute, kills all the threads
;; that the parallel-execute started
(define (kill-parallel-executors thread-list)
  (for-each kill-thread thread-list)
  'done)

;; An implementation of mutexes for MzScheme
(define (make-mutex)
  (let ((sema (make-semaphore 1)))
    (define (the-mutex m)
      (cond ((eq? m 'acquire) (semaphore-wait sema))
	    ((eq? m 'release) (semaphore-post sema))
	    (else (error "A mutex got an invalid argument:" m))))
    the-mutex))

;; make-serializer from SICP
(define (make-serializer)
  (let ((mutex (make-mutex)))
    (lambda (p)
      (define (serialized-p . args)
	(mutex 'acquire)
	(let ((val (apply p args)))
	  (mutex 'release)
	  val))
      serialized-p)))

;;;
;;; Some support for debugging
;;;

;; trace and untrace
(require (lib "trace.ss"))

;; (stack-trace-on) turns on MzScheme's stack tracing. Please note
;; that this slows down all code quite a lot, and that you need to
;; reload all your code _after_ executing (stack-trace-on)!
(define-macro stack-trace-on
  (lambda ()
    '(require-library "errortrace.ss" "errortrace")))

;;;
;;; Tell people that we're done
;;;

(define *sicp-and-t93210-support* #t)

(display "Support for SICP and T-93.210 loaded.")
(newline)

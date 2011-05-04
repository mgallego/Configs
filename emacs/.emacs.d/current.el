;; messenger.el --- MSN Messenger on Emacs
;; Copyright (C) 2002 ctlaltdel <ctlaltdel@geocities.co.jp>
;; Author: ctlaltdel <ctlaltdel@geocities.co.jp>, らむだ <lambda_list@hotmail.com>

;; This file is *NOT* part of GNU Emacs.
;;
;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 59 Temple Place - Suite 330,
;; Boston, MA 02111-1307, USA.

(require 'un-define)
(require 'un-tools)
(require 'cl)

(defvar *msn-version* "MSN Messenger on Emacs version 0.1.0.1")
(defvar *msn-user-account* nil)
(defvar *msn-contact-list* nil)
(defvar *msn-buffers* nil)
(defvar *msn-current-session* nil)
(defvar *msn-session-list* nil)
(defvar *msn-max-session* nil)
(defvar *msn-id* nil)
(defvar *msn-mode-map*
  (list (cons 'info (make-keymap))
	(cons 'session (make-keymap))
	(cons 'message (make-keymap))))
(defvar *msn-sync-id* nil)
(defvar *msn-sync-fragment* nil)
(defvar *msn-time-format* " %H:%M:%S")
(defvar *msn-idle-timer* nil)
(defvar *msn-ping-timer* nil)
(defvar *msn-window-configuration* nil)
(defvar *msnftp* nil)
(defvar *msn-session-users* nil)

;; hook
(defvar msn-background-message-notify-hook nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                         utility functions                                ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defmacro msn-set-user (type value)
  `(setcdr (assoc ,type *msn-user-account*) ,value))
(defmacro msn-get-user (type)
  `(cdr (assoc ,type *msn-user-account*)))

(defmacro msn-get-contact-list (lst mail type)
  `(cdr (assoc ,type (cdr (assoc ,mail (cdr (assoc ,lst *msn-contact-list*)))))))
(defmacro msn-set-contact-list (lst mail type value)
  `(setcdr (assoc ,type (cdr (assoc ,mail (cdr (assoc ,lst *msn-contact-list*))))) ,value))

(defmacro msn-get-key-map (type)
  `(cdr (assoc ,type *msn-mode-map*)))

(defmacro msn-set-process (type value)
  `(setcdr (assoc ,type *msn-connections*) ,value))
(defmacro msn-get-process (type)
  `(cdr (assoc ,type *msn-connections*)))
(defmacro msn-get-buffer (type)
  `(cdr (assoc ,type *msn-buffers*)))
(defmacro msn-get-session (N)
  `(cdr (assoc ,N *msn-session-list*)))
(defmacro msn-get-session-buffer (N)
  `(format " Session [%d]" ,N))
;;  `(process-buffer (cdr (assoc ,N *msn-session-list*))))

(defun msn-make-list (beg end)
  (do ((i beg (+ i 1))
       (l nil (cons i l)))
      ((> i end) (nreverse l))))

(defun msn-initialize ()
  (global-set-key "\C-c\C-i" #'msn-infomation-screen)
  (let ((map (msn-get-key-map 'info)))
    (define-key map "\C-m" (lambda () (interactive) (message "ENTER")))
    (define-key map [(control ?1)] (lambda () (interactive) (msn-session-screen 1)))
    (define-key map [(control ?2)] (lambda () (interactive) (msn-session-screen 2)))
    (define-key map [(control ?3)] (lambda () (interactive) (msn-session-screen 3)))
    (define-key map [(control ?4)] (lambda () (interactive) (msn-session-screen 4)))
    (define-key map [(control ?5)] (lambda () (interactive) (msn-session-screen 5)))
    (define-key map [(control ?6)] (lambda () (interactive) (msn-session-screen 6)))
    (define-key map [(control ?7)] (lambda () (interactive) (msn-session-screen 7)))
    (define-key map [(control ?8)] (lambda () (interactive) (msn-session-screen 8)))
    (define-key map [(control ?9)] (lambda () (interactive) (msn-session-screen 9)))
    (define-key map [(control ?0)] #'msn-infomation-screen)
    (define-key map "\C-c\C-i" #'msn-infomation-screen)
    (define-key map "\C-c\C-o" #'msn-change-status)
    ;;(define-key map "\C-c\C-c" #'msn-send-message)
    (define-key map "\C-c\C-r" #'msn-call)
    (define-key map "\C-c\C-s" #'msn-sync)
    (define-key map "\C-c\C-w" #'msn-close-session)
    (define-key map "\C-c\C-n" #'msn-create-new-session)
    (define-key map "\C-c\C-q" #'msn-exit)
    (define-key map "q" #'msn-exit)
    (define-key map "1" (lambda () (interactive) (msn-session-screen 1)))
    (define-key map "2" (lambda () (interactive) (msn-session-screen 2)))
    (define-key map "3" (lambda () (interactive) (msn-session-screen 3)))
    (define-key map "4" (lambda () (interactive) (msn-session-screen 4)))
    (define-key map "5" (lambda () (interactive) (msn-session-screen 5)))
    (define-key map "6" (lambda () (interactive) (msn-session-screen 6)))
    (define-key map "7" (lambda () (interactive) (msn-session-screen 7)))
    (define-key map "8" (lambda () (interactive) (msn-session-screen 8)))
    (define-key map "9" (lambda () (interactive) (msn-session-screen 9)))
    (define-key map "r" (lambda () (interactive) (msn-rename)))
    (define-key map "p" (lambda () (interactive) (next-line -1)))
    (define-key map "n" (lambda () (interactive) (next-line 1)))
    (define-key map "k" (lambda () (interactive) (next-line -1)))
    (define-key map "j" (lambda () (interactive) (next-line 1))))
  (let ((map (msn-get-key-map 'session)))
    (define-key map [(control ?1)] (lambda () (interactive) (msn-session-screen 1)))
    (define-key map [(control ?2)] (lambda () (interactive) (msn-session-screen 2)))
    (define-key map [(control ?3)] (lambda () (interactive) (msn-session-screen 3)))
    (define-key map [(control ?4)] (lambda () (interactive) (msn-session-screen 4)))
    (define-key map [(control ?5)] (lambda () (interactive) (msn-session-screen 5)))
    (define-key map [(control ?6)] (lambda () (interactive) (msn-session-screen 6)))
    (define-key map [(control ?7)] (lambda () (interactive) (msn-session-screen 7)))
    (define-key map [(control ?8)] (lambda () (interactive) (msn-session-screen 8)))
    (define-key map [(control ?9)] (lambda () (interactive) (msn-session-screen 9)))
    (define-key map [(control ?0)] #'msn-infomation-screen)
    (define-key map "\C-c\C-i" #'msn-infomation-screen)
    (define-key map "\C-c\C-o" #'msn-change-status)
    (define-key map "\C-c\C-q" #'msn-exit)
    (define-key map "1" (lambda () (interactive) (msn-session-screen 1)))
    (define-key map "2" (lambda () (interactive) (msn-session-screen 2)))
    (define-key map "3" (lambda () (interactive) (msn-session-screen 3)))
    (define-key map "4" (lambda () (interactive) (msn-session-screen 4)))
    (define-key map "5" (lambda () (interactive) (msn-session-screen 5)))
    (define-key map "6" (lambda () (interactive) (msn-session-screen 6)))
    (define-key map "7" (lambda () (interactive) (msn-session-screen 7)))
    (define-key map "8" (lambda () (interactive) (msn-session-screen 8)))
    (define-key map "9" (lambda () (interactive) (msn-session-screen 9)))
    (define-key map "\C-c\C-r" #'msn-call)
    (define-key map "\C-c\C-w" #'msn-close-session))
  (let ((map (msn-get-key-map 'message)))
    (define-key map [(control ?1)] (lambda () (interactive) (msn-session-screen 1)))
    (define-key map [(control ?2)] (lambda () (interactive) (msn-session-screen 2)))
    (define-key map [(control ?3)] (lambda () (interactive) (msn-session-screen 3)))
    (define-key map [(control ?4)] (lambda () (interactive) (msn-session-screen 4)))
    (define-key map [(control ?5)] (lambda () (interactive) (msn-session-screen 5)))
    (define-key map [(control ?6)] (lambda () (interactive) (msn-session-screen 6)))
    (define-key map [(control ?7)] (lambda () (interactive) (msn-session-screen 7)))
    (define-key map [(control ?8)] (lambda () (interactive) (msn-session-screen 8)))
    (define-key map [(control ?9)] (lambda () (interactive) (msn-session-screen 9)))
    (define-key map [(control ?0)] #'msn-infomation-screen)
    (define-key map "\C-c\C-i" #'msn-infomation-screen)
    (define-key map "\C-c\C-o" #'msn-change-status)
    (define-key map "\C-c\C-c" #'msn-send-message)
    (define-key map "\C-c\C-r" #'msn-call)
    (define-key map "\C-c\C-w" #'msn-close-session)
    (define-key map "\C-c\C-q" #'msn-exit)
    (define-key map "\C-v" (lambda () (interactive) (scroll-other-window 3)))
    (define-key map "\C-cv" (lambda () (interactive) (scroll-other-window))))
  (setq *msn-user-account*
	(copy-tree '((mail . nil) (name . nil) (pass . nil) (stat . nil)))
	*msn-contact-list*
	(copy-tree '((FL . ()) (RL . ()) (AL . ()) (BL . ())))
	*msn-buffers*
	'((dispatch . " Dispach") (notification . " Notification")
	  (info . " Messenger Information") (message . " Messenger Message"))
	*msn-connections*
	(copy-tree '((dispatch . nil) (notification . nil)))
	*msn-current-session* nil
	*msn-session-list* nil
	*msn-id* 0
	*msn-sync-id* 0
	*msn-sync-fragment* nil
	*msn-time-format* " %H:%M:%S"
	*msn-idle-timer* nil
	;;*msn-ping-timer* nil
	*msn-window-configuration* nil
	*msnftp* 
	'((process . nil) (command . "msnftp")
	  (directory . "~/tmp")
	  (send . nil) (recv . nil))))

(defun msn-url-encode-string (str)
  (apply #'concat
	 (mapcar
	  (lambda (e)
	    (cond
	     ;;((string-match "[a-zA-Z0-9:/]" e) e)
	     ((string-match "[^ %~]" e) e)
	     (t (format "%%%02X" (string-to-char e)))))
	  ;;(split-string (encode-coding-string str 'utf-8-dos) ""))))
	  (split-string str ""))))

(defun msn-url-decode-string (str)
  (let* ((str (encode-coding-string str 'utf-8-dos))
	 (size (length str))
	 (lst (do* ((i 0 (+ i 1))
		    (lst nil))
		  ((>= i size) (nreverse lst))
		(setq lst
		      (cons (if (not (eq (aref str i) ?%))
				(aref str i)
			      (setq i (+ i 2))
			      (string-to-int
			       (concat
				(char-to-string (aref str (- i 1)))
				(char-to-string (aref str (- i 0))))
			       16))
			    lst)))))
    (decode-coding-string 
     (apply #'concat (mapcar #'char-to-string lst))
     'utf-8-dos)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                          User Interface                                  ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defface msn-session-header-face 
  '((((type tty)) (:foreground "white" :background "black" :bold t))) nil)
(defface msn-session-body-face
  '((((type tty)) (:foreground "white" :background "black"))) nil)

(defface msn-status-online-face
  '((((type tty)) (:foreground "red" :bold t))
    (t (:foreground "red" :bold t))) nil)
(defface msn-status-offline-face
  '((((type tty)) (:foreground "black" :bold t))
    (t (:foreground "blue" :bold t))) nil)
(defface msn-status-default-face
  '((((type tty)) (:foreground "darkgreen" :bold t))
    (t (:foreground "darkgreen" :bold t))) nil)

(defface msn-command-face
  '((((type tty)) (:foreground "black" :background "cyan"  :bold t))
    (t (:foreground "red" :background "yellow" :bold t))) nil)

(defun msn-insert-with-face (face string)
  (let* ((beg (point))
	 (end (progn (insert string) (point)))
	 (overlay (make-overlay beg end)))
    (overlay-put overlay 'face face)
    (add-text-properties beg end '(read-only t))))

(defun msn-get-status-face (status)
  (cond
   ((string-equal status "NLN") 'msn-status-online-face)
   ((string-equal status "FLN") 'msn-status-offline-face)
   (t                           'msn-status-default-face)))

(defun msn-status-expand (status)
  (interactive)
  (cdr (assoc status
	      '(("NLN" . "(ONLINE)") ("FLN" . "(OFFLINE)")
		("BSY" . "(取り込み中)") ("IDL" . "(退席)") 
		("BRB" . "(一時退席中)") ("AWY" . "(退席中)")
		("PHN" . "(電話中)") ("LUN" . "(昼休み)")))))

(defun msn-infomation-screen ()
  (interactive)
  (when (not (one-window-p)) (delete-other-windows))
  (switch-to-buffer (msn-get-buffer 'info))
  (setq major-mode 'msn-mode)
  (setq mode-name "Messenger - Information")
  (use-local-map (msn-get-key-map 'info))
  (msn-draw-info))

(defun msn-session-screen (N)
  (interactive)
  (setq *msn-current-session* N)
  (when (not (one-window-p)) (delete-other-windows))
  (switch-to-buffer (get-buffer-create (msn-get-session-buffer N)))
  (setq major-mode 'msn-mode)
  (setq mode-name "Messenger - Session")
  (use-local-map (msn-get-key-map 'session))
  (split-window (selected-window) (- (window-height (selected-window)) 5))
  (setq mode-line-format (msn-get-session-buffer N))
  (other-window 1)
  (switch-to-buffer (msn-get-buffer 'message))
  (setq major-mode 'msn-mode)
  (setq mode-name "Messenger - Message")
  (use-local-map (msn-get-key-map 'message))
  (msn-draw-info))

(defun msn-draw-info ()
  (let ((inhibit-read-only t))
    (save-excursion
      (set-buffer (msn-get-buffer 'info))
      (erase-buffer)
      (msn-insert-with-face 'bold "[ユーザーアカウント]\n")
      (let* ((mail (msn-get-user 'mail))
	     (name (msn-get-user 'name))
	     (stat (msn-get-user 'stat))
	     (face (msn-get-status-face stat)))
	(msn-insert-with-face face (format "%-9s " (msn-status-expand stat)))
	(msn-insert-with-face 'default (format "%s <%s>\n" name mail)))
      (msn-insert-with-face 'bold "\n[セッション]\n")
      (dolist (s (sort (mapcar #'car *msn-session-list*) #'<))
	(let* ((proc (cdr (assoc s *msn-session-list*)))
	       (stat (if (eq (process-status proc) 'open) "(OPEN)" "(CLOSE)"))
	       (users (with-current-buffer (process-buffer proc) *msn-session-users*)))
	  (msn-insert-with-face
	   'bold
	   (if (eq s *msn-current-session*)
	       (concat "*Session [" (int-to-string s) "] " stat "\n")
	     (concat " Session [" (int-to-string s) "] " stat "\n")))
	  (dolist (u users)
	    (let ((mail (car u)) (name (cdr u)))
	      (msn-insert-with-face 'default (concat ">> " name " <" mail ">\n"))))))

      (let ((FL (assoc 'FL *msn-contact-list*)))
	(msn-insert-with-face 'bold "\n[コンタクトリスト]\n")
	(dolist (e (cdr FL))
	  (let* ((mail (car e))
		 (name (cdr (assoc 'name (cdr e))))
		 (stat (cdr (assoc 'stat (cdr e))))
		 (face (msn-get-status-face stat)))
	    (msn-insert-with-face face (format "%-9s " (msn-status-expand stat)))
	    (msn-insert-with-face 'default (format "%s <%s>\n" name mail)))))
      (set-buffer-modified-p nil))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                          Messenger Mode                                  ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun msn-mode ()
  (interactive)
  (msn-initialize)
  (let ((buffer (get-buffer (msn-get-buffer 'info))))
    (msn-infomation-screen)
    (msn-connect)))

(defun msn-connect ()
  (msn-set-user 'name nil)
  (msn-set-user 'mail nil)
  (msn-set-user 'pass nil)
  (msn-set-user 'stat "FLN")
  (let ((mail (msn-get-user 'mail))
	(pass (msn-get-user 'pass)))
    (when (null mail)
      (msn-set-user 'mail (read-string "Hotmail Account: ")))
    (when (null pass)
      (msn-set-user 'pass
		    (let ((inhibit-input-event-recording t))
		      (condition-case nil (read-passwd "Password: "))))))
  ;; connect to dispatch server
  (msn-set-process
   'dispatch
   (open-network-stream "Dispatch Server"
			(msn-get-buffer 'dispatch)
			"messenger.hotmail.com" 1863))
  (let ((process (msn-get-process 'dispatch)))
    (set-process-coding-system process 'utf-8-dos 'utf-8-dos)
    (set-process-filter process 'msn-dispatch-filter)
    (msn-login process)))

(defun msn-login (server)
  (msn-proc-send server "VER" "MSNP7 MSNP6 MSNP5 CVR0\n"))

(defun msn-get-id ()
  (setq *msn-id* (+ *msn-id* 1))
  (int-to-string *msn-id*))

(defun msn-proc-send (server cmd body)
  (let ((msg (concat cmd " " (msn-get-id) " " body)))
    (save-excursion
      (set-buffer (process-buffer server))
      (goto-char (point-max))
      (insert "--------------------\n<<< ")
      (insert msg)
      (insert "--------------------\n"))
    (process-send-string server msg)))

(defun msn-record-sever-message (string)
  (goto-char (point-max))
  (insert "--------------------\n>>> ")
  (insert string)
  (insert "--------------------\n"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                            Command                                       ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defmacro msn-open-p (type)
  `(and (msn-get-process ,type) (eq (process-status (msn-get-process ,type)) 'open)))

(defun msn-exit ()
  (interactive)
  (when (msn-open-p 'notification)
    (process-send-string (msn-get-process 'notification) "OUT\n")
    (msn-initialize))
  (let* ((lst nil))
    (delete-other-windows)
    (dolist (e (buffer-list))
      (when (string-match (concat "\\("
				  "^" (msn-get-buffer 'dispatch) "$\\|"
				  "^" (msn-get-buffer 'notification) "$\\|"
				  "^" (msn-get-buffer 'info) "$\\|"
				  "^" (msn-get-buffer 'message) "$\\|"
				  "^ Session \\[[0-9]+\\]$\\|"
				  "^ Switchboard \\[[0-9]+\\]$\\)")
			  (buffer-name e))
	(setq lst (cons e lst))))
    (dolist (b lst)
      (set-buffer b)
      (set-buffer-modified-p nil)
      (kill-buffer b))))

(defun msn-send-message ()
  (interactive)
  (if (null *msn-current-session*)
      (message "セッションを選んでください!!")
    (let ((session (cdr (assoc *msn-current-session* *msn-session-list*))))
      (when (and session
		 (eq (process-status session) 'open))
	(let* ((body (buffer-substring-no-properties (point-min) (point-max)))
	       (head "MIME-Version: 1.0\nContent-Type: text/plain; charset=UTF-8\nX-MMS-IM-Format: FN=MS%20UI%20Gothic; EF=; CO=0; CS=80; PF=0\n\n")
	       (msg (concat head body))
	       (size (int-to-string (length (encode-coding-string msg 'utf-8-dos))))
	       (msg (concat "MSG " (msn-get-id) " U " size "\n" msg)))
	  (process-send-string session msg)
	  (delete-region (point-min) (point-max))
	  (set-buffer-modified-p nil)
	  (msn-show-message *msn-current-session* msg))))))

(defun msn-change-status ()
  (interactive)
  (when (msn-open-p 'notification)
    (let* ((proc (msn-get-process 'notification))
	   (stat-list '(("NLN") ("BSY") ("IDL") ("BRB") ("AWY") ("PHN") ("LUN") ("FLN")))
	   (completion-ignore-case nil)
	   (stat (completing-read "Status?: " stat-list nil t "NLN")))
      (msn-proc-send proc "CHG" (concat stat "\n")))))

(defun msn-rename ()
  (interactive)
  (when (msn-open-p 'notification)
    (msn-proc-send (msn-get-process 'notification)
		   "REA"
		   (concat (msn-get-user 'mail) " "
			   (msn-url-encode-string (read-input "Nickname?: " (msn-get-user 'name)))
			   "\n"))))

(defun msn-sync ()
  (interactive)
  (when (msn-open-p 'notification)
    (msn-proc-send (msn-get-process 'notification)
		   "SYN" (concat (int-to-string *msn-sync-id*) "\n"))))

(defun msn-create-new-session ()
  (interactive)
  (when (msn-open-p 'notification)
    (msn-proc-send (msn-get-process 'notification) "XFR" "SB\n")))

(defun msn-close-session ()
  (interactive)
  (if (null *msn-current-session*)
      (message "セッションを選んでください!!")
    (let* ((session (cdr (assoc *msn-current-session* *msn-session-list*)))
	   (buf (process-buffer session)))
      (when (and session
		 (eq (process-status session) 'open))
	(process-send-string session "OUT\n")
	(delete-process session))
      (setq *msn-session-list*
	    (delete (assoc *msn-current-session* *msn-session-list*)
		    *msn-session-list*))
      (kill-buffer (msn-get-session-buffer *msn-current-session*))
      (setq *msn-current-session*
	    (if (null *msn-session-list*) nil (caar *msn-session-list*)))
      (msn-infomation-screen))))

(defun msn-call ()
  (interactive)
  (if (null (and *msn-current-session*
		 (assoc *msn-current-session* *msn-session-list*)))
      (message "現在のセッションは無効です…")
    (let ((server (cdr (assoc *msn-current-session* *msn-session-list*))))
      (when (eq (process-status server) 'open)
	(let ((who (completing-read "Who?: "
				    (cdr (assoc 'FL *msn-contact-list*))
				    nil nil)))
	  (msn-proc-send server "CAL" (concat who "\n")))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                             MSNP                                         ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun msn-xfr (string)
  (let* ((lst (split-string string "[ \n]"))
	 (type (nth 2 lst))
	 (address (split-string (nth 3 lst) ":"))
	 (addr (nth 0 address))
	 (port (nth 1 address)))
    (cond
     ((string-equal type "NS")
      (msn-set-process
       'notification
       (open-network-stream "Notification Server"
			    (msn-get-buffer 'notification)
			    addr (string-to-int port)))
      (let ((process (msn-get-process 'notification)))
	(when (null *msn-ping-timer*)
	  (setq *msn-ping-timer*
		;; 10 分毎に PNG をうつ
		(run-at-time t (* 60 10)
			     (lambda ()
			       (when (msn-open-p 'notification)
				 (process-send-string (msn-get-process 'notification) "PNG\n"))))))
	(set-process-coding-system process 'utf-8-dos 'utf-8-dos)
	(set-process-filter process 'msn-notification-filter)
	(msn-login process)))
     ((string-equal type "SB")
      (let ((auth (nth 4 lst))
	    (session-id (nth 1 lst))
	    (security-string (nth 5 lst)))
	(msn-answer addr port session-id security-string
		    (lambda (proc)
		      (msn-proc-send
		       proc "USR"
		       (concat (msn-get-user 'mail)
			       " " security-string "\n")))))))))

(defun msn-get-session-id ()
  (let ((lst (msn-make-list 1 100))
	(slst (mapcar #'car *msn-session-list*)))
    (if (null slst)
	1
      (dolist (e slst)
	(setq lst (delete e lst)))
      (if lst (apply #'min lst) nil))))

(defun msn-switchboard-sentinel (proc event)
  (let* ((name (buffer-name (process-buffer proc)))
	 (ret (string-match "\\[\\([0-9]+\\)\\]" name))
	 (session (string-to-int (substring name (match-beginning 1) (match-end 1))))
	 (status (process-exit-status proc)))
    (when status
      (setq *msn-session-list* 
	    (delete (assoc session *msn-session-list*)
		    *msn-session-list*))
      (delete-process proc)
      (msn-draw-info))))

(defun msn-answer (add port session-id security-string function)
  (let ((id (msn-get-session-id)))
    (if (null id)
	(message "[エラー] セッション作り過ぎ…．")
      (when (> id 7)
	(message "[警告] セッションが増えてきました．"))
      (let ((s (assoc id *msn-session-list*)))
	(when (null s)
	  (setq *msn-session-list* (cons (cons id nil) *msn-session-list*))
	  (setq s (assoc id *msn-session-list*)))
	(setcdr s (open-network-stream
		   (concat "Switch Board [" (int-to-string id) "]")
		   (concat " Switchboard [" (int-to-string id) "]")
		   addr (string-to-int port)))
	(let ((server (cdr s)))
	  (set-process-coding-system server 'utf-8-dos 'utf-8-dos)
	  (set-process-filter server 'msn-switchboard-filter)
	  (set-process-sentinel server #'msn-switchboard-sentinel)
	  (set-buffer (get-buffer-create (msn-get-session-buffer id)))
	  (set-buffer (get-buffer (process-buffer server)))
	  (make-local-variable '*msn-session-users*)
	  (setq *msn-session-users* nil)
	  (funcall function server))
	(when (null *msn-current-session*) (setq *msn-current-session* id))
	(msn-draw-info)))))
 
(defun msn-server-message-parse (string)
  (let ((cmd (substring string 0 3)))
    (cond
     (*msn-sync-fragment*
      (if (eq (aref string (- (length string) 1)) ?\n)
	  (let* ((lst (split-string
		       (if *msn-sync-fragment*
			   (concat *msn-sync-fragment* string)
			 string)
		       "\n")))
	    (setq *msn-sync-fragment* nil)
	    lst)
	(setq *msn-sync-fragment* (concat *msn-sync-fragment* string))
	nil))
     ((string-equal "MSG" cmd)
      (list string))
     ((string-equal "USR" cmd)
      (let* ((pos (string-match "\n" string))
	     (usr (substring string 0 pos))
	     (other (substring string (+ pos 1) (length string))))
	(if (> (length other) 5) (list usr other) (list usr))))
     (t (split-string string "\n")))))

(defun msn-parse-notification-message (proc string)
  (let* ((regexp "^Inbox-Unread: \\([0-9]+\\)\nFolders-Unread: \\([0-9]+\\)")
       (msg (split-string string "\n\n"))
       (head (car msg))
       (body (apply 'concat (cdr msg))))
  (cond
   ((equal body ""))
   ((> (length body) 10)
    (cond
     ((string-match regexp body)
      (let ((new (substring body (match-beginning 1) (match-end 1)))
	    (unread (substring body (match-beginning 2) (match-end 2))))
	(message (format "[MSN] new: %s unread: %s" new unread)))))))))

(defun msn-set-contact-list (mail stat name)
(let* ((FL (assoc 'FL *msn-contact-list*))
       (name (msn-url-decode-string name))
       (m (assoc mail (cdr FL))))
  (if (null m)
      (setcdr FL (cons (cons mail (list (cons 'stat stat) (cons 'name name))) (cdr FL)))
    (setcdr (assoc 'name (cdr m)) name)
    (setcdr (assoc 'stat (cdr m)) stat))))

(defun msn-rng (string)
(let* ((lst (split-string string "[ \n]"))
       (address (split-string (nth 2 lst) ":"))
       (addr (nth 0 address))
       (port (nth 1 address))
       (session-id (nth 1 lst))
       (security-string (nth 4 lst)))
  (msn-answer
   addr port session-id security-string
   (lambda (proc)
     (msn-proc-send proc
		    "ANS"
		    (concat (msn-get-user 'mail)
			    " " security-string
			    " " session-id "\n"))))))

(defun msn-challenge-auth (proc string)
(msn-proc-send proc
	       "QRY"
	       (concat "msmsgs@msnmsgr.com 32\n"
		       (msn-md5-digest
			(concat (nth 2 (split-string string "[ \n]"))
				"Q1P7W2E4J9R8U3S5")))))

(defun msn-notification-usr (proc string)
(let* ((lst (split-string string "[ \n]")))
  (cond
   ((string-equal (nth 3 lst) "S")
    (msn-proc-send proc
		   "USR"
		   (concat "MD5 S "
			   (msn-md5-digest (concat (nth 4 lst) (msn-get-user 'pass)))
			   "\n"))
    (msn-set-user 'pass nil))
   ((string-equal (nth 2 lst) "OK")
    (let* ((lst (split-string string " ")))
      (msn-set-user 'mail (nth 3 lst))
      (msn-set-user 'name (msn-url-decode-string (nth 4 lst)))
      (with-current-buffer (msn-get-buffer 'info)
	(message "LOGIN OK")
	(msn-proc-send proc "SYN" "0\n")))))))

(defun msn-lst (string)
(let ((lst (split-string string " ")))
  (when (> (length lst) 6)
    (let* ((type (nth 2 lst))
	   (type (cdr (assoc type '(("FL" . FL) ("RL" . FL) ("AL" . AL) ("BL" . BL)))))
	   (mail (nth 6 lst))
	   (name (msn-url-decode-string (nth 7 lst)))
	   (l (assoc type *msn-contact-list*))
	   (u (assoc mail (cdr l))))
      (when (null u)
	(setcdr l (cons (cons mail (list (cons 'name name) (cons 'stat "FLN"))) (cdr l))))))))

(defun msn-show-message (session string)
(let* ((regexp "MSG \\([a-zA-Z0-9-_./]+@[a-zA-Z0-9.]+ [^ \n]+\\|[0-9]+ [UA]\\) [0-9][0-9]+\n")
       (lst (do* ((pos (string-match regexp string)
		       (string-match regexp string (match-end 0)))
		  (ret (cons pos nil) (cons (if pos pos (length string)) ret)))
		((null pos) ret)))
       (lst (do* ((r (car lst) (car lst))
		  (l (cadr lst) (cadr lst))
		  (lst (cdr lst) (cdr lst))
		  (ret (cons (cons l r) nil) (cons (cons l r) ret)))
		((null (cadr lst)) ret)))
       (txt (do* ((pos (car lst) (car lst))
		  (lst (cdr lst) (cdr lst))
		  (ret (cons (substring string (car pos) (cdr pos)) nil)
		       (cons (substring string (car pos) (cdr pos)) ret)))
		((null lst) ret))))
  (dolist (msg txt)
    (let* ((inhibit-read-only t)
	   (pos (string-match "\n\n" msg))
	   (head (substring msg 0 pos))
	   (body (substring msg (+ pos 2))))
      (set-buffer (get-buffer-create (msn-get-session-buffer session)))
      (goto-char (point-max))
      (cond 
       ((string-match "^Content-Type: text/x-msmsgsinvite; charset=UTF-8" head)
	(string-match "MSG \\([a-zA-Z0-9._/]+@[a-zA-Z0-9.]+\\) \\([^ ]+\\) [0-9]+\n" head)
	(let ((mail (substring head (match-beginning 1) (match-end 1)))
	      (name (substring head (match-beginning 2) (match-end 2))))
	  (msn-invited session name mail body)))
       ((string-match "MSG [0-9]+ [UA] [0-9]+\n" head)
	(msn-insert-with-face
	 'msn-session-header-face
	 (concat "<" (int-to-string session) "> "
		 (let ((ret (assoc 'name *msn-user-account*)))
		   (if ret (cdr ret) "あなた")) " の発言:\n"))
	(msn-insert-with-face 'msn-session-body-face (concat body "\n")))
       ((string-match "MSG \\([a-zA-Z0-9._/]+@[a-zA-Z0-9.]+\\) \\([^ ]+\\) [0-9]+\n" head)
	(let* ((mail (substring head (match-beginning 1) (match-end 1)))
	       (name (substring head (match-beginning 2) (match-end 2)))
	       (name (msn-url-decode-string name)))
	  (if (string-match "^TypingUser: \\([a-zA-Z0-9._/]+@[a-zA-Z0-9.]+\\)" head)
	      (message (concat "<" (int-to-string session) "> " name " が入力中..."))
	    (msn-insert-with-face 'msn-session-header-face
				  (concat "<" (int-to-string session) "> " name " の発言:\n"))
	    (msn-insert-with-face 'msn-session-body-face (concat body "\n"))
	    ))))))))

(defun msn-show-command (session string)
(let ((inhibit-read-only t))
  (set-buffer (get-buffer-create (msn-get-session-buffer session)))
  (goto-char (point-max))
  (msn-insert-with-face 'msn-command-face (concat string "\n"))
  (goto-char (point-max))))

(defun msn-error (string)
(let* ((error-table '((200 . "ERR_SYNTAX_ERROR")
		      (201 . "ERR_INVALID_PARAMETER")
		      (205 . "ERR_INVALID_USER")
		      (206 . "ERR_FQDN_MISSING")
		      (207 . "ERR_ALREADY_LOGIN")
		      (208 . "ERR_INVALID_USERNAME")
		      (209 . "ERR_INVALID_FRIENDLY_NAME")
		      (210 . "ERR_LIST_FULL")
		      (215 . "ERR_ALREADY_THERE")
		      (216 . "ERR_NOT_ON_LIST")
		      (218 . "ERR_ALREADY_IN_THE_MODE")
		      (219 . "ERR_ALREADY_IN_OPPOSITE_LIST")
		      (280 . "ERR_SWITCHBOARD_FAILED")
		      (281 . "ERR_NOTIFY_XFR_FAILED")
		      (300 . "ERR_REQUIRED_FIELDS_MISSING")
		      (302 . "ERR_NOT_LOGGED_IN")
		      (500 . "ERR_INTERNAL_SERVER")
		      (501 . "ERR_DB_SERVER")
		      (510 . "ERR_FILE_OPERATION")
		      (520 . "ERR_MEMORY_ALLOC")
		      (600 . "ERR_SERVER_BUSY")
		      (601 . "ERR_SERVER_UNAVAILABLE")
		      (602 . "ERR_PEER_NS_DOWN")
		      (603 . "ERR_DB_CONNECT")
		      (604 . "ERR_SERVER_GOING_DOWN")
		      (707 . "ERR_CREATE_CONNECTION")
		      (711 . "ERR_BLOCKING_WRITE")
		      (712 . "ERR_SESSION_OVERLOAD")
		      (713 . "ERR_USER_TOO_ACTIVE")
		      (714 . "ERR_TOO_MANY_SESSIONS")
		      (715 . "ERR_NOT_EXPECTED")
		      (717 . "ERR_BAD_FRIEND_FILE")
		      (911 . "ERR_AUTHENTICATION_FAILED")
		      (913 . "ERR_NOT_ALLOWED_WHEN_OFFLINE")
		      (920 . "ERR_NOT_ACCEPTING_NEW_USERS")))
       (msg (cdr (assoc (string-to-int (car (split-string string " ")))
			error-table))))
  (message msg)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                             Filter Functions                             ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun msn-dispatch-filter (proc string)
(let ((old-buffer (current-buffer)) (finalize nil)
      (cmd (substring string 0 3)))
  (save-excursion
    (set-buffer (process-buffer proc))
    (msn-record-sever-message string)
    (cond
     ((string-equal "VER" cmd)
      (setq finalize
	    (lambda ()
	      (msn-proc-send proc "INF" "\n"))))
     ((string-equal "INF" cmd)
      (setq finalize
	    (lambda ()
	      (let ((mail (msn-get-user 'mail)))
		(msn-proc-send proc "USR" (concat "MD5 I " mail "\n"))))))
     ((string-equal "XFR" cmd) (msn-xfr string))
     ((string-match "^[0-9][0-9][0-9]" string) (msn-error string)))
    (when finalize (funcall finalize)))))

(defun msn-notification-filter (proc string)
(let ((old-buffer (current-buffer)) (finalize nil))
  (save-excursion
    (set-buffer (process-buffer proc))
    (msn-record-sever-message string)
    (dolist (string (msn-server-message-parse string))
      (let ((cmd (substring string 0 3)))
	(cond
	 ;; for notification
	 ((string-equal "CHL" cmd) (msn-challenge-auth proc string))
	 ((string-equal "USR" cmd) (msn-notification-usr proc string))
	 ((string-equal "GTC" cmd) (setq finalize (lambda () (msn-draw-info))))
	 ((string-equal "SYN" cmd)
	  (setq *msn-sync-id* (string-to-int (nth 2 (split-string string " "))))
	  (setq finalize (lambda () (msn-draw-info))))
	 ((string-equal "LST" cmd) (msn-lst string))
	 ((string-equal "ILN" cmd)
	  (let* ((lst (split-string string "[ \n]"))
		 (stat (nth 2 lst))
		 (mail (nth 3 lst))
		 (name (nth 4 lst)))
	    (msn-set-contact-list mail stat name)
	    (setq finalize (lambda () (msn-draw-info)))))
	 ((string-equal "FLN" cmd)
	  (let* ((lst (split-string string "[ \n]"))
		 (stat "FLN")
		 (mail (nth 1 lst))
		 (name (msn-get-contact-list 'FL mail 'name)))
	    (msn-set-contact-list mail stat name)
	    (setq finalize (lambda () (msn-draw-info)))))
	 ((string-equal "NLN" cmd)
	  (let* ((lst (split-string string "[ \n]"))
		 (stat (nth 1 lst))
		 (mail (nth 2 lst))
		 (name (nth 3 lst)))
	    (msn-set-contact-list mail stat name)
	    (setq finalize (lambda () (msn-draw-info)))))
	 ((string-equal "MSG" cmd) (msn-parse-notification-message proc string))
	 ((string-equal "REA" cmd)
	  (let* ((lst (split-string string "[ \n]"))
		 (mail (nth 3 lst))
		 (name (msn-url-decode-string (nth 4 lst))))
	    (msn-set-user 'name name)
	    (setq finalize (lambda () (msn-draw-info)))))
	 ((string-equal "CHG" cmd)
	  (let* ((lst (split-string string "[ \n]"))
		 (stat (nth 2 lst)))
	    ;; set timer
	    (when (and (string-equal stat "NLN") (null *msn-idle-timer*))
	      (setq *msn-idle-timer*
		    (run-with-idle-timer (* 60 5) nil
					 (lambda ()
					   (when (msn-open-p 'notification)
					     (msn-proc-send (msn-get-process 'notification) "CHG" "IDL\n")
					     (setq *msn-idle-timer* nil))))))
	    (msn-set-user 'stat stat)
	    (setq finalize (lambda () (msn-draw-info)))))
	 ;; for login
	 ((string-equal "VER" cmd)
	  (setq finalize
		(lambda ()
		  (msn-proc-send proc "INF" "\n"))))
	 ((string-equal "INF" cmd)
	  (setq finalize
		(lambda ()
		  (msn-proc-send proc "USR" (concat "MD5 I " (msn-get-user 'mail) "\n")))))
	 ((string-equal "RNG" cmd) (msn-rng string))
	 ((string-equal "XFR" cmd) (msn-xfr string))
	 ((string-match "^[0-9][0-9][0-9]" string) (msn-error string))))
      (when finalize (funcall finalize))))))

(defun msn-switchboard-filter (proc string)
(let ((old-buffer (current-buffer)) (finalize nil))
  (save-excursion
    (set-buffer (process-buffer proc))
    (msn-record-sever-message string)
    (let* ((name (buffer-name (process-buffer proc)))
	   (ret (string-match "\\[\\([0-9]+\\)\\]" name))
	   (session (string-to-int (substring name (match-beginning 1) (match-end 1)))))
      (dolist (string (msn-server-message-parse string))
	(let ((cmd (substring string 0 3)))
	  (cond
	   ;; for notification
	   ((string-equal "MSG" cmd)
	    (when (not (get-buffer-window-list (msn-get-session-buffer session)))
	      (run-hooks 'msn-background-message-notify-hook))
	    (msn-show-message session string))
	   ((string-equal "CHL" cmd) (msn-challenge-auth proc string))
	   ((string-equal "IRO" cmd)
	    (let* ((lst (split-string string "[ \n]"))
		   (mail (nth 4 lst))
		   (name (msn-url-decode-string (nth 5 lst))))
	      (when (null (member mail *msn-session-users*))
		(setq *msn-session-users*
		      (cons (cons mail name) *msn-session-users*)))
	      (msn-show-command session (concat name " が参加しました．"))
	      (setq finalize (lambda () (msn-draw-info)))))
	   ((string-equal "JOI" cmd)
	    (let* ((lst (split-string string "[ \n]"))
		   (mail (nth 1 lst))
		   (name (nth 2 lst)))
	      (when (null (member mail *msn-session-users*))
		(setq *msn-session-users*
		      (cons (cons mail name) *msn-session-users*)))
	      (msn-show-command session (concat name " が参加しました．"))
	      (setq finalize (lambda () (msn-draw-info)))))
	   ((string-equal "BYE" cmd)
	    (let* ((lst (split-string string "[ \n]"))
		   (mail (nth 1 lst))
		   (name (cdr (assoc mail *msn-session-users*))))
	      (when (assoc mail *msn-session-users*)
		(setq *msn-session-users*
		      (delete (assoc mail *msn-session-users*) *msn-session-users*)))
	      (msn-show-command session (concat "さよなら " name " ..."))
	      (setq finalize (lambda () (msn-draw-info)))))
	   ((string-equal "OUT" cmd)
	    (let* ((lst (split-string string "[ \n]"))
		   (stat (nth 2 lst)))
	      (setq finalize (lambda () (msn-draw-info)))))
	   ((string-match "^[0-9][0-9][0-9]" string) (msn-error string))))
	(when finalize (funcall finalize)))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                               MD5 Digest                                 ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; reference: rfc1321 The MD5 Message-Digest Algorithm

;; caluculate T  with CMUCL 1.8d
;;(do* ((i 0 (+ i 1.0d0))
;;      (s (* 4294967296 (abs (sin i))) (* 4294967296 (abs (sin i))))
;;      (r (floor s) (floor s))
;;      (ret
;;       (cons (cons (floor (/ r 65536)) (floor (logand r 65535))) nil)
;;       (cons (cons (floor (/ r 65536)) (floor (logand r 65535))) ret)))
;;    ((>= i 64.0d0) (nreverse ret)))
;; ((0 . 0)
;;  (55146 . 42104) (59591 . 46934) (9248 . 28891) (49597 . 52974)
;;  (62844 . 4015) (18311 . 50730) (43056 . 17939) (64838 . 38145)
;;  (27008 . 39128) (35652 . 63407) (65535 . 23473) (35164 . 55230)
;;  (27536 . 4386) (64920 . 29075) (42617 . 17294) (18868 . 2081)
;;  (63006 . 9570) (49216 . 45888) (9822 . 23121) (59830 . 51114)
;;  (54831 . 4189) (580 . 5203) (55457 . 59009) (59347 . 64456)
;;  (8673 . 52710) (49975 . 2006) (62677 . 3463) (17754 . 5357)
;;  (43491 . 59653) (64751 . 41976) (26479 . 729) (36138 . 19594)
;;  (65530 . 14658) (34673 . 63105) (28061 . 24866) (64997 . 14348)
;;  (42174 . 59972) (19422 . 53161) (63163 . 19296) (48831 . 48240)
;;  (10395 . 32454) (60065 . 10234) (54511 . 12421) (1160 . 7429)
;;  (55764 . 53305) (59099 . 39397) (8098 . 31992) (50348 . 22117)
;;  (62505 . 8772) (17194 . 65431) (43924 . 9127) (64659 . 41017)
;;  (25947 . 22979) (36620 . 52370) (65519 . 62589) (34180 . 24017)
;;  (28584 . 32335) (65068 . 59104) (41729 . 17172) (19976 . 4513)
;;  (63315 . 32386) (48442 . 62005) (10967 . 53947) (60294 . 54161))
(defconst msn-md5-T
[(0 . 0)
 (55146 . 42104) (59591 . 46934) ( 9248 . 28891) (49597 . 52974)
 (62844 .  4015) (18311 . 50730) (43056 . 17939) (64838 . 38145)
 (27008 . 39128) (35652 . 63407) (65535 . 23473) (35164 . 55230)
 (27536 .  4386) (64920 . 29075) (42617 . 17294) (18868 .  2081)
 (63006 .  9570) (49216 . 45888) ( 9822 . 23121) (59830 . 51114)
 (54831 .  4189) (  580 .  5203) (55457 . 59009) (59347 . 64456)
 ( 8673 . 52710) (49975 .  2006) (62677 .  3463) (17754 .  5357)
 (43491 . 59653) (64751 . 41976) (26479 .   729) (36138 . 19594)
 (65530 . 14658) (34673 . 63105) (28061 . 24866) (64997 . 14348)
 (42174 . 59972) (19422 . 53161) (63163 . 19296) (48831 . 48240)
 (10395 . 32454) (60065 . 10234) (54511 . 12421) ( 1160 .  7429)
 (55764 . 53305) (59099 . 39397) ( 8098 . 31992) (50348 . 22117)
 (62505 .  8772) (17194 . 65431) (43924 .  9127) (64659 . 41017)
 (25947 . 22979) (36620 . 52370) (65519 . 62589) (34180 . 24017)
 (28584 . 32335) (65068 . 59104) (41729 . 17172) (19976 .  4513)
 (63315 . 32386) (48442 . 62005) (10967 . 53947) (60294 . 54161)])

;; initial state
(defconst msn-md5-initial-buffer [(26437 . 8961) (61389 . 43913) (39098 . 56574) (4146 . 21622)])

;; F(X,Y,Z) = XY v not(X) Z
;; G(X,Y,Z) = XZ v Y not(Z)
;; H(X,Y,Z) = X xor Y xor Z
;; I(X,Y,Z) = Y xor (X v not(Z))
(defun msn-md5-F (X Y Z)
(let ((xh (car X)) (xl (cdr X))
      (yh (car Y)) (yl (cdr Y))
      (zh (car Z)) (zl (cdr Z)))
  (cons (logand (logior (logand xh yh) (logand (lognot xh) zh)) 65535)
	(logand (logior (logand xl yl) (logand (lognot xl) zl)) 65535))))

(defun msn-md5-G (X Y Z)
(let ((xh (car X)) (xl (cdr X))
      (yh (car Y)) (yl (cdr Y))
      (zh (car Z)) (zl (cdr Z)))
  (cons (logand (logior (logand xh zh) (logand yh (lognot zh))) 65535)
	(logand (logior (logand xl zl) (logand yl (lognot zl))) 65535))))

(defun msn-md5-H (X Y Z)
(let ((xh (car X)) (xl (cdr X))
      (yh (car Y)) (yl (cdr Y))
      (zh (car Z)) (zl (cdr Z)))
  (cons (logand (logxor xh yh zh) 65535)
	(logand (logxor xl yl zl) 65535))))

(defun msn-md5-I (X Y Z)
(let ((xh (car X)) (xl (cdr X))
      (yh (car Y)) (yl (cdr Y))
      (zh (car Z)) (zl (cdr Z)))
  (cons (logand (logxor yh (logior xh (lognot zh))) 65535)
	(logand (logxor yl (logior xl (lognot zl))) 65535))))

;; add & shift
(defun msn-md5-add (&rest n)
(let ((high 0) (low 0))
  (mapcar (lambda (e) (setq high (+ high (car e))) (setq low (+ low (cdr e)))) n)
  (cons (logand (+ high (lsh low -16)) 65535)
	(logand low 65535))))

(defun msn-md5-shift (n s)
(let ((high (if (<= s 15) (car n) (cdr n)))
      (low (if (<= s 15) (cdr n) (car n)))
      (shift (if (<= s 15) s (- s 16))))
  (cons (logand (logior (lsh high shift) (lsh low (- shift 16))) 65535)
	(logand (logior (lsh low shift) (lsh high (- shift 16))) 65535))))

(defun msn-md5-round1 (a b c d k s i X T)
(msn-md5-add b (msn-md5-shift (msn-md5-add a (msn-md5-F b c d) (aref X k) (aref T i)) s)))

(defun msn-md5-round2 (a b c d k s i X T)
(msn-md5-add b (msn-md5-shift (msn-md5-add a (msn-md5-G b c d) (aref X k) (aref T i)) s)))

(defun msn-md5-round3 (a b c d k s i X T)
(msn-md5-add b (msn-md5-shift (msn-md5-add a (msn-md5-H b c d) (aref X k) (aref T i)) s)))

(defun msn-md5-round4 (a b c d k s i X T)
(msn-md5-add b (msn-md5-shift (msn-md5-add a (msn-md5-I b c d) (aref X k) (aref T i)) s)))


(defun msn-md5-calc (buf str i)
(let* ((offset (* i 64))
       (X (do ((v (make-vector 16 0))
	       (i 0 (+ i 1))
	       (j 0 (+ j 4)))
	      ((>= i 16) v)
	    (aset v i
		  (cons (+ (* (aref str (+ offset j 3)) 256) (aref str (+ offset j 2)))
			(+ (* (aref str (+ offset j 1)) 256) (aref str (+ offset j)))))))
       (T msn-md5-T)
       (A (aref buf 0)) (AA A)
       (B (aref buf 1)) (BB B)
       (C (aref buf 2)) (CC C)
       (D (aref buf 3)) (DD D))
  ;; round1
  (setq A (msn-md5-round1 A B C D  0  7  1 X T))
  (setq D (msn-md5-round1 D A B C  1 12  2 X T))
  (setq C (msn-md5-round1 C D A B  2 17  3 X T))
  (setq B (msn-md5-round1 B C D A  3 22  4 X T))
  (setq A (msn-md5-round1 A B C D  4  7  5 X T))
  (setq D (msn-md5-round1 D A B C  5 12  6 X T))
  (setq C (msn-md5-round1 C D A B  6 17  7 X T))
  (setq B (msn-md5-round1 B C D A  7 22  8 X T))
  (setq A (msn-md5-round1 A B C D  8  7  9 X T))
  (setq D (msn-md5-round1 D A B C  9 12 10 X T))
  (setq C (msn-md5-round1 C D A B 10 17 11 X T))
  (setq B (msn-md5-round1 B C D A 11 22 12 X T))
  (setq A (msn-md5-round1 A B C D 12  7 13 X T))
  (setq D (msn-md5-round1 D A B C 13 12 14 X T))
  (setq C (msn-md5-round1 C D A B 14 17 15 X T))
  (setq B (msn-md5-round1 B C D A 15 22 16 X T))
  ;; round2
  (setq A (msn-md5-round2 A B C D  1  5 17 X T))
  (setq D (msn-md5-round2 D A B C  6  9 18 X T))
  (setq C (msn-md5-round2 C D A B 11 14 19 X T))
  (setq B (msn-md5-round2 B C D A  0 20 20 X T))
  (setq A (msn-md5-round2 A B C D  5  5 21 X T))
  (setq D (msn-md5-round2 D A B C 10  9 22 X T))
  (setq C (msn-md5-round2 C D A B 15 14 23 X T))
  (setq B (msn-md5-round2 B C D A  4 20 24 X T))
  (setq A (msn-md5-round2 A B C D  9  5 25 X T))
  (setq D (msn-md5-round2 D A B C 14  9 26 X T))
  (setq C (msn-md5-round2 C D A B  3 14 27 X T))
  (setq B (msn-md5-round2 B C D A  8 20 28 X T))
  (setq A (msn-md5-round2 A B C D 13  5 29 X T))
  (setq D (msn-md5-round2 D A B C  2  9 30 X T))
  (setq C (msn-md5-round2 C D A B  7 14 31 X T))
  (setq B (msn-md5-round2 B C D A 12 20 32 X T))
  ;; round3
  (setq A (msn-md5-round3 A B C D  5  4 33 X T))
  (setq D (msn-md5-round3 D A B C  8 11 34 X T))
  (setq C (msn-md5-round3 C D A B 11 16 35 X T))
  (setq B (msn-md5-round3 B C D A 14 23 36 X T))
  (setq A (msn-md5-round3 A B C D  1  4 37 X T))
  (setq D (msn-md5-round3 D A B C  4 11 38 X T))
  (setq C (msn-md5-round3 C D A B  7 16 39 X T))
  (setq B (msn-md5-round3 B C D A 10 23 40 X T))
  (setq A (msn-md5-round3 A B C D 13  4 41 X T))
  (setq D (msn-md5-round3 D A B C  0 11 42 X T))
  (setq C (msn-md5-round3 C D A B  3 16 43 X T))
  (setq B (msn-md5-round3 B C D A  6 23 44 X T))
  (setq A (msn-md5-round3 A B C D  9  4 45 X T))
  (setq D (msn-md5-round3 D A B C 12 11 46 X T))
  (setq C (msn-md5-round3 C D A B 15 16 47 X T))
  (setq B (msn-md5-round3 B C D A  2 23 48 X T))
  ;; round4
  (setq A (msn-md5-round4 A B C D  0  6 49 X T))
  (setq D (msn-md5-round4 D A B C  7 10 50 X T))
  (setq C (msn-md5-round4 C D A B 14 15 51 X T))
  (setq B (msn-md5-round4 B C D A  5 21 52 X T))
  (setq A (msn-md5-round4 A B C D 12  6 53 X T))
  (setq D (msn-md5-round4 D A B C  3 10 54 X T))
  (setq C (msn-md5-round4 C D A B 10 15 55 X T))
  (setq B (msn-md5-round4 B C D A  1 21 56 X T))
  (setq A (msn-md5-round4 A B C D  8  6 57 X T))
  (setq D (msn-md5-round4 D A B C 15 10 58 X T))
  (setq C (msn-md5-round4 C D A B  6 15 59 X T))
  (setq B (msn-md5-round4 B C D A 13 21 60 X T))
  (setq A (msn-md5-round4 A B C D  4  6 61 X T))
  (setq D (msn-md5-round4 D A B C 11 10 62 X T))
  (setq C (msn-md5-round4 C D A B  2 15 63 X T))
  (setq B (msn-md5-round4 B C D A  9 21 64 X T))
  ;; last
  (aset buf 0 (msn-md5-add A AA))
  (aset buf 1 (msn-md5-add B BB))
  (aset buf 2 (msn-md5-add C CC))
  (aset buf 3 (msn-md5-add D DD))
  buf))

(defun msn-md5 (str)
(let* ((buf (copy-sequence msn-md5-initial-buffer))
       (len (length str))
       (bits (* len 8))
       (n (/ len 64))
       (r (% len 64))
       (padding (- 64 r))
       ;; padding: 64 + (64-56) - 1 = 71 byte
       (str (concat str (when (> padding 0) (concat "\200" (make-string 71 0)))))
       (n (if (<= r 56) n (+ n 1)))
       ;; 8 (64-56) byte for size infomation ... 
       (buf (do* ((tmp (progn
			 ;; X-p
			 (aset str (+ (* n 64) 56) (% bits 256))
			 (aset str (+ (* n 64) 57) (/ bits 256))))
		  (i 0 (+ i 1))
		  (buf (msn-md5-calc buf str i) (msn-md5-calc buf str i)))
		((>= i n) buf)))
       (ah (car (aref buf 0))) (al (cdr (aref buf 0)))
       (bh (car (aref buf 1))) (bl (cdr (aref buf 1)))
       (ch (car (aref buf 2))) (cl (cdr (aref buf 2)))
       (dh (car (aref buf 3))) (dl (cdr (aref buf 3))))
  (format "%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x"
	  (% al 256) (/ al 256) (% ah 256) (/ ah 256)
	  (% bl 256) (/ bl 256) (% bh 256) (/ bh 256)
	  (% cl 256) (/ cl 256) (% ch 256) (/ ch 256)
	  (% dl 256) (/ dl 256) (% dh 256) (/ dh 256))))

(defun msn-md5-digest (string)
(if (fboundp 'md5)
    (md5 string nil nil 'utf-8-dos)
  (msn-md5 (encode-coding-string string 'utf-8-dos))))

(provide 'messenger)
(run-hooks 'msn-load-hook)

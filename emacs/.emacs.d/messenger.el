;; messenger.el --- MSN Messenger on Emacs

;; Copyright (C) 2002 ctlaltdel <ctlaltdel@geocities.co.jp>

;; Author: ctlaltdel <ctlaltdel@geocities.co.jp>, ���� <lambda_list@hotmail.com>

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


;; [�ǿ���]
;;	elisp �ˤ�� MSN Messenger �μ����Ǥ�������ˤʤ�и�Τ���ͤ���
;;	�ȤäƤ����������ǿ��Ǥ�
;;	<http://www.geocities.co.jp/SiliconValley-SanJose/7474/>
;;	<http://members.tripod.co.jp/lambda_list/EmacsMessenger.html>
;;	��������Ǥ��ޤ���������Ʊ�����Ƥ�櫓�ǤϤʤ��Τǡ�Ŭ���˿���������
;;	�ȤäƤ���������

;; [ư���ɬ�פʤ��]
;;	GNU Emacs21.2 + Mule-UCS 0.84��¿ʬ��
;;	��������Mule-UCS 0.84 �� Emacs21.2 ���Ȥ߹�碌�ƤĤ����Ȥ��Τޤ�
;;	�Ǥϥ�����٤��Τ�
;;	  <http://tsukuba.m17n.org/mule-archive/2002-3/msg00000.html>
;;	�Υѥå������ƤƻȤäƲ�������
;;	ư���ǧ���줿�Ķ���
;;
;;	- FreeBSD 4.7 RELEASE + Emacs21.2 + Mule-UCS 0.84
;;	- WindowsXP Professional (SP1) + Emacs21.2 + Mule-UCS 0.84
;;	- XEmacs21
;;	- Emacs21 + mule-ucs on Debian(unstable)
;;	- Meadow1.15 + Mule-UCS 0.84
;;
;;	�Ǥ���¾�ˤ⤢�ä��� lambda_list@hotmail.com �ޤ�Ϣ����������
;;	�ե�������������ǽ��Ȥ����Ϥ���� msnftp ���ޥ�ɤ�ɬ�פǤ���
;;	<http://www.geocities.co.jp/SiliconValley-SanJose/7474/>
;;	���� msnftp.c �����ꤷ�� msnftp ���ޥ�ɤ�������Ƥ���������
;;	�ƥ��Ȥ���Ƥ���Τ� FreeBSD 4.7 RELEASE �Τߡ�����ѥ��뤬
;;	�̤������ǧ����Ƥ���Τ�
;;      - FreeBSD 4.7 RELEASE
;;      - WindowsXP Professional + mingw
;;	�Ǥ�������ѥ���Ǥ����顤�Ȥꤢ�������󥽡��뤫�� msnftp ��
;;	�ե�����ž���Ǥ�������ǧ���Ƥ���������

;; [Ƚ�����Ƥ����Զ��]
;; - (encode-coding-system "\n" 'utf-8-dos) -> "^M^M\n"
;;   (encode-coding-system "\n" 'utf-8) -> "\n"
;;   �Ȥʤ�Ķ����б��Ǥ��ʤ��������󡤤ʤ󤸤㤳��㡩
;;   �������θ��ݤ���ǧ����Ƥ���Τ� Meadow1.99alpha �� Emacs21.1.2
;;   �����Ǥ�����¾�ˤ⤢�뤫�⡥
;; - ��å������ϷҤ��äƤ�����⤢��Τǡ�����������˥ѡ������Ƥޤ���
;;   ����������ȴ���ˤ����ʸ��� MSG hoge@hotmail.com hoge 19\n  �ߤ�����
;;   ʸ���󤬤��ä��餪�������ʤ뤫�⡥���ξ��� msn-show-message �������Ǥ���

;; [�Ȥ���]
;; 	.emacs ���
;; 	(load "messenger.el")
;; 	���뤤�ϡ�load-path ���̤ä��ǥ��쥯�ȥ�� messenger.el �������
;; 	(require 'messenger)
;; 	��񤤤Ƥ��������Ȥϡ�M-x msn-mode �Ǥ�����
;;	�����󤬴�λ������
;;	 C-cC-o NLN  <- ���ơ������򥪥�饤���
;;	 C-cC-n      <- ���å��������
;;	 C-cC-t      <- ���å�����������ֹ�����֡�
;;	 C-cC-r      <- ���ߤΥ��å�����ï����Ƥ�
;;	 C-cC-c      <- [����] �ե�����ɤΥ�å�����������
;;	 C-cC-q      <- Messenger ��Ϣ�ΥХåե��򤹤٤ƾõ�ƽ�λ
;;	                ������¸����ʤ��Τ���ա�
;;	 msn-rename  <- ̾�����ѹ�
;;	 C-cC-s      <- ���󥿥��ȥꥹ�Ȥ�Ʊ��
;;	 msn-receive-file <- �ե�����μ���
;;	����ʤΤɤ��Ǥ��礦��
;;	 C-cC-v      <- ���å����������session: �ιԤ������֡�
;;	 mouse-1     <- ���å����������session: �ιԤ������֡�

;; [����]
;; Revision 0.0.1.1  2002/11/14
;; * url-decode/encode ������Ⱦü���б������ܸ�ʸ���ޤ�{de/en}code�ġ�
;; Revision 0.0.1.0  2002/11/14
;; * ���󥿥��ȥꥹ�Ȥ�ɽ���� face �����ꤷ�Ƥߤ���
;; * ���å��������˥ޥ�����ȤäƤߤ���
;; * MSNFTP ���ޥ�ɤ����Ǥ����Ƥ��Τ���
;; Revision 0.0.0.9  2002/11/13
;; * ...@hotmail.com �ʳ��οͤ���Ȥ��������Τä��Τǽ�����
;; Revision 0.0.0.8  2002/11/11
;; * ���������Τ� RFC 1321 �򸫤ʤ��� MD5 ������������ Meadow 1.15 ���
;; * md5 �ؿ���̵���Ķ���Meadow 1.15�˸����˳����ץ����Ȥ��� md5 ��Ƥ��
;;   �׻����Ƥ�餦���ˤ����ĤȻפä����ɡ�Windows �ä� md5 ���äƤ��ä���
;;   �Ҥ�äȤ��ư�̵̣����
;; * �����ץ�����ߤΥե����������ǽ�������
;;   msnftp.c �򥳥�ѥ��뤷�� msnftp ���ޥ�ɤ��äơ������Ĥ˥ѥ����̤�
;;   �Ȥ������ݤʺ�Ȥ��Ѥ���м����Ǥ��ޤ����Ķ��� FreeBSD 4.7 RELEASE��
;; * (require 'cl) ���ɲá�copy-tree ��ɬ�פ��ä��ġ�
;; Revision 0.0.0.7  2002/11/08
;; * �饤���󥹤� GPL ��
;; Revision 0.0.0.6  2002/11/08
;; * MSNFTP �μ�����Ĥ��꤫���� Emacs ���֥�å������㤦�Τϥޥ����Τ�
;;   ��ä� elisp �ΤߤǤ�̵�����ʤ��İܿ����Τ�����ˡ�Ϥʤ������ʤ��
;;   ��뵤����������
;; * msn-connect �����Ȥ��������Υ��󥿥��ȥꥹ�Ȥ��Ĥä���äƤ��Τ���
;; Revision 0.0.0.5  2002/11/08
;; * 5 ʬ�� Emacs �����ʤ��ä��� IDL ���֤ˤ���褦�ˤ��Ƥߤ�
;; * msn-sync �������˼�ưŪ�˲��̤�񤭴�����褦�ˤ���
;; * �ѿ����ؿ�̾�� prefix �Ȥ��� msn- ���դ��Ƥߤ��������¾�� elisp ��
;;   Ʊ���˻ȤäƤ�ʤ���äȡ˰¿�
;; * ������ѿ����� queue ���Ի��Ѥˡ������ (require 'cl) ���פˤʤä���
;; Revision 0.0.0.4  2002/11/07
;; * �ѥ���ɤϻȤä���®���ä��褦�ˤ��Ƥߤ���
;; * msn-sync ������Ⱦü�˼¹ԤǤ���褦�ˤʤä������������̤ν񴹤���
;;   ��ư�ǤϤ��ʤ��Τǡ�����äȴ֤��֤��� C-cC-o NLN �ȤǤ��äƤߤ�
;; * md5 ��ʸ�������ɤ� 806 ����ν������ѹ�
;; * hook ��������Ƥߤ���.emacs �ˤǤ�
;;   (add-hook 'msn-switchboard-message-hook
;;	  (lambda ()
;;	    (let ((visible-bell nil))
;;	      (beep))))
;;   �Ȥ����Ȥ��ХХåե������򤵤�Ƥʤ��Ȥ��˥�å�����������
;;   �ӡ��ײ����Ĥ�ޤ���¿���������Τǡ�ɸ��Ǥϲ���ʤ���
;; Revision 0.0.0.3  2002/11/07
;; * Emacs21 + MuleUCS (Debian) �Ǥ�
;;   Wrong type argument: symbolp, (msn-get-queue *dispatch*)
;;   �Ȥʤ�Τ������Ĥ������褷�Ƥ��餷������¸�ط�����ߤ��ä�����
;; * �����С�����Υ�å������˻��֤�ɽ������褦�ˤ��Ƥߤ���
;; * �ѥ���ɤ��������Ƥ� 911 ��ǧ�ڼ��ԥ��顼���Ǥ���ͳ��Ƚ��
;;   ʸ����� coding-system �ˤ�� md5 ���ͤ��㤦�Τ��������ä���
;;   encode-coding-string ���Ƥ����ˤ�ꡤ���ʡ��ˡ������餯
;;   *-coding-system �Τɤ줫��̤����ξ��ˤ��줬����Ȥʤ�Τ�����
;; * ��������, 797 �����Ŧ�Υߥ�������
;; * ��¸�ط��� cl ������˺��Ƥ��Τ���
;; * ����Ȥ��ȤäƤʤ��ѿ�����
;; Revision 0.0.0.2  2002/11/06
;; * ���顼��ɽ������褦�ˤ��Ƥߤ���
;; * msn-add ���Ȥ��ʤ��ä��Τ���
;; * ��å�������� \n\n ��̵���ʤä��㤦�Τ���
;; * �����äѤ꽤��
;; * MSG ���Ҥ��äƤ��ޤäƤ�������б��ʤ���������å������˲��Τ����줢���
;; * save-selected-window �Ȥ����פ�̿�����
;; * ��������ȡ��ѥ���ɤ� nil �λ��ϵ�ư����ʹ�����Ȥˤ��Ƥߤ�
;; * msn-select-session ���ߥ˥Хåե���Ǥκ����˥�å��������ꤳ�ܤ��Τ���
;; Revision 0.0.0.1  2002/11/04
;; * elisp �Τߤǽ�ľ����

;; [Todo]
;; * ʸ�������ɤ���ߤ��Զ���Ĵ��������
;; * ��������å��������忮������,mode-line�ˤ��λݤ������뵡ǽ���ߤ���
;; * ���ƥ��ȥ��ꥢ(ï˿��ONLINE�ˤʤ�ޤ����Ȥ��Υ��ꥢ)����ʤ˸���.
;;   ���ƥ��Ȥ�����������ɽ�������ߤ���.
;; * ���å��ꥢ�ˤ�̾���ιԤϥϥ��饤�Ȥ�����.
;; * ���äϲ��ÿ���ʬ����,bufferʬ�䤷���ߤ���(C-x 2 �ߤ����ʴ�����)
;; * C-c n �� C-c t �� C-c r �ǤϤʤ���,C-c r �Τߤǲ��ó��Ͻ���������ڤǤ�?
;; * ���󥿥��ȥꥹ�ȥ��ꥢ��ɽ���������Ƥˤ�ä�,��ưŪ���礭�����Ѥ����ߤ���
;; * ���󥿥��ȥꥹ�ȼ��꤬���뤤��������������ͤ��Ϥʤ���
;; * ���å�����ֹ��Ȥ��ޤ路���ۤ����������ʤ���
;; * ���󥿡��ե������β����ʤȤꤢ�������å������˿��դ��Ȥ���

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                   ��¸�ѥå�������UTF-8 �Ȥ��Τǡ�                       ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(when (not (featurep 'meadow))
  (require 'un-define)
  (require 'un-tools))
(require 'cl)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                          ��������̤����ס�                              ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defvar *msn-user-account* '((mail . nil)
			     (pass . nil)
			     (name . "")
			     (stat . "FLN")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                       �����̤ϡ���������                                 ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defvar *msn-version* "MSN Messenger on Emacs version 0.0.1.1")
(defvar *msn-current-session* nil)
(defvar *msn-contact-list* '((FL . ())
			     (RL . ())
			     (AL . ())
			     (BL . ())))
(defvar *msn-mode-map* (make-keymap))
(defvar *msn-buffer* "MSN Messenger")

(defvar *msn-experimental* t "�¸��Ѥε�ǽ�ʤ����������ͭ���")
(defvar *msn-output-log* nil)

(defvar *msn-dispatch* nil)
(defvar *msn-dispatch-buffer* " Dispatch")
(defvar *msn-notification* nil)
(defvar *msn-notification-buffer* " Notification")
(defvar *msn-switchboards* nil)

(defvar *msn-id* nil)
(defvar *msn-switchboard-id* nil)
(defvar *msn-id-and-address* nil)

(defvar *msn-sync-fragment* nil)

(defvar msn-load-hook nil)
(defvar msn-connect-hook nil)
(defvar msn-switchboard-message-hook nil)

(defvar *msn-time-format* " %H:%M:%S")
(defvar *msn-idle-timer* nil)

(defvar *msn-received-file-directory* "~/tmp")
(defvar *msnftp-command* "msnftp")
(defvar *msnftp* nil)
;;(defvar *msnftp-auth* nil)
(defvar *msn-receiving-file* nil)
(defvar *msn-receive-file* nil)

(defvar *msn-sending-file* nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                        �桼����������Ϣ                                ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun msn-mode-init ()
  (define-key *msn-mode-map* "\C-c\C-q" 'msn-exit)
  (define-key *msn-mode-map* "\C-c\C-c" 'msn-send-message)
  (define-key *msn-mode-map* "\C-c\C-o" 'msn-change-status)
  (define-key *msn-mode-map* "\C-c\C-s" 'msn-sync)
  (define-key *msn-mode-map* "\C-c\C-t" 'msn-select-session)
  (define-key *msn-mode-map* "\C-c\C-v" 'msn-select-session-with-current-word)
  (define-key *msn-mode-map* [mouse-1] 'msn-select-session-with-current-word)
  (define-key *msn-mode-map* "\C-c\C-n" 'msn-create-new-session)
  (define-key *msn-mode-map* "\C-c\C-w" 'msn-close-session)
  (define-key *msn-mode-map* "\C-c\C-r" 'msn-ring)
  ;;(define-key *msn-mode-map* "\C-c\C-v" 'msn-version)
  (msn-connect)
  (when (not (one-window-p)) (delete-other-windows))
  (msn-initialize-screen)
  (use-local-map *msn-mode-map*)
  (msn-version))

(defun msn-mode ()
  "MSN Messenger Mode"
  (interactive)
  (msn-mode-init)
  (setq major-mode 'msn-mode)
  (setq mode-name "MSN Messenger Mode"))

(defun msn-version ()
  (interactive)
  (message *msn-version*))

(defun msn-exit ()
  (interactive)
  (when (and *msn-notification*
	     (eq (process-status *msn-notification*) 'open))
    (process-send-string *msn-notification* "OUT\n")
    (setq *msn-dispatch* nil
	  *msn-notification* nil
	  *msn-switchboards* nil))
  (let* ((lst nil))
    (delete-other-windows)
    (dolist (e (buffer-list))
      (when (string-match (concat "\\("
				  "^" *msn-buffer* "$\\|"
				  "^" *msn-dispatch-buffer* "$\\|"
				  "^" *msn-notification-buffer* "$\\|"
				  "Switchboard \\[[0-9]+\\]\\)")
			  (buffer-name e))
	(setq lst (cons e lst))))
    (dolist (b lst)
      (set-buffer b)
      (set-buffer-modified-p nil)
      (kill-buffer b))))

(defun msn-send-message ()
  (interactive)
  (if (null *msn-current-session*)
      (message "���å���������Ǥ�������!!")
    (let ((session (cdr (assoc (string-to-int *msn-current-session*) *msn-switchboards*)))
	  message)
      (when (and session
		 (eq (process-status session) 'open))
	(msn-redraw nil
		    (lambda ()
		      (let* ((inhibit-read-only t)
			     (body (buffer-substring-no-properties (point-min) (point-max)))
			     (head "MIME-Version: 1.0\nContent-Type: text/plain; charset=UTF-8\nX-MMS-IM-Format: FN=MS%20UI%20Gothic; EF=; CO=0; CS=80; PF=0\n\n")
			     (msg (concat head body))
			     (size (int-to-string (length (encode-coding-string msg 'utf-8-dos))))
			     (msg (concat (make-command "MSG %s U ") size "\n" msg)))
			(process-send-string session msg)
			(delete-region (point-min) (point-max))
			(setq offset nil) ;; ���ե��åȤ����פˤʤ��
			(set-buffer-modified-p nil)
			(setq message msg)))
		    nil)
	(msn-show-message *msn-current-session* message)))))

(defun msn-change-status ()
  (interactive)
  (when (and *msn-notification*
	     (eq (process-status *msn-notification*) 'open))
    (let* ((stat-list '(("NLN") ("BSY") ("IDL") ("BRB") ("AWY") ("PHN") ("LUN") ("FLN")))
	   (completion-ignore-case nil)
	   (stat (completing-read "Status?: " stat-list nil t "NLN")))
      (msn-proc-send *msn-notification* (concat "CHG %s " stat "\n")))))

(defun msn-known-user-list ()
  (let ((lst nil))
    (dolist (l *msn-contact-list*)
      (dolist (e (cdr l))
	(when (not (member (car e) lst))
	  (setq lst (cons (car e) lst)))))
    (mapcar #'list lst)))

(defun msn-add ()
  (interactive)
  (when (and *msn-notification*
	     (eq (process-status *msn-notification*) 'open))
    (let* ((type '(("FL") ("AL") ("BL")))
	   (completion-ignore-case nil)
	   (which (completing-read "Which?: " type nil t))
	   (who (completing-read "Who?: " (msn-known-user-list) nil nil)))
      (msn-proc-send *msn-notification* (concat "ADD %s " which " " who " " who "\n")))))

(defun msn-remove ()
  (interactive)
  (when (and *msn-notification*
	     (eq (process-status *msn-notification*) 'open))
    (let* ((type '(("FL") ("AL") ("BL")))
	   (completion-ignore-case nil)
	   (which (completing-read "Which?: " type nil t))
	   (who (completing-read "Who?: " (msn-known-user-list) nil t)))
      (msn-proc-send *msn-notification* (concat "REM %s " which " " who "\n")))))

(defun msn-url-encode-string (str)
  (apply #'concat
	 (mapcar
	  (lambda (e)
	    (cond ((string-match "[a-zA-Z0-9:/]" e) e)
		  (t
		   ;; ��� format �̤�Τ� % -> %% �Ȥ��Ȥ���
		   (format "%%%%%02X" (string-to-char e)))))
	  (split-string (encode-coding-string str 'utf-8-dos) ""))))

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

(defun msn-rename ()
  (interactive)
  (when (and *msn-notification*
	     (eq (process-status *msn-notification*) 'open))
    (msn-proc-send *msn-notification*
		   (concat "REA %s " (cdr (assoc 'mail *msn-user-account*)) " "
			   (msn-url-encode-string
			    (read-input "Nickname?: " (cdr (assoc 'name *msn-user-account*))))
			   "\n"))))

(defun msn-sync ()
  (interactive)
  (when (and *msn-notification*
	     (eq (process-status  *msn-notification*) 'open))
    (msn-proc-send *msn-notification* "SYN %d 0\n")))

(defun msn-select-session ()
  (interactive)
  (let* ((completion-ignore-case nil)
	 (session (completing-read "Session?: "
				   (mapcar (lambda (e) (list (int-to-string (car e))))
					   *msn-switchboards*)
				   nil t *msn-current-session*)))
    (setq *msn-current-session* session)
    (when (not (one-window-p)) (delete-other-windows))
    (switch-to-buffer *msn-buffer*)
    (msn-redraw nil nil #'msn-show-contact-list)))

(defun msn-select-session-with-current-word ()
  (interactive)
  (let ((pos (point)))
    (save-excursion
      (let* ((num (current-word))
	     (head (progn
		     (goto-char (point-at-bol))
		     (current-word))))
	(when (and (string-equal head "sessions")
		   (not (string-equal num "sessions")))
	  (setq *msn-current-session* num)
	  (msn-redraw nil nil #'msn-show-contact-list))))
    (goto-char pos)))

(defun msn-create-new-session ()
  (interactive)
  (when (and *msn-notification*
	     (eq (process-status *msn-notification*) 'open))
    (msn-proc-send *msn-notification* "XFR %s SB\n")))

(defun msn-close-session ()
  (interactive)
  (if (null *msn-current-session*)
      (message "���å���������Ǥ�������!!")
    (let* ((session (cdr (assoc (string-to-int *msn-current-session*) *msn-switchboards*)))
	   (buf (process-buffer session)))
      (when (and session
		 (eq (process-status session) 'open))
	(msn-proc-send session (concat "OUT\n"))
	(delete-process session))
      (setq *msn-id-and-address* (delete (assoc (string-to-int *msn-current-session*)
						*msn-id-and-address*) *msn-id-and-address*))
      (setq *msn-switchboards*
	    (delete (assoc (string-to-int *msn-current-session*) *msn-switchboards*)
		    *msn-switchboards*))
      (msn-show-command *msn-current-session*
			(concat "<" *msn-current-session* "> ���Ĥ��ޤ���"))
      (setq *msn-current-session*
	    (if (null *msn-switchboards*) nil (int-to-string (caar *msn-switchboards*))))
      (msn-redraw))))

(defun msn-ring ()
  (interactive)
  (if (null (and *msn-current-session*
		 (assoc (string-to-int *msn-current-session*) *msn-switchboards*)))
      (message "���ߤΥ��å�����̵���Ǥ���")
    (let ((server (cdr (assoc (string-to-int *msn-current-session*) *msn-switchboards*))))
      (when (eq (process-status server) 'open)
	(let ((who (completing-read "Who?: "
				    (cdr (assoc 'FL *msn-contact-list*))
				    nil nil)))
	  (msn-proc-send server (concat "CAL %s " who "\n")))))))


(defun msn-receive-file ()
  (interactive)
  (if (null *msn-current-session*)
      (message "���å���������Ǥ�������!!")
    (let ((session (cdr (assoc (string-to-int *msn-current-session*) *msn-switchboards*))))
      (when (and session
		 ;;(null *msn-receiving-file*)
		 *msn-receive-file*
		 (eq (process-status session) 'open))
	(let* ((receive (car *msn-receive-file*))
	       (cookie (car receive)))
	  (setq *msn-receiving-file* receive)
	  (setq *msn-receive-file* (cdr *msn-receive-file*))
	  (msn-redraw
	   nil
	   (lambda ()
	     (let* ((inhibit-read-only t)
		    (body (concat
			   "Invitation-Command: ACCEPT\n"
			   "Invitation-Cookie: " cookie "\n"
			   "Launch-Application: FALSE\n"
			   "Request-Data: IP-Address\n"))
		    (head "MIME-Version: 1.0\nContent-Type: text/x-msmsgsinvite; charset=UTF-8\n\n")
		    (msg (concat head body))
		    (size (int-to-string (length (encode-coding-string msg 'utf-8-dos))))
		    (msg (concat (make-command "MSG %s U ") size "\n" msg)))
	       (process-send-string session msg)))))))))

(defun msn-send-file ()
  (interactive)
  (if (null *msn-current-session*)
      (message "���å���������Ǥ�������!!")
    (let ((session (cdr (assoc (string-to-int *msn-current-session*) *msn-switchboards*))))
      (when (and session
		 ;;(null *msn-sending-file*)
		 (eq (process-status session) 'open))
	(let* ((filename (expand-file-name (read-file-name "�����ե�����: " (expand-file-name "~/") nil t)))
	       (size (int-to-string (nth 7 (file-attributes filename))))
	       (cookie (int-to-string (random (* 256 256))))
	       (buffer (concat " Switchboard [" *msn-current-session* "]"))
	       (*msn-output-log* buffer))
	  (setq *msn-sending-file*
		(list (cons 'session session)
		      (cons 'cookie cookie)
		      (cons 'size size)
		      (cons 'filename filename)))
	  (save-excursion
	    (msn-redraw
	     nil
	     (lambda ()
	       (let* ((inhibit-read-only t)
		      (body (concat
			     "Application-Name: File Transfer\n"
			     "Application-GUID: {5D3E02AB-6190-11d3-BBBB-00C04F795683}\n"
			     "Invitation-Command: INVITE\n"
			     "Invitation-Cookie: " cookie "\n"
			     "Application-File: " (file-name-nondirectory filename) "\n"
			     "Application-FileSize: " size "\n"))
		      (head "MIME-Version: 1.0\nContent-Type: text/x-msmsgsinvite; charset=UTF-8\n\n")
		      (msg (concat head body))
		      (size (int-to-string (length (encode-coding-string msg 'utf-8-dos))))
		      (msg (concat (make-command "MSG %s U ") size "\n" msg)))
		 (set-buffer (get-buffer buffer))
		 (goto-char (point-max))
		 (msn-proc-send session msg))))))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                 �桼�������󥿡��ե�������Ϣ                             ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defface msn-session-header-face 
  '((((type tty)) (:foreground "white" :background "black" :bold t))) nil)
(defface msn-session-body-face
  '((((type tty)) (:foreground "white" :background "black"))) nil)

(defface msn-session-header-face-1
  '((((type tty)) (:foreground "cyan" :background "black" :bold t))) nil)
(defface msn-session-body-face-1
  '((((type tty)) (:foreground "cyan" :background "black"))) nil)

(defface msn-session-header-face-2
  '((((type tty)) (:foreground "yellow" :background "black" :bold t))) nil)
(defface msn-session-body-face-2
  '((((type tty)) (:foreground "yellow" :background "black"))) nil)

(defface msn-session-header-face-3
  '((((type tty)) (:foreground "green" :background "black" :bold t))) nil)
(defface msn-session-body-face-3
  '((((type tty)) (:foreground "green" :background "black"))) nil)

(defface msn-receiving-delimiter-face
  '((((type tty)) (:foreground "cyan" :underline t :bold t))
    (t (:foreground "blue" :background "cyan" :underline t :bold t))) nil)
(defface msn-writting-delimiter-face
  '((((type tty)) (:foreground "cyan" :underline t :bold t))
    (t (:foreground "blue" :background "cyan" :underline t :bold t))) nil)
(defface msn-status-delimiter-face
  '((((type tty)) (:foreground "yellow" :underline t :bold t))
    (t (:foreground "red" :background "yellow" :underline t :bold t))) nil)
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

;; NLN|FLN|BSY|IDL|BRB|AWY|PHN|LUN �Ȥ�
(defun msn-status-expand (status)
  (interactive)
  (cdr (assoc status '(("NLN" . "ONLINE") ("FLN" . "OFFLINE") ("BSY" . "��������")
		       ("IDL" . "����") ("BRB" . "���������") ("AWY" . "������")
		       ("PHN" . "������") ("LUN" . "��٤�")))))

(defun msn-initialize-screen ()
  (interactive)
  (switch-to-buffer *msn-buffer*)
  (let ((inhibit-read-only t))
    (erase-buffer)
    ;; ������ʬ
    (msn-insert-with-face 'msn-receiving-delimiter-face " [����] \n")
    ;; ������ʬ
    (msn-insert-with-face 'default "\n")
    (msn-insert-with-face 'msn-writting-delimiter-face
			  (concat " [����]" " ("
				  (msn-status-expand (cdr (assoc 'status *msn-user-account*)))
				  ")" "\n"))
    (add-text-properties (- (point) 1) (point) '(rear-nonsticky t))
    ;; ���󥿥��ȥꥹ��ɽ����ʬ
    (msn-insert-with-face 'default "\n")
    (msn-insert-with-face 'msn-status-delimiter-face  " [���󥿥��ȥꥹ��]\n")))

(defun msn-show-contact-list ()
  (let ((inhibit-read-only t))
    (delete-region (point-min) (point-max))
    (msn-insert-with-face 'bold "sessions: ")
    (mapcar (lambda (e)
	      (if (and (not (null *msn-current-session*))
		       (string-equal e *msn-current-session*))
		  (msn-insert-with-face 'bold (concat "[" e "]"))
		(msn-insert-with-face 'default (concat "[" e "]"))))
	    (mapcar (lambda (e) (int-to-string (car e))) *msn-switchboards*))
    (msn-insert-with-face 'default "\n")
    (when (null (cdr (assoc 'FL *msn-contact-list*)))
      (msn-insert-with-face 'default "����⤤�ʤ���\n"))
    (dolist (e (cdr (assoc 'FL *msn-contact-list*)))
      (msn-insert-with-face 'default (concat
				      (cdr (assoc 'name (cdr e)))
				      " <" (car e) "> "))
      (let* ((status (msn-status-expand (cdr (assoc 'stat (cdr e)))))
	     (face (msn-get-status-face status)))
	(msn-insert-with-face face (concat "(" status ")\n"))))))

(defun msn-get-status-face (status)
  (cond
   ((string-equal status "ONLINE")  'msn-status-online-face)
   ((string-equal status "OFFLINE") 'msn-status-offline-face)
   (t                               'msn-status-default-face)))

(defun msn-get-message-area ()
  (let (beg end)
    (goto-char (point-max))
    (search-backward-regexp "^")
    (setq end (- (point) 1))
    (search-backward-regexp "^")
    (setq beg (progn (forward-line 1) (point)))
    (cons beg end)))

(defun msn-get-message-area-offset ()
  (let* ((current (point))
	 (lst (msn-get-message-area))
	 (beg (car lst))
	 (end (cdr lst)))
    (if (and (>= current beg) (<= current end))
	(- current beg))))

;; ������ʬ
(defun msn-redraw (&optional action1 action2 action3)
  (interactive)
  (set-buffer *msn-buffer*)
  (let ((inhibit-read-only t)
	(offset (msn-get-message-area-offset)))
    (goto-char (point-max))
    (let* ((status-end (point-max))
	   (status-beg (progn
			 (search-backward-regexp "^")
			 (forward-line 1)
			 (point)))
	   (msg-end (progn (forward-line -1) (- (point) 1)))
	   (msg-line-beg (progn (search-backward-regexp "^") (point)))
	   (msg-line-end (progn (search-forward-regexp "$") (point)))
	   (msg-beg (progn
		      (forward-line 1)
		      (point)))
	   (show-end (progn (forward-line -2) (point)))
	   (show-beg (point-min)))
      ;; status
      (save-excursion
	(save-restriction
	  (narrow-to-region status-beg status-end)
	  (when action3
	    (funcall action3))))
      (save-excursion
	(save-restriction
	  (narrow-to-region msg-line-beg msg-line-end)
	  (delete-region (point-min) (point-max))
	  (msn-insert-with-face
	   'msn-writting-delimiter-face
	   (concat " [����]  [" *msn-current-session* "] "
		   (cdr (assoc 'name *msn-user-account*))
		   " <" (cdr (assoc 'mail *msn-user-account*)) "> ("
		   (msn-status-expand (cdr (assoc 'stat *msn-user-account*)))
		   ")"))))
      (save-excursion
	(save-restriction
	  (narrow-to-region msg-beg msg-end)
	  (when action2
	    (funcall action2))))
      (save-excursion
	(save-restriction
	  (narrow-to-region show-beg show-end)
	  (when action1
	    (funcall action1))))
      ;; point to message area
      (let* ((beg (car (msn-get-message-area))))
	(goto-char (if offset (+ beg offset) beg))
	;; ɽ������Ĵ��
	(when *msn-experimental*
	  (let ((old (point)))
	    (goto-char beg)
	    (forward-line -7)
	    (recenter)
	    (goto-char old)))))))

(defun msn-get-local-ip-address ()
  (interactive)
  (cond
   ((string-match "freebsd" (version))
    (with-temp-buffer
      (call-process "ifconfig" nil t)
      (goto-char (point-min))
      (if (re-search-forward "inet[^0-9]*\\([0-9]+\\(\.[0-9]+\\)+\\)" nil t)
	  (match-string 1)
	"unknown")))
   ((string-match "ms" (version))
    (with-temp-buffer
      (call-process "ipconfig" nil t)
      (goto-char (point-min))
      (if (re-search-forward "IP[^0-9]*\\([0-9]+\\(\.[0-9]+\\)+\\)" nil t)
	  (match-string 1)
	"unknown")))))

;; "MSG \\([a-zA-Z0-9-_]+@[a-zA-Z0-9-_.]+ [^ \n]+\\|[0-9]+ [UA]\\) [0-9][0-9]+\n") �ǤϹ������롩��
(defun msn-show-message (session string &optional redraw)
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
      (let* ((pos (string-match "\n\n" msg))
	     (head (substring msg 0 pos))
	     (body (substring msg (+ pos 2))))
	(set-buffer *msn-buffer*)
	(cond 
	 ((string-match "^Content-Type: text/x-msmsgsinvite; charset=UTF-8" head)
	  (string-match "MSG \\([a-zA-Z0-9._/]+@[a-zA-Z0-9.]+\\) \\([^ ]+\\) [0-9]+\n" head)
	  (let ((mail (substring head (match-beginning 1) (match-end 1)))
		(name (substring head (match-beginning 2) (match-end 2))))
	    (msn-invited session name mail body)))
	 ((string-match "MSG [0-9]+ [UA] [0-9]+\n" head)
	  (msn-redraw
	   (lambda ()
	     (msn-insert-with-face
	      'msn-session-header-face
	      (concat "<" session "> "
		      (let ((ret (assoc 'name *msn-user-account*)))
			(if ret (cdr ret) "���ʤ�")) " ��ȯ��:\n"))
	     (msn-insert-with-face 'msn-session-body-face
				   (concat body "\n")))))
	 ((string-match "MSG \\([a-zA-Z0-9._/]+@[a-zA-Z0-9.]+\\) \\([^ ]+\\) [0-9]+\n" head)
	  (let* ((mail (substring head (match-beginning 1) (match-end 1)))
		 (name (substring head (match-beginning 2) (match-end 2)))
		 (name (msn-url-decode-string name)))
	    (if (string-match "^TypingUser: \\([a-zA-Z0-9._/]+@[a-zA-Z0-9.]+\\)" head)
		(message (concat name " ��������..."))
	      (msn-redraw
	       (lambda ()
		 (msn-insert-with-face 'msn-session-header-face
				       (concat "<" session "> " name " ��ȯ��:\n"))
		 (msn-insert-with-face 'msn-session-body-face
				       (concat body "\n")))
	       nil
	       (if redraw #'msn-show-contact-list nil))))))))))

(defun msn-show-command (session command)
  (set-buffer *msn-buffer*)
  (msn-redraw
   (lambda ()
     (msn-insert-with-face 'msn-command-face
			   (concat (msn-url-decode-string command)
				   (when *msn-experimental*
				     (format-time-string *msn-time-format*))
				   "\n")))
   nil
   #'msn-show-contact-list)
  (set-buffer-modified-p nil))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;              �����С��ȤΥǡ����Τ��Ȥ�˻Ȥ���ʬ                      ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun make-command (str)
  (setq *msn-id* (+ *msn-id* 1))
  (format str *msn-id*))

(defun msn-proc-send (server msg)
  (save-selected-window
    (let ((cmd (make-command msg)))
      (when *msn-output-log*
	(insert "------------\n<<< ")
	(insert cmd)
	(insert "------------\n"))
      (process-send-string server cmd))))

(defun msn-record-sever-message (string)
  (goto-char (point-max))
  (insert "--------------------\n")
  (insert string)
  (insert "--------------------\n"))

(defun msn-login (server)
  (msn-proc-send server "VER %d MSNP7 MSNP6 MSNP5 CVR0\n"))

(defun msn-png ()
  (interactive)
  (when (and *msn-notification*
	     (eq (process-status  *msn-notification*) 'open))
    (msn-proc-send *msn-notification* "PNG\n")))

(defun msn-connect ()
  (interactive)
  (setq *msn-dispatch* nil
	*msn-notification* nil
	*msn-switchboards* nil
	*msn-contact-list* (copy-tree
			    '((FL . ())
			      (RL . ())
			      (AL . ())
			      (BL . ())))
	*msn-id-and-address* nil
	*msn-current-session* nil
	*msn-id* -1
	*msn-switchboard-id* -1)
  (setq *msnftp* nil
	*msnftp-auth* nil
	*msnftp-rest* nil
	*msn-receiving-file* nil
	*msn-receive-file* nil)
  (setcdr (assoc 'stat *msn-user-account*) "FLN") ;; ������֤� OFFLINE
  (run-hooks 'msn-connect-hook)
  (let ((mail (assoc 'mail *msn-user-account*))
	(pass (assoc 'pass *msn-user-account*)))
    (when (null (cdr mail)) (setcdr mail (read-string "Hotmail Account: ")))
    (when (null (cdr pass))
      (setcdr pass
	      (let ((inhibit-input-event-recording t))
		(condition-case nil (read-passwd "Password: "))))))
  ;; dispatch server ����³
  (setq *msn-dispatch*
	(open-network-stream "Dispatch Server" *msn-dispatch-buffer*
			     "messenger.hotmail.com" 1863))
			     ;;"127.0.0.1" 1863))
  (set-process-coding-system *msn-dispatch* 'utf-8-dos 'utf-8-dos)
  (set-process-filter *msn-dispatch* 'msn-dispatch-filter)
  (msn-login *msn-dispatch*))

(defun msn-message-parse (string)
  (cond
   ((or *msn-sync-fragment*
	(string-match "^GTC" string))
    (if (not (eq (aref string (- (length string) 1)) ?\n))
	(progn
	  (setq *msn-sync-fragment* (concat *msn-sync-fragment* string))
	  nil)
      (let* ((lst (split-string
		   (if *msn-sync-fragment* (concat *msn-sync-fragment* string) string)
		   "\n")))
	(setq *msn-sync-fragment* nil)
	lst)))
   ((string-match "^MSG" string)
    (list string))
   ((string-match "^USR" string)
    (let* ((pos (string-match "\n" string))
	   (usr (substring string 0 pos))
	   (other (substring string (+ pos 1) (length string))))
      (if (> (length other) 5)
	  (list usr other)
	(list usr))))
   (t (split-string string "\n"))))

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

(defun msn-parse-notification-message (string)
  (let* ((msg (split-string string "\n\n"))
	 (head (car msg))
	 (body (apply 'concat (cdr msg))))
    (set-buffer *msn-buffer*)
    (cond
     ((equal body "")
      (msn-redraw (lambda () (msn-insert-with-face 'bold (concat "[Hotmail]: LOGIN OK\n")))))
     ((> (length body) 10)
      (cond
       ((string-match "^Inbox-Unread: \\([0-9]+\\)\nFolders-Unread: \\([0-9]+\\)" body)
	(let ((new (substring body (match-beginning 1) (match-end 1)))
	      (unread (substring body (match-beginning 2) (match-end 2))))
	  (msn-redraw
	   (lambda ()
	     (msn-insert-with-face
	      'bold
	      (concat "[Hotmail]:\n"
		      "����᡼��: " new "\n"
		      "̤�ɥ᡼��: " new "\n"))))))
       (t (msn-redraw (lambda () (msn-insert-with-face 'bold (concat "[Hotmail]:\n" body "\n"))))))))))

(defun msn-set-contact-list (mail stat name)
  (let* ((FL (assoc 'FL *msn-contact-list*))
	 (name (msn-url-decode-string name))
	 (m (assoc mail (cdr FL))))
    (if (null m)
	(setcdr FL (cons (cons mail (list (cons 'stat stat) (cons 'name name))) (cdr FL)))
      (setcdr (assoc 'name (cdr m)) name)
      (setcdr (assoc 'stat (cdr m)) stat))))

(defun msn-challenge-auth (server string)
  (msn-proc-send server
		 (concat "QRY %s msmsgs@msnmsgr.com 32\n"
			 (msn-md5-digest
			    (concat (nth 2 (split-string string "[ \n]"))
				    "Q1P7W2E4J9R8U3S5")))))

(defun msn-rng (string)
  (let* ((lst (split-string string "[ \n]"))
	 (address (split-string (nth 2 lst) ":"))
	 (addr (nth 0 address))
	 (port (nth 1 address))
	 (session-id (nth 1 lst))
	 (security-string (nth 4 lst)))
    (msn-answer addr port session-id security-string
		(lambda ()
		  (msn-proc-send (cdr server)
				 (concat "ANS %s " (cdr (assoc 'mail *msn-user-account*))
					 " " security-string " " session-id "\n"))))))

(defun msn-notification-usr (string)
  (let* ((lst (split-string string "[ \n]")))
    (cond ((string-equal (nth 3 lst) "S")
	   (msn-proc-send
	    *msn-notification*
	    (concat "USR %s MD5 S "
		    (msn-md5-digest (concat (nth 4 lst)
					    (cdr (assoc 'pass *msn-user-account*))))
		    "\n"))
	   (setcdr (assoc 'pass *msn-user-account*) nil))
	  ((string-equal (nth 2 lst) "OK")
	   (let* ((lst (split-string string " ")))
	     (setcdr (assoc 'mail *msn-user-account*) (nth 3 lst))
	     (setcdr (assoc 'name *msn-user-account*)
		     (msn-url-decode-string (nth 4 lst)))
	     (msn-show-command nil "LOGIN OK")
	     (message "LOGIN OK"))))))

(defun msn-xfr (string)
  (let* ((lst (split-string string "[ \n]"))
	 (type (nth 2 lst))
	 (address (split-string (nth 3 lst) ":"))
	 (addr (nth 0 address))
	 (port (nth 1 address)))
    (cond ((string-equal type "NS")
	   (setq *msn-notification*
		 (open-network-stream "Notification Server"
				      *msn-notification-buffer* addr (string-to-int port)))
	   (set-process-coding-system *msn-notification* 'utf-8-dos 'utf-8-dos)
	   (set-process-filter *msn-notification* 'msn-notification-filter)
	   (msn-login *msn-notification*))
	  ((string-equal type "SB")
	   (let ((auth (nth 4 lst))
		 (session-id (nth 1 lst))
		 (security-string (nth 5 lst)))
	     (msn-answer addr port session-id security-string
			 (lambda ()
			   (msn-proc-send (cdr server)
					  (concat "USR %s " (cdr (assoc 'mail *msn-user-account*))
						  " " security-string "\n")))))))))

(defun msn-answer (add port session-id security-string function)
  (setq id (let* ((address (concat add ":" port))
		  (found (rassoc address *msn-id-and-address*)))
	     (if found
		 (car found)
	       (setq *msn-switchboard-id* (+ *msn-switchboard-id* 1))
	       (setq *msn-id-and-address* (cons (cons *msn-switchboard-id* address) *msn-id-and-address*))
	       *msn-switchboard-id*)))
  (let ((server (assoc id *msn-switchboards*)))
    (when (null server)
      (setq *msn-switchboards* (cons (copy-tree `( ,id nil)) *msn-switchboards*))
      (setq server (assoc id *msn-switchboards*)))
    (setcdr server
	    (open-network-stream (concat "Switch Board [" (format "%d" id) "]")
				 (concat " Switchboard [" (format "%d" id) "]")
				 addr (string-to-int port)))
    (set-process-coding-system (cdr server) 'utf-8-dos 'utf-8-dos)
    (set-process-filter (cdr server) 'msn-switchboard-filter)
    (set-buffer (get-buffer (process-buffer (cdr server))))
    (funcall function)
    (when (null *msn-current-session*)
      (setq *msn-current-session* (int-to-string id)))
    (msn-redraw nil nil #'msn-show-contact-list)))

(defun msn-bye (session string)
  (let* ((buf (get-buffer (concat " Switchboard [" session "]")))
	 (mail (nth 1 (split-string string "[ \n]")))
	 (user (assoc mail (cdr (assoc 'FL *msn-contact-list*)))))
    (msn-show-command session (concat "<" session ">" " ���褦�ʤ� "
				      (if user (cdr (assoc 'name (cdr user))) mail)
				      " <" mail ">"))))

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
    (msn-show-command nil msg)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                               MSNFTP ��Ϣ                                ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun msn-invited (session name mail body)
  (let ((lst (split-string body "\n")) 
	(i `((session . ,session)))
	(cookie nil))
    (dolist (e (mapcar #'split-string lst))
      (cond
       ;; ������ 1
       ((string-equal (car e) "Application-Name:")
	(setq i (cons (cons 'application (cadr e)) i)))
       ((string-equal (car e)"Application-GUID:")
	(setq i (cons (cons 'guid (cadr e)) i)))
       ((string-equal (car e)"Invitation-Command:")
	(setq i (cons (cons 'command (cadr e)) i)))
       ((string-equal (car e)"Invitation-Cookie:")
	(setq i (cons (cons 'cookie (cadr e)) i))
	(setq cookie (cadr e)))
       ((string-equal (car e)"Application-File:")
	(setq i (cons (cons 'filename (cadr e)) i)))
       ((string-equal (car e)"Application-FileSize:")
	(setq i (cons (cons 'filesize (cadr e)) i)))
       ;; ������ 2
       ((string-equal (car e)"IP-Address:")
	(setq i (cons (cons 'ip (cadr e)) i)))
       ((string-equal (car e)"Port:")
	(setq i (cons (cons 'port (cadr e)) i)))
       ((string-equal (car e)"AuthCookie:")
	(setq i (cons (cons 'auth (cadr e)) i)))
       ;; ������
       ((string-equal (car e)"Cancel-Code:")
	(setq i (cons (cons 'auth (cadr e)) i)))
       ((string-equal (car e)"Request-Data:")
	(setq i (cons (cons 'auth (cadr e)) i)))))
    (cond
     ((and (string-equal (cdr (assoc 'command i)) "ACCEPT")
	   (not (null *msn-sending-file*)))
      (msnftp-send i))
     ((string-equal (cdr (assoc 'command i)) "ACCEPT")
      (let ((ip (cdr (assoc 'ip i)))
	    (port (cdr (assoc 'port i)))
	    (auth (cdr (assoc 'auth i))))
	(msnftp-recv ip port auth)))
     ((string-equal (cdr (assoc 'command i)) "CANCEL")
      (setq *msn-receive-file* (delete (assoc cookie  *msn-receive-file*)
				       *msn-receive-file*))
      (msn-redraw
       (lambda ()
	 (msn-insert-with-face
	  'msn-session-header-face
	  (concat "<" session "> " name " <" mail "> "
		  "���ե�����򥭥�󥻥뤷�ޤ���\n")))))
     ((string-equal (cdr (assoc 'command i)) "INVITE")
      (setq *msn-receive-file* (cons (cons cookie i) *msn-receive-file*))
      (msn-redraw
       (lambda ()
	 (msn-insert-with-face
	  'msn-session-header-face
	  (concat "<" session "> " name " <" mail "> "
		  "���ե�������������褦�Ȥ��Ƥ��ޤ�\n"))
	 (msn-insert-with-face 
	  'msn-session-body-face
	  (concat
	   "�ե�����̾: " (cdr (assoc 'filename i)) "\n"
	   "�ե����륵����: " (cdr (assoc 'filesize i)) "\n"))))))))

(defun msnftp-sentinel (process event)
  (when event
    (let ((status (process-exit-status process)))
      (cond
       ((= status 0)
	(setq *msn-sending-file* nil)
	(msn-show-command nil "�ե������̵�����ԡ����ޤ���"))
       ((= status 1)
	(setq *msn-sending-file* nil)
	(msn-show-command nil "�ե�����Υ��ԡ��˼��Ԥ��ޤ���"))))))

(defun msnftp-send (data)
  (let ((mail "S")
	(session (cdr (assoc 'session data)))
	(cookie (cdr (assoc 'cookie data)))
	(auth (int-to-string (random (* 256 256))))
	(ip (msn-get-local-ip-address))
	(port "6891")
	(file (cdr (assoc 'filename *msn-sending-file*))))
    (when (not (string-equal ip "unknown"))
      (setq *msnftp*
	    (start-process
	     "MSNFTP" " MSNFTP"
	     (expand-file-name *msnftp-command*)
	     mail auth ip port file))
      (set-process-sentinel *msnftp* #'msnftp-sentinel)
      (save-excursion
	(msn-redraw
	 nil
	 (lambda ()
	   (let* ((inhibit-read-only t)
		  (body (concat
			 "Invitation-Command: ACCEPT\n"
			 "Invitation-Cookie: " cookie "\n"
			 "IP-Address: " ip "\n"
			 "Port: " port "\n"
			 "AuthCookie: " auth "\n"
			 "Launch-Application: FALSE\n"
			 "Request-Data: IP-Address:\n"))
		  (head "MIME-Version: 1.0\nContent-Type: text/x-msmsgsinvite; charset=UTF-8\n\n")
		  (msg (concat head body))
		  (size (int-to-string (length (encode-coding-string msg 'utf-8-dos))))
		  (msg (concat (make-command "MSG %s U ") size "\n" msg)))
	     (let* ((session (cdr (assoc (string-to-int session) *msn-switchboards*)))
		    (*msn-output-log* (buffer-name (process-buffer session))))
	       (set-buffer (process-buffer session))
	       (goto-char (point-max))
	       (msn-proc-send session msg)))))))))

(defun msnftp-recv (ip port auth)
  (when (null (file-directory-p *msn-received-file-directory*))
    (make-directory *msn-received-file-directory*))
  (setq *msnftp*
	(start-process
	 "MSNFTP" " MSNFTP"
	 (expand-file-name *msnftp-command*)
	 (cdr (assoc 'mail *msn-user-account*))
	 auth ip port
	 (expand-file-name
	  (cdr (assoc 'filename (cdr *msn-receiving-file*)))
	  *msn-received-file-directory*)))
  (set-process-sentinel *msnftp* #'msnftp-sentinel))

;; (defun msnftp-recv (ip port auth)
;;   (setq *msnftp*
;; 	(open-network-stream
;; 	 "MSNFTP" " MSNFTP" ip (string-to-int port)))
;;   (set-process-coding-system *msnftp* 'utf-8-dos 'utf-8-dos)
;;   (set-process-filter *msnftp* 'msnftp-filter)
;;   (set-buffer (get-buffer (process-buffer *msnftp*)))
;;   (set-buffer-file-coding-system 'binary)
;;   (setq *msnftp-auth* auth)
;;   (process-send-string *msnftp* "VER MSNFTP\n"))

;; (defun msnftp-insert (data)
;;   (let* ((stat (aref string 0))
;; 	 (low (aref string 1))
;; 	 (high (aref string 2))
;; 	 (data (substring string 3))
;; 	 ;;(size (length data)))
;; 	 (size (+ (* high 256) low)))
;;     (insert data)
;;     (setq *msnftp-rest* (- *msnftp-rest* size))
;;     (when (eq stat 1)
;;       (delete-process *msnftp*)
;;       (setq *msnftp* nil))
;;     (when (< *msnftp-rest* 1)
;;       (set-process-coding-system *msnftp* 'utf-8-dos 'utf-8-dos)
;;       (process-send-string *msnftp* "BYE 16777989\n")
;;       (delete-process *msnftp*)
;;       (msn-show-command nil "�ե�����ž����λ�ʼ�ʬ����¸���Ƥ���������")
;;       (setq *msnftp* nil))))

;; (defun msnftp-filter (proc string)
;;   (let ((old-buffer (current-buffer)))
;;     (save-excursion
;;       (let ((*msn-output-log* (buffer-name (process-buffer proc)))
;; 	    (finalize nil))
;; 	(set-buffer (process-buffer *msnftp*))
;; 	(if (null *msnftp-auth*)
;; 	    (msnftp-insert string)
;; 	  (cond
;; 	   ((string-match "^VER" string)
;; 	    (setq finalize 
;; 		  (lambda ()
;; 		    (process-send-string
;; 		     *msnftp*
;; 		     (concat "USR "
;; 			     (cdr (assoc 'mail *msn-user-account*)) " "
;; 			     *msnftp-auth* "\n")))))
;; 	   ((string-match "^FIL" string)
;; 	    (setq *msnftp-auth* nil)
;; 	    (setq *msnftp-rest* 
;; 		  (string-to-int (cadr (split-string string "[ \n]"))))
;; 	    (setq finalize 
;; 		  (lambda ()
;; 		    (process-send-string *msnftp* "TFR\n")
;; 		    (set-process-coding-system *msnftp* 'binary 'binary)
;; 		    (set-buffer-file-coding-system 'binary)))))
;; 	  (when finalize
;; 	    (funcall finalize)))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;              �����С�����Υ�å����������������ʬ                      ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun msn-dispatch-filter (proc string)
  (let ((old-buffer (current-buffer)))
    (save-excursion
      (let ((*msn-output-log* *msn-dispatch-buffer*) (finalize nil))
	(set-buffer (process-buffer proc))
	(msn-record-sever-message string)
	(cond
	 ((string-match "^VER" string)
	  (setq finalize (lambda () (msn-proc-send *msn-dispatch* "INF %d\n"))))
	 ((string-match "^INF" string)
	  (setq finalize (lambda ()
			   (msn-proc-send *msn-dispatch*
					  (concat "USR %d MD5 I " (cdr (assoc 'mail *msn-user-account*)) "\n")))))
	 ((string-match "^XFR" string)
	  (msn-xfr string))
	 (t nil))
	(when finalize (funcall finalize))))))

(defun msn-notification-filter (proc string)
  (let ((old-buffer (current-buffer)))
    (save-excursion
      (let ((*msn-output-log* *msn-notification-buffer*) (finalize nil))
	(set-buffer (process-buffer proc))
	(msn-record-sever-message string)
	(dolist (string (msn-message-parse string))
	  (cond
	   ((string-match "^ILN" string)
	    (let* ((lst (split-string string "[ \n]"))
		   (stat (nth 2 lst))
		   (mail (nth 3 lst))
		   (name (nth 4 lst)))
	      (msn-set-contact-list mail stat name)
	      (msn-show-command nil (concat name " <" mail "> �� (" (msn-status-expand stat) ") �ˤʤ�ޤ���"))))
	   ((string-match "^FLN" string)
	    (let* ((lst (split-string string "[ \n]"))
		   (mail (nth 1 lst))
		   (stat "FLN")
		   (name (cdr (assoc 'name (cdr (assoc mail (cdr (assoc 'FL *msn-contact-list*))))))))
	      (msn-set-contact-list mail stat name)
	      (msn-show-command nil (concat name " <" mail "> �� (" (msn-status-expand stat) ") �ˤʤ�ޤ���"))))
	   ((string-match "^NLN" string)
	    (let* ((lst (split-string string "[ \n]"))
		   (stat (nth 1 lst))
		   (mail (nth 2 lst))
		   (name (nth 3 lst)))
	      (msn-set-contact-list mail stat name)
	      (msn-show-command nil (concat name " <" mail "> �� (" (msn-status-expand stat) ") �ˤʤ�ޤ���"))))
	   ((string-match "^CHG" string)
	    (let* ((lst (split-string string "[ \n]"))
		   (stat (nth 2 lst)))
	      ;; NLN �ˤʤä����� IDL �ѤΥ����ޡ���ư
	      (when (and *msn-experimental* (string-equal stat "NLN") (null *msn-idle-timer*))
		(setq *msn-idle-timer*
		      (run-with-idle-timer (* 60 5) nil
					   (lambda ()
					     (when (and *msn-notification*
							(eq (process-status *msn-notification*) 'open))
					       (msn-proc-send *msn-notification* (concat "CHG %s IDL\n")))
					     (setq *msn-idle-timer* nil)))))
	      (setcdr (assoc 'stat *msn-user-account*) stat)
	      (msn-redraw nil nil #'msn-show-contact-list)))
	   ((string-match "^MSG" string) (msn-parse-notification-message string))
	   ((string-match "^REA" string)
	    (let* ((lst (split-string string "[ \n]"))
		   (mail (nth 3 lst))
		   (name (msn-url-decode-string (nth 4 lst))))
	      (setcdr (assoc 'name *msn-user-account*) name)
	      (msn-redraw)))
	   ((string-match "^CHL" string) (msn-challenge-auth *msn-notification* string))
	   ((string-match "^RNG" string) (msn-rng string))
	   ((string-match "^USR" string) (msn-notification-usr string))
	   ((string-match "^XFR" string) (msn-xfr string))
	   ((string-match "^[0-9][0-9][0-9]" string) (msn-error string))
	   ((string-match "^OUT" string) (msn-show-command nil "�����С��������Ǥ���ޤ���"))
	   ;; ���󥿥��ȥꥹ��Ʊ����
	   ((string-match "^GTC" string)
	    (setq finalize (lambda () (msn-redraw nil nil #'msn-show-contact-list))))
	   ((string-match "^LST" string) (msn-lst string))
	   ;; ��������˻Ȥ����
	   ((string-match "^VER" string)
	    (setq finalize (lambda () (msn-proc-send *msn-notification* "INF %d\n"))))
	   ((string-match "^INF" string)
	    (setq finalize (lambda ()
			     (msn-proc-send *msn-notification*
					    (concat "USR %d MD5 I "
						    (cdr (assoc 'mail *msn-user-account*))
						    "\n")))))
	   (t nil)))
	(when finalize (funcall finalize))))))

(defun msn-switchboard-filter (proc string)
  (let ((old-buffer (current-buffer)))
    (save-excursion
      (let ((*msn-output-log* (buffer-name (process-buffer proc))) (finalize nil))
	(set-buffer (process-buffer proc))
	(msn-record-sever-message string)
	(let* ((name (buffer-name (process-buffer proc)))
	       (ret (string-match "\\[\\([0-9]+\\)\\]" name))
	       (session (substring name (match-beginning 1) (match-end 1))))
	  (dolist (string (msn-message-parse string))
	    (cond
	     ((string-match "^MSG" string)
	      (setq finalize
		    (lambda ()
		      (when (not (get-buffer-window-list *msn-buffer*))
			(run-hooks 'msn-switchboard-message-hook))))
	      (msn-show-message session string t))
	     ((string-match "^ILN" string)
	      (let* ((lst (split-string string "[ \n]"))
		     (stat (nth 2 lst))
		     (mail (nth 3 lst))
		     (name (nth 4 lst)))
		(msn-show-command session (concat "<" session "> " name " <" mail "> �����ä��ޤ���"))
		(msn-set-contact-list mail stat name)))
	     ((string-match "^IRO" string)
	      (let* ((lst (split-string string "[ \n]"))
		     (mail (nth 4 lst))
		     (name (nth 5 lst)))
		(msn-show-command session (concat "<" session "> " name " <" mail "> �����ä��ޤ���"))
		(msn-set-contact-list mail "NLN" name)))
	     ((string-match "^JOI" string)
	      (let* ((lst (split-string string "[ \n]"))
		     (mail (nth 1 lst))
		     (name (nth 2 lst)))
		(msn-show-command session (concat "<" session "> " name " <" mail "> �����ä��ޤ���"))
		(msn-set-contact-list mail "NLN" name)))
	     ((string-match "^CHL" string)
	      (msn-challenge-auth *msn-notification* string))
	     ((string-match "^BYE" string)
	      (msn-bye session string))
	     ((string-match "^OUT" string)
	      (msn-bye session (concat "OUT " (cdr (assoc 'mail *msn-user-account*)))))
	     ((string-match "^[0-9][0-9][0-9]" string) (msn-error string))
	     (t nil))))
	(when finalize (funcall finalize))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                               MD5 Digest                                 ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; ����ʸ��: rfc1321 The MD5 Message-Digest Algorithm

;; T �򤢤餫����׻����Ƥ�����CMUCL 1.8d ����ѡ�
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

;; �������
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
	 ;; �������Թ�� 64 �Х��Ȥ��ܿ��ʤΤǡ�padding �� "\200" ��ʬ�������
	 ;; 64 + (64-56) - 1 = 71 �Х��Ȥ���н�ʬ��
	 (str (concat str (when (> padding 0) (concat "\200" (make-string 71 0)))))
	 (n (if (<= r 56) n (+ n 1)))
	 ;; �����դϻ��ͤ�ꥫ�󥿥�ˤʤäƤ롥
	 (buf (do* ((tmp (progn
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

;; �ӥ�ȥ���� md5 ��̵�����ϼ����Τ�ĤǷ׻�
(defun msn-md5-digest (string)
  (if (fboundp 'md5)
      (md5 string nil nil 'utf-8-dos)
    (msn-md5 (encode-coding-string string 'utf-8-dos))))

(provide 'messenger)
(run-hooks 'msn-load-hook)

(require 'jka-compr)

;; Configure additional package archives
(package-initialize)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))

(add-to-list 'load-path "~/.emacs.d/el-get/el-get")
(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (let (el-get-master-branch)
      (goto-char (point-max))
      (eval-print-last-sexp))))
(el-get 'sync)

;; Install missing packages
;; http://batsov.com/articles/2012/02/19/package-management-in-emacs-the-good-the-bad-and-the-ugly/
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defvar prelude-packages
  '(ack-and-a-half auto-complete autopair concurrent ctable dash deferred
		   epc ;;flycheck flymake flymake-easy flymake-python-pyflakes
		   ipython popup python-django python-mode python-pylint
		   pyvirtualenv s virtualenv yasnippet)
  "A list of packages to ensure are installed at launch.")

(defun prelude-packages-installed-p ()
  (loop for p in prelude-packages
        when (not (package-installed-p p)) do (return nil)
        finally (return t)))

(unless (prelude-packages-installed-p)
  ;; check for new packages (package versions)
  (message "%s" "Emacs Prelude is now refreshing its package database...")
  (package-refresh-contents)
  (message "%s" " done.")
  ;; install the missing packages
  (dolist (p prelude-packages)
    (when (not (package-installed-p p))
      (package-install p))))

(provide 'prelude-packages)

;; Jedi
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;(setq jedi:setup-keys t)
;;(add-hook 'python-mode-hook 'jedi:setup)
;;(setq jedi:complete-on-dot t)

;; Python Django
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(global-set-key (kbd "C-x j") 'python-django-open-project)

(autoload 'django-html-mumamo-mode "~/.emacs.d/nxhtml/autostart.el")
(setq auto-mode-alist
      (append '(("\\.html?$" . django-html-mumamo-mode)) auto-mode-alist))
(setq mumamo-background-colors nil)
(add-to-list 'auto-mode-alist '("\\.html$" . django-html-mumamo-mode))

;; Mumamo is making emacs 24.3 freak out:
(when (and (equal emacs-major-version 24)
           (equal emacs-minor-version 3))
  (eval-after-load "bytecomp"
    '(add-to-list 'byte-compile-not-obsolete-vars
                  'font-lock-beginning-of-syntax-function))
  (eval-after-load "bytecomp"
    '(add-to-list 'byte-compile-not-obsolete-vars
                  'font-lock-syntactic-keywords))

  ;; tramp-compat.el clobbers this variable!
  (eval-after-load "tramp-compat"
    '(add-to-list 'byte-compile-not-obsolete-vars
                  'font-lock-beginning-of-syntax-function))
  (eval-after-load "tramp-compat"
    '(add-to-list 'byte-compile-not-obsolete-vars
                  'font-lock-syntactic-keywords))

  (eval-after-load "mumamo"
    '(setq mumamo-per-buffer-local-vars
           (delq 'buffer-file-name mumamo-per-buffer-local-vars))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq redisplay-preemption-period nil)
(electric-pair-mode +1)

;; Enable ido
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

;; yasnippet
;;(add-to-list 'load-path "~/.emacs.d/elpa/yasnippet-20130907.1855")
;;(setq yas/prompt-functions '(yas/ido-prompt))
;;(global-set-key (kbd "C-c l") 'yas/insert-snippet) ;; Bind insert snippet
;;(yas/initialize)

;; This is where your snippets will lie.
;;(setq yas/root-directory '("~/.emacs.d/elpa/yasnippet-20130907.1855/snippets/"))
;;(mapc 'yas/load-directory yas/root-directory)

;; auto-complete
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/plugins/auto-complete")
(ac-config-default)

;;(setq-default ac-sources '(ac-source-yasnippet ac-source-abbrev ac-source-dictionary ac-source-words-in-same-mode-buffers))
(setq-default ac-sources '(ac-source-abbrev ac-source-dictionary ac-source-words-in-same-mode-buffers))
(add-hook 'emacs-lisp-mode-hook 'ac-emacs-lisp-mode-setup)
(add-hook 'c-mode-common-hook 'ac-cc-mode-setup)
(add-hook 'auto-complete-mode-hook 'ac-common-setup)
(global-auto-complete-mode t)
(add-to-list 'ac-modes 'objc-mode)

;; Remove trailing whitespace on file save
(add-hook 'before-save-hook 'delete-trailing-whitespace)

(add-hook 'text-mode-hook 'auto-fill-mode)

;; UTF-8
(prefer-coding-system 'utf-8)

; set text size
(set-face-attribute 'default nil :height 90)

; open .m and .mm files in objc-mode
(setq auto-mode-alist
      (cons '("\\.m$" . objc-mode) auto-mode-alist))
(setq auto-mode-alist
      (cons '("\\.h$" . objc-mode) auto-mode-alist))
(setq auto-mode-alist
      (cons '("\\.mm$" . objc-mode) auto-mode-alist))

(setq-default truncate-lines t)

; indent 4 spaces
(setq-default c-basic-offset 4)
(setq-default indent-tabs-mode nil)

;; Similar to C-x o
(defun select-previous-window ()
  "Switch to the previous window"
  (interactive)
  (select-window (previous-window)))

(global-set-key (kbd "C-x p") 'select-previous-window)
(global-set-key (kbd "M-s u") 'revert-buffer)

;; UTF-8
;(set-terminal-coding-system 'utf-8)
;(set-keyboard-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

;; Syntax highlighting
(global-font-lock-mode 1)

;; General settings
(setq user-full-name "Robert S. Jones"
      user-mail-address "robert.jones.sv@gmail.com"
      inhibit-startup-message t
      initial-scratch-message nil
      major-mode 'fundamental-mode
      next-line-add-newlines nil
      scroll-step 1
      scroll-conservatively 1
      font-lock-maximum-decoration t
      require-final-newline t
      truncate-partial-width-windows nil
      shift-select-mode nil
      echo-keystrokes 0.1
      x-select-enable-clipboard t
      mouse-yank-at-point t
      custom-unlispify-tag-names nil
      ring-bell-function '(lambda ()))

;; Display line, column and time (24h format)
(line-number-mode t)
(column-number-mode t)
(size-indication-mode t)
(display-time)
(setq display-time-24hr-format t)
(global-hi-lock-mode 1)

(show-paren-mode 1)
(setq show-paren-delay 0)

;; Hide things that just take up space
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

(global-set-key "\C-x\C-m" 'execute-extended-command)
(global-set-key "\C-c\C-m" 'execute-extended-command)
(global-set-key (kbd "C-c y") 'balance-windows)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(require 'uniquify)
(setq
  uniquify-buffer-name-style 'post-forward
  uniquify-separator ":")

;; Eliminate some annoying prompts
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(fset 'yes-or-no-p 'y-or-n-p)
(setq confirm-nonexistent-file-or-buffer nil)
(setq ido-create-new-buffer 'always)
(setq inhibit-startup-message t
      inhibit-startup-echo-area-message t)

;; Obj-C switch between header and source: Ctrl-C t
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun objc-in-header-file ()
  (let* ((filename (buffer-file-name))
         (extension (car (last (split-string filename "\\.")))))
    (string= "h" extension)))

(defun objc-jump-to-extension (extension)
  (let* ((filename (buffer-file-name))
         (file-components (append (butlast (split-string filename
                                                         "\\."))
                                  (list extension))))
    (find-file (mapconcat 'identity file-components "."))))

;;; Assumes that Header and Source file are in same directory
(defun objc-jump-between-header-source ()
  (interactive)
  (if (objc-in-header-file)
      (objc-jump-to-extension "m")
    (objc-jump-to-extension "h")))

(defun objc-mode-customizations ()
  (define-key objc-mode-map (kbd "C-c t") 'objc-jump-between-header-source))

(add-hook 'objc-mode-hook 'objc-mode-customizations)
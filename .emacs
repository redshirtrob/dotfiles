(setq redisplay-preemption-period nil)

;; Enable ido
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

;; yasnippet
(add-to-list 'load-path "~/.emacs.d/plugins/yasnippet")
(require 'yasnippet)
(setq yas/prompt-functions '(yas/ido-prompt))

;; This is where your snippets will lie.
(setq yas/root-directory '("~/.emacs.d/plugins/yasnippet/snippets"))
(mapc 'yas/load-directory yas/root-directory)

;; Bind insert snippet
(global-set-key (kbd "C-c l") 'yas/insert-snippet)

;; auto-complete
(add-to-list 'load-path "~/elisp")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/elisp/ac-dict")
(ac-config-default)

(setq-default ac-sources '(ac-source-yasnippet ac-source-abbrev ac-source-dictionary ac-source-words-in-same-mode-buffers))
;(setq-default ac-sources '(ac-source-abbrev ac-source-dictionary ac-source-words-in-same-mode-buffers))
(add-hook 'emacs-lisp-mode-hook 'ac-emacs-lisp-mode-setup)
(add-hook 'c-mode-common-hook 'ac-cc-mode-setup)
(add-hook 'auto-complete-mode-hook 'ac-common-setup)
(global-auto-complete-mode t)
(add-to-list 'ac-modes 'objc-mode)

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
(setq indent-tabs-mode nil)

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(show-paren-mode t))

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
      user-mail-address ""
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
(display-battery-mode 1)
(size-indication-mode t)
(display-time)
(setq display-time-24hr-format t)
(global-hi-lock-mode 1)

;; Hide things that just take up space
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
  
(global-set-key "\C-x\C-m" 'execute-extended-command)
(global-set-key "\C-c\C-m" 'execute-extended-command)

(setq custom-file "~/.emacs.d/emacs.custom.el")

(require 'package)
;;(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

;; Refresh package contents if needed
(unless package-archive-contents
  (package-refresh-contents))

;; Install eglot if it's not already installed
(unless (package-installed-p 'eglot)
  (package-install 'eglot))

;; Install gruber-darker if it is not already installed
(unless (package-installed-p 'gruber-darker-theme)
  (package-install 'gruber-darker-theme))

;; Install multiple-cursors if it is not already installed
(unless (package-installed-p 'multiple-cursors)
  (package-install 'multiple-cursors))

(setq inhibit-startup-message t)
;(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode)
(cua-mode t)
(load-theme 'gruber-darker t)
;; Set default font
(set-face-attribute 'default nil
                    :family "DaddyTimeMono Nerd Font"  ;; Replace with your preferred font family
                    :height 120         ;; Font size in 1/10 pt (120 = 12 pt)
                    :weight 'normal      ;; Options: 'normal, 'bold, etc.
                    :slant 'normal)      ;; Options: 'normal, 'italic, etc.
(setq-default indent-tabs-mode nil)  ;; Use spaces instead of tabs
(setq-default tab-width 4)           ;; Set tab width to 4 spaces
(setq-default standard-indent 4)     ;; Set indentation width to 4 spaces
(setq make-backup-files nil)  ;; Disable creation of backup files
(setq auto-save-default nil)  ;; Disable auto-save files
(require 'multiple-cursors)

;; ElDoc
(global-eldoc-mode 1) ;; Activate eldoc mode
(global-set-key (kbd "C-S-d") 'eldoc-print-current-symbol-info) ;; Set ctrl + shift + D to print current symbol information


;; LSP ----
;; C

(add-hook 'c-mode-hook 'eglot-ensure) ;; Ensure eglot is open
(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
               '(c-mode . ("clangd" "--completion-style=detailed"
                           "--fallback-style=LLVM"
                           "--clang-tidy"
                           "--header-insertion=never"
                           "--enable-config"))))

;; Ensure 4-space indentation for C/C++ files
(add-hook 'c-mode-common-hook
          (lambda ()
            (setq c-basic-offset 4          ;; Set indentation to 4 spaces
                  tab-width 4               ;; Set tab width to 4 spaces
                  indent-tabs-mode nil)))   ;; Use spaces, not tabs

;; C++
(add-hook 'c++-mode-hook 'eglot-ensure) ;; Ensure eglot is open
(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
               '(c++-mode . ("clangd" "--completion-style=detailed"
                           "--fallback-style=LLVM"
                           "--clang-tidy"
                           "--header-insertion=never"
                           "--enable-config"))))

;; Ensure 4-space indentation for C/C++ files
(add-hook 'c++-mode-common-hook
          (lambda ()
            (setq c++-basic-offset 4          ;; Set indentation to 4 spaces
                  tab-width 4               ;; Set tab width to 4 spaces
                  indent-tabs-mode nil)))   ;; Use spaces, not tabs


;; Automatically format the buffer before saving if eglot is active
(add-hook 'before-save-hook #'eglot-format-buffer)

;; Set eglot to shutdown automatically
(setq eglot-autoshutdown t)

;; kEY BINDINGS ----
(global-set-key (kbd "C-M-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
(load-file custom-file)
(put 'dired-find-alternate-file 'disabled nil)

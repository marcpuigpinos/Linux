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
                    :family "ComicShannsMono Nerd Font"  ;; Replace with your preferred font family
                    :height 180          ;; Font size in 1/10 pt (120 = 12 pt)
                    :weight 'normal      ;; Options: 'normal, 'bold, etc.
                    :slant 'normal)      ;; Options: 'normal, 'italic, etc.
(setq-default indent-tabs-mode nil)  ;; Use spaces instead of tabs
(setq-default tab-width 4)           ;; Set tab width to 4 spaces
(setq-default standard-indent 4)     ;; Set indentation width to 4 spaces
(add-hook 'c-mode-common-hook
          (lambda ()
            (setq c-basic-offset 4)      ;; Use 4 spaces for indentation
            (setq tab-width 4)           ;; Set visual tab width to 4 spaces
            (setq indent-tabs-mode nil))) ;; Use spaces instead of tabs
(setq make-backup-files nil)  ;; Disable creation of backup files
(setq auto-save-default nil)  ;; Disable auto-save files
(require 'multiple-cursors)

;; LSP ----

;; C/C++:
;; Enable eglot mode for C/C++ files
(add-hook 'c-mode-hook 'eglot-ensure)
(add-hook 'c++-mode-hook 'eglot-ensure)

;; Optional: Set the path to clangd if it's not in your PATH
(setq eglot-server-programs '((c-mode . ("clangd"))
                              (c++-mode . ("clangd"))))

;; PYTHON:
;; Enable eglot mode for Python files
(add-hook 'python-mode-hook 'eglot-ensure)

;; FORTRAN:
;; Enable eglot mode for Fortran files
(add-hook 'fortran-mode-hook 'eglot-ensure)

;; Optional: Set the path to fortls if it's not in your PATH
(setq eglot-server-programs '((fortran-mode . ("fortls"))))

;; Enable auto-formatting on save
(add-hook 'eglot-managed-mode-hook
          (lambda ()
            (add-hook 'before-save-hook 'eglot-format-buffer nil t)))

;; kEY BINDINGS ----
(global-set-key (kbd "C-M-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
(load-file custom-file)

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

;; Install eldoc if it's not already installed
(unless (package-installed-p 'eldoc)
  (package-install 'eldoc))
(unless (package-installed-p 'eldoc-box)
  (package-install 'eldoc-box))

;; Install gruber-darker if it is not already installed
(unless (package-installed-p 'gruber-darker-theme)
  (package-install 'gruber-darker-theme))

;; Install multiple-cursors if it is not already installed
(unless (package-installed-p 'multiple-cursors)
  (package-install 'multiple-cursors))

;; Install corfu for suggestions and autocompletion
(unless (package-installed-p 'corfu)
  (package-install 'corfu))
(use-package corfu
  :ensure t
  :custom
  (corfu-cycle t)                ;; Enable cycling for `tab`
  (corfu-auto t)                 ;; Enable auto completion
  (corfu-auto-delay 0.2)         ;; Delay before suggestions
  (corfu-auto-prefix 1)          ;; Start completing after 1 character
  :init
  (global-corfu-mode))

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
;; Require and enable eldoc-box
(require 'eldoc-box)
(eldoc-box-hover-mode 1) ;; Activate eldoc hover mode
;; Optionally enable eldoc-box in all programming modes
(add-hook 'prog-mode-hook #'eldoc-box-hover-mode)
(global-set-key (kbd "C-S-d") 'eldoc-print-current-symbol-info) ;; Set ctrl + shift + D to print current symbol information

;; Add paths to exed-path.
(add-to-list 'exec-path (expand-file-name "~/.local/bin")) ;; Path of pip installations

;; Inherit shell enviroments
(use-package exec-path-from-shell
  :ensure t
  :config
  (exec-path-from-shell-initialize))

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


;; Fortran
(add-hook 'f90-mode-hook 'eglot-ensure) ;; Ensure eglot is started in Fortran files

;; Add fortls to eglot server programs
(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
               '(f90-mode . ("~/.local/bin/fortls" 
                                 "--hover_signature"
                                 "--use_signature_help"
                                 "--autocomplete_no_prefix"
                                 "--enable_code_actions"))))


(add-hook 'f90-mode-hook
          (lambda ()
            (setq indent-tabs-mode nil   ;; Use spaces, not tabs
                  tab-width 4            ;; Tab width = 4 spaces
                  f90-indent 4)))        ;; Indent 4 spaces per level


(defun my/fortran-format-buffer-with-fprettify ()
  "Format the current buffer with fprettify if it's a Fortran file."
  (when (and (eq major-mode 'f90-mode)
             (executable-find "fprettify"))
    (let ((current-point (point)))
      (call-process-region (point-min) (point-max)
                           "fprettify" t (current-buffer) t)
      (goto-char current-point))))

(add-hook 'f90-mode-hook
          (lambda ()
            (add-hook 'before-save-hook #'my/fortran-format-buffer-with-fprettify nil t)))


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

(setq custom-file "~/.emacs.d/emacs.custom.el")
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
(global-set-key (kbd "C-M-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
(load-file custom-file)

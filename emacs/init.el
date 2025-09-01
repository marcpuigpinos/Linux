;; Configuración de Emacs

;; 0. Pantalla completa
(add-to-list 'initial-frame-alist '(fullscreen . fullboth))
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; 1. Configuración básica de paquetes y uso de `use-package`
(require 'package)
(setq package-archives
      '(("melpa" . "https://melpa.org/packages/")
        ("elpa"  . "https://elpa.gnu.org/packages/")))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

;; 2. Configuración de idioma y codificación
(set-language-environment "English")  ;; Configurar idioma español
(prefer-coding-system 'utf-8)         ;; Asegurarse de usar UTF-8 para caracteres especiales
(setq locale-coding-system 'utf-8)

;; 3. Copiar pegar tradicional
(cua-mode t)

;; 4. Configuración de la indentación a 4 espacios y reemplazo de tabuladores por espacios
(setq-default indent-tabs-mode nil)   ;; No usar tabs (usar espacios)
(setq-default tab-width 4)            ;; Usar 4 espacios por tabulación
(setq-default standard-indent 4)      ;; Configuración estándar de indentación a 4 espacios

(defun set-up-indent-for-all-languages ()
  "Configuración global de indentación para todos los lenguajes."
  (setq indent-tabs-mode nil)          ;; Reemplazar tabs por espacios
  (setq tab-width 4)                   ;; Usar 4 espacios por tabulación
  (setq standard-indent 4))            ;; Configurar la indentación estándar a 4 espacios

;; Aplicar la configuración de indentación a todos los modos de programación
(add-hook 'prog-mode-hook 'set-up-indent-for-all-languages)

;; 5. Instalación de paquetes esenciales
(use-package doom-themes
  :ensure t
  :config
  (load-theme 'doom-dracula t))  ;; Tema Doom Dracula, puedes cambiarlo por el que prefieras

(use-package all-the-icons
  :ensure t)  ;; Paquete de íconos para mejorar la estética

(use-package which-key
  :ensure t
  :config
  (which-key-mode))  ;; Habilitar which-key para ver atajos de teclas disponibles

(use-package company
  :ensure t
  :config
  (add-hook 'after-init-hook 'global-company-mode))  ;; Activar autocompletado global

(use-package magit
  :ensure t
  :bind ("C-x g" . magit-status))  ;; Asignar C-x g para abrir Magit

(use-package powerline
  :ensure t
  :config
  (powerline-default-theme))  ;; Activar Powerline para mejorar la barra de estado

(use-package ivy
  :ensure t
  :config
  (ivy-mode 1))  ;; Activar Ivy para mejorar la búsqueda

(use-package counsel
  :ensure t)

(use-package swiper
  :ensure t
  :bind (("C-s" . swiper)))  ;; Cambiar el comando de búsqueda para usar Swiper

(use-package smartparens
  :ensure t
  :config
  (smartparens-global-mode 1))  ;; Activar Smartparens para mejorar la gestión de paréntesis

;; 6. Configuración de Undo y Rehacer con `undo-fu`
(use-package undo-fu
  :ensure t)

(global-set-key (kbd "C-z") 'undo-fu-only-undo)  ;; Deshacer
(global-set-key (kbd "C-y") 'undo-fu-only-redo)  ;; Rehacer

;; 7. Soporte para terminal en Emacs con `vterm`
(use-package vterm
  :ensure t)

;; 8. Configuración de autoformato con `format-all`
(use-package format-all
  :ensure t
  :hook (prog-mode . format-all-mode))  ;; Activar format-all en todos los lenguajes de programación

;; 9. Personalización de la pantalla de inicio
(setq inhibit-startup-screen t)  ;; Desactivar la pantalla de inicio
(setq initial-scratch-message "")  ;; Vaciar el mensaje de inicio en el buffer scratch

;; 10. Configuración para los lenguajes de programación específicos
;; C
;; Ensure 4-space indentation for C/C++ files
(add-hook 'c-mode-common-hook
          (lambda ()
            (setq c-basic-offset 4          ;; Set indentation to 4 spaces
                  tab-width 4               ;; Set tab width to 4 spaces
                  indent-tabs-mode nil)))   ;; Use spaces, not tabs

;; C++
;; Ensure 4-space indentation for C/C++ files
(add-hook 'c++-mode-common-hook
          (lambda ()
            (setq c++-basic-offset 4          ;; Set indentation to 4 spaces
                  tab-width 4               ;; Set tab width to 4 spaces
                  indent-tabs-mode nil)))   ;; Use spaces, not tabs

;; LSP para C/C++
(use-package lsp-mode
  :ensure t
  :hook ((c-mode c++-mode) . lsp)
  :commands lsp)

(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode
  :config
  (setq lsp-ui-doc-enable t
        lsp-ui-sideline-enable t
        lsp-ui-peek-enable t))

;; Python
;; Ensure 4-space indentation for Python
(add-hook 'python-mode-hook
          (lambda ()
            (setq python-indent-offset 4
                  tab-width 4
                  indent-tabs-mode nil)))

;; Añadir pyright al path de Emacs
(add-to-list 'exec-path "/home/marc/.npm-global/bin")

;; LSP para Python con pyright
(use-package lsp-pyright
  :ensure t
  :hook (python-mode . lsp-deferred)
  :config
  (setq lsp-prefer-flymake nil))


(use-package lsp-ui
  :commands lsp-ui-mode)

;; Fortran
;; Set up 4-space indentation for Fortran (free-form)
(add-hook 'f90-mode-hook
          (lambda ()
            (setq indent-tabs-mode nil       ;; Use spaces
                  tab-width 4                ;; Tab width is 4
                  f90-do-indent 4            ;; Indentation after DO
                  f90-if-indent 4            ;; Indentation after IF
                  f90-type-indent 4          ;; Indentation for TYPE blocks
                  f90-program-indent 4       ;; No indent for PROGRAM
                  f90-subprogram-indent 4    ;; Indent for FUNCTION/SUBROUTINE
                  f90-begin-indent 4         ;; No indent at block start
                  f90-end-indent 4           ;; No indent at block end
                  f90-continuation-indent 4  ;; Indent for continuation lines
                  f90-indent 4)))            ;; Basic indentation level


;; LSP Fortran
;; Añadir fortls a exec-path
(add-to-list 'exec-path "/home/marc/.local/bin")  ;; Cambia esto si lo tienes en otro lugar

;; LSP para Fortran
(use-package lsp-mode
  :ensure t
  :hook ((f90-mode . lsp-deferred))
  :commands (lsp lsp-deferred)
  :config
  (setq lsp-clients-fortls-executable "fortls"
        lsp-clients-fortls-args '("--hover_signature" "--use_signature_help")))

(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode)

;;; 11. Desactivar barras de herramientas, título y desplazamiento
(setq-default mode-line-format nil)  ;; Desactivar la línea de modo (barra de título)

(tool-bar-mode -1)   ;; Elimina la barra de herramientas de iconos
(menu-bar-mode -1)   ;; Elimina la barra de menús (Archivo, Edición, etc.)
(scroll-bar-mode -1) ;; Elimina la barra de desplazamiento

(setq inhibit-startup-screen t)  ;; Desactivar la pantalla de inicio

(setq-default mode-line-format (quote ("%e" mode-line-front-space
                                        mode-line-mule-info
                                        mode-line-client
                                        mode-line-modified
                                        mode-line-remote
                                        mode-line-frame-identification
                                        mode-line-buffer-identification
                                        mode-line-position
                                        (vc-mode vc-mode)
                                        mode-line-misc-info
                                        mode-line-end-spaces)))

;;; 12. Activar números de línea y números relativos
(global-display-line-numbers-mode 1)  ;; Activar números de línea globalmente

;; Habilitar números relativos
(setq display-line-numbers-type 'relative)  ;; Establecer los números relativos

;;; 13. Desactivar archivos de backup
(setq make-backup-files nil)
(setq auto-save-default nil)


;;; 14. Hacer que dired abra en el mismo buffer el archivo o directorio con la tecla a.
(put 'dired-find-alternate-file 'disabled nil)

;;; 15. Multiples cursores
(unless (package-installed-p 'multiple-cursors)
  (package-install 'multiple-cursors))
(require 'multiple-cursors)

;;; 16. Keybindings
(global-set-key (kbd "C-M-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this);;
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

;;; 17. Custom file
(setq custom-file "~/.emacs.d/emacs.custom.el")
(load-file custom-file)


;;; 18. Fuente
(set-face-attribute 'default nil :font "DaddyTimeMono Nerd Font" :height 160)


;;; 19. Márgenes
;; Simular padding superior e inferior sin mostrar líneas visuales
(setq-default header-line-format " ")   ;; Espacio arriba

;; Hacer header-line y mode-line invisibles
(set-face-attribute 'header-line nil
                    :background (face-background 'default)
                    :foreground (face-foreground 'default)
                    :box nil
                    :underline nil)

;;; 20. Org-mode
(setq org-support-shift-select t)

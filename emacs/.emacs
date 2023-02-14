;; change defaults
(setq inhibit-startup-screen t)
(setq inhibit-startup-message t)
(menu-bar-mode t)
(tool-bar-mode 0)
(scroll-bar-mode 0)
(tooltip-mode t)
(set-fringe-mode 10)
;; (add-to-list 'default-frame-alist '(background-color . "black"))

;; disable system clipboard
;; (setq x-select-enable-clipboard nil)

;; line numbers
;; (use-package linum
;;     :config
;;     (global-linum-mode t)
;;     ;; use customized linum-format: add a addition space after the line number                                                                      
;;     (setq linum-format (lambda (line) (propertize (format (let ((w (length (number-to-string (count-lines (point-min) (point-max)))))) (concat "%" 
;;     (number-to-string w) "d ")) line) 'face 'linum)))
;;   )

(column-number-mode t)

(global-display-line-numbers-mode t)
;; (setq-default display-line-numbers-width 3)


;; always maximize window
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; font
(set-face-attribute 'default nil :font "UbuntuMono Nerd Font" :height 150)
;; (set-face-attribute 'default nil :font "DroidSansMono Nerd Font" :height 150)

;; theme
(load-theme 'wombat)

;; disable customize
(dolist (sym '(customize-option customize-browse customize-group customize-face
               customize-rogue customize-saved customize-apropos
               customize-changed customize-unsaved customize-variable
               customize-set-value customize-customized customize-set-variable
               customize-apropos-faces customize-save-variable
               customize-apropos-groups customize-apropos-options
               customize-changed-options customize-save-customized))
  (put sym 'disabled "`customize' is not supported"))
(put 'customize-themes 'disabled "use `load-theme' instead")

;; disable cutomize tracking installed packages
(defun package--save-selected-packages (&rest opt) nil)
;; (setq custom-file (expand-file-name "custom.el" user-emacs-directory))
;; (when (file-exists-p custom-file)
;;     (load custom-file))



;; keybindings
(global-set-key (kbd "s-k") 'kill-this-buffer)
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

(defun my-switch-to-other-buffer ()
  "Switch to other buffer"
  (interactive)
  (switch-to-buffer (other-buffer)))
(global-set-key (kbd "M-b") 'my-switch-to-other-buffer)

;; (global-set-key (kbd "C-c l") #'org-store-link)
;; (global-set-key (kbd "C-c a") #'org-agenda)
;; (global-set-key (kbd "C-c c") #'org-capture)


;; packages

;; Initialize package sources
(require 'package)

(setq package-archives '(("elpa" . "http://elpa.gnu.org/packages")
  			 ("org" . "http://orgmode.org/elpa/")
    			 ("melpa" . "http://melpa.org/packages/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(use-package diminish)

(use-package evil
  :config
  (evil-mode t))
(defalias 'forward-evil-word 'forward-evil-symbol)

(use-package persistent-scratch
  :ensure t
  :config
  (persistent-scratch-setup-default))


;; (use-package ido
;;   :config
;;   (ido-mode t))

(use-package ivy
  :diminish
  ;; :bind (("c-s" . swiper)
	 ;; :map ivy-minibuffer-map
  ;; 	 ("tab" . ivy-alt-done)
  ;; 	 ("c-l" . ivy-alt-done)
  ;; 	 ("<tab>" . ivy-alt-done)
  ;; 	 ("<s-tab>" . ivy-alt-done)
  ;;  	 :map ivy-minibuffer-map
  ;; 	 ("c-k" . ivy-alt-done)
  ;; 	 ("c-l" . ivy-alt-done)
  ;; 	 ("c-d" . ivy-alt-done)
  ;; 	 :map ivy-minibuffer-map
  ;; 	 ("c-k" . ivy-alt-done)
  ;; 	 ("c-d" . ivy-alt-done))
  :config
  (ivy-mode 1))

;; (require 'smex) ; Not needed if you use package.el
		; when Smex is auto-initialized on its first run.

;; (use-package smex)
;; (global-set-key (kbd "M-x") 'smex)
;; (global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; ;; This is your old M-x.
;; (global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;; (use-package smex)
;; (smex-initialize) ; Can be omitted. This might cause a (minimal) delay

(use-package rainbow-delimiters
  :hook (rainbow-delimeters-mode))

(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config (setq which-key-idle-delay 1))

;; (global-set-key (kbd "M-x") 'counsel-M-x)

(use-package ivy-rich
  :init
  (ivy-rich-mode t))

(use-package counsel
  :bind (("M-x" . counsel-M-x)
         ("C-x b" . counsel-ibuffer)
         ("C-x C-f" . counsel-find-file)
         :map minibuffer-local-map
         ("C-r" . 'counsel-minibuffer-history))
  :config
  (setq ivy-initial-inputs-alist nil))

(use-package doom-themes)

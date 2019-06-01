;; Disable toolbar, menu-bar, scroll-bar.
(tool-bar-mode -1) 
(menu-bar-mode -1)
(toggle-scroll-bar -1) 

;;; Adding lines numbers
(global-linum-mode 1)

; Hide the startup message!
(setq inhibit-startup-message t) 

(require 'package)
;; Org-Mode
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
;; Package-Manager
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
;; Package-Manager
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))

(setq package-enable-at-startup nil)
(package-initialize)

;; Evil-Mode
(setq evil-want-C-w-delete nil evil-want-C-w-in-emacs-state t)
(setq evil-want-C-u-scroll t)
(require 'evil)
(evil-mode t)

;; Enable elpy (for python support!)
(elpy-enable)

;; Powerline
(require 'powerline)
(powerline-default-theme)

;; Org-mode
(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)

;; Install packages (automatically generated)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (misterioso)))
 '(package-selected-packages
   (quote
    (flycheck evil-magit magit elpy spacemacs-theme powerline evil-visual-mark-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Adding runtime spell check with flycheck
(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))

;; Remap keybindings to make evil-mode and magit work side by side
(require 'evil-magit)


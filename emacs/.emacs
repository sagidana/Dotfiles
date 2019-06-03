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
(use-package evil
  :ensure t
  :config
  (evil-mode 1)

  (use-package evil-leader
    :ensure t
    :config
    (global-evil-leader-mode))

  (use-package evil-surround
    :ensure t
    :config
    (global-evil-surround-mode))

  (use-package evil-indent-textobject
    :ensure t))

;; PHP support
(use-package php-mode 
  :ensure t
  )

;; Enable elpy (for python support!)
(use-package elpy
  :ensure t
  :config
  (elpy-enable)
  )

;; Powerline
(use-package powerline
  :ensure t
  :config
  (powerline-default-theme)
  )

;; Theme 
(use-package spacemacs-common
    :ensure spacemacs-theme
    :config (load-theme 'spacemacs-dark t)
  )

;; flycheck
(use-package flycheck
  :ensure t
  :config
  ;; Adding runtime spell check with flycheck
  (when (require 'flycheck nil t)
    (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
    (add-hook 'elpy-mode-hook 'flycheck-mode))
  )
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (php-mode use-package spacemacs-theme powerline flycheck evil-surround evil-leader evil-indent-textobject elpy))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

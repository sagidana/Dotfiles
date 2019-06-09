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
  :init
  ;; Enable C-u in normal mode (Up).
  (setq evil-want-C-u-scroll t)
  :config
  (evil-mode 1)

  (use-package evil-leader
    :ensure t
    :config
    (global-evil-leader-mode)

    ;; Setting the leader to space.
    (evil-leader/set-leader "<SPC>")

    ;; Setting custom commands
    (evil-leader/set-key "r" 'ranger)
    ;; Search in files
    (evil-leader/set-key "sif" 'helm-do-ag-project-root)

    ;; Go to definition
    (evil-leader/set-key "gd" 'helm-cscope-find-global-definition-no-prompt)
    ;; Cross-references
    (evil-leader/set-key "x" 'helm-cscope-find-this-symbol-no-prompt)
    ;; List all references inside current function
    (evil-leader/set-key "X" 'helm-cscope-find-called-function-no-prompt)
  )

  (use-package evil-surround
    :ensure t
    :config
    (global-evil-surround-mode))

  (use-package evil-magit
    :ensure t)


 (use-package evil-indent-textobject
    :ensure t))

;; Ranger 
(use-package ranger :ensure t
  :commands (ranger)
  :config
  (setq ranger-cleanup-eagerly t)
  )

;; helm silver searcher
(use-package helm-ag
  :ensure t
  :init
  ;; Enable follow mode by default
  (custom-set-variables '(helm-follow-mode-persistent t))
  :config
  ;; Configuration goes here
  )

;; cscope
;; http://wikemacs.org/index.php/Python#Indexing_sources:_ctags.2C_cscope.2C_pycscope
;; https://github.com/alpha22jp/helm-cscope.el
(use-package helm-cscope
  :ensure t
  )

;; PHP support
(use-package php-mode 
  :init
  (require 'xcscope)
  :ensure t
  :config
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

;; Enable hs-minor-mode to the relevant modes
(add-hook 'c-mode-common-hook #'hs-minor-mode)
(add-hook 'python-mode-hook #'hs-minor-mode)
(add-hook 'emacs-lisp-mode-hook #'hs-minor-mode)

;; Enable cscope in c-mode
(add-hook 'c-mode-common-hook 'helm-cscope-mode)

;; Auto-generated
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(helm-follow-mode-persistent t)
 '(package-selected-packages
   (quote
    (ranger helm spacemacs-theme use-package powerline php-mode evil-surround evil-leader evil-indent-textobject elpy))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

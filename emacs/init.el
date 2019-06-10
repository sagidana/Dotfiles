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

;; Globally resize window bindings!
(global-set-key (kbd "S-C-h") (lambda() (interactive) (shrink-window-horizontally 6)))
(global-set-key (kbd "S-C-l") (lambda() (interactive) (enlarge-window-horizontally 6)))
(global-set-key (kbd "S-C-k") (lambda() (interactive) (shrink-window 6)))
(global-set-key (kbd "S-C-j") (lambda() (interactive) (enlarge-window 6)))

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

    ;; launching ranger
    (evil-leader/set-key "r" 'ranger)

    ;; -------------------------------------------
    ;; Search commands
    ;; -------------------------------------------

    ;; Search file in project 
    (evil-leader/set-key "sf" 'helm-projectile)
    ;; Search in files
    (evil-leader/set-key "sif" 'helm-projectile-grep)
    ;; Go to definition
    (evil-leader/set-key "sd" 'helm-cscope-find-global-definition-no-prompt)
    ;; Cross-references
    (evil-leader/set-key "sx" 'helm-cscope-find-this-symbol-no-prompt)
    ;; List all references inside current function
    (evil-leader/set-key "sX" 'helm-cscope-find-called-function-no-prompt)

    ;; -------------------------------------------
    ;; Fold command (z in vim is for foldings)
    ;; -------------------------------------------
    
    ;; Fold all by level
    (evil-leader/set-key "zl" 'hs-hide-level)

    ;; -------------------------------------------
    ;; Git commands
    ;; -------------------------------------------
    
    ;; Git status
    (evil-leader/set-key "gs" 'magit-status)
    
    ;; -------------------------------------------
    ;; Toggle commands
    ;; -------------------------------------------

    ;; toggle imenu window
    (evil-leader/set-key "ti" 'imenu-list-smart-toggle)


    ;; -------------------------------------------
    ;; Open commands
    ;; -------------------------------------------

    ;; open config file
    (evil-leader/set-key "oc" (lambda() (interactive) (find-file user-init-file)))

    ;; -------------------------------------------
    ;; Buffers commands
    ;; -------------------------------------------

    ;; buffers list
    (evil-leader/set-key "bl" 'buffer-menu)
    ;; buffer kill
    (evil-leader/set-key "bk" 'kill-this-buffer)

    ;; -------------------------------------------
    ;; Windows commands
    ;; -------------------------------------------

    ;; window kill
    (evil-leader/set-key "wk" 'delete-window)
    ;; window horizontal split
    (evil-leader/set-key "whs" 'split-window-below)
    ;; window vertical split
    (evil-leader/set-key "wvs" 'split-window-right)

    ;; -------------------------------------------
    ;; Globals commands
    ;; -------------------------------------------

    ;; Update (save)
    (evil-leader/set-key "u" 'save-buffer)
    ;; Quit
    (evil-leader/set-key "q" 'kill-emacs)
  )

  (use-package evil-surround
    :ensure t
    :config
    (global-evil-surround-mode))

  (use-package evil-magit
    :ensure t)

  (use-package evil-indent-plus
    :ensure t
    :config
    ;; Adding indent-text-objects
    (define-key evil-inner-text-objects-map "i" 'evil-indent-plus-i-indent)
    (define-key evil-outer-text-objects-map "i" 'evil-indent-plus-a-indent)
    (define-key evil-inner-text-objects-map "I" 'evil-indent-plus-i-indent-up)
    (define-key evil-outer-text-objects-map "I" 'evil-indent-plus-a-indent-up)
    (define-key evil-inner-text-objects-map "J" 'evil-indent-plus-i-indent-up-down)
    (define-key evil-outer-text-objects-map "J" 'evil-indent-plus-a-indent-up-down)
  )
)

;; Ranger 
(use-package ranger :ensure t
  :commands (ranger)
  :config
  (setq ranger-cleanup-eagerly t)
  )

;; helm projectile
(use-package helm-projectile
  :ensure t
  :config
  )

;; cscope
;; http://wikemacs.org/index.php/Python#Indexing_sources:_ctags.2C_cscope.2C_pycscope
;; https://github.com/alpha22jp/helm-cscope.el
(use-package helm-cscope
  :ensure t
  )

;; imenu-list
(use-package imenu-list
  :ensure t
  :config
  (setq imenu-list-focus-after-activation t)
  (setq imenu-list-size 0.18)  
  (setq imenu-list-position 'left)
)

;; -----------------------------
;; Programming Languages Support
;; -----------------------------

;; C# support
(use-package csharp-mode
  :ensure t)

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

;; Enable hs-minor-mode to the relevant modes (for folding)
(add-hook 'c-mode-common-hook #'hs-minor-mode)
(add-hook 'python-mode-hook #'hs-minor-mode)
(add-hook 'emacs-lisp-mode-hook #'hs-minor-mode)
(add-hook 'csharp-mode-hook #'hs-minor-mode)

;; Enable cscope 
;;   apt-get install cscope
;;   pip install pycscope
;;   # in project base dir:
;;   find . -name '*.py' > cscope.files
;;   cscope -R 
(add-hook 'c-mode-common-hook 'helm-cscope-mode)
(add-hook 'python-mode-hook 'helm-cscope-mode)
(add-hook 'csharp-mode-hook 'helm-cscope-mode)

;; Auto-generated
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(helm-follow-mode-persistent t)
 '(package-selected-packages
   (quote
    (imenu-list evil-indent-plus helm-projectile helm-ag-r helm-ag ranger helm spacemacs-theme use-package powerline php-mode evil-surround evil-leader elpy))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(require 'package)

;; -------------------------------
;; Sources
;; -------------------------------

;; Org-Mode
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
;; Package-Manager
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
;; Package-Manager
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))

(setq package-enable-at-startup nil)
(package-initialize)

;; Disable toolbar, menu-bar, scroll-bar.
(tool-bar-mode -1) 
(menu-bar-mode -1)
(toggle-scroll-bar -1) 

;;; Adding lines numbers
(global-linum-mode 1)

;; Hide the startup message!
(setq inhibit-startup-message t) 

;; disable creating backup files
(setq auto-save-default nil) ; stop creating #autosave# files
(setq make-backup-files nil) ; stop creating backup~ files

;; Save sessions between startups
(desktop-save-mode 1)

;; Globally resize window bindings!
(global-set-key (kbd "S-C-h") (lambda() (interactive) (shrink-window-horizontally 6)))
(global-set-key (kbd "S-C-l") (lambda() (interactive) (enlarge-window-horizontally 6)))
(global-set-key (kbd "S-C-k") (lambda() (interactive) (shrink-window 6)))
(global-set-key (kbd "S-C-j") (lambda() (interactive) (enlarge-window 6)))

;; replace M-x with helm-M-x
(global-set-key (kbd "M-x") 'helm-M-x)

;; Evil-Mode
(use-package evil
  :ensure t
  :init
  ;; Enable C-u in normal mode (Up).
  (setq evil-want-C-u-scroll t)
  :config
  (evil-mode 1)

  ;; Disable evil-mode for some modes
  ;; (evil-set-initial-state 'help-mode 'emacs)
  ;; (add-to-list 'evil-emacs-state-modes 'org-mode)
  
  ;; Enable hs-minor-mode to the relevant modes (for folding)
  (add-hook 'c-mode-common-hook #'hs-minor-mode)
  (add-hook 'html-mode-common-hook #'hs-minor-mode)
  (add-hook 'python-mode-hook #'hs-minor-mode)
  (add-hook 'emacs-lisp-mode-hook #'hs-minor-mode)
  (add-hook 'csharp-mode-hook #'hs-minor-mode)

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
    ;; Search in imenu
    (evil-leader/set-key "sii" 'helm-imenu)
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

    ;; toggle speedbar
    (evil-leader/set-key "ts" (lambda() (interactive) (sr-speedbar-toggle)))

    ;; -------------------------------------------
    ;; Open commands
    ;; -------------------------------------------

    ;; open config file
    (evil-leader/set-key "oc" (lambda() (interactive) (find-file user-init-file)))

    ;; -------------------------------------------
    ;; Comments commands
    ;; -------------------------------------------

    ;; Comment line
    (evil-leader/set-key "cl" 'evilnc-comment-or-uncomment-lines)
    ;; Comment operator
    (evil-leader/set-key "co" 'evilnc-comment-operator)

    ;;;; -------------------------------------------
    ;; Buffers commands
    ;; -------------------------------------------

    ;; buffers before
    (evil-leader/set-key "bb" 'mode-line-other-buffer)
    ;; buffers switch
    (evil-leader/set-key "bs" 'helm-projectile-switch-to-buffer)
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
    ;; Frames commands
    ;; -------------------------------------------

    ;; frame create 
    (evil-leader/set-key "fc" 'make-frame-command)
    ;; frame kill
    (evil-leader/set-key "fk" 'delete-frame)

    ;; -------------------------------------------
    ;; Globals commands
    ;; -------------------------------------------

    ;; Kill buffer and windows
    (evil-leader/set-key "k" 'kill-buffer-and-window)
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

  (use-package evil-nerd-commenter
    :ensure t)
)

;; Speedbar 
(use-package sr-speedbar
  :ensure t
  :init
  ;; Put the speedbar  in the left side
  (setq sr-speedbar-right-side nil)
  ;; do not  change to currect file automaticaly
  (setq sr-speedbar-auto-refresh nil)
  ;; Show all files
  (setq speedbar-show-unknown-files t)
  :config
  (define-key speedbar-mode-map "\t" 'speedbar-toggle-line-expansion) 
)

;; Ranger 
(use-package ranger :ensure t
  :commands (ranger)
  :config
  (setq ranger-cleanup-eagerly t)
  )

;; Helm...
(use-package helm
  :ensure t
  :config
  (setq helm-M-x-fuzzy-match t)
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
  :config
  ;; Enable cscope 
  ;;   apt-get install cscope
  ;;   pip install pycscope
  ;;   # in project base dir:
  ;;   find . -name '*.py' > cscope.files
  ;;   cscope -R 
  (add-hook 'c-mode-common-hook 'helm-cscope-mode)
  (add-hook 'python-mode-hook 'helm-cscope-mode)
  (add-hook 'csharp-mode-hook 'helm-cscope-mode)
  )

;; imenu-list
(use-package imenu-list
  :ensure t
  :config
  (setq imenu-list-focus-after-activation t)
  (setq imenu-list-size 0.18)  
  (setq imenu-list-position 'left)
)

;; yasnippets
(use-package yasnippet
  :ensure t
  :config
  ;; Sinppets colletions for all the languages!!
  (use-package yasnippet-snippets
    :ensure t
    :config
    ;; enable yasnippet on specific modes
    (yas-reload-all)
    (add-hook 'c-mode-common-hook #'yas-minor-mode)
    (add-hook 'python-mode-hook #'yas-minor-mode)
    )
  )

;; -----------------------------
;; Programming Languages Support
;; -----------------------------

;; Python auto-complete
(use-package jedi
  :ensure t
  :config
  (add-hook 'python-mode-hook 'jedi:setup)
  (setq jedi:complete-on-dot t)
  )

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

;; Auto-complete for lisp (mainly).
(use-package auto-complete
  :ensure t
  :config
  (ac-config-default))

;; Auto-generated
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(helm-follow-mode-persistent t)
 '(package-selected-packages
   (quote
    (websocket sr-speedbar treemacs swiper counsel imenu-list evil-indent-plus helm-projectile helm-ag-r helm-ag ranger helm spacemacs-theme use-package powerline php-mode evil-surround evil-leader elpy))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

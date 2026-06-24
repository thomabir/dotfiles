;;; init.el -*- lexical-binding: t; -*-

(tool-bar-mode -1)
(setq inhibit-splash-screen t)
(set-frame-font "Iosevka Term 16" nil t)
(pixel-scroll-precision-mode 1)
(global-visual-line-mode 1)
(load-theme 'leuven t)

;; Free the right Option key for system Unicode input.
(setq ns-right-option-modifier 'none)

(require 'use-package-ensure)
(setq use-package-always-ensure t)

;; Tree-sitter (Emacs 31): offer to install missing grammars, and prefer
;; the *-ts-mode variant whenever a grammar is available.
(setq treesit-auto-install-grammar 'ask
      treesit-enabled-modes t
      treesit-font-lock-level 4)

;; Org.
(setq org-confirm-babel-evaluate nil
      org-image-actual-width 900
      org-startup-indented t
      org-hide-leading-stars t
      org-indent-indentation-per-level 1)
(org-babel-do-load-languages
 'org-babel-load-languages
 '((shell . t)
   (python . t)))

(use-package which-key
  :ensure nil
  :config (which-key-mode 1))

(use-package helm
  :bind (("M-x"     . helm-M-x)
         ("C-x C-f" . helm-find-files)
         ("C-x r b" . helm-filtered-bookmarks)))

(use-package avy
  :defer t
  :bind (("C-:"   . avy-goto-char-timer)
         ("M-g g" . avy-goto-line)
         ("M-g w" . avy-goto-word-1))
  :init (setq avy-all-windows t)
  :config (avy-setup-default))

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file) (load custom-file))

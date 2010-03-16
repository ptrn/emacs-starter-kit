;;; starter-kit-js.el --- Some helpful Javascript helpers
;;
;; Part of the Emacs Starter Kit

(autoload 'espresso-mode "espresso" "Start espresso-mode" t)
;(add-to-list 'auto-mode-alist '("\\.js$" . espresso-mode))
(add-to-list 'auto-mode-alist '("\\.json$" . espresso-mode))
;(add-hook 'espresso-mode-hook 'moz-minor-mode)
;(add-hook 'espresso-mode-hook 'esk-paredit-nonlisp)
;(add-hook 'espresso-mode-hook 'run-coding-hook)
;(add-hook 'espresso-mode-hook 'idle-highlight)
(setq espresso-indent-level 2)

;(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(add-hook 'espresso-mode-hook 'moz-minor-mode)
;(add-hook 'espresso-mode-hook 'esk-paredit-nonlisp)
(add-hook 'espresso-mode-hook 'run-coding-hook)
(add-hook 'espresso-mode-hook 'idle-highlight)
;(setq espresso-indent-level 2)

;; If you prefer js2-mode, use this instead:
;; (add-to-list 'auto-mode-alist '("\\.js$" . espresso-mode))

(eval-after-load 'espresso
  '(progn (define-key espresso-mode-map "{" 'paredit-open-curly)
          (define-key espresso-mode-map "}" 'paredit-close-curly-and-newline)
          ;; fixes problem with pretty function font-lock
          (define-key espresso-mode-map (kbd ",") 'self-insert-command)
          (font-lock-add-keywords
           'espresso-mode `(("\\(function *\\)("
                             (0 (progn (compose-region (match-beginning 1)
                                                       (match-end 1) "ƒ")
                                       nil)))))))
(eval-after-load 'js2-mode
  '(progn
     (font-lock-add-keywords
      'js2-mode `(("\\(function *\\)("
                   (0 (progn (compose-region (match-beginning 1) (match-end 1)
                                             "ƒ")
                             nil)))))
     (font-lock-add-keywords
      'js2-mode
      '(("\\<\\(FIX\\|TODO\\|FIXME\\|HACK\\|REFACTOR\\):"
         1 font-lock-warning-face t)))
     (defun js-lambda ()
       (interactive)
       (insert "function () {\n}")
       (backward-char 5))

     (add-hook 'js2-mode-hook 'run-coding-hook)
     (define-key js2-mode-map (kbd "C-c l") 'js-lambda)
))

(provide 'starter-kit-js)
;;; starter-kit-js.el ends here

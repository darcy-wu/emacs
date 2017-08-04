;; (defvar spell-checking-enable-by-default t
;;   "Enable spell checking by default.")
;; 
;; (defvar spell-checking-enable-auto-dictionary nil
;;   "Specify if auto-dictionary should be enabled or not.")
;; 
;; (defvar enable-flyspell-auto-completion nil
;;   "If not nil, show speeling suggestions in popups.")

(add-to-list 'load-path "~/.spacemacs.d/layers/darcy-use/packages/")

(defun open-my-init-file()
  (interactive)
  (find-file "~/.spacemacs.d/layers/darcy-use/config.el"))

;; verilog-mode
(require 'verilog-mode)
(autoload 'verilog-mode "verilog-mode" "Verilog mode" t )
(add-to-list 'auto-mode-alist '("\\.[ds]?vh?\\'" . verilog-mode))

;; multi-term
(require 'multi-term)
(setq multi-term-program "/bin/bash")
;; Use Emacs terminfo, not system terminfo, mac系统出现了4m
;; 如果你使用的是mac系统，发现multi-term每行出出了4m，在shell里运行下：tic -o ~/.terminfo /Applications/Emacs.app/Contents/Resources/etc/e/eterm-color.ti 
(setq system-uses-terminfo nil)


;; Be sure to examine at the help for verilog-auto, and the other
;; verilog-auto-* functions for some major coding time savers.
;;
;; If you want to customize Verilog mode to fit your needs better,
;; you may add the below lines (the values of the variables presented
;; here are the defaults). Note also that if you use an Emacs that
;; supports custom, it's probably better to use the custom menu to
;; edit these.  If working as a member of a large team these settings
;; should be common across all users (in a site-start file), or set
;; in Local Variables in every file.  Otherwise, different people's
;; AUTO expansion may result different whitespace changes.
;;
;; Enable syntax highlighting of **all** languages
(global-font-lock-mode t)

;; User customization for Verilog mode
(setq verilog-indent-level             4
      verilog-indent-level-module      4
      verilog-indent-level-declaration 4
      verilog-indent-level-behavioral  4
      verilog-indent-level-directive   1
      verilog-case-indent              4
      verilog-auto-newline             t
      verilog-auto-indent-on-newline   t
      verilog-tab-always-indent        t
      verilog-auto-endcomments         t
      verilog-minimum-comment-distance 40
      verilog-indent-begin-after-if    t
      verilog-auto-lineup              'declarations
      verilog-highlight-p1800-keywords nil
      verilog-linter                   "my_lint_shell_command"
      )


;; Auto-complete word in Emacs mini-buffer when using Evil
;; When using Evil I often input %s/old-keyword/new-keyword/g in Minibuffer.
;; The problem is auto completions of new-keyword using hippie-expand always fail.
;; It turns out that the character "/" is treated as Word constituent in minibuffer.
;; The solution is to re-define "/" as Punctuation characters:
(defun minibuffer-inactive-mode-hook-setup ()
  ;; make `try-expand-dabbrev' from `hippie-expand' work in mini-buffer
  ;; @see `he-dabbrev-beg', so we need re-define syntax for '/'
  (set-syntax-table (let* ((table (make-syntax-table)))
                      (modify-syntax-entry ?/ "." table)
                      table)))
(add-hook 'minibuffer-inactive-mode-hook 'minibuffer-inactive-mode-hook-setup)

;; Turn off linum-mode when file is too big
;; It's well known that linum-mode slows Emacs when the file contains thousands of lines.
;; Though nlinum-mode has performance, I still stick to linum-mode because git-gutter only supports linum-mode.
;; You can check the interesting discussion about git-gutter/linum-mode/nlinum-mode. Syohei Yoshida made git-gutter 95% functional when linum-mode off.
;; Here is the fix,
(defun buffer-too-big-p ()
  (or (> (buffer-size) (* 5000 80))
      (> (line-number-at-pos (point-max)) 5000)))
(add-hook 'prog-mode-hook
          (lambda ()
            ;; turn off `linum-mode' when there are more than 5000 lines
            (if (buffer-too-big-p) (linum-mode -1))))

;; my fix for tab indent
(defun zilongshanren/indent-region(numSpaces)
  (progn
                                      ; default to start and end of current line
    (setq regionStart (line-beginning-position))
    (setq regionEnd (line-end-position))

                                      ; if there's a selection, use that instead of the current line
    (when (use-region-p)
      (setq regionStart (region-beginning))
      (setq regionEnd (region-end))
      )

    (save-excursion                          ; restore the position afterwards
      (goto-char regionStart)                ; go to the start of region
      (setq start (line-beginning-position)) ; save the start of the line
      (goto-char regionEnd)                  ; go to the end of region
      (setq end (line-end-position))         ; save the end of the line

      (indent-rigidly start end numSpaces) ; indent between start and end
      (setq deactivate-mark nil)           ; restore the selected region
      )
    )
  )


(defun zilongshanren/tab-region ()
  (interactive)
  (if (use-region-p)
      (zilongshanren/indent-region 4)               ; region was selected, call indent-region
    (insert "    ")                   ; else insert four spaces as expected
    ))

(defun zilongshanren/untab-region ()
  (interactive)
  (zilongshanren/indent-region -4))

(defun zilongshanren/hack-tab-key ()
  (interactive)
  (local-set-key (kbd "<tab>") 'zilongshanren/tab-region)
  (local-set-key (kbd "<S-tab>") 'zilongshanren/untab-region)
  )

(add-hook 'prog-mode-hook 'zilongshanren/hack-tab-key)
(add-hook 'text-mode-hook 'zilongshanren/hack-tab-key)

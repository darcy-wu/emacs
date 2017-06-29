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

(require 'verilog-mode)

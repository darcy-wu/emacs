;;; packages.el --- darcy-use layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2017 Sylvain Benner & Contributors
;;
;; Author:  <kuikuiwu@BJPC000129>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;;; Commentary:

;; See the Spacemacs documentation and FAQs for instructions on how to implement
;; a new layer:
;;
;;   SPC h SPC layers RET
;;
;;
;; Briefly, each package to be installed or configured by this layer should be
;; added to `darcy-use-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `darcy-use/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `darcy-use/pre-init-PACKAGE' and/or
;;   `darcy-use/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst darcy-use-packages
  '(
    try
    ;; swiper
    ;; helm-gtags
    )
)

(defun darcy-use/init-try ()
  (use-package try
    :ensure t)
  )

;; (defun darcy-use/init-swiper ()
;;   (use-package swiper
;;     :config
;;     (global-set-key (kbd "C-s") 'swiper)
;;     )
;;   )

;; (defun darcy-use/init-helm-gtags ()
;;   (use-package helm-gtags
;;     :defer t
;;    )
;;   )

;;(defun darcy-use/init-hungry-delete()
;;  (use-package hungry-delete
;;    :config
;;    (hungry-delete-mode t)
;;    )
;;  )
;;
;;(defun darcy-use/post-init-hungry-delete()
;;  )
;;; packages.el ends here

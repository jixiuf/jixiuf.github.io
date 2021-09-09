;;; -*- coding:utf-8 -*-

;; #+OPTIONS:   H:2 num:nil toc:t \n:nil @:t ::t |:t ^:nil -:t f:t *:t <:t

;; H:         set the number of headline levels for export
;; num:       turn on/off section-numbers
;; toc:       turn on/off table of contents, or set level limit (integer)
;; \n:        turn on/off line-break-preservation (DOES NOT WORK)
;; @:         turn on/off quoted HTML tags
;; ::         turn on/off fixed-width sections
;; |:         turn on/off tables
;; ^:         turn on/off TeX-like syntax for sub- and superscripts.  If
;; you write "^:{}", a_{b} will be interpreted, but
;; the simple a_b will be left as it is.
;; -:         turn on/off conversion of special strings.
;; f:         turn on/off footnotes like this[1].
;; todo:      turn on/off inclusion of TODO keywords into exported text
;; tasks:     turn on/off inclusion of tasks (TODO items), can be nil to remove
;; all tasks, todo to remove DONE tasks, or list of kwds to keep
;; pri:       turn on/off priority cookies
;; tags:      turn on/off inclusion of tags, may also be not-in-toc
;; <:         turn on/off inclusion of any time/date stamps like DEADLINES
;; *:         turn on/off emphasized text (bold, italic, underlined)
;; TeX:       turn on/off simple TeX macros in plain text
;; LaTeX:     configure export of LaTeX fragments.  Default auto
;; skip:      turn on/off skipping the text before the first heading
;; author:    turn on/off inclusion of author name/email into exported file
;; email:     turn on/off inclusion of author email into exported file
;; creator:   turn on/off inclusion of creator info into exported file
;; timestamp: turn on/off inclusion creation time into exported file
;; d:         turn on/off inclusion of drawers

;; (require 'org-publish nil t)
(require 'ox-publish nil t)
(require 'ox-org nil t)
(require 'ob-ditaa nil t)

(setq-default
 user-full-name "纪秀峰"                ;记得改成你的名字
 user-login-name "jixiuf"
 user-mail-address "jixiuf@qq.com")
(setq load-prefer-newer t)              ;当el文件比elc文件新的时候,则加载el,即尽量Load最新文件文件

(defun vmacs-project-root ()
  "Thin (zero) wrapper over projectile to find project root."
  (let ((proj (project-current)))
    (when proj
      (if (fboundp 'project-root)
          (project-root proj)
        (car (project-roots proj))))))
(setq user-emacs-directory (expand-file-name "."))
(setq origin-default-direct default-directory)
(setq default-directory (expand-file-name  "./build/elpa" (vmacs-project-root)))
(normal-top-level-add-subdirs-to-load-path)
(setq default-directory origin-default-direct)
(if (equal system-type 'gnu/linux)
    (setq dired-listing-switches "--time-style=+%y-%m-%d/%H:%M  --group-directories-first -alhG")
  (setq dired-listing-switches "-alhG"))
(when (eq system-type 'darwin)
  (require 'ls-lisp)
  (setq-default ls-lisp-use-insert-directory-program nil))

(setq org-html-link-org-files-as-html t)


;;; the following is only needed if you install org-page manually
(require 'org-page)
(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)))

(setq org-confirm-babel-evaluate nil)

(setq op/site-main-title "拾遗笔记")
(setq op/site-sub-title "")
(setq op/personal-github-link "http://github.com/jixiuf")
(setq op/repository-directory "../")    ;must ends with /
(setq op/site-domain "http://jixiuf.github.io")
;;; for commenting, you can choose either disqus or duoshuo
(setq op/personal-disqus-shortname "jixiuf")
(setq op/personal-duoshuo-shortname "jixiuf")
(setq op/theme-root-directory (expand-file-name "./org-page-themes"))
(setq op/theme 'jixiuf_theme)
(setq op/highlight-render 'htmlize)
;;; the configuration below are optional
;; (setq op/personal-google-analytics-id "jixiuf")


;; (require 'org-exp-blocks nil t)           ;#+BEGIN_DITAA hello.png -r -S -E 要用到
(setq org-ditaa-jar-path (expand-file-name "./ditaa.jar"))
(with-eval-after-load 'org-exp-blocks  (add-to-list 'org-babel-load-languages '(ditaa . t)))

;; (declare-function org-publish "ox-publish")
;; (declare-function yas-global-mode "yasnippet")


;;;###autoload
(defun publish-my-note-recent(&optional n)
  "发布我的`note'笔记"
  (interactive "p")
  (when (zerop n) (setq n 1))
  (save-some-buffers)
  ;; (dolist (b (buffer-list))
  ;;   (when (and (buffer-file-name b)
  ;;              (file-in-directory-p (buffer-file-name b) op/repository-directory))
  ;;     (kill-buffer b)))
  (op/do-publication nil (format "HEAD~%d" n) t nil)
  ;; (publish-single-project "note-src")
  ;; ;; (publish-my-note-html)
  ;; (publish-single-project "note-html")
  ;; (view-sitemap-html-in-brower)
  (dired op/repository-directory))

;;;###autoload
(defun publish-my-note-local-preview()
  "发布我的`note'笔记"
  (interactive)
  (save-some-buffers)
  ;; (dolist (b (buffer-list))
  ;;   (when (and (buffer-file-name b)
  ;;              (file-in-directory-p (buffer-file-name b) op/repository-directory))
  ;;     (kill-buffer b)))
  (call-interactively 'op/do-publication-and-preview-site)
  (dired op/repository-directory))
;;;###autoload

(defun publish-my-note-all()
  "发布我的`note'笔记"
  (interactive)
  (save-some-buffers)
  ;; (dolist (b (buffer-list))
  ;;   (when (and (buffer-file-name b)
  ;;              (file-in-directory-p (buffer-file-name b) op/repository-directory))
  ;;     (kill-buffer b)))
  (op/do-publication t nil t t)
  (dired op/repository-directory))



(setq op/category-ignore-list  '("themes" "assets" "daily" "style" "img" "js" "author" "download" ".github"
                                 "docker" "build"
                                 "nginx" "cocos2dx" "mac"
                                 "Linux" "autohotkey" "c"   "emacs" "emacs_tutorial" "erlang" "git" "go" "java" "mysql"
                                 "oracle" "passhash.htm" "perl" "sqlserver"  "svn" "windows"))


(setq-default op/category-config-alist
  '(("blog" ;; this is the default configuration
    :show-meta t
    :show-comment t
    :uri-generator jixiuf/generate-uri
    :uri-template "/blog/%f"
    :sort-by :date     ;; how to sort the posts
    :category-index t) ;; generate category index or not
   ("index"
    :show-meta nil
    :show-comment nil
    :uri-generator jixiuf/generate-uri
    :uri-template "/"
    :sort-by :date
    :category-index nil)
   ("about"
    :show-meta nil
    :show-comment nil
    :uri-generator jixiuf/generate-uri
    :uri-template "/about"
    :sort-by :date
    :category-index nil)))


;; (add-to-list 'op/category-config-alist
;;              '("sitemap"
;;               :show-meta nil
;;               :show-comment nil
;;               :uri-generator jixiuf/generate-uri
;;               :uri-template "/blog/sitemap"
;;               :sort-by :date
;;               :category-index nil)
;;              )


(defun jixiuf/generate-uri (default-uri-template creation-date title)
  "Generate URI of org file opened in current buffer. It will be firstly created
by #+URI option, if it is nil, DEFAULT-URI-TEMPLATE will be used to generate the
uri. If CREATION-DATE is nil, current date will be used. The uri template option
can contain following parameters:
%y: year of creation date
%m: month of creation date
%d: day of creation date
%f: filename (a.org->a.html)
%t: title of current buffer"
  (let ((uri-template (or (op/read-org-option "URI")
                          default-uri-template))
        (date-list (split-string (if creation-date
                                     (fix-timestamp-string creation-date)
                                   (format-time-string "%Y-%m-%d"))
                                 "-"))
        (html-file-name (concat (file-name-base (buffer-file-name)) ".html"))
        (encoded-title (encode-string-to-url title)))
    (format-spec uri-template `((?y . ,(car date-list))
                                (?m . ,(cadr date-list))
                                (?d . ,(cl-caddr date-list))
                                (?f . ,html-file-name)
                                (?t . ,encoded-title)))))

(defun jixiuf-get-file-category (org-file)
  "Get org file category presented by ORG-FILE, return all categories if
ORG-FILE is nil. This is the default function used to get a file's category,
see `op/retrieve-category-function'. How to judge a file's category is based on
its name and its root folder name under `op/repository-directory'."
  (cond ((not org-file)
         (let ((cat-list '("index" "about" "blog"))) ;; 3 default categories
           (dolist (f (directory-files op/repository-directory))
             (when (and (not (equal f "."))
                        (not (equal f ".."))
                        (not (equal f ".git"))
                        (not (equal f "build"))
                        (not (equal f "author"))
                        (not (equal f "c"))
                        (not (equal f "erlang"))
                        (not (member f op/category-ignore-list))
                        (not (equal f "blog"))
                        (file-directory-p
                         (expand-file-name f op/repository-directory)))
               (setq cat-list (cons f cat-list))))
           cat-list))
        ((string= (expand-file-name "index.org" op/repository-directory)
                  (expand-file-name org-file)) "index")
        ;; ((string= (expand-file-name "sitemap.org" op/repository-directory)
        ;;           (expand-file-name org-file)) "sitemap")
        ((string= (expand-file-name "about.org" op/repository-directory)
                  (expand-file-name org-file)) "about")
        ((string= (file-name-directory (expand-file-name org-file))
                  op/repository-directory) "blog")

        (t "blog"                       ;changed by me ,默认都算到blog 下
           ;; (car (split-string (file-relative-name (expand-file-name org-file)
           ;;                                                   op/repository-directory)
           ;;                               "[/\\\\]+"))
           )))

(fset 'op/get-file-category 'jixiuf-get-file-category)
(setq op/retrieve-category-function 'jixiuf-get-file-category)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(bm-face ((t (:background "#272728"))))
 '(buffers-tab ((t (:background "#0C1021" :foreground "#F8F8F8"))))
 '(completions-common-part ((t (:inherit default :foreground "Cyan"))))
 '(completions-first-difference ((t (:background "black" :foreground "Gold2" :weight extra-bold :height 1.3))))
 '(cursor ((t (:background "tomato"))))
 '(custom-comment-tag ((t (:inherit default))))
 '(custom-face-tag ((t (:inherit default))))
 '(custom-group-tag ((t (:inherit variable-pitch :weight bold :height 1.2))))
 '(custom-variable-tag ((t (:inherit default :weight bold))))
 '(diff-added ((t (:foreground "OliveDrab1"))))
 '(diff-changed ((t (:foreground "yellow"))))
 '(diff-context ((t (:inherit default))))
 '(diff-file-header ((t (:foreground "tan1"))))
 '(diff-function ((t (:inherit diff-header :inverse-video t))))
 '(diff-header ((t (:foreground "light steel blue"))))
 '(diff-hunk-header ((t (:inherit diff-header :inverse-video t))))
 '(diff-index ((t (:foreground "Magenta"))))
 '(diff-nonexistent ((t (:foreground "yellow"))))
 '(diff-refine-added ((t (:background "gray26"))))
 '(diff-refine-changed ((t (:background "gray26"))))
 '(diff-refine-removed ((t (:background "gray26"))))
 '(diff-removed ((t (:inherit font-lock-comment-face :slant italic))))
 '(dired-directory ((t (:background "Blue4" :foreground "gray"))))
 '(ediff-current-diff-A ((t (:background "dark cyan"))))
 '(ediff-current-diff-Ancestor ((t (:background "dark red"))))
 '(ediff-current-diff-B ((t (:background "chocolate4"))))
 '(ediff-current-diff-C ((t (:background "sea green"))))
 '(ediff-even-diff-A ((t (:background "gray33"))))
 '(ediff-even-diff-Ancestor ((t (:background "gray40"))))
 '(ediff-even-diff-B ((t (:background "gray35"))))
 '(ediff-even-diff-C ((t (:background "gray49"))))
 '(ediff-fine-diff-A ((t (:background "cadet blue"))))
 '(ediff-fine-diff-Ancestor ((t (:background "sienna1"))))
 '(ediff-fine-diff-B ((t (:background "SlateGray4"))))
 '(ediff-fine-diff-C ((t (:background "saddle brown"))))
 '(ediff-odd-diff-A ((t (:background "gray49"))))
 '(ediff-odd-diff-B ((t (:background "gray50"))))
 '(ediff-odd-diff-C ((t (:background "gray30"))))
 '(erc-command-indicator-face ((t (:background "Purple" :weight bold))))
 '(erc-direct-msg-face ((t (:foreground "Yellow"))))
 '(erc-header-line ((t (:background "GreenYellow" :foreground "Gold"))))
 '(erc-input-face ((t (:foreground "Cyan2"))))
 '(erc-my-nick-face ((t (:foreground "Goldenrod" :weight bold))))
 '(erc-nick-default-face ((t (:foreground "Chartreuse" :weight bold))))
 '(erl-fdoc-name-face ((t (:foreground "green" :weight bold))))
 '(error ((t (:foreground "red" :weight bold))))
 '(flymake-errline ((t (:inherit error :foreground "red"))))
 '(font-lock-builtin-face ((t (:foreground "#F8F8F8"))))
 '(font-lock-comment-face ((t (:foreground "#AEAEAE"))))
 '(font-lock-constant-face ((t (:foreground "#D8FA3C"))))
 '(font-lock-doc-string-face ((t (:foreground "DarkOrange"))))
 '(font-lock-done-face ((t (:foreground "Green" :box (:line-width 2 :color "grey75" :style released-button) :height 1.2))) t)
 '(font-lock-function-name-face ((t (:foreground "#FF6400"))))
 '(font-lock-keyword-face ((t (:foreground "#FBDE2D"))))
 '(font-lock-preprocessor-face ((t (:foreground "Aquamarine"))))
 '(font-lock-reference-face ((t (:foreground "SlateBlue"))))
 '(font-lock-regexp-grouping-backslash ((t (:foreground "#E9C062"))))
 '(font-lock-regexp-grouping-construct ((t (:foreground "red"))))
 '(font-lock-string-face ((t (:foreground "light salmon"))))
 '(font-lock-todo-face ((t (:foreground "Red" :box (:line-width 2 :color "grey75" :style released-button) :height 1.2))) t)
 '(font-lock-type-face ((t (:foreground "#8DA6CE"))))
 '(font-lock-variable-name-face ((t (:foreground "#40E0D0"))))
 '(font-lock-warning-face ((t (:foreground "Pink"))))
 '(gui-element ((t (:background "#D4D0C8" :foreground "black"))))
 '(header-line ((t (:background "gray30" :distant-foreground "gray" :inverse-video nil))))
 '(helm-buffer-directory ((t (:background "Blue4" :foreground "gray"))))
 '(helm-ff-directory ((t (:background "Blue4" :foreground "gray"))))
 '(helm-grep-file ((t (:foreground "cyan1" :underline t))))
 '(helm-match ((t (:foreground "gold1"))))
 '(helm-selection ((t (:background "darkolivegreen" :underline t))))
 '(helm-source-header ((t (:background "gray46" :foreground "yellow" :weight bold :height 1.3 :family "Sans Serif"))))
 '(helm-visible-mark ((t (:background "gray43" :foreground "orange1"))))
 '(highlight ((t (:background "darkolivegreen"))))
 '(highline-face ((t (:background "SeaGreen"))))
 '(hl-paren-face ((t (:overline t :underline t :weight extra-bold))) t)
 '(isearch ((t (:background "seashell4" :foreground "green1"))))
 '(lazy-highlight ((t (:background "ivory4"))))
 '(link ((t (:foreground "cyan" :underline t))))
 '(linum ((t (:inherit (shadow default) :foreground "green"))))
 '(linum-relative-current-face ((t (:inherit linum :foreground "#FBDE2D" :weight bold))))
 '(linum-relative-face ((t (:inherit linum :foreground "dark gray"))))
 '(log-view-file ((t (:foreground "DodgerBlue" :weight bold))))
 '(log-view-message ((t (:foreground "Goldenrod" :weight bold))))
 '(magit-branch ((t (:foreground "Green" :weight bold))))
 '(magit-branch-local ((t (:foreground "coral1"))))
 '(magit-branch-remote ((t (:foreground "green1"))))
 '(magit-diff-added ((t (:inherit diff-added))))
 '(magit-diff-added-highlight ((t (:background "gray26" :foreground "green4"))))
 '(magit-diff-context ((t (:inherit diff-context))))
 '(magit-diff-file-heading ((t (:inherit diff-file-header))))
 '(magit-diff-hunk-heading ((t (:inherit diff-hunk-header :inverse-video t))))
 '(magit-diff-removed ((t (:inherit diff-removed))))
 '(magit-header ((t (:foreground "DodgerBlue"))))
 '(magit-log-author ((t (:foreground "Green"))))
 '(magit-log-date ((t (:foreground "cyan"))))
 '(magit-section-heading ((t (:background "gray29" :weight bold))))
 '(minibuffer-prompt ((t (:foreground "salmon1"))))
 '(mode-line ((t (:background "grey75" :foreground "black"))))
 '(mode-line-buffer-id ((t (:background "dark olive green" :foreground "beige"))))
 '(mode-line-highlight ((((class color) (min-colors 88)) nil)))
 '(mode-line-inactive ((t (:background "dark olive green" :foreground "dark khaki" :weight light))))
 '(org-agenda-date ((t (:inherit org-agenda-structure))))
 '(org-agenda-date-today ((t (:inherit org-agenda-date :underline t))))
 '(org-agenda-date-weekend ((t (:inherit org-agenda-date :foreground "green"))))
 '(org-agenda-done ((t (:foreground "#269926"))))
 '(org-agenda-restriction-lock ((t (:background "#FFB273"))))
 '(org-agenda-structure ((t (:foreground "gold1" :weight bold))))
 '(org-date ((t (:foreground "medium sea green" :underline t))))
 '(org-document-info ((t (:foreground "tomato1"))))
 '(org-document-title ((t (:foreground "orchid1" :weight bold))))
 '(org-done ((t (:foreground "green" :weight bold))))
 '(org-drawer ((t (:foreground "purple1"))))
 '(org-ellipsis ((t (:foreground "#FF7400" :underline t))))
 '(org-footnote ((t (:foreground "#1240AB" :underline t))))
 '(org-hide ((t (:foreground "gray20"))))
 '(org-level-1 ((t (:inherit outline-1 :box nil))))
 '(org-level-2 ((t (:inherit outline-2 :box nil))))
 '(org-level-3 ((t (:inherit outline-3 :box nil))))
 '(org-level-4 ((t (:inherit outline-4 :box nil))))
 '(org-level-5 ((t (:inherit outline-5 :box nil))))
 '(org-level-6 ((t (:inherit outline-6 :box nil))))
 '(org-level-7 ((t (:inherit outline-7 :box nil))))
 '(org-level-8 ((t (:inherit outline-8 :box nil))))
 '(org-scheduled-previously ((t (:foreground "#FF7400"))))
 '(org-table ((t (:foreground "cyan"))))
 '(org-tag ((t (:weight bold))))
 '(org-todo ((t (:foreground "#FF6961" :weight bold))))
 '(region ((t (:background "DarkSlateGray"))))
 '(term-color-blue ((t (:background "#85aed9" :foreground "#85aed9"))))
 '(term-color-green ((t (:background "#ceffa0" :foreground "#ceffa0"))))
 '(term-color-magenta ((t (:background "#ff73fd" :foreground "#ff73fd"))))
 '(term-color-red ((t (:background "#ff6d60" :foreground "#ff6d60"))))
 '(term-color-yellow ((t (:background "#d1f13c" :foreground "#d1f13c"))))
 '(text-cursor ((t (:background "yellow" :foreground "black"))))
 '(tooltip ((t (:inherit variable-pitch :background "systeminfowindow" :foreground "DarkGreen" :height 2.5))))
 '(underline ((nil (:underline nil))))
 '(vhl/default-face ((t (:background "DarkSlateGray"))))
 '(vmacs-scroll-highlight-line-face ((t (:background "cadetblue4" :foreground "white" :weight bold))))
 '(warning ((t (:foreground "Salmon" :weight bold))))
 '(web-mode-html-tag-bracket-face ((t (:inherit web-mode-html-tag-face))))
 '(woman-addition ((t (:inherit font-lock-builtin-face :foreground "Tan2"))))
 '(woman-bold ((t (:inherit bold :foreground "yellow2"))))
 '(woman-italic ((t (:inherit italic :foreground "green"))))
 '(woman-unknown ((t (:inherit font-lock-warning-face :foreground "Firebrick")))))

(provide 'org-publish)

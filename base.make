; Version and API
core = 7.x
api = 2

; Modules ======================================================================

; Admin ========================================================================
projects[admin_menu][type] = "module"
projects[admin_menu][subdir] = "contrib"

; Ctool/Context ================================================================
projects[ctools][type] = "module"
projects[ctools][subdir] = "contrib"

; Development ==================================================================
projects[devel][type] = "module"
projects[devel][subdir] = "contrib"

projects[backup_migrate][type] = "module"
projects[backup_migrate][subdir] = "contrib"

; Field related ================================================================
projects[link][type] = "module"
projects[link][subdir] = "contrib"

projects[entity][type] = "module"
projects[entity][subdir] = "contrib"

; Menu =========================================================================

; Other ========================================================================

projects[token][type] = "module"
projects[token][subdir] = "contrib"

projects[module_filter][type] = "module"
projects[module_filter][subdir] = "contrib"

; Performance ==================================================================
projects[entitycache][type] = "module"
projects[entitycache][subdir] = "contrib"

; Rules ========================================================================
projects[rules][type] = "module"
projects[rules][subdir] = "contrib"

; Security =====================================================================
projects[mollom][type] = "module"
projects[mollom][subdir] = "contrib"


; SEO ==========================================================================
projects[globalredirect][type] = "module"
projects[globalredirect][subdir] = "contrib"

projects[google_analytics][type] = "module"
projects[google_analytics][subdir] = "contrib"

projects[metatag][type] = "modules"
projects[metatag][subdir] = "contrib"

projects[pathauto][type] = "module"
projects[pathauto][subdir] = "contrib"

projects[xmlsitemap][type] = "module"
projects[xmlsitemap][subdir] = "contrib"

; Views ========================================================================
projects[views][type] = "module"
projects[views][subdir] = "contrib"

; projects[views_bulk_operations][type] = "module"
; projects[views_bulk_operations][subdir] = "contrib"
; projects[views_slideshow][type] = "module"
; projects[views_slideshow][subdir] = "contrib"

; Webform ======================================================================
projects[webform][type] = "module"
projects[webform][subdir] = "contrib"


; WYSIWYG ======================================================================
projects[imce][type] = "module"
projects[imce][subdir] = "contrib"

projects[wysiwyg][type] = "module"
projects[wysiwyg][subdir] = "contrib"

projects[imce_wysiwyg][type] = "module"
projects[imce_wysiwyg][subdir] = "contrib"


; Themes =======================================================================
projects[rubik][type] = "theme"
projects[tao][type] = "theme"

; Third party libraries ========================================================
libraries[tinymce][download][type] = get
libraries[tinymce][download][url] = https://github.com/downloads/tinymce/tinymce/tinymce_3.5.8.zip
libraries[tinymce][directory_name] = tinymce


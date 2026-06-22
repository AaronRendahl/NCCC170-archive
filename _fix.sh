perl -pi -e 's/index.html%3Fsccss=1&amp;ver=6.0.2.css/nccc170.css/g' *.html 

perl -pi -e 's/index.html%3Fp=([0-9]+).html/p\1.html/g' */*.html

perl -pi -e 's/<link rel="alternate".*$//g' */*.html
perl -pi -e "s/<link rel='dns-prefetch'.*$//g" *.html
perl -pi -e "s/^jQuery.*$//g" *.html

perl -pi -e 's/<p id="footer-info">.*//g' */*.html
perl -pi -e 's/body{--wp--preset--color--black.*//g' */*.html

perl -pi -e 's/<link rel="wlwmanifest".*//g' */*.html
perl -pi -e 's/<link rel="pingback".*//g' *.html

perl -pi -e 's/<meta http-equiv="X-UA-Compatible" content="IE=edge">//'g *.html

perl -pi -e 's|<p><a href="http://wordpressua.uark.edu/wp-admin">Site admin</a></p>||g' */*.html
perl -pi -e 's|<link rel="https://api.w.org/" href="../wp-json/index.html" />||g' */*.html
perl -pi -e 's|<meta name="generator".*||g' */*.html
perl -pi -e 's|<meta content="UARK Divi Theme - Fullwidth v.1.0.0" name="generator"/>||g' *.html

perl -pi -e 's|<a href="https://nccc170.uark.edu/nccc170report17-1k61t7c/NCCC170Report17-1k61t7c.pdf">||g' *.html
perl -pi -e 's|^</a>||' *.html

perl -pi -e 's|.*\.container.*||' *.html
perl -0777 -i -pe 's|<div class="et_search_outer">.*close_search_field">\s*</span>\s*</div>\s*</div>||s' *.html

perl -0777 -i -pe 's|<div id="et_top_search">.*toggle">\s*</span>\s*</div>\s*</div>||sg' *.html
perl -0777 -i -pe 's|<h5 id="logo-tagline">\s*</h5>||sg' *.html

## remove blank lines
perl -i -ne 'print if /\S/' *.html
perl -i -ne 'print if /\S/' */*.html

perl -0777 -i -pe "s|<p>\s*</p>||gs" *.html


## remove rest of canonical links
grep '<link rel="canon' *.html
grep "<link rel='short" *.html
perl -pi -ne 's|<link rel="canon.*||g' *.html
perl -pi -ne "s|<link rel='short.*||g" *.html

perl -pi -ne "s|<link rel='stylesheet' id='wtfdivi-user-css-css.*||" *.html
perl -pi -ne "s|<script type='text/javascript' src='https://wordpressua.*||" *.html

perl -pi -ne 's|<img alt="NCCC 170".*||g' *.html


perl -0777 -i -pe 's!<style>\s*/. Display.*important;\s*}\s*</style>!!gs' *.html
perl -0777 -i -pe 's!<style type.*CDATA.* \*/\s*</style>!!gs' *.html
perl -0777 -i -pe 's!<style>\s*#et_builder.*30px}\s*</style>!!gs' *.html
perl -0777 -i -pe 's!<style type.*hidden}\s*</style>!!gs' *.html

perl -0777 -i -pe 's|<style id="global-styles-inline-css" type="text/css">\s*</style>||gs' *.html

## updated font stylesheet
perl -pi -ne 's|<style id="et-builder-googlefonts-cached-inline">.*</style>|<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Lato" />|g' *.html

perl -0777 -i -pe "s|<style id='wp-block-library-theme-inline-css.*0000}.</style>|<link rel='stylesheet' id='wp-block-library-theme-inline-css' href='style_theme_inline.css' type='text/css' media='all' />|gs" *.html
perl -0777 -i -pe "s|<style id=\"et-divi-customizer-global-cached-inline-styles\">.*24%}</style>|<link rel='stylesheet' id='et-divi-customizer-global-cached-inline-styles' href='style_cached_inline.css' type='text/css' media='all' />|gs" *.html

perl -pi -ne 's|wp-includes/css/dist/block-library/style.min.css\?ver=6.0.2.css|wp-block-library.style.min.css|g' *.html


### remove footer and svg
perl -0777 -i -pe 's|<footer.*</footer> <!-- #main-footer -->||gs' *.html
perl -pi -e 's|<svg.*</svg> *||g' *.html
perl -pi -e 's|<meta.*||g' *.html

#perl -pi -e 's|%3F|\?|g' *.html

### remove scripts
perl -0777 -i -pe 's|</script>|<XXX>|' *.html
perl -0777 -i -pe 's|<script.*<XXX>||gs' *.html
perl -i -ne 'print if /\S/' *.html
grep "</script>" *.html

perl -pi -ne "s|<\!-- Google Analytics tracking.*||" *.html

perl -0777 -i -pe 's!><style!>\n<style!g' *.html
perl -0777 -i -pe 's!</style><!</style>\n<!g' *.html

############
### fix duplicate pages
orig="p679"
grep $orig *.html
grep $orig */*.html

dup="meeting20"
new="meeting-2017"
perl -pi -e 's|[.][.]/||g' $dup/index.html
diff $orig.html $dup/index.html

perl -pi -ne 's|<link rel="canon.*||g' $dup/index.html
perl -pi -ne "s|<link rel='short.*||g" $dup/index.html
perl -i -ne 'print if /\S/' *.html
mv $orig.html $new.html
rm $dup/index.html
ls $dup

rmdir $dup
perl -pi -ne "s|$orig.html|$new.html|g" *.html

grep $orig *.html
grep $orig */*.html

###########
## redo links to files
orig="files/2018/0./"
new="meeting-2017/"
grep $orig *.html
perl -pi -ne "s|$orig|$new|g" meeting-2017.html
mv $orig $new


##########
## extract images
orig="photos-2019.pdf"
new="photos2019"
pdfimages -list $orig
pdfimages -all $orig $new

jhead -ft -cmd "mogrify -sampling-factor 4:2:0 -strip -quality 75 -interlace JPEG &i" *.jpg


magick photos2019-007*.jpg -append photos2019-007.jpg

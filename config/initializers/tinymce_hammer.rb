Tinymce::Hammer.plugins  = ['paste,pagebreak,style,layer,advhr,iespell,media,contextmenu,directionality,nonbreaking,xhtmlxtras']

Tinymce::Hammer.languages = ['en']

Tinymce::Hammer.themes = ['advanced']

Tinymce::Hammer.init = [
      [:paste_convert_headers_to_strong, true],
      [:paste_convert_middot_lists, true],
      [:paste_remove_spans, true],
      [:paste_remove_styles, true],
      [:paste_strip_class_attributes, true],
      [:theme, 'advanced'],
      [:theme_advanced_toolbar_align, 'left'],
      [:theme_advanced_toolbar_location, 'top'],
      [:theme_advanced_buttons1, 'undo,redo,cut,copy,paste,pastetext,|,bold,italic,strikethrough,blockquote,charmap,bullist,numlist,removeformat,|,link,unlink,image,|,cleanup,code'],
      [:theme_advanced_buttons2, 'justifyleft,justifycenter,justifyright,justifyfull,|,styleselect,formatselect,fontselect,fontsizeselect,|,cite,abbr,acronym,del,ins,attribs,|,visualchars,nonbreaking,template,blockquote,pagebreak'],
      [:theme_advanced_buttons3, ''],
      [:valid_elements, "a[href|title],blockquote[cite],br,caption,cite,code,dl,dt,dd,em,i,img[src|alt|title|width|height|align],li,ol,p,pre,q[cite],small,strike,strong/b,-h1,-h2,-h3,-h4,-h5,sub,sup,u,ul,script[language|type|src],div[id|style|class]"],
    ]
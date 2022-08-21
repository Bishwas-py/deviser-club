require 'pagy/extras/support'

# default :empty_page (other options :last_page and :exception )
Pagy::DEFAULT[:overflow] = :last_page

# OR
require 'pagy/countless'
require 'pagy/extras/overflow'

# default :empty_page (other option :exception )
Pagy::DEFAULT[:overflow] = :exception

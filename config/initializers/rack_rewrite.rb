Rails.application.config.middleware.insert_before(Rack::Runtime, Rack::Rewrite) do

  # Redirect all http traffic to https
  if ENV['REDIRECT_ALL_TRAFFIC'].present?
    # redirect http to https
    r301 %r{.*}, 'https://covoiturage-libre.fr$&', scheme: 'http'
    # redirect all subdomains except from 'dons'
    r301 %r{.*}, 'https://covoiturage-libre.fr$&', :if => Proc.new {|rack_env|
      rack_env['SERVER_NAME'] != 'covoiturage-libre.fr' && rack_env['SERVER_NAME'] != 'dons.covoiturage-libre.fr'
    }
    r301 %r{.*}, 'https://www.helloasso.com/associations/covoiturage-libre-fr/collectes/campagne-courante/$&', :if => Proc.new {|rack_env|
      rack_env['SERVER_NAME'] == 'dons.covoiturage-libre.fr'
    }
  end

  # static pages
  r301 '/association_descriptif.php', '/association'
  r301 '/association-descriptif.php', '/association'
  r301 '/infos.php', 'http://wiki.covoiturage-libre.fr/index.php?title=Accueil'
  r301 '/presse.php', '/presse'
  r301 '/mentions-legales.php', '/mentions-legales'
  r301 '/association.php', 'https://www.helloasso.com/associations/covoiturage-libre-fr/collectes/campagne-courante/'
  r301 '/missions.php', 'missions-benevoles'
  r301 '/contact.php', '/contact'
  r301 '/bug.php', '/bug'
  r301 '/manif_14juin.php', '/manif_14juin'
  r301 '/stickers.php', '/stickers'
  r301 '/pourquoi.php', 'http://wiki.covoiturage-libre.fr/index.php?title=Le_covoiturage_est_un_bien_commun'
  r301 '/faq.php', '/faq'
  r301 '/metamoteur.php', '/metamoteur' # TODO transfer this page on the wiki ?
  r301 '/fonctionnement-etapes.html', '/fonctionnement-etapes'
  r301 '/infos-assurance.php', '/calculer'
  r301 '/PDFs/cp_cvl_2016-04-21.pdf', 'http://blog.covoiturage-libre.fr/2016/04/21/la-seconde-plateforme-francaise-de-covoiturage-devient-un-bien-commun/'

  # dynamic pages
  r301 '/recherche.php', '/recherche'
  r301 '/nouveau.php', '/trajets/nouveau'

  r301 %r{/detail\.php\?c=(\w+).*}, '/trajets/$1'
  r301 %r{/validation\.php\?c=(\w+).*}, '/trajets/$1/confirmer'
  r301 %r{/modification\.php\?m=(\w+).*}, '/trajets/$1/editer'
  r301 %r{/suppression\.php\?supp=(\w+).*}, '/trajets/$1/supprimer'

  r301 %r{/nouveau\.php\?c=(\w+)\&a\=r\&c2\=.+}, '/trajets/$1/creer_retour'
  r301 %r{/nouveau\.php\?c=(\w+)\&a\=d\&c2\=.+}, '/trajets/$1/dupliquer'

  # bad pages
  r301 %r{/trajets\?c=(\w+).*}, '/trajets/$1'
  r301 '/index_css.css', '/'
  r301 '/telephone.php', '/'
  r301 '/wp-login.php', '/'
  r301 '/index.php', '/'

end

# Lecoincoin : groupe "LeGrailsGrails" - Saad el din AHMED & Hugo NORTIER
---

A l'occasion des 80 ans de Lecoincoin, nous avons réalisé une plateforme en ligne complète proposant:
- un backend permettant d'administrer les annonces, les modifier, les supprimer et même en créer;
- une API REST poiur que des clients puissent créer leurs annonces.

### SE CONNECTER
Pour se connecter aux différents comptes pré-créés, vous pouvez utiliser la combinaison "identifiant/mot de passe" suivante :
- "admin/admin" qui possédera le ROLE_ADMIN ;
- "modo/modo" qui possédera le ROLE_MODERATOR ;
- "client/client" qui possédera le ROLE_CLIENT.

Admin et Modo peuvent accéder au backend.

### BACKEND
- Pour la mise à niveau du site, nous avons repris le html généré par les beans de grails et les avons modifiés pour prendre en compte les exigences du client :
  - quand on crée un client, il sera possible de lui affecter un rôle dans le formulaire, ce rôle pourra être aussi modifié dans la page de modification.
  - la gestion des illustrations s'effectue entièrement dans l'annonce.
  - à la création d'une annonce on peut ajouter plusieurs illustrations qui seront retrouvées par le controlleur à travers le body de la requête, sauvegardées puis affectées à l'annonce associée ; ces illustrations peuvent être ensuite supprimées dans la page de modification de l'annonce.
- Les pages html ont été modifiées pour afficher du contenu différent par rapport au rôle de l'utilisateur connecté.
- Certaines options dans les formulaires ont été cachés selon le niveau d'autorité de l'utilisateur.
- Les 3 rôles que nous avons créé avec des droits différents sont :
  - ROLE_ADMIN : accède à l'interface administrateur, peut tout faire, inclus créer, modifier et supprimer des utilisateurs.
  - ROLE_MODERATOR : accède à l'interface administrateur, peut uniquement créer, supprimer ou modifier des annonces.
  - ROLE_CLIENT : accède à l'interface client lui montrant une vue sur toutes les annonces publiées sur le site. Il pourra uniquement ajouter et supprimer ses propres annonces.

### API REST
Premièrement, toutes les requêtes de l'API REST sont disponibles dans une [collection postman](https://github.com/Master-2-MIAGE-MBDS/grails-lecoincoin-legrailsgrails/blob/master/Lecoincoin_LeGrailsGrails.postman_collection.json)
- L'API REST permet de s'identifier via localhost:8081/api/login (voir "login" dans la collection POSTMAN)
- L'API REST prend en charge les méthodes GET / PUT / PATCH et DELETE sur un  **utilisateur** et sur une **anonce**
- L'API REST prend en charge les méthodes GET et POST sur une listes d'**utilisateurs** ou d'**annonces**
- L’API est capable de renvoyer du JSON ou du XML en fonction du header Accept pour une annonce, pour les méthodes GET d'utilisateur et de liste d'utilisateurs
- L’API prend donc en charge les ressources individuelles (voir user et annonce dans la collection POSTMAN) ou bien une collection (voir users et annonces dans la collection POSTMAN)
- [BONUS] Ajout non demandé par M. et Mme Lecoincoin => Un utilisateur peut avoir plusieurs Rôles (authorities). Par défaut, un nouvel utilisateur a le rôle (authority) client et si un rôle inexistant lui ai donné, alors l'API ignore cette authority. Ce choix qui a été fait aurait pu aisément être remplacé par une levée d'erreur si aucun authority valable n'était donnée à l'utilisateur... Exemple:
```json
{
    "username": "TataYoyo 1",
    "password": "TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT",
    "authorities": [
        {
            "authority": "ROLE_CLIENT"
        },
        {
            "authority": "ROLE_ADMIN"
        }
    ]
}
```

### DEPLOYEMENT SUR HEROKU
- [BONUS] Vous pouvez trouver le site déployé au lien suivant : https://legrailsgrails.herokuapp.com.
- Pour déployer sur Heroku, nous avons modifié les basePath et baseUrl dans le "application.yml" pour qu'ils pointent vers le site déployé, de plus nous avons permis la création d'une base h2 en production.
- Nous avons aussi modifié le build.gradle pour avoir un webapp-runner permettant de tourner grails.
- Les modifications se trouvent sur une branche Heroku afin d'avoir un projet dans la branche main qui marche en local.
- Remarque : Nous n'avons pas stocké les images dans un hébergeur cloud. Par conséquence, après l’ajout d'une nouvelle annonce, les images ne seront pas visualisables (elles sont sauvegardées en tant que fichiers statiques).

### AMELIORATIONS POSSIBLES
- Améliorer l'interface client pour être esthétiquement + diffèrente de celle admin.
- Héberger les images dans le cloud pour le site déployé sur Heroku (performances).
- Gérer le cas où une annonce est créée avec 0 ou 1 illustration dans le backend

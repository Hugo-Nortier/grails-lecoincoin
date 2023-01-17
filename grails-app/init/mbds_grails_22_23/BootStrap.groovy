package mbds_grails_22_23

import com.mbds.grails.Annonce
import com.mbds.grails.Illustration
import com.mbds.grails.Role
import com.mbds.grails.User
import com.mbds.grails.UserRole

class BootStrap {

    def init = { servletContext ->
        // client et son rôle
        def clientUserInstance = new User(username: "client",password: "client").save()
        def clientRole = new Role(authority: "ROLE_CLIENT").save()
        UserRole.create(clientUserInstance, clientRole, true)

        // modérateur et son rôle
        def moderatorUserInstance = new User(username: "modo",password: "modo").save()
        def moderatorRole = new Role(authority: "ROLE_MODERATOR").save()
        UserRole.create(moderatorUserInstance, moderatorRole, true)

        def adminUserInstance = new User(username: "admin",password: "admin").save()
        def adminRole = new Role(authority: "ROLE_ADMIN").save()
        UserRole.create(adminUserInstance, adminRole, true)

        // On boucle sur une liste de 5 prénoms
        ["Alice", "Bob", "Charly", "Denis", "Etienne"].each {
            String username ->
                // On crée les utilisateurs associés
                def userInstance = new User(username: username, password: "password")
                List titre = ['Vélo', 'Réfrigérateur', 'Lampadaire', 'Bracelet en or', 'Jeu Monopoly', 'CD de Nirvana', 'Picsou Magazine', 'Pokemon evoli shiny', 'Maillot de football', 'Skateboard', 'Pull de Noël', 'Lot de casseroles', 'Biberon pour nourrisson', 'Jeu Call of Duty AW', 'Ordinateur gaming', 'Pantalon XXL']
                List desc = ['neuf', 'quasi neuf', 'en excellent état', 'abîmé', 'très abîmé', 'très peu servi', 'pour cause de déménagement', 'car je ne l\'utilise plus']

                // Pour chaque utilisateur on boucle 5 fois
                (1..8).each {
                    Integer index ->
                        String title = titre.get(new Random().nextInt(titre.size()))
                        titre.remove(title)
                        def description = " "+desc.get(new Random().nextInt(desc.size()))
                        // Pour ajouter 5 annonces par utilisateur
                        def annonceInstance = new Annonce(title: username + " vends un " + title, description: "Je vends ce "+title+ description, price: new Random().nextInt(240-10)+10, active: Boolean.TRUE)
                        (1..5).each {
                            // Et enfin 5 illustrations par annonce
                            annonceInstance.addToIllustrations(new Illustration(filename: "grails"+it+".svg"))
                        }
                        // On associe l'annonce créée à l'utilisateur
                        userInstance.addToAnnonces(annonceInstance)
                        // Et on sauvegarde l'utilisateur qui va sauvegarder ses annonces qui sauvegarderont leurs illustrations
                        userInstance.save(flush: true, failOnError: true)
                        UserRole.create(userInstance, clientRole, true)
                }
        }
    }
    def destroy = {

    }
}

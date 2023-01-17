package com.mbds.grails

import grails.gorm.transactions.Transactional
import grails.validation.ValidationException

@Transactional
class ApiService {

    def serviceMethod() {
    }

    def creerAnnonce(title, desc, price, illustrations, author, path) {
        def annonce = new Annonce(title: title, description: desc, price: price, active: true, author: author)

        if (annonce) {
            if (illustrations != null && !illustrations.size() != 0) {
                def i = 0
                illustrations.each {
                    def value = it.toString().split(":")[1]
                    value = value.replace("}", "")
                    value = value.replace("\"", "")
                    def filename = "annonce_" + annonce.title + "_illustration" + i + ".png"
                    def finalpath = path + "/" + filename
                    byte[] data = Base64.getDecoder().decode(value)
                    OutputStream os = new FileOutputStream(finalpath);
                    os.write(data);
                    def illustration = new Illustration(filename: filename)
                    annonce.addToIllustrations(illustration)
                    i++
                }
            }
            try {
                println annonce.toString()
                annonce.save(flush: true, failOnError: true)
            } catch (ValidationException e) {
                e.printStackTrace()
                return false
            }
            return true
        }
        return false
    }

    // si un User a pu être créé, on renvoit True sinon false
    def creerUser(username, password, ArrayList<String> role) {
        def user = new User(username: username, password: password, accountExpired: false, accountLocked: false, passwordExpired: false, enabled: true).save()
        if (user) {
            if (role.isEmpty() || (!role.contains("ROLE_CLIENT") && !role.contains("ROLE_ADMIN") && !role.contains("ROLE_MODERATOR")))
                UserRole.create(user, Role.findByAuthority("ROLE_CLIENT"), true)
            for(String s : role){
                if ("ROLE_CLIENT" == s || "ROLE_ADMIN" == s || "ROLE_MODERATOR" == s) //Création UserRole
                    UserRole.create(user, Role.findByAuthority(s), true)
            }
            return true
        }
        return false
    }
}

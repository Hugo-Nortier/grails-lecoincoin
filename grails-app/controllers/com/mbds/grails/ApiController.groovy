package com.mbds.grails

import grails.converters.JSON
import grails.converters.XML
import grails.plugin.springsecurity.annotation.Secured
import org.springframework.http.HttpMethod

@Secured(['ROLE_ADMIN','ROLE_CLIENT','ROLE_MODERATOR'])
class ApiController {

    ApiService apiService;
    /**
     * Singleton
     * Gestion des points d'entrée : GET / PUT / PATCH / DELETE
     */
    def annonce() {
        // On vérifie qu'un ID ait bien été fourni
        if (!params.id)
            return response.status = 400
        // On vérifie que l'id corresponde bien à une instance existante
        def annonceInstance = Annonce.get(params.id)
        if (!annonceInstance)
            return response.status = 404
        switch (request.getMethod()) {
            case "GET":
                renderThis(request.getHeader("Accept"), annonceInstance)
                break;
            case "PUT":
                def ct = request.getContentType()
                def collection;
                def requestbody;
                Set<?> properties = annonceInstance.getProperties().keySet()
                properties.remove("illustrations")
                properties.remove("dateCreated")
                properties.remove("lastUpdated")
                switch (ct) {
                    case "application/json":
                        requestbody = request.getJSON()
                        collection = requestbody
                        break;
                    case "application/xml":
                        requestbody = request.getXML()
                        collection = []
                        requestbody.each {
                                // pour la balise root
                            thing ->
                                // pour chaque noeud dans le root, on retrouve le nom de la balise ainsi que le contenu
                                thing.children().each { tag ->
                                    def text = tag.text()
                                    // un exemple de balise author: <author id="4" />
                                    // on voit que l'id voulu est un attribut de la balise
                                    if (tag.name() == "author")
                                        text = tag.@id
                                    collection.push(tag.name() + "=" + text)
                                }
                        }
                        break
                    default:
                        return response.status = 400
                        break
                }
                collection.collect().each {
                    // donne chaque key présente dans la collection
                    def key = it.toString().split("=")[0]
                    def value = it.toString().split("=")[1]
                    // on retire du Set toutes les key qui sont dans le body
                    if (properties.contains(key)) {
                        // on transforme la String du price en Float
                        if (key.equals("price"))
                            value = Float.parseFloat(it.toString().split("=")[1])
                        if (key.equals("author")) {
                            value = User.get(value)
                        }
                        // le putAt est nécessaire pour le XML
                        annonceInstance.putAt(key, value)
                        properties.remove(key)
                    }
                    if (key == "author") properties.remove("authorId")
                }
                // si il reste encore des values dans le Set, c'est que le body n'avait pas toutes les valeurs demandées
                // pour que le put modifie l'utilisateur. Alors on renvoit une BadRequest
                if (properties.size() != 0)
                    return response.status = 400
                // si c'est un Json, les properties sont utilisables directement
                if (ct.equals("application/json"))
                    annonceInstance.properties = requestbody
                annonceInstance.save(flush: true)
                return response.status = 200

                break;
            case "PATCH":
                def ct = request.getContentType()
                switch (ct) {
                    case "application/json":
                        annonceInstance.properties = request.getJSON()
                        break
                    case "application/xml":
                        request.getXML().each {
                                // pour la balise root
                            thing ->
                                // pour chaque noeud dans le root, on retrouve le nom de la balise ainsi que le contenu
                                thing.children().each { tag ->
                                    def text = tag.text()

                                   if (tag.name().equals("price"))
                                        text = Float.parseFloat(tag.text())
                                    if (tag.name() == "author")
                                        text = User.get(tag.@id)
                                    annonceInstance.putAt(tag.name(),text)
                                }
                        }
                        break
                    default:
                        return response.status = 400
                        break
                }
                annonceInstance.save(flush: true)
                return response.status = 200
                break
            case "DELETE":
                annonceInstance.delete(flush: true)
                return response.status = 200
                break
            default:
                return response.status = 405
                break
        }
        return response.status = 406
    }

    /**
     * Collection
     * POST / GET
     */
    def annonces() {
        def annonceListInstance = Annonce.list()
        if (!annonceListInstance)
            return response.status = 404
        switch(request.getMethod()) {
            case "GET":
                renderThis(request.getHeader("Accept"), annonceListInstance)
                return response.status = 200
                break
            case "POST":
                if(!request.JSON.title || !request.JSON.description || !request.JSON.price || !request.JSON.illustrations)
                    return response.status = 400
                if(apiService.creerAnnonce(request.JSON.title, request.JSON.description, request.JSON.price, request.JSON.illustrations.collect(),request.JSON.author,grailsApplication.config.illustrations.basePath))
                    return response.status = 201
                else{
                    response.status=400
                    withFormat { json { render ([status : 400, message : "L'annonce "+request.JSON.title+" n'a pas été créée"] as JSON)}}
                }
                break
            default:
                return response.status = 405
                break
        }
    }

    def user() {
        // On vérifie qu'un ID ait bien été fourni
        if (!params.id)
            return response.status = 400
        // On vérifie que l'id corresponde bien à une instance existante
        def userInstance = User.get(params.id)
        if (!userInstance)
            return response.status = 404
        switch (request.getMethod()) {
            case "GET":
                def userMap = [
                        user       : userInstance,
                        authorities: userInstance.getAuthorities()
                ]
                renderThis(request.getHeader("Accept"), userMap)
                break
            case "PUT":
                // si on ne chnage ni le password ni l'username ni les deux
                if(!(request.JSON.username || request.JSON.password))
                    return response.status = 400
                userInstance.properties = request.JSON
                if (userInstance.save(flush:true))
                    return response.status = 200
                else {
                    response.status = 400
                    withFormat { json { render ([status : 400, message : "L'utilisateur "+params.id+" n'a pas été modifié"] as JSON)}}
                }
                break
            case "PATCH":
                userInstance.properties = request.JSON
                if (userInstance.save(flush:true))
                    return response.status = 200
                else {
                    response.status = 400
                    withFormat { json { render ([status : 400, message : "L'utilisateur "+params.id+" n'a pas été modifié"] as JSON)}}
                }
                break
            case "DELETE":
                userInstance.delete(flush: true)
                return response.status = 200
                break
            default:
                return response.status = 405
                break
        }
    }

    def users() {
        def usersList = User.list()
        if (!usersList)
            return response.status = 404
        switch(request.getMethod()) {
            case "GET" :
                renderThis(request.getHeader("Accept"), usersList)
                break
            case "POST" :
                if(!request.JSON.username || !request.JSON.password || !request.JSON.authorities.authority)
                    return response.status = 400
                if(User.findByUsername(request.JSON.username)) {
                    response.status=400
                    withFormat { json { render ([status: 400, message : "L'username n'est pas disponible"] as JSON)}}
                }
                if(apiService.creerUser(request.JSON.username, request.JSON.password, request.JSON.authorities.authority))
                    return response.status = 201
                else{
                    response.status=400
                    withFormat { json { render ([status: 404, message : "L'utilisateur "+request.JSON.username+" n'a pas été créé"] as JSON)}}
                }
                break
            default:
                return response.status= 405
                break
        }
    }

    def renderThis(String acceptHeader, Object object) {
        switch (acceptHeader) {
            case 'xml':
            case 'text/xml':
            case 'application/xml':
                render object as XML
                break
            case 'json':
            case 'text/json':
            case 'application/json':
                render object as JSON
                break
        }
    }
}

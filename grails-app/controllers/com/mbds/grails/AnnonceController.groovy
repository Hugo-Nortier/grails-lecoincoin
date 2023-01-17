package com.mbds.grails

import grails.plugin.springsecurity.annotation.Secured
import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*

@Secured(['ROLE_ADMIN','ROLE_MODERATOR','ROLE_CLIENT'])

class AnnonceController {

    AnnonceService annonceService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond annonceService.list(params), model:[annonceCount: annonceService.count()]
    }

    def show(Long id) {
        respond annonceService.get(id)
    }

    def create() {
        respond new Annonce(params)
    }


    def save(Annonce annonce) {
        def annonceInstance = new Annonce(title: params.title, description: params.description, price: params.price, active: params.active, author:params.author)

        List fileList = request.getFiles('illustrations') // 'files' is the name of the input
        fileList.each { file ->
            def finalpath = grailsApplication.config.illustrations.basePath+"/"+file.getOriginalFilename()
            file.transferTo(new File(finalpath))
            annonceInstance.addToIllustrations(new Illustration(filename:file.getOriginalFilename()))
        }

        if (annonce == null) {
            notFound()
            return
        }

        try {

            annonceService.save(annonceInstance)
        } catch (ValidationException e) {
            respond annonceInstance.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'annonce.label', default: 'Annonce'), annonceInstance.id])
                redirect annonceInstance
            }
            '*' { respond annonceInstance, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond annonceService.get(id)
    }

    def update(Annonce annonce) {
        if (annonce == null) {
            notFound()
            return
        }

        try {
            annonceService.save(annonce)
        } catch (ValidationException e) {
            respond annonce.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'annonce.label', default: 'Annonce'), annonce.id])
                redirect annonce
            }
            '*'{ respond annonce, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        annonceService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'annonce.label', default: 'Annonce'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'annonce.label', default: 'Annonce'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}

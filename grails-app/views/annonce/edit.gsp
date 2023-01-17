<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'annonce.label', default: 'Annonce')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <a href="#edit-annonce" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
        <div class="nav" role="navigation">
            <ul>
                <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
                <li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
                <li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
            </ul>
        </div>
        <div id="edit-annonce" class="content scaffold-edit" role="main">
            <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message" role="status">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${this.annonce}">
            <ul class="errors" role="alert">
                <g:eachError bean="${this.annonce}" var="error">
                <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
                </g:eachError>
            </ul>
            </g:hasErrors>
            <g:form resource="${this.annonce}" method="PUT">
                <g:hiddenField name="version" value="${this.annonce?.version}" />
                <fieldset class="form">
                    <div class='fieldcontain required'>
                        <label for='title'>Title
                            <span class='required-indicator'>*</span>
                        </label><input type="text" name="title" value="${this.annonce.title}" required="" maxlength="100" id="title" />
                    </div><div class='fieldcontain required'>
                    <label for='description'>Description
                        <span class='required-indicator'>*</span>
                    </label><input type="text" name="description" value="${this.annonce.description}" required="" id="description" />
                </div><div class='fieldcontain required'>
                    <label for='price'>Price
                        <span class='required-indicator'>*</span>
                    </label><input type="number decimal" name="price" value=${this.annonce.price} required="" step="0.01" min="0.0" id="price" />
                </div><div class='fieldcontain'>
                    <label for='active'>Active</label><input type="hidden" name="_active" /><input type="checkbox" name="active" checked="checked" id="active"  />
                </div>
                </fieldset>
                <fieldset class="buttons">
                    <input class="save" type="submit" value="${message(code: 'default.button.update.label', default: 'Update')}" />
                </fieldset>
            </g:form>
            <h1>Supprimer illustrations</h1>

            <div class='fieldcontain'>
                <label >Illustrations</label>
                <div class="property-value" aria-labelledby="illustrations-label">
                    <ul>
                        <g:each var="illustration" in="${this.annonce.illustrations}">
                            <li >
                                <img src="${grailsApplication.config.illustrations.baseUrl+illustration.filename}"/>
                                <g:form resource="${illustration}" method="DELETE">
                                    <fieldset >
                                        <input class="delete" type="submit" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
                                    </fieldset>
                                </g:form>
                            <!--<a href="/illustration/delete/${illustration.id}" class="delete">Delete</a>-->
                            </li>
                        </g:each>
                    </ul>
                </div>
            </div>
        </div>
    </body>
</html>




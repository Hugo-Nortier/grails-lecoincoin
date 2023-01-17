<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <a href="#show-user" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
        <div class="nav" role="navigation">
            <ul>
                <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
                <li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
                <li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
            </ul>
        </div>
        <div id="show-user" class="content scaffold-show" role="main">
            <h1><g:message code="default.show.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message" role="status">${flash.message}</div>
            </g:if>

            <ul class="property-list user">
                <li class="fieldcontain">
                    <span id="username-label" class="property-label">Username</span>
                    <div class="property-value" aria-labelledby="username-label"> ${this.user.username}</div>
                </li>
                <li class="fieldcontain">
                    <span id="role-label" class="property-label">Rôle</span>
                    <div class="property-value" aria-labelledby="role-label">
                        <ul>
                        <g:each var="role" in="${this.user.getAuthorities()}">
                            <li>
                                ${role.authority}
                            </li>
                        </g:each>
                        </ul>
                    </div>
                </li>
                <li class="fieldcontain">
                    <span id="annonce-label" class="property-label">Annonces</span>
                    <div class="property-value" aria-labelledby="annonce-label">
                        <ul>
                            <g:each var="annonce" in="${this.user.annonces}">
                                <li>
                                    <a href="/annonce/show/${annonce.id}">${annonce.id} - ${annonce.title}</a>
                                </li>
                            </g:each>
                        </ul>
                    </div>
                </li>
                <li class="fieldcontain">
                    <span id="enabled-label" class="property-label">Enabled</span>
                    <div class="property-value" aria-labelledby="enabled-label"> ${this.user.enabled}</div>
                </li>
                <li class="fieldcontain">
                    <span id="passwordExpired-label" class="property-label">Password Expired</span>
                    <div class="property-value" aria-labelledby="passwordExpired-label"> ${this.user.passwordExpired}</div>
                </li>
                <li class="fieldcontain">
                    <span id="accountLocked-label" class="property-label">Account Locked</span>
                    <div class="property-value" aria-labelledby="accountLocked-label"> ${this.user.accountLocked}</div>
                </li>
                <li class="fieldcontain">
                    <span id="accountExpired-label" class="property-label">Account Expired</span>
                    <div class="property-value" aria-labelledby="accountExpired-label"> ${this.user.accountExpired}</div>
                </li>
            </ul>

            <g:form resource="${this.user}" method="DELETE">
                <fieldset class="buttons">
                    <g:link class="edit" action="edit" resource="${this.user}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
                    <input class="delete" type="submit" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
                </fieldset>
            </g:form>
        </div>
    </body>
</html>

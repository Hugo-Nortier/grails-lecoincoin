<%@ page import="com.mbds.grails.User" %>

<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <a href="#list-user" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
        <div class="nav" role="navigation">
            <ul>
                <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
                <li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
            </ul>
        </div>
        <div id="list-user" class="content scaffold-list" role="main">
            <h1><g:message code="default.list.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
                <div class="message" role="status">${flash.message}</div>
            </g:if>

            <table>
                <thead>
                    <tr>
                        <th class="sortable sorted desc">Username</th>
                        <th class="sortable">Rôle</th>
                        <th class="sortable">Annonces</th>
                        <th class="sortable">Enable</th>
                        <th class="sortable">Password Expired</th>
                        <th class="sortable">Account Locked</th>
                        <th class="sortable">Account Expired</th>
                    </tr>
                </thead>
                <tbody>
                <g:each var="user" in="${User.list()}">
                    <tr class="even">

                        <td><a href="/user/show/${user.id}">${user.username}</a></td>
                        <td>
                            <ul>
                                <g:each var="role" in="${user.getAuthorities()}">
                                    <li>
                                        ${role.authority}
                                    </li>
                                </g:each>
                            </ul>
                        </td>
                        <td>
                            <ul>
                                <g:each var="annonce" in="${user.annonces}">
                                        <li>
                                            <a href="/annonce/show/${annonce.id}">${annonce.id} - ${annonce.title}</a>
                                        </li>
                                </g:each>
                            </ul>
                        </td>
                        <td>${user.enabled}</td>
                        <td>${user.passwordExpired}</td>
                        <td>${user.accountLocked}</td>
                        <td>${user.accountExpired}</td>
                    </tr>
                </g:each>
                </tbody>
            </table>
        </div>
    </body>
</html>
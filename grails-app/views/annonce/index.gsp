<%@ page import="com.mbds.grails.Annonce" %>
<%@ page import="com.mbds.grails.User" %>


<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main" />
    <g:set var="entityName" value="${message(code: 'annonce.label', default: 'Annonce')}" />
    <title><g:message code="default.list.label" args="[entityName]" /></title>
</head>
<body>
<a href="#list-annonce" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
<div class="nav" role="navigation">
    <ul>
        <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
        <li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
    </ul>
</div>
<div id="list-annonce" class="content scaffold-list" role="main">
    <h1><g:message code="default.list.label" args="[entityName]" /></h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <sec:ifAnyGranted roles="ROLE_ADMIN, ROLE_MODERATOR">
        <table>
            <thead>
            <tr>

                <th class="sortable sorted desc" >Title</th>

                <th class="sortable" >Description</th>

                <th class="sortable" >Price</th>

                <th class="sortable" >Active</th>

                <th class="sortable" >Illustrations</th>

                <th class="sortable" >Author</th>

            </tr>
            </thead>
            <tbody>
        <g:each var="annonce" in="${Annonce.list()}">
            <tr class="even">

                <td><a href="/annonce/show/${annonce.id}">${annonce.title}</a></td>



                <td>${annonce.description}</td>



                <td>${annonce.price}</td>



                <td>${annonce.active}</td>


                <td>
                    <g:each var="illustration" in="${annonce.illustrations}">
                        <img src="${grailsApplication.config.illustrations.baseUrl+illustration.filename}"/>
                    </g:each>
                </td>


                <td><a href="/user/show/${annonce.author.getId()}">${annonce.author.username}</a></td>

            </tr>
        </g:each>
        </tbody>
    </table>
    </sec:ifAnyGranted>
    <sec:ifAnyGranted roles="ROLE_CLIENT">
        <table>
            <thead>
            <tr>

                <th class="sortable sorted desc" >Title</th>

                <th class="sortable" >Description</th>

                <th class="sortable" >Price</th>

                <th class="sortable" >Active</th>

                <th class="sortable" >Illustrations</th>

            </tr>
            </thead>
            <tbody>

            <g:each var="annonce" in="${Annonce.findAllByAuthor(User.findById(sec.loggedInUserInfo(field:'id')))}">
                <tr class="even">

                    <td><a href="/annonce/show/${annonce.id}">${annonce.title}</a></td>



                    <td>${annonce.description}</td>



                    <td>${annonce.price}</td>



                    <td>${annonce.active}</td>


                    <td>
                        <g:each var="illustration" in="${annonce.illustrations}">
                            <img src="${grailsApplication.config.illustrations.baseUrl+illustration.filename}"/>
                        </g:each>
                    </td>
                </tr>
            </g:each>
            </tbody>
        </table>
    </sec:ifAnyGranted>
</div>
</body>
</html>
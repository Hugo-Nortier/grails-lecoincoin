<%@ page import="com.mbds.grails.User" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'annonce.label', default: 'Annonce')}"/>
    <title>
    <g:message code="default.create.label" args="[entityName]"/>
    </title>
</head>

<body>
<a href="#create-annonce" class="skip" tabindex="-1">
    <g:message code="default.link.skip.label" default="Skip to content&hellip;"/>
</a>

<div class="nav" role="navigation">
    <ul>
        <li>
            <a class="home" href="${createLink(uri: '/')}">
                <g:message code="default.home.label"/>
            </a>
        </li>
        <li>
            <g:link class="list" action="index">
                <g:message code="default.list.label" args="[entityName]"/>
            </g:link>
        </li>
    </ul>
</div>

<div id="create-annonce" class="content scaffold-create" role="main">
    <h1>
        <g:message code="default.create.label" args="[entityName]"/>
    </h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <g:hasErrors bean="${this.annonce}">
        <ul class="errors" role="alert">
            <g:eachError bean="${this.annonce}" var="error">
                <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>>
                    <g:message error="${error}"/>
                </li>
            </g:eachError>
        </ul>
    </g:hasErrors>
    <g:uploadForm resource="${this.annonce}" method="POST">
        <fieldset class="form">
          <fieldset class="form">
            <div class='fieldcontain required'>
              <label for='title'>Title <span class='required-indicator'>*</span>
              </label>
              <input type="text" name="title" value="" required="" maxlength="100" id="title" />
            </div>
            <div class='fieldcontain required'>
              <label for='description'>Description <span class='required-indicator'>*</span>
              </label>
              <input type="text" name="description" value="" required="" id="description" />
            </div>
            <div class='fieldcontain required'>
              <label for='price'>Price <span class='required-indicator'>*</span>
              </label>
              <input type="number decimal" name="price" value="" required="" step="0.01" min="0.0" id="price" />
            </div>
            <div class='fieldcontain'>
              <label for='active'>Active</label>
              <input type="hidden" name="_active" />
              <input type="checkbox" name="active" id="active" />
            </div>
            <div class='fieldcontain'>
              <label for="illustrations">Illustrations</label>
              <input style="display:inline" type="file" id="illustrationsupload" name="illustrations" accept="image/png, image/jpeg" multiple>
            </div>
            <div class='fieldcontain required'>
              <label for='author'>Author <span class='required-indicator'>*</span>
              </label>
                    <select name="author.id" required="" id="author">
        <sec:ifAnyGranted roles="ROLE_ADMIN, ROLE_MODERATOR">
            <g:each in="${User.list()}" var="user">
                <option value= ${user.id}>${user.username}</option>
            </g:each>
        </sec:ifAnyGranted>
        <sec:ifAnyGranted roles="ROLE_CLIENT">
            <option value= ${sec.loggedInUserInfo(field: 'id')}>${sec.loggedInUserInfo(field: 'username')}</option>
        </sec:ifAnyGranted>
        </select>
</div>
</fieldset>
        <fieldset class="buttons">
            <g:submitButton name="create" class="save"
                            value="${message(code: 'default.button.create.label', default: 'Create')}"/>
        </fieldset>
    </g:uploadForm>
</div>
</body>
</html>
